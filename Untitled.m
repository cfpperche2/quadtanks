Ts = 0.0005;
%Continuous system
Ps = tf(2,[1,12,20.02]);
Pz = c2d(Ps,Ts,'zoh');
%response
[y,t] = step(Pz);
plot(t,y);
hold on;
% Estimate the 2nd deriv. by finite differences
ypp = diff(y,2);  
% Find the root using FZERO
t_infl = fzero(@(T) interp1(t(2:end-1),ypp,T,'linear','extrap'),0)
y_infl = interp1(t,y,t_infl,'linear')
plot(t_infl,y_infl,'ro');