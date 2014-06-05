function [mdot, data] = vacuum_ODE(t, m)

%% Given
gamma = 1.21;                     %
mdot_engine = 0.001 * 0.453592;   %(kg/s)
Pc = 300 * 6894.75729;            %(Pa)
Tc = 2165;                        %(K)
Vdot_pump = -40*0.00027777;       %(m^3/s)    
R = 461.5;                        %(j/kg-K) - assume water vapor gas constant

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
rho_c = Pc/(R*Tc);                        %(kg/m^3)
Tv = Tc*(rho_v/rho_c)^(gamma-1);          %(K)
Pv = rho_v*R*Tv;                          %(Pa)

%% Formulate Output
data.mdot = mdot;
data.Tc = Tc;
data.Pc = Pc;
data.rho_c = rho_c;
data.Tv = Tv;
data.Pv = Pv;
data.rho_v = rho_v;

end







