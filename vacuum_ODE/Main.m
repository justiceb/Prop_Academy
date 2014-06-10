clc; clear; close all;

%% run ode45 solver
timerange = [0, 30];
m0 = 0;
[t, m] = ode45(@vacuum_ODE, timerange, m0);

%run myfunc once last time to solve for dependant variables
for n = 1:1:length(t)
    [~, data_ODE] = vacuum_ODE(t(n), m(n));
    data(n) = data_ODE;
end
data = transpose_arrayOfStructs(data);

%% Plotting
figure(1)
subplot(3,2,1)
plot(t,m*1000)
xlabel('time (s)')
ylabel('Mass (g)')
grid on

subplot(3,2,2)
plot(t,data.mdot*1000)
xlabel('time (s)')
ylabel('Mass Flow Rate (g/s)')
grid on

Te_F = 1.8*(data.Te-273)+32;
Tv_F = 1.8*(data.Tv-273)+32;
subplot(3,2,3)
plot(t,Te_F,t,Tv_F)
xlabel('time (s)')
ylabel('Temperature (F)')
grid on
legend('Nozzle Exit','Vacuum Chamber')

subplot(3,2,4)
plot(t,data.Pv*0.000145037738)
xlabel('time (s)')
ylabel('Vacuum Chamber Pressure (psi)')
grid on

subplot(3,2,5)
plot(t,data.rho_v*1000)
xlabel('time (s)')
ylabel('Vacuum Chamber Density (gcm)')
grid on
