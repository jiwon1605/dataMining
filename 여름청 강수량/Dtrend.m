% CSV 파일을 읽습니다.
filename = '장마철 강수량 연도별 데이터.csv';  % CSV 파일의 경로를 지정하세요.
data = readtable(filename);  % CSV 파일을 읽어옵니다.

% 연도와 강수량 데이터를 추출합니다.
years = data{:, 1};  % 첫 번째 열은 연도
rainfall = data{:, 2};  % 두 번째 열은 강수량

% 선형회귀를 사용하여 트렌드를 제거합니다.
% X 행렬을 만들 때 상수항을 추가합니다.
X = [ones(length(years), 1), years];  % [1 연도] 형식의 행렬
b = X \ rainfall;  % 선형회귀 계수 계산

% 회귀에 기반하여 추정된 트렌드
trend = X * b;

% 강수량에서 추정된 트렌드를 뺍니다.
rainfall_detrended = rainfall - trend;

% 트렌드 제거 결과를 시각화합니다.
figure;
plot(years, rainfall, 'b', 'DisplayName', 'Original Rainfall');
hold on;
plot(years, trend, 'r--', 'DisplayName', 'Estimated Trend');
plot(years, rainfall_detrended, 'g', 'DisplayName', 'Detrended Rainfall');
xlabel('Year');
ylabel('Rainfall');
title('Original Rainfall, Estimated Trend, and Detrended Rainfall');
legend;
grid on;
hold off;

% 그래프에서 파란색 선은 원본 강수량 데이터, 빨간색 점선은 추정된 트렌드, 
% 녹색 선은 트렌드가 제거된 강수량 데이터를 나타냅니다.
