% CSV 파일을 읽어서 데이터셋을 가져옵니다.
filename = '장마철 강수량 연도별 데이터.csv';  % CSV 파일의 경로를 지정하세요.
data = readtable(filename);  % 데이터셋을 읽어옵니다.

% 데이터에서 연도와 강수량 데이터를 추출합니다.
years = data{:, 1};  % 첫 번째 열은 연도
rainfall = data{:, 2};  % 두 번째 열은 강수량

% 그래프를 시각화합니다.
figure;
hold on;

% 원본 강수량 데이터 그래프
plot(years, rainfall, 'b', 'DisplayName', '원본 데이터');

% 그래프 설정
xlabel('연도');
ylabel('강수량');
title('강수량 시계열 분석');
legend;
grid on;

hold off;

% 원본 강수량 데이터의 PACF 계산 및 시각화
% PACF를 계산할 최대 시차(lag)를 설정합니다.
maxlag = 20;

% PACF 값을 계산하고 시각화합니다.
figure;
parcorr(rainfall, maxlag);
title('PACF of Original Rainfall');
xlabel('Lag');
ylabel('PACF');
grid on;
