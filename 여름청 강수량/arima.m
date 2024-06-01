% CSV 파일을 읽어서 데이터셋을 가져옵니다.
filename = '장마철 강수량 연도별 데이터.csv';  % CSV 파일의 경로를 지정하세요.
data = readtable(filename);  % 데이터셋을 읽어옵니다.

% 데이터에서 연도와 강수량 데이터를 추출합니다.
years = data{:, 1};  % 첫 번째 열은 연도
rainfall = data{:, 2};  % 두 번째 열은 강수량

% 이동 평균 스무딩을 적용합니다.
% 윈도우 크기를 조정해서 적절한 스무딩 효과를 얻을 수 있습니다.
windowSize = 5;  % 이동 평균의 윈도우 크기 (예: 5)
smoothed_rainfall = movmean(rainfall, windowSize);

% ARIMA(1,2,1) 모델을 설정합니다.
model = arima(1, 2, 1);

% ARIMA 모델을 스무딩된 데이터에 적합시킵니다.
fit = estimate(model, smoothed_rainfall);

% 예측을 수행합니다.
num_forecast_periods = 10;  % 예측할 기간(단위: 연도)을 설정합니다.
[forecast, forecast_mse] = forecast(fit, num_forecast_periods);

% 예측 시각화
figure;
% 원본 데이터 시각화
plot(years, smoothed_rainfall, 'b', 'DisplayName', '스무딩된 데이터');
hold on;
% 예측 데이터 시각화
plot(years(end) + (1:num_forecast_periods), forecast, 'r', 'DisplayName', '예측 데이터');

% 그래프 설정
xlabel('연도');
ylabel('강수량');
title('ARIMA(1,2,1) 모델을 사용한 스무딩된 강수량 예측');
legend;
grid on;

% 예측 신뢰 구간을 계산합니다.
forecast_sd = sqrt(forecast_mse);
forecast_upper = forecast + 1.96 * forecast_sd;
forecast_lower = forecast - 1.96 * forecast_sd;

% 신뢰 구간을 시각화
plot(years(end) + (1:num_forecast_periods), forecast_upper, 'r--', 'DisplayName', '95% 신뢰 구간 상한');
plot(years(end) + (1:num_forecast_periods), forecast_lower, 'r--', 'DisplayName', '95% 신뢰 구간 하한');

hold off;
