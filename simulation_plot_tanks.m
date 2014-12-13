%% 
function simulation_plot_tanks(u)
% hi == 1 Full tank
% To init the time must be 0
    t = u(5);

    h1 = u(1);
    h2 = u(2);
    h3 = u(3);
    h4 = u(4);

    persistent ULPatch;
    persistent URPatch;
    persistent LLPatch;
    persistent LRPatch;

    PW = 25;     % piping width (just for visual)
    bS = 1000;   % Half of the box size (just for visual)
    vH = 100;    % valve height
    vW = 60;     % valve width
    tW = 500;    % Tank Width
    tH = 700;    % Tank Height
    D = 40;      % Distance between pipe and Tank

% Piping 1
% ----------------------------------
    LeftPiping = [-bS, -bS;...
                  -bS, -vH/2;...
                  -bS+PW, -vH/2;...
                  -bS+PW,-bS];

    LeftPipingSide = [-bS+PW/2+vH/2, 0;...
                      -bS/2, 0;...
                      -bS/2, -3*PW;...
                      -bS/2-PW, -3*PW;...
                      -bS/2-PW, -PW;... 
                      -bS+PW/2+vH/2, -PW]; 

    RightPiping = LeftPiping;
    RightPiping(:,1) = -RightPiping(:,1);

    RightPipingSide = LeftPipingSide;
    RightPipingSide(:,1) = -RightPipingSide(:,1);

% Valves
% ----------------------------------
    gamma = (vW - PW)/2;  % distance of the valve end from the pipe

    LeftValve = [ -bS-gamma , 0-vH/2; ...
                    -bS+PW+gamma, 0-vH/2; ...
                    -bS+PW/2,0; ...
                    -bS-gamma ,0+vH/2; ...
                    -bS+PW+gamma, 0+vH/2; ...
                    -bS+PW/2,0; ...
                    -bS+PW/2+vH/2, vW/2; ...
                    -bS+PW/2+vH/2, -vW/2; ...
                    -bS+PW/2,0; ...
                    -bS-gamma , 0-vH/2];

    RightValve = LeftValve;

    RightValve(:,1) = -RightValve(:,1);

% Piping 2 
% ------------------------------------

    LeftPiping2 = [ -bS, vH/2; ...
                    -bS, bS-(.1*bS); ...
                    bS/2+PW, bS-(.1*bS); ...
                    bS/2+PW, bS-(.1*bS)-3*PW; ...
                    bS/2, bS-(.1*bS)-3*PW; ...
                    bS/2, bS-(.1*bS)-PW; ...
                    -bS+PW, bS-(.1*bS)-PW; ...
                    -bS+PW, vH/2];

    RightPiping2 = [ bS, vH/2; ...
                    bS, bS; ...
                    -bS/2-PW, bS; ...
                    -bS/2-PW, bS-3.3*PW; ...
                    -bS/2, bS-3.3*PW; ...
                    -bS/2, bS-PW; ...
                    bS-PW, bS-PW; ...
                    bS-PW, vH/2];

    RightPiping3 = [ -bS/2-PW, bS-(.1*bS)-3*PW; ...
                    -bS/2, bS-(.1*bS)-3*PW ; ...
                    -bS/2, bS-(.1*bS)-1.5*PW; ...
                    -bS/2-PW, bS-(.1*bS)-1.5*PW; ...
                    -bS/2-PW, bS-(.1*bS)-3*PW] ;

% Outline for the Tanks
% ---------------------------------------
    LeftUpperTank = [-bS/2-PW+tW/2 ,bS-(.1*bS)-3*PW-D; ...
                     -bS/2-PW+tW/2 , bS-(.1*bS)-3*PW-D; ...
                     -bS/2-PW+tW/2 , bS-(.1*bS)-3*PW-D-tH; ...
                     -bS/2+3*PW+PW , bS-(.1*bS)-3*PW-D-tH; ...
                     -bS/2+3*PW, bS-(.1*bS)-3*PW-D-tH; ...
                     -bS/2-PW-tW/2 , bS-(.1*bS)-3*PW-D-tH; ...
                     -bS/2-PW-tW/2 , bS-(.1*bS)-3*PW-D];

    RightUpperTank = LeftUpperTank;
    RightUpperTank(:,1) = -RightUpperTank(:,1);

    % short cut to create lower tanks
    Beta = max(LeftUpperTank(:,2));
    Const = Beta - (-3*PW - D);

    RightLowerTank = RightUpperTank;
    RightLowerTank(:,2) = RightLowerTank(:,2) - Const;

    LeftLowerTank = LeftUpperTank;
    LeftLowerTank(:,2) = LeftLowerTank(:,2) - Const;

%Pipes Connecting the upper tank to the lower tank
% ----------------------------------------------------
    LeftConnector = [  -bS/2+3*PW , bS-(.1*bS)-3*PW-2*D-tH+40; ...
                       -bS/2+3*PW+PW , bS-(.1*bS)-3*PW-2*D-tH+40;...
                       -bS/2+3*PW+PW,bS-(.1*bS)-3*PW-Const; ...
                       -bS/2+3*PW, bS-(.1*bS)-3*PW-Const; ...
                       -bS/2+3*PW , bS-(.1*bS)-3*PW-2*D-tH+40];

    RightConnector = LeftConnector;
    
    RightConnector(:,1) = -LeftConnector(:,1);

