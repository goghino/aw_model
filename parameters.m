%load airplane parameters
boeing_767_params;

% Tracking method selection
% Defines which aero's point is tracked: either NOSE or GC
par.NOSE = 1;
par.CG = 2;
par.TRACKING = par.NOSE;

%INITIAL CONDITIONS FOR THE MODEL
par.vx_init = 0; %m/s
par.vy_init = 0; %m/s
par.wz_init = 0; %rad/s

%heading,zero=EAST, positive to pilot right hand (inverse unitary circle)
par.heading_init = atan2(txwyUTM_y(2)-txwyUTM_y(1), txwyUTM_x(2)-txwyUTM_x(1));%rad
%transform from -pi,pi to 0-2pi and inverse unitary circle direction
if(par.heading_init<0)
    par.heading_init = abs(par.heading_init);
else
    par.heading_init = 2*pi - par.heading_init;
end

%set starting position to first txwy waypoint
if(par.TRACKING == par.CG)
    par.x_init = txwyUTM_x(1); %m UTM Lon. format
    par.y_init = txwyUTM_y(1); %m UTM Lat. format
else
    %transform l_xN vector from BFF to nav
    x_nav = par.l_xN*cos(-par.heading_init);
    y_nav = par.l_xN*sin(-par.heading_init);
    
    %compensate for l_xN vector so that nose wheel is at starting point,
    %not CG
    par.x_init = txwyUTM_x(1)-x_nav; %m UTM Lon. format
    par.y_init = txwyUTM_y(1)-y_nav; %m UTM Lat. format
end

%TARGET CONDITIONS FOR THE MODEL
par.v_target = 5; %m/s

%environment settings
environ.dry = 1;
environ.wet = 2;
environ.ice = 3;
par.environ = environ.dry; 

%distance to target when model switches to next target
par.switch_distance = 4; %m
par.count_targets = length(txwyUTM_x);

%==========================================================================
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
% plot(X.Data, Y.Data, 'b-', XR.Data, YR.Data, 'r-',XL.Data, YL.Data, 'g-',XN.Data, YN.Data, 'k-');
% set_param('aero_ground_model', 'AlgebraicLoopSolver', 'LineSearch');
% set_param('aero_ground_model','AlgebraicLoopSolver','TrustRegion');

disp('MODEL INITIALIZED...');