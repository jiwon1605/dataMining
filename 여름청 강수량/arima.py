import pandas as pd
import matplotlib.pyplot as plt
from statsmodels.tsa.arima.model import ARIMA

# CSV 파일에서 데이터를 읽습니다.
filename = 'smoothed_data.csv'  # CSV 파일의 경로
data = pd.read_csv(filename, encoding='utf-8')  # UTF-8 인코딩을 사용

# 연도와 스무딩된 강수량 데이터를 추출합니다.
years = data['Year']
smoothed_rainfall = data['SmoothedRainfall']

# 스무딩된 강수량 데이터를 시각화합니다.
plt.figure()
plt.plot(years, smoothed_rainfall, label='Smoothed Rainfall Data')
plt.title('Smoothed Rainfall Data')
plt.xlabel('Year')
plt.ylabel('Rainfall')
plt.legend()
plt.grid(True)
plt.show()

# ARIMA(1,2,1) 모델 설정 및 추정
model = ARIMA(smoothed_rainfall, order=(3, 2, 5))
model_fit = model.fit()

# 모델 요약 정보 출력
print(model_fit.summary())

# 예측 기간 설정
horizon = 10  # 10년 예측

# 예측 수행
forecast = model_fit.get_forecast(steps=horizon)
forecast_mean = forecast.predicted_mean
conf_int = forecast.conf_int()

# 예측 결과를 시각화하기 위한 미래 연도 계산
future_years = years.iloc[-1] + pd.Series(range(1, horizon + 1))

# 예측 결과 시각화
plt.figure()
plt.plot(years, smoothed_rainfall, label='Smoothed Rainfall Data')
plt.plot(future_years, forecast_mean, 'r--', label='ARIMA(3,2,5) Forecast')
plt.fill_between(future_years, conf_int['lower SmoothedRainfall'], conf_int['upper SmoothedRainfall'], color='gray', alpha=0.2, label='95% Confidence Interval')
plt.title('ARIMA(3,2,5) Model Forecast')
plt.xlabel('Year')
plt.ylabel('Rainfall')
plt.legend()
plt.grid(True)
plt.show()
