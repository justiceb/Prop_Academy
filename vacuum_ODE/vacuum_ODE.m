function [mdot, data] = vacuum_ODE(t, m)

%% Given
gamma_e = 1.2525;                 %          -CEA
CP_e = 1.8984 * 1000;             %(J/kg-K)  -CEA
CV_e = CP_e/gamma_e;              %(J/kg-K)  -CEA
R_e = CP_e - CV_e;                %(j/kg-K)  -CEA
mdot_engine = 0.001 * 0.453592;   %(kg/s)
Pe = 0.23664 * 100000;            %(Pa)      -CEA
Te = 943.03;                      %(K)       -CEA
rho_e = 6.5575E-2;                %(kg/m^3)  -CEA
Vdot_pump = -40*0.00027777;       %(m^3/s)   -assume constant over pressure range

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







