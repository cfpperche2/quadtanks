close all; clear all; clc;
warning('off','all');

%% EXEMPLO MATLAB HELP REFERENCIA
% http://www.mathworks.com/help/control/examples/temperature-control-in-a-heat-exchanger.html#zmw57dd0e6207
% -----------------------------------

%% Must be defined

% Tempo de simulação
simulation_time = 300;

% Valores para entrada Ut1 (Step 1)
ut1_step_time = 50;
ut1_initial_value = 0;
ut1_final_value = 1;
ut1_sample_time = 0.01; %Precisão da amostra, influencia nos gráficos

% Valores para entrada Ut2 (Step 2)
ut2_step_time = 50;
ut2_initial_value = 0;
ut2_final_value = 1;
ut2_sample_time = 0.01; %Precisão da amostra, influencia nos gráficos

%% Para ver a resposta na fase minima
model_minimum_phase;
% Função model_evalute_params está com erro, precisa ser verificada
% definindo parametros do controladores manual mente
Kp1 = 0.87; Kp2 = Kp1;
Ti1 = 2.25; Ti2 = Ti1;
Td1 = 0; Td2 = Td1;
pid_minimum_phase;

%% Para ver a resposta na fase não minima
model_nonminimum_phase;
% Função model_evalute_params está com erro, precisa ser verificada
% definindo parametros do controladores manual mente
Kp1 = 0.78; Kp2 = Kp1;
Ti1 = 2.25; Ti2 = Ti1;
Td1 = 0; Td2 = Td1;
pid_nonminimum_phase;

close all;
t = [-10:0.001:200];
% Step response Minimum Phase

% G11
figure
%subplot(2,1,1);
step(Gmin(1,1),t);
hold on
grid on
axis auto
title(sprintf('Step response\nMinimum Phase - G[11]'));
datacursormode on
yy = heaviside(t);
plot(t,yy,'r')
% G22
figure
%subplot(2,1,2);
t = [-10:0.0001:200];
step(Gmin(2,2),t);
hold on
grid on
axis auto
title(sprintf('Step response\nMinimum Phase - G[22]'));
datacursormode on
yy = heaviside(t);
plot(t,yy,'r')

% Step response Nonminimum Phase


% G12
figure
%subplot(2,1,1);
step(Gnonmin(1,2),t);
hold on
grid on
axis auto
title(sprintf('Step response\nNonminimum Phase - G[12]'));
datacursormode on
yy = heaviside(t);
plot(t,yy,'r')

% G21
figure
%subplot(2,1,2);
[stepy stept] = step(Gnonmin(2,1),t);
plot(stept,stepy,'b');
hold on
grid on
VALUE = axis auto
title(sprintf('Step response\nNonminimum Phase - G[21]'));
datacursormode on
yy = heaviside(t);
plot(t,yy,'r')

Kc = (stepy(end)-stepy(1))/(yy(end)-yy(1));
TauY = Kc*0.63;
TauI = max(find(stepy<=TauY));
TauX = t(TauI);
plot(TauX,TauY,'.k','MarkerSize', 15) %horizontal line
plot([0 TauX],[TauY TauY],'k:') %horizontal line
plot([TauX TauX],[0 TauY],'k:') %vertical line
Str = strcat('\leftarrow \tau = ',num2str(TauX));
h = text(TauX*1.05, TauY*1.05, Str);
h.FontSize = 14;
set(h, 'rotation', 60);