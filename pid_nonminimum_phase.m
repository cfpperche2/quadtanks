%% Script Quadruple Tanks for Minimum Phase

% Decouplers - IN TEST
W1 = eye(2); W2 = eye(2);
%% Executa modelo em malha fechada
clear simOut;
simOut = sim('quadtanks_pid',simulation_time);

%% Resultados

%% Plot resposta em malha aberta para o modelo de fase minima
figure
% G11(s)
subplot(2,2,1);
plot(simOut,U1t1);
hold on;
plot(simOut,Yt_gs11, 'r');
grid on;
xlabel('Time (ms)');
ylabel('Amplitude');
title(sprintf('Resposta modelo\nfase não mínima G11(s)'));
axis auto
datacursormode on
% G12(s)
subplot(2,2,2);
plot(simOut,U1t1);
hold on;
plot(simOut,Yt_gs12, 'r');
grid on;
xlabel('Time (ms)');
ylabel('Amplitude');
title(sprintf('Resposta modelo\nfase não mínima G12(s)'));
axis auto
datacursormode on
% G21(s)
subplot(2,2,3);
plot(simOut,U2t2);
hold on;
plot(simOut,Yt_gs21, 'r');
grid on;
xlabel('Time (ms)');
ylabel('Amplitude');
title(sprintf('Resposta modelo\nfase não mínima G21(s)'));
axis auto
datacursormode on
% G22(s)
subplot(2,2,4);
plot(simOut,U2t2);
hold on;
plot(simOut,Yt_gs22, 'r');
grid on;
xlabel('Time (ms)');
ylabel('Amplitude');
title(sprintf('Resposta modelo\nfase não mínima G22(s)'));
axis auto
datacursormode on