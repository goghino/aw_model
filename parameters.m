%Max engine thrust [N]
par.max_thrust = 111205;

%General Aircraft Weight [kg]
par.weight = 45420;
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

% tire pressure [psi]
par.pressure = 200; %http://www.b737.org.uk/techspecsdetailed.htm

%environment settings
environ.dry = 1;
environ.wet = 2;
environ.snow = 3;
environ.ice = 4;
par.environ = environ.dry;

%Environment characteristics
%http://en.wikipedia.org/wiki/Rolling_resistance#Rolling_resistance_coefficient_examples
%http://hpwizard.com/tire-friction-coefficient.html
par.muR_dry = 0.008; %Truck tires on concrete
par.muR_wet = 0.007; %Truck tires on wet concrete
par.muR_ice = 0.011; %Truck tires on ice
par.muR_snow = 0.013; %Truck tire on hard-packed snow
par.muR_boeing = 0.02; %Boeing, J.Rankin



%tspan=0:0.1:100;
%sim('aero_ground_model',tspan);
%plot(sn(:,1),sn(:,2), 'k-', sl(:,1),sl(:,2), 'b-', sr(:,1),sr(:,2), 'r-');
%plot(X.Data, Y.Data, 'r-');

%A = [1 2; (par.l_xN-par.mu_R*par.l_zN) 2*(-par.l_xR-par.mu_R*par.l_zR)];
%B = [par.weight*par.g ; -par.l_zT*par.max_thrust];
%linsolve(A,B);