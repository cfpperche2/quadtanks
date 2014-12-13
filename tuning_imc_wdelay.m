%% Tuning IMC with delay time
function [Kp Ti Td] = tuning_imc_wdelay(K,tau, theta, lambda, type)
    Kp=0;
    Ti = 0;
    Td = 0;
    if strcmp(type, 'P')
        Kp = theta/(K*lambda);
    elseif strcmp(type, 'PI')
        Kp = (2*tau+theta)/(K*2*lambda);
        Ti= tau + (theta/2);
    elseif strcmp(type, 'PID')
        Kp = (2*tau+theta)/(K*(2*lambda+theta));
        Ti = tau + (theta/2);
        Td = (tau*theta)/(2*tau+theta);
    end
end