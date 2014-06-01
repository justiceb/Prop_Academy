clc; clear; close all

%% Given
Thrust = 1;                %(N)
ISP = 250;                 %(s)
prop.rho = 1.46 * 1000;    %(kg/m^3)
prop.T = 298;              %(K)
prop.mu = 0.009;           %(Pa-s) dynamic viscosity [2]  
tube.OD = (1/8)*0.0254;    %(m)
tube.t = 0.020*0.0254;     %(m)
tube.eps =  0.002 * 0.001; %(m) tube roughness [1]  --> assume new stainless steel
valve.ID = 0.030 * 0.0254; %(m) valve orrifice size

%% Constants
g = 9.087;   %(m/s/s)

%% Calculations
mdot = Thrust/(ISP*g);

%Length of Straight Pipe
tube.ID = tube.OD - 2*tube.t;                   %(m)
tube.A = pi*(tube.ID/2)^2;                      %(m^2)
tube.V = mdot/(prop.rho*tube.A);                %(m/s) - velocity through tube
tube.RE = prop.rho*tube.V*tube.ID/prop.mu;      %
tube.f = 64/tube.RE;                            %darcy friction factor [3]  ---> assume laminar flow
syms L                                          %(m) length of tube  --->unknown
tube.dP = tube.f*(L/tube.ID)*(tube.V^2/(2*g));  %(Pa)

%Valve
valve.A = pi*(valve.ID/2)^2;                     %(m^2)
valve.V = tube.V*tube.A/valve.A;                 %(m/s) - velocity through valve
mu = 0.63 + 0.37*(valve.A/tube.A)^3;             %[4]
Kl_contraction = ((1/mu)-1)^2;                   %[5]
Kl_expansion = (1-(valve.A/tube.A))^2;           %[6]
dP_contraction = Kl_contraction*valve.V^2/(2*g); %
dP_expansion = Kl_expansion*valve.V^2/(2*g);     %
valve.dP = dP_contraction+dP_expansion;          %

%% Print Outputs
fprintf('Mass Flow Rate = %f [kg/s] \n',mdot);
fprintf('Tube Pressure Drop = %s [Pa] \n',char(vpa(tube.dP,3)));
fprintf('Valve Pressure Drop = %s [Pa] \n',valve.dP);

%% Reference
%{
[1] get roughness of pipe ---> http://bkhoshandam.tripod.com/MoodyDiagram.pdf
[2] get prop dynamic vicosity ---> http://www.engineeringtoolbox.com/absolute-viscosity-liquids-d_1259.html
[3] darcy friction factor ---> http://en.wikipedia.org/wiki/Colebrook_equation
[4] sudden contraction coefficient ---> http://en.wikipedia.org/wiki/Borda%E2%80%93Carnot_equation
[5] sudden contraction head loss coefficient ---> http://nptel.ac.in/courses/Webcourse-contents/IIT-KANPUR/FLUID-MECHANICS/lecture-14/14-7_losses_sudden_contract.htm
[6] sudden expansion head loss coefficient --> http://nptel.ac.in/courses/Webcourse-contents/IIT-KANPUR/FLUID-MECHANICS/lecture-14/14-6_losses_sudden_enlarg.htm
%}










