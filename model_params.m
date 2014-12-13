function [Kc, tau, theta] = model_params(Ut,Yt)
    Kc = (Yt(end)-Yt(1)) / (Ut(end)-Ut(1));
    yt1 = (Kc*28.3)/100; 
    yt2 = (Kc*63.2)/100;
    t1=max(find(Yt(:,:)<=yt1));
    t2=max(find(Yt(:,:)<=yt2));
    tau = 3/2 * ( t2 - t1 )
    theta = t2 - tau
end