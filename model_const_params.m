%%
% Tank cross-section [cm^2]
A1 = 4.9; A2=A1; A3=A1; A4=A1; 
% Outlet hole cross-sections [cm^2]
a1 = 0.03; a2=a1; a3=a1; a4=a1; 
% Pump constants [cm^3 V^{-1} s^{-1}]
k1 = 1.6; k2=k1;
% Measurement constant [V cm^{-1}]
kc = 0.5; %10/16; % Measurement constant [V cm^{-1}] 0.5?!
% Acceleration of gravitation [cm s^{-2}]
g = 981; 
% Operating point in lower tank 1 [cm]
h10 = 10; 
% Operating point in lower tank 2 [cm]
h20 = 10; 
% Corresponding pump signal [V]
u10 = a1/k1*sqrt(2*g*h10); 
% Corresponding pump signal [V]
u20 = a2/k2*sqrt(2*g*h20); 