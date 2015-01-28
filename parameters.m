%INITIAL CONDITIONS FOR THE MODEL
par.vx_init = 0; %m/s
par.vy_init = 0; %m/s
par.wz_init = 0; %rad/s

par.kbr = 0.0;
par.kbl = 0.0;

par.x_init = 0; %m
par.y_init = 0; %m
par.heading_init = pi/2; %rad, inverse unitary circle convenction

%TARGET CONDITIONS FOR THE MODEL
par.v_target = 5; %m/s

par.x_targets = [0 30 90 150  180 200 200]; %m
par.y_targets = [-30 -90 -120 -120 -150 -200 0]; %m
%par.x_targets = [20 -20 20 -20 20 -20 20 -20 20 -20]; %m
%par.y_targets = [20 60 100 140 180 220 260 300 340 380]; %m

%distance to target when model switch next target
par.switch_distance = 4; %m

%environment settings
environ.dry = 1;
environ.wet = 2;
environ.ice = 3;
par.environ = environ.dry;

%Max 2-engine thrust [N]
par.max_thrust = 2*111205;

%Max steering angle
par.max_delta = 1.22; %rad

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

%Aircraft geometric model [m]
par.l_yT_R = 5.755;
par.l_yT_L = par.l_yT_R;
par.l_yL = 3.795;
par.l_yR = par.l_yL;
par.l_yN = 1;

par.l_xT = 0;
par.l_xL = 1.450;
par.l_xR = par.l_xL;
par.l_xN = 11.235;

par.l_zT = 1.229;
par.l_zL = 2.932;
par.l_zR = par.l_zL;
par.l_zN = 2.932;

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
par.min_velo = 0.0005; %m/s
par.min_force = par.g*par.weight*par.muR_boeing; %N

%---------------------------------
%Solver for weight decomposition
%----------------------------------
% Kb_l = 0;
% Kb_r = 0;
% mu_Beff = 0.6;
% K = (Kb_l + Kb_r)*mu_Beff;
% A = [1 2; (par.l_xN-par.muR_boeing*par.l_zN) 2*(-par.l_xR-par.muR_boeing*par.l_zR-K*par.l_zR)];
% B = [par.weight*par.g ; -par.l_zT*13000];
% linsolve(A,B);

%------------------------
%analytical turn radius
%------------------------
% L = par.l_xN + par.l_xR;
% steer = 0.7;
% 
% R_dash = L/sin(steer);
% R_dash_dash = R_dash * cos(steer);
% R = sqrt(par.l_xR^2 + R_dash_dash^2);

%------------------------
%Trajectory visualization
%------------------------
% tspan=0:0.1:100;
% sim('aero_ground_model',tspan);
% plot(X.Data, Y.Data, 'r-');
% set_param('aero_ground_model', 'AlgebraicLoopSolver', 'LineSearch');
% set_param('aero_ground_model','AlgebraicLoopSolver','TrustRegion');

disp('MODEL INITIALIZED...');