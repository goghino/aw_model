%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.


%Max 2-engine thrust [N]
par.max_thrust = 2*111205;

%Max steering angle
par.max_delta = 1.22; %rad
%steering angle when diff. braking starts
par.delta_lim = 0.8; %rad

% tire pressure [psi]
par.p_rated = 210; %http://www.b737.org.uk/techspecsdetailed.htm
par.p = 140;    %[psi]
par.diam = 1.2446;  %m [49 ins]
par.width = 0.4318; %m [17 ins]

%General Aircraft Weight [kg]
par.weight = 45420;
par.weight1 = 75000;
par.g = 9.80665;

%Aircraft inertia in Z-axis [kg*m^2]
par.Inertia_z = 3335000;

%Aircraft geometric model [m] source: J. Rankin
par.l_yT_R = 5.755;
par.l_yT_L = par.l_yT_R;
par.l_yL = 3.795;
par.l_yR = par.l_yL;

par.l_xT = 0;
par.l_xL = 1.450;
par.l_xR = par.l_xL;
par.l_xN = 11.235; 

par.l_zT = 1.229;
par.l_zL = 2.932;
par.l_zR = par.l_zL;
par.l_zN = 2.932;

%Aircraft geometric model [m] source: Boeing 737-400
% par.l_yT_R = 4.83;
% par.l_yT_L = par.l_yT_R;
% par.l_yL = 2.61;
% par.l_yR = par.l_yL;
% 
% par.l_xT = 0;
% par.l_xL = 3.73;
% par.l_xR = par.l_xL;
% par.l_xN = 10.54; 
% 
% par.l_zT = 1.229;
% par.l_zL = 2.932;
% par.l_zR = par.l_zL;
% par.l_zN = par.l_zL;

%Aircraft Aerodynamics
par.rho = 1.225; %[kg/m^3]
par.Sw = 122.4;  %[m^2]
par.Cx = 0.0674; %no unit

%Lateral Tire Friction polynom coeficients
%nose tire
par.c2_N = -3.53 * 10^(-6);
par.c1_N = 8.83 * 10^(-1);

par.c2_N_alpha = 3.52 * 10^(-9);
par.c1_N_alpha = 2.8*10^(-5);
par.c0_N_alpha = 13.8;

%right/left wheel
par.c2_RL = -7.39 * 10^(-7);
par.c1_RL = 5.11 * 10^(-1);

par.c2_RL_alpha = 1.34 * 10^(-10);
par.c1_RL_alpha = 1.06*10^(-5);
par.c0_RL_alpha = 6.72;

%Environment characteristics
%http://en.wikipedia.org/wiki/Rolling_resistance#Rolling_resistance_coefficient_examples
%http://hpwizard.com/tire-friction-coefficient.html
par.muR_dry = 0.008; %Truck tires on concrete
par.muR_wet = 0.007; %Truck tires on wet concrete
par.muR_ice = 0.011; %Truck tires on ice
par.muR_snow = 0.013; %Truck tire on hard-packed snow
par.muR_boeing = 0.02; %Boeing, J.Rankin

%velocity below which model will be discontinually reset to zero state
par.min_velo = 0.1; %m/s
par.min_force = par.g*par.weight*par.muR_boeing; %N