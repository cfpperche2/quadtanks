%%
function [sys,x0,str,ts,simStateCompliance] = tank_dynamics(t,x,u,flag,P)
    switch flag,
        % Initialization
        case 0,
            [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(P);
        % Derivatives 
        case 1,
            sys=mdlDerivatives(t,x,u,P);
        % Update
        case 2,
            sys=mdlUpdate(t,x,u);
        % Outputs
        case 3,
            sys=mdlOutputs(t,x,u,P);
        % GetTimeOfNextVarHit
        case 4,
            sys=mdlGetTimeOfNextVarHit(t,x,u);
        % Terminate
        case 9,
            sys=mdlTerminate(t,x,u);
        % Unexpected flags
        otherwise
            DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
    end
end
%%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(P)
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
% Note that in this example, the values are hard coded.  This is not a
% recommended practice as the characteristics of the block are typically
% defined by the S-function parameters.
%
    sizes = simsizes;

    sizes.NumContStates  = 4;
    sizes.NumDiscStates  = 0;
    sizes.NumOutputs     = 4;
    sizes.NumInputs      = 4;
    sizes.DirFeedthrough = 0;
    sizes.NumSampleTimes = 1;   % at least one sample time is needed

    sys = simsizes(sizes);
    
    % initialize the initial conditions
    x0  = [0; 0;  0; 0];

    % str is always an empty matrix
    str = [];

    % initialize the array of sample times
    ts  = [0 0];

    % Specify the block simStateCompliance. The allowed values are:
    %    'UnknownSimState', < The default setting; warn and assume DefaultSimState
    %    'DefaultSimState', < Same sim state as a built-in block
    %    'HasNoSimState',   < No sim state
    %    'DisallowSimState' < Error out when saving or restoring the model sim state
    simStateCompliance = 'UnknownSimState';
end

%%
function sys=mdlDerivatives(t,x,u,P)
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
    h1 = x(1);
    h2 = x(2);
    h3 = x(3);
    h4 = x(4);  
  
    gamma1 = u(1);
    gamma2 = u(2);
    beta1        = u(3);
    beta2        = u(4);
    
    v1 = P.v1_max*beta1;
    v2 = P.v2_max*beta2;
    
    if h1 < 0  
      h1 = 0;
    end
  
    if h2 < 0
      h2 = 0;
    end
    
    if h3 < 0
      h3 = 0;
    end
    
    if h4 < 0
      h4 = 0;
    end
  
    h1_dot = (1-gamma2)*P.C1*v2 - P.C2*sqrt(h1);
    h2_dot = (1-gamma1)*P.C1*v1 - P.C2*sqrt(h2);
    h3_dot = gamma1*P.C1*v1 + P.C2*(sqrt(h1)-sqrt(h3));
    h4_dot = gamma2*P.C1*v2 + P.C2*(sqrt(h2)-sqrt(h4));
    
    % Assume that tanks are open
  
    if h3 >= P.hT && h3_dot >= 0 
        h3_dot = 0;
    end
    if h4 >= P.hT && h4_dot >= 0
      h4_dot = 0;  
    end     
    if h1 >= P.hT && h1_dot >= 0
        h1_dot = 0;
    end
    if h2 >= P.hT && h2_dot >= 0
        h2_dot = 0;
    end
    
    sys = [h1_dot; h2_dot;  h3_dot; h4_dot];
end

%%
function sys=mdlUpdate(t,x,u)
%=============================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=============================================================================
    sys = [];
end

%%
function sys=mdlOutputs(t,x,u,P)
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
    h1 = x(1);
    h2 = x(2);
    h3 = x(3);
    h4 = x(4);
    
    sys = [h1;h2;h3;h4];
end

%%
function sys=mdlGetTimeOfNextVarHit(t,x,u)
%=============================================================================
% mdlGetTimeOfNextVarHit
% Return the time of the next hit for this block.  Note that the result is
% absolute time.  Note that this function is only used when you specify a
% variable discrete-time sample time [-2 0] in the sample time array in
% mdlInitializeSizes.
%=============================================================================

    sampleTime = 1;    %  Example, set the next hit to be one second later.
    sys = t + sampleTime;
end

%%
function sys=mdlTerminate(t,x,u)
%=============================================================================
% mdlTerminate
% Perform any end of simulation tasks.
%=============================================================================
    sys = [];
end