import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from skimage.metrics import mean_squared_error
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
from sklearn.model_selection import cross_val_score
import seaborn as sns

# Use pandas to read the data due to it has many 'NA'
house_data = pd.read_csv('HousingData.csv')
# Remove the 'NA' data with the mean
house_data = house_data.fillna(house_data.mean())

# Load the data
x = house_data.drop('MEDV', axis=1).values
y = house_data['MEDV'].values

# Feature normalization
scaler = StandardScaler()
x_scaled = scaler.fit_transform(x)

pca = PCA(n_components=0.95)
x_pca = pca.fit_transform(x_scaled)

# Split the dataset into training and test sets
x_train, x_test, y_train, y_test = train_test_split(x_pca, y, test_size=0.1, random_state=7)


# Create a linear regression class for easy invocation and multitasking integration
class RidgeRegression:
    # Initialization of the class
    def __init__(self, alpha=1.0, learning_rate=0.01, iterations=1000):
        self.learning_rate = learning_rate  # Set the learning rate for the gradient descent
        self.iterations = iterations  # Set the number of iterations for the gradient descent
        self.alpha = alpha  # Regularization parameter for Ridge Regression
        self.weights = None  # Initialize the weights as None
        self.bias = None  # Initialize the bias as None

    def fit(self, x, y):
        n_samples, n_features = x.shape  # Get the number of samples and features from x

        # Initialize weights and bias to zero
        self.weights = np.zeros(n_features)
        self.bias = 0

        # Gradient descent for optimization
        for epoch in range(self.iterations):
            # Dot product computation with x and add the bias
            y_predicted = np.dot(x, self.weights) + self.bias  # Predicted y values

            # Compute gradients
            dw = (1 / n_samples) * np.dot(x.T, (y_predicted - y)) + 2 * self.alpha * self.weights
            db = (1 / n_samples) * np.sum(y_predicted - y)

            # Update weights and bias
            self.weights -= self.learning_rate * dw
            self.bias -= self.learning_rate * db

            # Calculate loss with regularization term
            loss = (1 / n_samples) * np.sum((y_predicted - y) ** 2) + self.alpha * np.sum(self.weights ** 2)
            # Print the training process
            print(f"epoch:{epoch} Loss:{loss}")

    def predict(self, x):
        # Predict y values using the trained model
        return np.dot(x, self.weights) + self.bias

    # For fitting in Scikit-learn framework to use the cross_val_score
    def score(self, x, y):
        # Compute the negative mean squared error
        y_predicted = self.predict(x)
        return -mean_squared_error(y, y_predicted)

    # For fitting in Scikit-learn framework to use the cross_val_score
    def get_params(self, deep=True):
        # Return model parameters
        return {'alpha': self.alpha, 'learning_rate': self.learning_rate, 'iterations': self.iterations}

    # For fitting in Scikit-learn framework to use the cross_val_score
    def set_params(self, **parameters):
        # Set model parameters
        for parameter, value in parameters.items():
            setattr(self, parameter, value)
        return self

# Instantiate the Ridge Regression model
model = RidgeRegression(alpha=0.01, learning_rate=0.01, iterations=1000)

# Fit the model on the training data
model.fit(x_train, y_train)

# Predict house prices on the test data
predictions = model.predict(x_test)

# Calculate and print the mean squared error on the testing set
mse = mean_squared_error(y_test, predictions)
print(f'Mean Squared Error on Testing Set: {mse}')

# Evaluate the model using 10-fold cross-validation
scores = cross_val_score(model, x_pca, y, cv=10, scoring='neg_mean_squared_error')
print(f"Mean squared error scores for 10-fold CV: {-scores.mean()}")

# Plot the distribution of the target variable
plt.figure(figsize=(10, 6))
# Plotting histograms
sns.histplot(y, kde=True)
# Axis Naming
plt.title('Distribution of Target Variable (House Prices)')
plt.xlabel('House Price')
plt.ylabel('Frequency')
plt.show()

# Create and plot the correlation matrix to understand the relationship between variables
plt.figure(figsize=(12, 10))
# Calculate the correlation coefficient matrix for all columns in the house_data data frame
correlation_matrix = house_data.corr()
sns.heatmap(correlation_matrix, annot=True, cmap='Greens')
plt.title('Correlation Matrix of Variables')
plt.show()

# Plot a scatter plot between the original and predicted house prices to visualize the model's performance
plt.figure(figsize=(10, 6))
# Plot a scatter plot between actual house prices (y_test) and predicted house prices (predictions).
plt.scatter(y_test, predictions, alpha=0.5)
plt.title('Actual vs. Predicted House Prices')
plt.xlabel('Actual House Prices')
plt.ylabel('Predicted House Prices')
# Add a red reference line, which indicates the perfect prediction in the ideal case
plt.plot([min(y_test), max(y_test)], [min(y_test), max(y_test)], 'r')
plt.show()
