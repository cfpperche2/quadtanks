%% Tuning IMC without delay time
function [Kc Ti Td] = tuning_imc_wodelay(K, tau, theta, lambda, type)
    Kc=0;
    Ti = 0;
    Td = 0;
    if strcmp(type, 'P')
        Kc = tau/(K*theta);
    elseif strcmp(type, 'PI')
        Kc = tau/(K*lambda);
        Ti= tau;
    elseif strcmp(type, 'PID')
        Kc = 0;
        Ti = 0;
        Td = 0;
    end
end