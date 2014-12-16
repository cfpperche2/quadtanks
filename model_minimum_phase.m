%% Script Quadruple Tanks for Minimum Phase

%% Initialize common model params
model_const_params

%% Minimun Phase Parameters
gamma1 = 0.7; % Parcela do fluxo da bomba 1 para o tq 1
gamma2 = gamma1; % Parcela do fluxo da bomba 2 para o tq 2

h30 = ((1-gamma2)*k2*u20/a3)^2/(2*g); %0.9 cm
h40 = ((1-gamma1)*k1*u10/a4)^2/(2*g); %0.9 cm

T1 = (A1/a1)*sqrt((2*h10)/g);
T2 = (A2/a2)*sqrt((2*h20)/g);
T3 = (A3/a3)*sqrt((2*h30)/g);
T4 = (A4/a4)*sqrt((2*h40)/g);

Ap = [-1/T1 0 A3/(A1*T3) 0; 0 -1/T2 0 A4/(A2*T4); 0 0 -1/T3 0; 0 0 0 -1/T4];
Bp = [gamma1*k1/A1 0; 0 gamma2*k2/A2; 0 (1-gamma2)*k2/A3; (1-gamma1)*k1/A4 0];
Cp = [kc 0 0 0; 0 kc 0 0];

% Gmin
Gmin = tf(ss(Ap,Bp,Cp,0));
% Zeros of Gmin
Gmin_z = zero(minreal(ss(Gmin)));
% Gmin RGA of Gmin(0)
Gmin_rga = evalfr(Gmin,0*i);
Gmin_rga = Gmin_rga.*transpose(inv(Gmin_rga));

[num dem]  = tfdata(Gmin);

gs_num11 = num{1,1};
gs_dem11 = dem{1,1};

gs_num12 = num{1,2};
gs_dem12 = dem{1,2};

gs_num21 = num{2,1};
gs_dem21 = dem{2,1};

gs_num22 = num{2,2};
gs_dem22 = dem{2,2};

c1 = (T1*k1*kc)/A1;
c2 = (T2*k2*kc)/A2;

% numeradores função G(s)
gs11_n = gamma1*c1;
gs12_n = (1-gamma2)*c1;
gs21_n = (1-gamma1)*c2;
gs22_n = gamma2*c2;

% denominadores função G(s)
syms s;
gs11 = expand(T1*s + 1);
coeff_gs11 = coeffs(gs11);
gs11_ds = double(coeff_gs11(2));
gs11_d = double(coeff_gs11(1));

gs12 = expand((T1*s + 1)*(T3*s + 1));
coeff_gs12 = coeffs(gs12);
gs12_ds2 = double(coeff_gs12(3));
gs12_ds = double(coeff_gs12(2));
gs12_d = double(coeff_gs12(1));

gs21 = expand((T2*s + 1)*(T4*s + 1));
coeff_gs21 = coeffs(gs21);
gs21_ds2 = double(coeff_gs21(3));
gs21_ds = double(coeff_gs21(2));
gs21_d = double(coeff_gs21(1));

gs22 = expand(T2*s + 1);
coeff_gs22 = coeffs(gs22);
gs22_ds = double(coeff_gs22(2));
gs22_d = double(coeff_gs22(1));

Gs11 = tf([gs11_n],[gs11_ds gs11_d]);
Gs12 = tf([gs12_n],[gs12_ds2 gs12_ds gs12_d]);
Gs21 = tf([gs21_n],[gs21_ds2 gs21_ds gs21_d]);
Gs22 = tf([gs22_n],[gs22_ds gs22_d]);

Gs = [Gs11 Gs12;Gs21 Gs22]

Poles = pole(Gs);
Zeros = zero(Gs);

%% Executa modelo em malha aberta
simOut = sim('quadtanks_model',simulation_time);

