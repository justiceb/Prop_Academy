function [mdot, data] = vacuum_ODE(t, m)

%% Given
gamma_e = 1.2797;                 %
CP_e = 1.7509 * 1000;             %(J/kg-K)
CV_e = CP_e/gamma_e;                %(J/kg-K)
R_e = CP_e - CV_e;                %(j/kg-K) - assume water vapor gas constant
mdot_engine = 0.001 * 0.453592;   %(kg/s)
Pe = 0.22655 * 100000;            %(Pa)
Te = 872.39;                      %(K)
rho_e = 6.785E-2;                 %(kg/m^3)
Vdot_pump = -40*0.00027777;       %(m^3/s)    

%% Calculations
% Chamber Geometry
r = 7.75;                                          %(in)
L = 20;                                            %(in)
volume = (pi*r^2*L + (4/3)*pi*r^3) * 1.63871e-5;   %(m^3)

%mdot
rho_v = m/volume;
mdot_pump = rho_v * Vdot_pump;
mdot = mdot_engine + mdot_pump;

%Isentropic expansion
Tv = Te*(rho_v/rho_e)^(gamma_e-1);          %(K)
Pv = rho_v*R_e*Tv;                          %(Pa)

%% Formulate Output
data.mdot = mdot;
data.Te = Te;
data.Pe = Pe;
data.rho_e = rho_e;
data.Tv = Tv;
data.Pv = Pv;
data.rho_v = rho_v;

end







