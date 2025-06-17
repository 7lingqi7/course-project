# Evaluation of Deep Learning Models for Weather Prediction  

## Project Title  
Weather Forecasting in Shenzhen Using Deep Learning: LSTM, GRU, and Transformer-based Models

## Description  
This project evaluates various deep learning models—including LSTM, GRU, RNN, Transformer-augmented hybrids, and MLP—for weather prediction using Shenzhen’s daily meteorological data (2007–2024). The models were trained to forecast key weather parameters like temperature, humidity, pressure, rainfall, and wind speed. Their performance was compared using MSE, MAE, and RMSE metrics.

## Key Techniques  
- **LSTM (Long Short-Term Memory)** for capturing long-term temporal dependencies in sequential weather data.  
- **GRU (Gated Recurrent Unit)** as a simplified, faster alternative to LSTM.  
- **RNN (Recurrent Neural Network)** as a baseline model.  
- **MLP (Multilayer Perceptron)** for modeling non-sequential nonlinear relationships.  
- **Hybrid RNN + Transformer** architectures for combining local and global feature modeling.  
- **Transformer self-attention** for enhanced sequence learning.  
- **MinMax normalization**, time-based feature extraction, linear interpolation for data preprocessing.  
- **Early stopping** to prevent overfitting.

## Dataset  
Daily weather data from Shenzhen, including:
- Temperature (MAXT, MINT, AVGT24)
- Humidity (MAXU, MINU, AVGU24)
- Pressure (MAXP, MINP, AVGP24)
- Rainfall (R24H)
- Wind speed (AVGWD10WF)  

Split into:
- Training set (2007–2018)
- Validation set (2019–2021)
- Test set (2022–2024)

## Results  
| Model | Best Metrics |
|-------|--------------|
| **LSTM** | Lowest RMSE on MAXT and R24H, indicating best overall performance |
| **GRU** | Competitive performance with lower training cost |
| **Transformer Hybrids** | Mixed results, no consistent improvement across all parameters |
| **MLP** | Underperformed on sequential features like rainfall and pressure |

## Conclusion  
LSTM and GRU models provided strong predictive power for weather forecasting tasks. While transformer-enhanced models offered potential, their added complexity did not consistently lead to better performance. Future directions include integrating convolutional layers and exploring more granular temporal resolutions.

