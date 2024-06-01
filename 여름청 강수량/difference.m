% CSV 파일을 읽어서 데이터셋을 가져옵니다.
filename = '장마철 강수량 연도별 데이터.csv';  % CSV 파일의 경로를 지정하세요.
data = readtable(filename);  % 데이터셋을 읽어옵니다.

% 데이터에서 연도와 강수량 데이터를 추출합니다.
years = data{:, 1};  % 첫 번째 열은 연도
rainfall = data{:, 2};  % 두 번째 열은 강수량

% 이동 평균 스무딩을 적용합니다.
windowSize = 5;  % 이동 평균의 윈도우 크기 (예: 5)
smoothed_rainfall = movmean(rainfall, windowSize);

% 1차 차분을 수행합니다.
smoothed_diff_1 = diff(smoothed_rainfall);

% 2차 차분을 수행합니다.
smoothed_diff_2 = diff(smoothed_diff_1);

% 스무딩된 강수량 데이터와 차분된 데이터를 테이블로 구성합니다.
% 1차 차분과 2차 차분된 데이터의 길이를 맞추기 위해 years 벡터의 끝부분에서 각 1개씩을 제거해야 합니다.
smoothed_table = table(years, smoothed_rainfall, [years(2:end), smoothed_diff_1], [years(3:end), smoothed_diff_2], ...
    'VariableNames', {'Year', 'SmoothedRainfall', 'FirstDiffRainfall', 'SecondDiffRainfall'});

% 테이블을 CSV 파일로 저장합니다.
output_filename = 'smoothed_diff.csv';
writetable(smoothed_table, output_filename);

% 그래프를 시각화합니다.
figure;
hold on;

% 원본 강수량 데이터 그래프
plot(years, rainfall, 'b', 'DisplayName', '원본 데이터');

% 스무딩된 강수량 데이터 그래프
plot(years, smoothed_rainfall, 'r', 'DisplayName', '스무딩된 데이터');

% 2차 차분된 데이터 그래프
plot(years(3:end), smoothed_diff_2, 'g', 'DisplayName', '2차 차분된 데이터');

% 그래프 설정
xlabel('연도');
ylabel('강수량');
title('강수량 시계열 분석');
legend;
grid on;

hold off;
