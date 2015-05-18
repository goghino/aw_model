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

close all;
FONTSIZE = 22;
% ----------------------------------------------------------------
% Plot graphs of the aircraft's ground motion simulation
%-----------------------------------------------------------------
%VELOCITY and VELOCITY ERROR
figure();
set(gca,'FontSize',FONTSIZE);
targetVelo = ones(size(VELO.Time)) * par.v_target;
h = plot(VELO.Time, VELO.Data, 'k-', VELO.Time, targetVelo, 'r-');
set(h(1),'linewidth',3);
set(h(2),'linewidth',3);
grid on; grid minor;
legend('Velocity', 'Target Velocity', 'Location', 'best');
xlabel('Time [s]') % x-axis label
ylabel('Velocity [m.s^{-1}]') % y-axis label
title('Aircraft Taxi Velocity (target v=5 m.s^{-1})');

%PATHERROR
figure();
set(gca,'FontSize',FONTSIZE);
limitError = ones(size(PATHERROR.Time)) * par.switch_distance;
h = plot(PATHERROR.Time, PATHERROR.Data, 'k-', PATHERROR.Time, limitError, 'r-');
set(h(1),'linewidth',2);
set(h(2),'linewidth',3);
grid on; grid minor;
legend('Trajectory Offset', 'MAX Offset', 'Location', 'best');
xlabel('Time [s]') % x-axis label
ylabel('Offset [m]') % y-axis label
title('Aircraft Taxi Trajectory Offset');

%return;

%PATH and VELO ERR
figure();
set(gca,'FontSize',FONTSIZE);
h = plot(PATHERROR.Time, PATHERROR.Data, 'k-', VELO_ERR.Time, VELO_ERR.Data, 'r-');
set(h(1),'linewidth',3);
set(h(2),'linewidth',3)
grid on; grid minor;
legend('Trajectory Offset [m]', 'Velocity error [m.s^{-1}]' , 'Location', 'best');
xlabel('Time [s]'); % x-axis label
title('AutoTaxi Error');
set(gcf, 'color', 'none');
set(gca, 'color', 'none');
%xlim([0 400]);
%%ylim([a b])
%cd export_fig;
%export_fig test.png

% -----------------------------
% Plot Controller responses
%------------------------------
rad2deg = 57.2957795;

%HEADING ERROR AND CONTROLLER RESPONSE
figure();
set(gca,'FontSize',FONTSIZE);
h = plot(HEADING_ERR.Time, HEADING_ERR.Data*rad2deg, 'r-', HEADING_PID.Time, HEADING_PID.Data*rad2deg, 'k-');
set(h(1),'linewidth',4);
set(h(2),'linewidth',4);
grid on; grid minor;
legend('Heading Error', 'Controller Response', 'Location', 'northeast');
xlabel('Time [s]') % x-axis label
ylabel('Heading [deg]') % y-axis label
title('Directional Controller Response');

%PATH ERROR AND CONTROLLER RESPONSE
figure();
set(gca,'FontSize',FONTSIZE);
h = plot(PATH_ERR.Time, PATH_ERR.Data, 'r-', PATH_PID.Time, PATH_PID.Data, 'k-');
set(h(1),'linewidth',4);
set(h(2),'linewidth',4);
grid on; grid minor;
legend('Lateral Displacement', 'Controller Response', 'Location', 'northeast');
xlabel('Time [s]') % x-axis label
ylabel('Displacement [m]') % y-axis label
title('Lateral Displacement Controller Response');

%VELOCITY ERROR AND CONTROLLER RESPONSE
figure();
set(gca,'FontSize',FONTSIZE);
h = plot(VELO_ERR.Time, VELO_ERR.Data, 'r-', VELO_PID.Time, VELO_PID.Data, 'k-');
set(h(1),'linewidth',4);
set(h(2),'linewidth',4);
grid on; grid minor;
legend('Velocity Error', 'Controller Response', 'Location', 'best');
xlabel('Time [s]') % x-axis label
ylabel('Velocity [m.s^{-1}]') % y-axis label
title('Velocity Controller Response(target v=5 m.s^{-1})');

%VELOCITY ERROR AND BRAKES CONTROLLER RESPONSE
figure();
set(gca,'FontSize',FONTSIZE);
h = plot(V_DIFF.Time, V_DIFF.Data, 'r-', BRAKES.Time, BRAKES.Data, 'k-');
set(h(1),'linewidth',4);
set(h(2),'linewidth',4);
grid on; grid minor;
legend('Velocity Error', 'Controller Response', 'Location', 'northeast');
xlabel('Time [s]') % x-axis label
ylabel('Velocity [m.s^{-1}]') % y-axis label
title('Brake Controller Response');

%DIFF BRAKES CONTROLLER RESPONSE
figure();
set(gca,'FontSize',FONTSIZE);
limitDelta = ones(size(R_BRAKE.Time)) * par.delta_lim;
h = plot(STEER.Time, STEER.Data, 'r-', R_BRAKE.Time, R_BRAKE.Data, 'k', L_BRAKE.Time, L_BRAKE.Data, 'b-', L_BRAKE.Time,limitDelta,'k--',L_BRAKE.Time,limitDelta*(-1),'k--');
set(h(1),'linewidth',4);
set(h(2),'linewidth',3);
set(h(3),'linewidth',3);
set(h(4),'linewidth',3);
set(h(5),'linewidth',3);
grid on; grid minor;
legend('Steer Angle', 'R Brake', 'L Brake', 'Threshold');
xlabel('Time [s]') % x-axis label
ylabel('Steer [rad]') % y-axis label
title('Brake Controller Response');

%------------------------
%Trajectory visualization
%set experiment to INPUT = 'gpx\test_spiral'; and T=660s
%------------------------
figure();
set(gca,'FontSize',FONTSIZE);
h = plot(txwyUTM_x-txwyUTM_x(end), txwyUTM_y-txwyUTM_y(end), 'k-', XN.Data-txwyUTM_x(end), YN.Data-txwyUTM_y(end), 'b-');
grid on; grid minor;
set(h(1),'linewidth',3);
set(h(2),'linewidth',3);
xlabel('X [m]') % x-axis label
ylabel('Y [m]') % y-axis label
legend('Reference', 'Simulated');
% title('Aircraft Trajectory');
% axis equal;