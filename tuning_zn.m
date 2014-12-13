function [Kc Ti Td] = zn(K, tau, theta, type)
    Kc=0;
    Ti = 0;
    Td = 0;
    if strcmp(type, 'P')
        Kc = tau/(K*theta);
    else if strcmp(type, 'PI')
        Kc = (0.9*tau)/(K*theta);
        Ti= 3*theta;
    else if strcmp(type, 'PID')
        Kc = (1.2*tau)/(K*theta);
        Ti = 2*theta;
        Td = theta/2;
    end
end