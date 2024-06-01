% CSV 파일을 읽습니다.
filename = '장마철 강수량 연도별 데이터.csv';  % CSV 파일의 경로를 지정하세요.
data = readtable(filename);  % CSV 파일을 읽어옵니다.

% 연도와 강수량 데이터를 추출합니다.
years = data{:, 1};  % 첫 번째 열은 연도
rainfall = data{:, 2};  % 두 번째 열은 강수량

% 연도별 강수량을 그래프로 나타냅니다.
figure;  % 새로운 그림을 생성합니다.

% 연도와 강수량 데이터를 플로팅합니다.
plot(years, rainfall, '-o', 'LineWidth', 1.5, 'MarkerSize', 4);

% 그래프 설정
xlabel('연도');  % x축 레이블
ylabel('강수량');  % y축 레이블
title('연간 강수량 그래프');  % 그래프 제목
grid on;  % 그리드를 켭니다.

% 그래프에 표시를 추가합니다.
legend('강수량');
