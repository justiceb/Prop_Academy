clc; clear; close all;

%% Given
SA_perplate = 10 * 0.092903;   %(m^2) heat transfer surface area per plate
N = 20;                        %number of plates
Aflux = SA_perplate*N;         %(m^2) flux area for heat transfer
g = 9.807;                     %(m/s/s) gravitational constant

%% Wall features --> constant temperature
Twall = 293.15;                %(K) temperature of wall
L = 2 * 0.3048;                %(m) length of wall
P = Aflux/L;                   %(m) effective perimeter of wall

%% Gas features
%constants
k = 0.065;                    %(W/(K-m)) thermal conductivity
CP = 2.7508 * 1000;           %(J/KG-K) coefficient of pressure
mdot = 0.00045;               %(kg/s) mass flow rate
rho = 0.0397;                 %(kg/m^3) initial density --> assume incompressible for the moment

%inlet properties
Ti = 810;                      %(K) initial gas temp
%outlet properties
syms To positive

for i = 1:1:2
    %logarithmic mean temperature
    Tlm = (To-Ti)/log(To/Ti);

    %gas properties
    alpha = k/(rho*CP);         %(m^2/s) thermal diffusivity
    beta = 1/Tlm;               %(1/K) thermal expansion coefficient
    mu = 0.00003;               %(Pa*s) dynamic viscosity
    nu = mu/rho;                %(m^2/s) kinematic viscosity
    Ra = (g*beta*L^3)/(nu*alpha) * abs(Twall-Tlm);                           %(SI) Rayleigh number
    Pr = nu/alpha;                                                           %(SI) Prandtl number
    %h_mean = (k/L)*(0.68+0.67*Ra^(1/4)/(1+(0.492/Pr)^(9/16))^(4/9));         %(W/m^2-K) heat transfer coefficient - Churchill and Chu method
    h_mean = 0.548*(k/L)*(L^3*rho^2*g*beta*CP*mu*abs(Twall-Tlm)/(mu^2*k))^0.25; %(W/m^2-K) heat transfer coefficient - Lauer method      
    
    %solve for unknown To
    if i == 1
        sol = solve( (Twall-To)/(Twall-Ti) == exp(-P*L*h_mean/(mdot*CP)) );
        To = double(sol);
    end
end

x = 0:0.01:L;
T = Twall - (Twall-Ti)*exp(-P*x*h_mean/(mdot*CP));

figure(1)
plot(x,T)
hold all
plot(get(gca,'xlim'), Twall*ones(1,2)); %plot horizontal line
xlabel('distance from leading edge (m)')
ylabel('Mean Gas Temperature (K)')
grid on
legend('Gass Temp','Wall Temp')

fprintf('mean heat transfer coefficient = %f [W/m^2-K] \n',h_mean)


