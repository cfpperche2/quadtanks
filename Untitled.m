Ts = 0.0001;
%Continuous system
Ps = tf(2,[1,12,20.02]);
Pz = c2d(Ps,Ts,'zoh');
%response
[y,t] = step(Pz);
figure
plot(t,y);
hold on;
% Estimate the 2nd deriv. by finite differences
ypp = diff(y,2);  
% Find the root using FZERO
t_infl = fzero(@(T) interp1(t(2:end-1),ypp,T,'linear','extrap'),0)
y_infl = interp1(t,y,t_infl,'linear')
plot(t_infl,y_infl,'ro');

%{
figure
plot(simOut,U1t);
hold on;
plot(simOut,Yt_gs12, 'r');
grid on;
xlabel('Time (ms)');
ylabel('Amplitude');
title(sprintf('Resposta modelo\nfase não mínima G12(s)'));
axis([min(simOut) max(simOut) -max(Yt_gs12)/2 max(Yt_gs12)])
datacursormode on 
%}

h = 0.001;       % step size
X = -pi:h:pi;    % domain
f = sin(X);      % range
Y = diff(f)/h;   % first derivative
Z = diff(Y)/h;   % second derivative
plot(X(:,1:length(Y)),Y,'r',X,f,'b', X(:,1:length(Z)),Z,'k')