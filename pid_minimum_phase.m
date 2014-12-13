%% Script Quadruple Tanks for Minimum Phase

% Decouplers - IN TEST
W1 = eye(2); W2 = eye(2);
%% Executa modelo em malha fechada
simOut = sim('quadtanks_pid',simulation_time);

%% Resultados

%% Plot resposta em malha fechada para o modelo de fase minima
%% G11(s)
subplot(2,2,1);
plot(simOut,Yt_gs11, 'r');
%% G12(s)
subplot(2,2,2);
plot(simOut,Yt_gs12, 'r');
%% G21(s)
subplot(2,2,3);
plot(simOut,Yt_gs21, 'r');
%% G22(s)
subplot(2,2,4);
plot(simOut,Yt_gs22, 'r');