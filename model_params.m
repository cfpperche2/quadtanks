function [Kp, Tau, Theta] = model_params(Ut,Yt)
    Kp = (Yt(end)-Yt(1)) / (Ut(end)-Ut(1));
    Tau = Kp*0.63;
    Theta = 0;
end