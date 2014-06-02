clc; clear; close all;
%{
Nomenclature
   c = engine chamber
   e = nozzle exit
   v = vacuum chamber
%}

%% Given
Te = 2165;                 %(K)
gamma = 1.21;              %
mdot = 0.001 * 0.453592;   %(kg/s)
Pc = 300 * 6894.75729;     %(Pa)
Pamb = 0;                  %(Pa)
Isp = 250;                 %(s)
Vdot_pump = 46*0.00027777; %(m^3/s)    
R = 461.5;                 %(j/kg-K) - assume water vapor gas constant

%% Constants
g = 9.807;                %(m/s/s)

%% Calculations
%Thruster Properties
Ve = Isp*g;                              %(m/s) - effective exhaust velocity
Me = Ve/sqrt(gamma*R*Te);                %
Tc = Te*(1+(gamma-1)/2*Me^2);            %(K)
Pe = Pc*(Te/Tc)^(gamma/(gamma-1));       %(Pa)
rho_e = Pe/(R*Te);                       %(kg/m^3)

%Chamber Properties
rho_v = mdot/Vdot_pump;                   %(kg/m^3)
Tv = Te*(rho_v/rho_e)^(gamma-1);          %(K)
Pv = rho_v*R*Tv;                          %(Pa)

%% Print Outputs
fprintf('Rocket Chamber Temperature is %f [K] \n',Tc);
fprintf('Nozzle Exit Temperature is %f [K] \n',Te);
fprintf('Vacuum Chamber Temperature is %f [K] \n',Tv);
fprintf('Rocket Chamber Presure is %f [Pa] \n',Pc);
fprintf('Nozzle Exit Pressure is %f [Pa] \n',Pe);
fprintf('Vacuum Chamber Pressure is %f [Pa] \n',Pv);



