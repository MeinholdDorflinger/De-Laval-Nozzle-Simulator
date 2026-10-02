clear;clc;clf;

% Define the Nozzle's Geometry
x=-2:0.2:3;                    % Unequal magnitude of domain ends gives an asymmetrical nozzle
y_top = 1/23.415*x.^2+1;       
y_bottom = -1/23.415*x.^2-1;

% Calulate Radius, Area, and Area to Throat-Area ratio
r = y_top;  
r_throat = 1;
area = pi*r.^2;
area_throat = pi*r_throat.^2;
area_ratio = area./area_throat;

% Define Initial Values
gamma = 1.4;
R = 287;              % J/(kg*K)
T_0 = 3000;           % Kelvin
P_0 = 1000000;        % Pascal
P_ambient = 101325;   % Pascal

% Calculate Mach numbers from area_Mach relation using fzero function
M = zeros(size(x));

for i = 1:length(x)

    m_fcn = @(m) (1./m^2)*((2/(gamma+1))*(1+((gamma-1)/2)*m^2))^((gamma+1)/(gamma-1))-area_ratio(i)^2;    
    if x(i)<0
        M(i) = fzero(m_fcn, [0.001, 0.999]); % Make guesses on where Mach number lies (subsonic)
    elseif x(i) == 0
        M(i) = 1;
    else
        M(i) = fzero(m_fcn, [1.001, 10]);    % Make guesses on where Mach number lies (supersonic)
    end
end

P = P_0*(1 + ((gamma-1)/2).*M.^2).^(-gamma/(gamma-1));   % Pascals
T = T_0*(1 + ((gamma-1)/2).*M.^2).^(-1);                 % Kelvin
v = M.*sqrt(gamma.*R.*T);                                % meters per second
rho = P./(R.*T);                                         % kg/m^3
m_dot = rho.*area.*v;                                    % kg/s

% Calculate values for Momentum and Pressure Thrust (Newtons)
F_total = m_dot(end)*v(length(x))+(P(length(x)) - P_ambient).*area(length(x));
F_momentum = m_dot(end)*v(end);
F_pressure = (P(length(x)) - P_ambient).*area(length(x));


% Map out distributions for all Thermodynamic Properties
subplot(3,2,1)
plot(x, y_top); hold on;
plot(x, y_bottom); hold on;
title('De Laval Nozzle')
grid on;

subplot(3,2,2)
plot(x, M)
title('Mach')
grid on;

subplot(3,2,3)
plot(x, T)
title("Temperature (K)")
grid on;

subplot(3,2,4)
plot(x, P)
title('Pressure (Pascal)')
grid on;

subplot(3,2,5)
plot(x, v)
title('Velocity (m/s)')
grid on;

subplot(3,2,6)
plot(x, m_dot)
title('Mass Flow Rate (kg/s)')
grid on;

% Calculate Exit Pressure to Ambient Pressure Ratio and determine if
% Ideally Expanded, Underexpanded Nozzle, or Overexpanded Nozzle
exit_pressure_ratio = P(length(x))/P_ambient;

if (0.95 <= P(end)/P_ambient) &&  (P(end)/P_ambient <= 1.05)
    expansion_condition = 'Ideally Expanded';
elseif P(end)/P_ambient > 1.05 
    expansion_condition = 'Underexpanded Nozzle';
else 
    expansion_condition = 'Overexpanded Nozzle';
end

% Display all numerical outputs
fprintf('Exit Mach %.2f \n', M(end));
fprintf('Exit Pressure %.2f kPa \n', P(end)/1000);
fprintf('Ambient Pressure %.2f kPa \n', P_ambient/1000);
fprintf('Expansion Condition: %s \n', expansion_condition);
fprintf('Momentum Thrust %.2f kN \n', F_momentum/1000);
fprintf('Pressure Thrust %.2f kN \n', F_pressure/1000);
fprintf('Total Thrust %.2f kN \n', F_total/1000);

