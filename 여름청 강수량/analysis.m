% CSV 파일에서 데이터를 불러옵니다.
filename = '장마철 강수량 연도별 데이터.csv';  % CSV 파일의 경로를 지정하세요.
data = readtable(filename, 'VariableNamingRule', 'preserve');  % CSV 파일에서 데이터를 읽습니다.

% 데이터에서 연도와 강수량 데이터를 추출합니다.
years = data{:, 1};  % 첫 번째 열은 연도
rainfall = data{:, 2};  % 두 번째 열은 강수량

% 이동 평균 스무딩을 적용합니다.
windowSize = 5;  % 이동 평균의 윈도우 크기 (예: 5)
smoothed_rainfall = movmean(rainfall, windowSize);

% 연도와 스무딩된 강수량 데이터를 테이블로 변환하여 저장
smoothed_table = table(years, smoothed_rainfall, 'VariableNames', {'Year', 'SmoothedRainfall'});
writetable(smoothed_table, 'smoothed_data.csv');

% 스무딩된 데이터를 그래프로 시각화합니다.
figure;
hold on;

% 원본 강수량 데이터 그래프
plot(years, rainfall, 'b', 'DisplayName', '원본 강수량 데이터');

% 스무딩된 강수량 데이터 그래프
plot(years, smoothed_rainfall, 'r', 'DisplayName', '스무딩된 강수량 데이터');

% 그래프 설정
xlabel('연도');
ylabel('강수량');
title('강수량 데이터 시각화');
legend;
grid on;

hold off;
