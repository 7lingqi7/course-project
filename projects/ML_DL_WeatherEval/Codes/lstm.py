import pandas as pd
import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error, mean_absolute_error
import matplotlib.pyplot as plt

# Read the dataset and parse the date column
df = pd.read_csv('数据.csv', parse_dates=['DDATETIME'], date_format='%Y%m%d')
df.rename(columns={'DDATETIME': 'date'}, inplace=True)
df.replace('-', np.nan, inplace=True)

# Convert columns to numeric values, handling errors by setting them to NaN
for col in df.columns[1:]:
    df[col] = pd.to_numeric(df[col], errors='coerce')

# Interpolate missing values linearly and drop any remaining NaNs
df.interpolate(method='linear', inplace=True)
df.dropna(inplace=True)
df.sort_values(by='date', inplace=True)

# Define input and output features
input_features = df.columns.tolist()
input_features.remove('date')
output_features = ['MAXT', 'MINT', 'AVGT24', 'MAXP', 'MINP', 'AVGP24', 'MAXU', 'MINU', 'AVGU24', 'R24H', 'AVGWD10WF']

# Split the dataset into training, validation, and test sets based on date
train_df = df[(df['date'] >= '2007-01-01') & (df['date'] <= '2018-12-31')].copy()
val_df = df[(df['date'] >= '2019-01-01') & (df['date'] <= '2021-12-31')].copy()
test_df = df[(df['date'] >= '2022-01-01') & (df['date'] <= '2024-12-31')].copy()

