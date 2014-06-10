clc; clear; close all;

%% Given
SA_perplate = 10 * 0.092903;   %(m^2) heat transfer surface area per plate
N = 20;                        %number of plates
Aflux = SA_perplate*N;         %(m^2) flux area for heat transfer
g = 9.807;                     %(m/s/s) gravitational constant

%% Wall features
Twall = 293.15;                %(K) temperature of wall
L = 2 * 0.3048;                %(m) length of wall

%% Gas features
k = 0.065;                    %(W/(K-m)) thermal diffusivity
CP = 2.7508 * 1000;           %(J/KG-K) coefficient of pressure
T = 810;                      %(K) initial gas temp
rho = 0.0397;                 %(kg/m^3) initial density
h = CP*T;                     %(J/kg) initial specific enthalpy

i=0; t=0; dt = 0.0001; x = 0;
while x < L
    %% find dx
    mdot = 0.00045;       %(kg/s) mass flow rate
    Ahole = 0.00203;      %(m^2) oriffice area of heat exchanger
    V = mdot/(rho*Ahole); %(m/s) gas velocity through heat exchanger
    dx = V*dt;             %(m) distance progressed through the heat exchanger
    
    %% Calc heat transfer coefficient
    alpha = k/(rho*CP);         %(m^2/s) thermal diffusivity
    beta = 1/T;                 %(1/K) thermal expansion coefficient
    mu = 0.00003;               %(Pa*s) dynamic viscosity
    nu = mu/rho;                %(m^2/s) kinematic viscosity

    Ra = (g*beta*L^3)/(nu*alpha) * abs(Twall-T);                 %(SI) Rayleigh number
    Pr = nu/alpha;                                               %(SI) Prandtl number
    hc = (k/L)*(0.68+0.67*Ra^(1/4)/(1+(0.492/Pr)^(9/16))^(4/9)); %(W/m^2-K) heat transfer coefficient
    
    %% Calc heat transfer
    qdotdot = (Twall-T)*hc;           %(W/m^2) heat flux
    dq = qdotdot*dt*Aflux*(dx/L);     %(J) heat transferred this time step
    mass = rho*Ahole*dx;              %(kg) mass in control volume
    h = (h*mass+dq)/mass;             %(J/kg) new enthalpy
    T = h/CP;                         %(K) new temperature

    %% Move sim forward
    x = x+dx;             %(m) new distance from leading edge
    i = i+1;
    t = t+dt;             %(s) time step
    
    %% Save data
    data.T(i) = T;
    data.t(i) = t;
    data.x(i) = x;
    data.Ra(i) = Ra;
    
end

%% Plots
figure(1)
plot(data.x,data.T)
hold all
plot(get(gca,'xlim'), Twall*ones(1,2)); %plot horizontal line
xlabel('distance from leading edge (m)')
ylabel('Gas Temp (K)')
grid on
legend('Gass Temp','Wall Temp')

figure(2)
plot(data.x,data.Ra)
xlabel('distance from leading edge (m)')
ylabel('Ra')
grid on

