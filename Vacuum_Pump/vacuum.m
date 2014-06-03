clc; clear; close all;
%{
Nomenclature
   c = engine chamber
   e = nozzle exit
   v = vacuum chamber
%}

%% Given
gamma = 1.21;              %
mdot = 0.001 * 0.453592;   %(kg/s)
Pc = 300 * 6894.75729;     %(Pa)
Tc = 2165;                 %(K)
Vdot_pump = 40*0.00027777; %(m^3/s)    
R = 461.5;                 %(j/kg-K) - assume water vapor gas constant

%% Constants
g = 9.807;                %(m/s/s)

%% Calculations
rho_c = Pc/(R*Tc);                        %(kg/m^3)
rho_v = mdot/Vdot_pump;                   %(kg/m^3)
Tv = Tc*(rho_v/rho_c)^(gamma-1);          %(K)
Pv = rho_v*R*Tv;                          %(Pa)

%% Print Outputs
fprintf('Rocket Chamber Temperature is %f [K] \n',Tc);
fprintf('Vacuum Chamber Temperature is %f [K] \n',Tv);
fprintf('Rocket Chamber Presure is %f [Pa] \n',Pc);
fprintf('Vacuum Chamber Pressure is %f [Pa] \n',Pv);



