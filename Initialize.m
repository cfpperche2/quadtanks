% ------------------------------------------------
%         PARAMETERS
% ------------------------------------------------
% Set it up so calcs are made in SI units

% the variable h refers to height
% Diameters
P.dP = .25; % inner pipe diameter (inches)
P.dT = 10; % inner tank diameter (inches)

% height
P.hT = 18; % inner tank height (inches)

% density
P.rho = 1; % g/cm^3
P.g = 9.8; % acceleration of gravity (m/s^2)

% Convert to SI (specifically cm and g)
P.dP = 6*P.dP; % inner pipe diameter (centimeters)
P.dT = 2.54*P.dT; % inner tank diameter (centimeters)
P.hT = 2.54*P.hT; % inner tank height (centimeters)
P.g = P.g*100; % acceleration of gravity (cm/s^2)

% coefficient for flow out of the bottom of the tanks
P.Cf_tanks = (pi*(P.dP/2)^2)*(P.rho^1.5)*sqrt(2*P.g);

% Constants (to make calculations easier
P.C_HM = P.rho*(pi*(P.dT/2)^2);  % Convert from dhdt to dmdt
P.C_CM = (pi*(P.dP/2)^2)*P.rho;  % Convert from velocity to mass flow

% Make it even more convenient...
P.C1 = P.C_CM/P.C_HM;
P.C2 = P.Cf_tanks/P.C_HM;

% Velocities (they are static as of now)
P.v1_max = 500; % cm/s
P.v2_max = P.v1_max; % cm/s