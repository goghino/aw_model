close all;
% -----------------------------
% Plot some graphs
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