%Pipes Connecting the lower tank to the reservoir
% ----------------------------------------------------   
    LeftExitConnector = [  -bS/2+3*PW , bS-(1.0*bS)-3*PW-2*D-tH+40; ...
                       -bS/2+3*PW+PW , bS-(1.0*bS)-3*PW-2*D-tH+40;...
                       -bS/2+3*PW+PW,bS-(1.0*bS)-3*PW-Const; ...
                       -bS/2+3*PW, bS-(1.0*bS)-3*PW-Const; ...
                       -bS/2+3*PW , bS-(1.0*bS)-3*PW-2*D-tH+40];
    
    
    RightExitConnector = LeftExitConnector;
    
    RightExitConnector(:,1) = -LeftExitConnector(:,1);

    
% polygon representing water level
% ------------------------------------------

    Space = 10;

% x points
    xUL = [-bS/2-PW-tW/2+Space, -bS/2-PW+tW/2-Space];
    xLL = xUL;
    xUR = -xUL;
    xLR = xUR;

% y points
    yUL = [bS-(.1*bS)-3*PW-D-tH+Space+h1*(tH-2*Space), bS-(.1*bS)-3*PW-D-tH+Space];
    yUR = [bS-(.1*bS)-3*PW-D-tH+Space+h2*(tH-2*Space), bS-(.1*bS)-3*PW-D-tH+Space];
    yLL = [bS-(.1*bS)-3*PW-D-tH+Space+h3*(tH-2*Space), bS-(.1*bS)-3*PW-D-tH+Space];
    yLL = yLL - Const;
    yLR = [bS-(.1*bS)-3*PW-D-tH+Space+h4*(tH-2*Space), bS-(.1*bS)-3*PW-D-tH+Space];
    yLR = yLR - Const;


    xPolyUL = [xUL(1),xUL(2),xUL(2),xUL(1)];
    yPolyUL = [yUL(1),yUL(1),yUL(2),yUL(2)];
    xPolyUR = [xUR(1),xUR(2),xUR(2),xUR(1)];
    yPolyUR = [yUR(1),yUR(1),yUR(2),yUR(2)];
    xPolyLL = [xLL(1),xLL(2),xLL(2),xLL(1)];
    yPolyLL = [yLL(1),yLL(1),yLL(2),yLL(2)];
    xPolyLR = [xLR(1),xLR(2),xLR(2),xLR(1)];
    yPolyLR = [yLR(1),yLR(1),yLR(2),yLR(2)];
    z = [1,1,1,1];

    if t == 0
        figure;
        clf;
        % Form the plots, Use handles to change colors with operatin conditions
        % -----------------------------------------------------------------------
        hold on
        axis manual
        % PLOTTIING For the structure 

        % bottom piping (furthest upstream/connection to bottom tanks) [ Green is flowing, black is empty]
        plot(LeftPiping(:,1),LeftPiping(:,2),'k',LeftPipingSide(:,1),LeftPipingSide(:,2),'k');
        plot(RightPiping(:,1),RightPiping(:,2),'k',RightPipingSide(:,1),RightPipingSide(:,2),'k');

        % Valves [ Color Convention] 
        lValvePlot = plot(LeftValve(:,1),LeftValve(:,2),'b');
        rValvePlot = plot(RightValve(:,1),RightValve(:,2),'b');

        % Top piping (connection to the top tanks)
        plot(LeftPiping2(:,1),LeftPiping2(:,2),'k');
        plot(RightPiping2(:,1),RightPiping2(:,2),'k',RightPiping3(:,1), RightPiping3(:,2), 'k');

        % Tanks 
        plot(LeftUpperTank(:,1),LeftUpperTank(:,2),'k');
        
        plot(RightUpperTank(:,1),RightUpperTank(:,2),'k');
        
        plot(LeftLowerTank(:,1),LeftLowerTank(:,2),'k');

        plot(RightLowerTank(:,1),RightLowerTank(:,2),'k');

        % connection between upper and lower tanks
        plot(LeftConnector(:,1),LeftConnector(:,2),'k');
        plot(RightConnector(:,1),RightConnector(:,2),'k');

        % connection between upper and reservoir
        plot(LeftExitConnector(:,1),LeftExitConnector(:,2),'k');
        plot(RightExitConnector(:,1),RightExitConnector(:,2),'k');
        
        % Handles For Plotting for Tank Level 
        ULPatch = fill(xPolyUL,yPolyUL,'c','EraseMode', 'Normal');
        URPatch = fill(xPolyUR,yPolyUR,'c','EraseMode', 'Normal');
        LLPatch = fill(xPolyLL,yPolyLL,'c','EraseMode', 'Normal');
        LRPatch = fill(xPolyLR,yPolyLR,'c','EraseMode', 'Normal');

    % Annotations 
    % ---------------------------
        ULy = (bS-(.1*bS)-3*PW-3*D)/1.5;
        ULx = -bS;
        URy = ULy;
        URx = -ULx;
        LLy = ULy - Const;

        URx = URx/2.4;
        LRy = LLy;
        LRx = URx;

        ULx = ULx/1.6;
        LLx = ULx;

        set(0,'DefaultTextFontSize', 10);
        text(ULx,ULy,'Tank 3');
        text(URx,URy,'Tank 4');
        text(LLx,LLy,'Tank 1');
        text(LRx,LRy,'Tank 2');

        set(0,'DefaultTextFontSize', 14);
        text(-bS-200,0,'\gamma 1');
        text(bS+100,0,'\gamma 2');

        axis([-1200,1200,-1100,1300])
    else 
        ULPatch = updatePlot(yPolyUL,ULPatch);
        URPatch = updatePlot(yPolyUR,URPatch);
        LLPatch = updatePlot(yPolyLL,LLPatch);
        LRPatch = updatePlot(yPolyLR,LRPatch);    
    end
end


function handle = updatePlot(y,handle)
    set(handle,'Ydata',y);
    %set(handle,'ColorSpec',[0 1 0]);
    drawnow
end