% CSV 파일에서 데이터를 읽습니다.
filename = 'smoothed_data.csv';  % CSV 파일 경로를 지정합니다.
data = readtable(filename, 'VariableNamingRule', 'preserve');  % CSV 파일을 읽습니다.

% 연도와 스무딩된 강수량 데이터를 추출합니다.
years = data{:, 'Year'};
smoothed_rainfall = data{:, 'SmoothedRainfall'};

% 데이터 시각화
figure;
plot(years, smoothed_rainfall);
title('스무딩된 강수량 데이터');
xlabel('연도');
ylabel('강수량');

% ARIMA(1,2,1) 모델 설정 및 추정
Mdl = arima(1, 2, 1);  % ARIMA(1,2,1) 모델 설정
EstMdl = estimate(Mdl, smoothed_rainfall);  % 모델 추정

% 모델 요약 정보를 출력합니다.
disp('ARIMA 모델 요약 정보:');
summary(EstMdl);

% 모델 시각화
figure;
plot(years, smoothed_rainfall, 'b');  % 스무딩된 강수량 데이터 그래프
title('ARIMA 모델과 스무딩된 강수량 데이터');
xlabel('연도');
ylabel('강수량');
grid on;

% 코드를 추가로 수정하여 예측을 시각화할 수 있습니다.
% Horizon (예측 기간)에 대한 예측 및 시각화를 다시 구현할 수 있습니다.