%% Parametros do modelo
%[Kc_gs11, Tau_gs11, Theta_gs11] = model_evaluate_params(U1t, Yt_gs11);
%[Kc_gs12, Tau_gs12, Theta_gs12] = model_evaluate_params(U1t, Yt_gs12);
%[Kc_gs21, Tau_gs21, Theta_gs21] = model_evaluate_params(U2t, Yt_gs21);
%[Kc_gs22, Tau_gs22, Theta_gs22] = model_evaluate_params(U2t, Yt_gs22);

Kc_gs11 = gs11_n;
Tau_gs11= gs11_ds;
Theta_gs11 = 0;

Kc_gs22 = Kc_gs11; 
Tau_gs22 = Tau_gs11;
Theta_gs22 = Theta_gs11;

%% Sintonia PID - Método IMC com atraso

%Controlador 1 G(s) 11
lambda1 = (Tau_gs11+Theta_gs11)/2;
[Kp1 Ti1 Td1] = tuning_imc_wodelay(Kc_gs11, Tau_gs11, Theta_gs11, lambda1, 'PI');

%Controlador 2 G(s) 22
lambda2 = (Tau_gs22+Theta_gs22)/2;
[Kp2 Ti2 Td2] = tuning_imc_wodelay(Kc_gs22, Tau_gs22, Theta_gs22, lambda2, 'PI');

%% Resultados
fprintf('--------------- Fase Mínima Dados G(s) ---------------\n');
%fprintf('C1: %.5f\n', c1);
%fprintf('C2: %.5f\n', c2);
fprintf('gamma1: %.5f\n', gamma1);
fprintf('gamma2: %.5f\n', gamma2);
fprintf('Zeros: %.5f\n', Zeros);
fprintf('--------------------- Modelo G11 ---------------------\n');
fprintf('Kc: %.3f\n', Kc_gs11);
fprintf('Tau: %.3f\n', Tau_gs11);
fprintf('Theta: %.5f\n', Theta_gs11);
fprintf('--------------------- Modelo G22 ---------------------\n');
fprintf('Kc: %.3f\n', Kc_gs22);
fprintf('Tau: %.3f\n', Tau_gs22);
fprintf('Theta: %.5f\n', Theta_gs22);
fprintf('----------------- Controlador 1 IMC-A -----------------\n');
fprintf('Lambda: %.5f\n', lambda1);
fprintf('Kp: %.5f\n', Kp1);
fprintf('Ti: %.5f\n', Ti1);
fprintf('Td: %.5f\n', Td1);
fprintf('----------------- Controlador 2 IMC-A -----------------\n');
fprintf('Lambda: %.5f\n', lambda2);
fprintf('Kp: %.5f\n', Kp2);
fprintf('Ti: %.5f\n', Ti2);
fprintf('Td: %.5f\n', Td2);

%% Plot resposta em malha aberta para o modelo de fase minima
%{
figure
%% G11
subplot(2,2,1);
plot(simOut,U1t);
hold on;
plot(simOut,Yt_gs11, 'k');
grid on;
xlabel('Time (ms)');
ylabel('Amplitude');
title(sprintf('Resposta modelo\nfase mínima G11'));
axis auto
datacursormode on
%% G12
subplot(2,2,2);
plot(simOut,U1t);
hold on;
plot(simOut,Yt_gs12, 'k');
grid on;
xlabel('Time (ms)');
ylabel('Amplitude');
title(sprintf('Resposta modelo\nfase mínima G12'));
axis auto
datacursormode on
%% G21
subplot(2,2,3);
plot(simOut,U2t);
hold on;
plot(simOut,Yt_gs21, 'k');
grid on;
xlabel('Time (ms)');
ylabel('Amplitude');
title(sprintf('Resposta modelo\nfase mínima G21'));
axis auto
datacursormode on
%% G22
subplot(2,2,4);
plot(simOut,U2t);
hold on;
plot(simOut,Yt_gs22, 'k');
grid on;
xlabel('Time (ms)');
ylabel('Amplitude');
title(sprintf('Resposta modelo\nfase mínima G22'));
axis auto
datacursormode on
%}