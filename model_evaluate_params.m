function [kc, tau, theta] = model_evaluate_params(Ut,Yt)
%% ref: http://www.mathworks.com/help/control/examples/temperature-control-in-a-heat-exchanger.html#zmw57dd0e6207
    kc = (Yt(end)-Yt(1)) / (Ut(end)-Ut(1));
    yt1 = (kc*28.3)/100; 
    yt2 = (kc*63.2)/100;
    t1=max(find(Yt<=yt1));
    t2=max(find(Yt<=yt2));
    tau = 3/2 * ( t2 - t1 );
    theta = t2 - tau;
end