close all;
% -----------------------------
% Plot graphs of aero state
%------------------------------
%VELOCITY and VELOCITY ERROR
figure();
set(gca,'FontSize',25,'fontWeight','bold');
h = plot(VELO.Time, VELO.Data, 'k-', VELO_ERR.Time, VELO_ERR.Data, 'r-');
set(h(1),'linewidth',5);
set(h(2),'linewidth',5);
grid on; grid minor;
legend('Velocity', 'Velocity Error', 'Location', 'best');
xlabel('Time [s]') % x-axis label
ylabel('Velocity [m/s]') % y-axis label
title('Aeroplane Taxi Velocity (target v=5 m/s)');

%PATHERROR
figure();
set(gca,'FontSize',25,'fontWeight','bold');
h = plot(PATHERROR.Time, PATHERROR.Data, 'k-');
set(h(1),'linewidth',3);
grid on; grid minor;
legend('Patherror', 'Location', 'best');
xlabel('Time [s]') % x-axis label
ylabel('Patherror [m]') % y-axis label
title('Aeroplane Taxi Patherror');

%PATH and VELO ERR
figure();
set(gca,'FontSize',25,'fontWeight','bold');
h = plot(PATHERROR.Time, PATHERROR.Data, 'k-', VELO_ERR.Time, VELO_ERR.Data, 'r-');
set(h(1),'linewidth',3);
set(h(2),'linewidth',3)
grid on; grid minor;
legend('Patherror [m]', 'Velocity error [m/s]' , 'Location', 'best');
xlabel('Time [s]'); % x-axis label
title('AutoTaxi Error');
set(gcf, 'color', 'none');
set(gca, 'color', 'none');
%xlim([0 400]);
%cd export_fig;
%export_fig test.png

% -----------------------------
% Plot Controller responses
%------------------------------

%HEADING ERROR AND CONTROLLER RESPONSE
figure();
set(gca,'FontSize',25,'fontWeight','bold');
h = plot(HEADING_ERR.Time, HEADING_ERR.Data, 'r-', HEADING_PID.Time, HEADING_PID.Data, 'k-');
set(h(1),'linewidth',5);
set(h(2),'linewidth',5);
grid on; grid minor;
legend('Heading Error', 'Controller Response', 'Location', 'northeast');
xlabel('Time [s]') % x-axis label
ylabel('Heading [rad]') % y-axis label
title('Heading Controller Response');

%PATH ERROR AND CONTROLLER RESPONSE
figure();
set(gca,'FontSize',25,'fontWeight','bold');
h = plot(PATH_ERR.Time, PATH_ERR.Data, 'r-', PATH_PID.Time, PATH_PID.Data, 'k-');
set(h(1),'linewidth',5);
set(h(2),'linewidth',5);
grid on; grid minor;
legend('Lateral Displacement', 'Controller Response', 'Location', 'northeast');
xlabel('Time [s]') % x-axis label
ylabel('Displacement [m]') % y-axis label
title('Lateral Displacement Controller Response');

%VELOCITY ERROR AND CONTROLLER RESPONSE
figure();
set(gca,'FontSize',25,'fontWeight','bold');
h = plot(VELO_ERR.Time, VELO_ERR.Data, 'r-', VELO_PID.Time, VELO_PID.Data, 'k-');
set(h(1),'linewidth',5);
set(h(2),'linewidth',5);
grid on; grid minor;
legend('Velocity Error', 'Controller Response', 'Location', 'best');
xlabel('Time [s]') % x-axis label
ylabel('Velocity [m/s]') % y-axis label
title('Velocity Controller Response(target v=5 m/s)');

%VELOCITY ERROR AND BRAKES CONTROLLER RESPONSE
figure();
set(gca,'FontSize',25,'fontWeight','bold');
h = plot(V_DIFF.Time, V_DIFF.Data, 'r-', BRAKES.Time, BRAKES.Data, 'k-');
set(h(1),'linewidth',5);
set(h(2),'linewidth',5);
grid on; grid minor;
legend('Velocity Error', 'Controller Response', 'Location', 'northeast');
xlabel('Time [s]') % x-axis label
ylabel('Velocity [m/s]') % y-axis label
title('Brakes Controller Response');

%DIFF BRAKES CONTROLLER RESPONSE
figure();
set(gca,'FontSize',25,'fontWeight','bold');
h = plot(STEER.Time, STEER.Data, 'r-', R_BRAKE.Time, R_BRAKE.Data, 'k', L_BRAKE.Time, L_BRAKE.Data, 'b-');
set(h(1),'linewidth',5);
set(h(2),'linewidth',4);
set(h(3),'linewidth',4);
grid on; grid minor;
legend('Steer Angle', 'R Brake', 'L Brake', 'Location', 'northeast');
xlabel('Time [s]') % x-axis label
ylabel('Steer [rad]') % y-axis label
title('Brakes Controller Response');

%------------------------
%Trajectory visualization
%set experiment to INPUT = 'gpx\test_spiral'; and T=660s
%------------------------
% figure();
% set(gca,'FontSize',25,'fontWeight','bold');
% h = plot(txwyUTM_x-txwyUTM_x(end), txwyUTM_y-txwyUTM_y(end), 'k-', XN.Data-txwyUTM_x(end), YN.Data-txwyUTM_y(end), 'b-');
% grid on; grid minor;
% set(h(1),'linewidth',5);
% set(h(2),'linewidth',4);
% xlabel('X [m]') % x-axis label
% ylabel('Y [m]') % y-axis label
% legend('Reference traj', 'Simulated traj', 'northeast');
% title('Lateral displacement minimisation');
% axis equal;

%xlim([0 N])