# Loop through each output feature to train and predict
for output_feature in output_features:
    print(f"Training and predicting for: {output_feature}")

    # Preprocess the data using MinMaxScaler
    scaler = MinMaxScaler()
    target_scaler = MinMaxScaler()

    train_data = scaler.fit_transform(train_df[input_features].values)
    train_target_data = target_scaler.fit_transform(train_df[[output_feature]].values)

    val_data = scaler.transform(val_df[input_features].values)
    val_target_data = target_scaler.transform(val_df[[output_feature]].values)

    test_data = scaler.transform(test_df[input_features].values)
    test_target_data = target_scaler.transform(test_df[[output_feature]].values)

    # Function to create sequences for LSTM input
    def create_sequences(data, target_data, seq_length):
        xs, ys = [], []
        for i in range(len(data) - seq_length):
            x = data[i:i+seq_length]
            y = target_data[i+seq_length]
            xs.append(x)
            ys.append(y)
        return np.array(xs), np.array(ys)

    seq_length = 7  # Define sequence length

    # Create sequences for training, validation, and test sets
    X_train, y_train = create_sequences(train_data, train_target_data, seq_length)
    X_val, y_val = create_sequences(val_data, val_target_data, seq_length)
    X_test, y_test = create_sequences(test_data, test_target_data, seq_length)

    # Convert data to PyTorch tensors
    X_train = torch.tensor(X_train, dtype=torch.float32)
    y_train = torch.tensor(y_train, dtype=torch.float32)
    X_val = torch.tensor(X_val, dtype=torch.float32)
    y_val = torch.tensor(y_val, dtype=torch.float32)
    X_test = torch.tensor(X_test, dtype=torch.float32)
    y_test = torch.tensor(y_test, dtype=torch.float32)

    # Custom dataset class for PyTorch
    class ClimateDataset(Dataset):
        def __init__(self, X, y):
            self.X = X
            self.y = y

        def __len__(self):
            return len(self.X)

        def __getitem__(self, idx):
            return self.X[idx], self.y[idx]

    # Create dataLoader instances for training, validation, and test sets
    train_dataset = ClimateDataset(X_train, y_train)
    val_dataset = ClimateDataset(X_val, y_val)
    test_dataset = ClimateDataset(X_test, y_test)

    train_loader = DataLoader(train_dataset, batch_size=64, shuffle=True)
    val_loader = DataLoader(val_dataset, batch_size=64, shuffle=False)
    test_loader = DataLoader(test_dataset, batch_size=64, shuffle=False)

    # Define LSTM model architecture
    class LSTMModel(nn.Module):
        def __init__(self, input_dim, hidden_dim, output_dim, num_layers):
            super(LSTMModel, self).__init__()
            self.hidden_dim = hidden_dim
            self.num_layers = num_layers
            self.lstm = nn.LSTM(input_dim, hidden_dim, num_layers, batch_first=True)
            self.fc = nn.Linear(hidden_dim, output_dim)

        def forward(self, x):
            # Initialize hidden and cell states
            h0 = torch.zeros(self.num_layers, x.size(0), self.hidden_dim).to(device)
            c0 = torch.zeros(self.num_layers, x.size(0), self.hidden_dim).to(device)
            # Forward propagate LSTM
            out, _ = self.lstm(x, (h0, c0))
            # Decode the hidden state of the last time step
            out = self.fc(out[:, -1, :])
            return out

    input_dim = X_train.shape[2]  # Number of input features
    hidden_dim = 128  # Number of hidden units in LSTM
    output_dim = 1  # Single output target
    num_layers = 2  # Number of LSTM layers

    # Instantiate the model, define the loss function and the optimizer
    model = LSTMModel(input_dim, hidden_dim, output_dim, num_layers)
    device = torch.device('cuda')
    model.to(device)

    criterion = nn.MSELoss()  # Mean Squared Error Loss
    optimizer = optim.Adam(model.parameters(), lr=0.001)  # Adam Optimizer

    # Train the model
    num_epochs = 150
    best_val_loss = float('inf')
    patience = 10
    trigger_times = 0

    for epoch in range(num_epochs):
        model.train()
        train_loss = 0.0
        for X_batch, y_batch in train_loader:
            X_batch, y_batch = X_batch.to(device), y_batch.to(device)
            optimizer.zero_grad()
            output = model(X_batch)
            loss = criterion(output, y_batch)
            loss.backward()
            optimizer.step()
            train_loss += loss.item() * X_batch.size(0)

        train_loss /= len(train_loader.dataset)

        model.eval()
        val_loss = 0.0
        with torch.no_grad():
            for X_batch, y_batch in val_loader:
                X_batch, y_batch = X_batch.to(device), y_batch.to(device)
                output = model(X_batch)
                loss = criterion(output, y_batch)
                val_loss += loss.item() * X_batch.size(0)

        val_loss /= len(val_loader.dataset)

        print(f'Epoch {epoch+1}/{num_epochs}, Loss: {train_loss}, Val Loss: {val_loss}')

        # Early stopping based on validation loss
        if val_loss < best_val_loss:
            best_val_loss = val_loss
            torch.save(model.state_dict(), 'best_model.pth')
            trigger_times = 0
        else:
            trigger_times += 1
            if trigger_times >= patience:
                print('Early stopping!')
                break

    # Save the best model
    torch.save(model.state_dict(), 'LSTM.pth')

    # Load the best model
    model.load_state_dict(torch.load('LSTM.pth'))

    # Make predictions on the test set
    model.eval()
    predictions, y_true = [], []
    with torch.no_grad():
        for X_batch, y_batch in test_loader:
            X_batch, y_batch = X_batch.to(device), y_batch.to(device)
            output = model(X_batch)
            predictions.append(output.cpu().numpy())
            y_true.append(y_batch.cpu().numpy())

    predictions = np.concatenate(predictions, axis=0)
    y_true = np.concatenate(y_true, axis=0)

    # Rescale the predictions and true values back to original scale
    predictions_rescaled = target_scaler.inverse_transform(predictions)
    y_true_rescaled = target_scaler.inverse_transform(y_true)

    # Calculate performance metrics
    mse = mean_squared_error(y_true_rescaled, predictions_rescaled)
    mae = mean_absolute_error(y_true_rescaled, predictions_rescaled)
    rmse = np.sqrt(mse)

    print(f'Test MSE for {output_feature}: {mse}')
    print(f'Test MAE for {output_feature}: {mae}')
    print(f'Test RMSE for {output_feature}: {rmse}')

    # Plot the predictions vs true values
    plt.figure(figsize=(10, 6))

    # Align dates with predictions
    test_dates = test_df['date'].values[seq_length:]
    plt.plot(test_dates, y_true_rescaled, label='True Values')
    plt.plot(test_dates, predictions_rescaled, label='Predictions')

    plt.xlabel('Date')
    plt.ylabel(output_feature)
    plt.legend()
    plt.title(f'Prediction vs True for {output_feature}')
    plt.show()