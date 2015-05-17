%Boeing 747-300 parameters
v = 10;             %m/s [10 knots] 
Kb = 0;             %braking ratio
alpha = 0.01;       %[rad]
Fz_total = 140000;        %[N]
Fz = 40000;

%tire spec [AGARD and http://www.b737.org.uk/techspecsdetailed.htm]
diam = 1.2446;  %m [49 ins]
width = 0.4318; %m [17 ins]
p = 140;    %[psi]
pr = 210;   %[psi] 220 web

%constants
DRY = 0;
WET = 1;
ICE = 2;

% x==0.2 at rated load
xxx = Fz / (p * diam*39.3701 * sqrt(width*39.3701*diam*39.3701));

close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BRAKING COEFFICIENT in various ENVIRON and speed
Fy = zeros(61,1);
Fy1 = zeros(61,1);
Fy11 = zeros(61,1);
Fy2 = zeros(61,1);
Fy3 = zeros(61,1);
Fy4 = zeros(61,1);

velo = 0:0.5:30;

for i = 1:61
    Fy(i)  = braking_friction(DRY,p,velo(i));
    Fy1(i)  = braking_friction(WET,p,velo(i));
    Fy11(i)  = braking_friction(ICE,p,velo(i));
    Fy2(i)  = braking_friction(DRY,0.8*p,velo(i));
    Fy3(i)  = braking_friction(WET,0.8*p,velo(i));
    Fy4(i)  = braking_friction(ICE,0.8*p,velo(i));

end

figure();
set(gca,'FontSize',25);
set(findall(gcf,'type','text'),'FontSize',25);
h = plot(velo, Fy, 'b-', velo, Fy1, 'r-', velo, Fy11, 'g-', velo, Fy2, 'bo', velo, Fy3, 'ro');
set(h(1),'linewidth',2);
set(h(2),'linewidth',2);
set(h(3),'linewidth',2);
set(h(4),'linewidth',2);
set(h(5),'linewidth',2);
legend('nominal DRY','nominal WET', 'nominal ICE', '0.8p DRY','0.8p WET','Location','southeast');
xlabel('Velocity [m/s]') % x-axis label
ylabel('Friction coeff.') % y-axis label
title('Effective Braking Friction Coefficient vs. Speed');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%DRY LATERAL FORCE COEFF plot vs. yaw angle
Fy = zeros(315,1);
Fy1 = zeros(315,1);
Fy2 = zeros(315,1);
Fy3 = zeros(315,1);
Fy4 = zeros(315,1);

alpha_i = -pi/2:0.01:pi/2;

for i = 1:315
    Fy(i)  = lateral_friction(DRY,alpha_i(i),Fz,p,pr,diam,width,v,Kb);
    Fy1(i) = lateral_friction(DRY,alpha_i(i),0.8*Fz,p,pr,diam,width,v,Kb);
    Fy2(i) = lateral_friction(DRY,alpha_i(i),1.2*Fz,p,pr,diam,width,v,Kb);
    Fy3(i) = lateral_friction(DRY,alpha_i(i),Fz,0.8*p,pr,diam,width,v,Kb);
    Fy4(i) = lateral_friction(DRY,alpha_i(i),Fz,1.2*p,pr,diam,width,v,Kb);

end

alpha_i = alpha_i.*57.2957795;
figure();
set(gca,'FontSize',25);
set(findall(gcf,'type','text'),'FontSize',25);
plot(alpha_i,Fy,alpha_i,Fy1,alpha_i,Fy3,alpha_i,Fy2);
legend('nominal','0.8Fz','0.8p','1.2Fz');
xlabel('Tire angle [deg]') % x-axis label
ylabel('Friction coeff.') % y-axis label
title(sprintf('Lateral Friction Coefficient vs. Tire Yaw Angle (v=%d m/s, Fz=%d kN, DRY and Kb=%.1f)',v, Fz/1000,Kb));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DRY/WET LATERAL FORCE COEFF plot vs. yaw angle
wFy = zeros(217,1);
wFy1 = zeros(217,1);
wFy2 = zeros(217,1);
wFy3 = zeros(217,1);
wFy33 = zeros(217,1);
wFy4 = zeros(217,1);
walpha = -0.08:0.005:1;

for i = 1:217
    wFy(i) = lateral_friction(DRY,walpha(i),Fz,p,pr,diam,width,v,Kb);
    wFy1(i) = lateral_friction(WET,walpha(i),Fz,p,pr,diam,width,v,Kb);
    wFy2(i) = lateral_friction(ICE,walpha(i),Fz,p,pr,diam,width,v,Kb);
    wFy3(i) = lateral_friction(WET,walpha(i),1.2*Fz,p,pr,diam,width,v,Kb);
    wFy33(i) = lateral_friction(DRY,walpha(i),1.2*Fz,p,pr,diam,width,v,Kb);
end

walpha = walpha.*57.2957795;
figure();
set(gca,'FontSize',25);
set(findall(gcf,'type','text'),'FontSize',25);
h = plot(walpha,wFy,'b-',walpha,wFy1,'r-',walpha,wFy2,'g-',walpha,wFy3,'ro',walpha,wFy33,'bo');
set(h(1),'linewidth',2);
set(h(2),'linewidth',2);
set(h(3),'linewidth',2);
set(h(4),'linewidth',2);
set(h(5),'linewidth',2);
legend('nominal DRY','nominal WET','nominal ICE','1.2Fz WET', '1.2Fz DRY');
xlabel('Tire angle [deg]') % x-axis label
ylabel('Friction coeff.') % y-axis label
title(sprintf('Lateral Friction Coeff. (v=%d m/s, Fz=%d kN and Kb=%.1f)',v, Fz/1000,Kb));
xlim([-5 60]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ENGINE MODEL
% figure();
% limitThrust = ones(size(step.Time)) * par.max_thrust;
% set(gca,'FontSize',25,'fontWeight','bold');
% set(findall(gcf,'type','text'),'FontSize',30,'fontWeight','bold');
% h = plot(step.Time, step.Data, step.Time, thrust.Data, 'r-', step.Time, limitThrust, 'k--');
% set(h(1),'linewidth',4);
% set(h(2),'linewidth',4);
% set(h(3),'linewidth',2);
% legend('Step', 'Response', 'Max Thrust');
% xlabel('Time [s]') % x-axis label
% ylabel('Force [N]') % y-axis label
% title('Engine Model Step Response');

% num = [par.max_thrust];
% den = [1 2 1];
% sys = tf(num,den);
% figure();
% set(gca,'FontSize',25,'fontWeight','bold');
% set(findall(gcf,'type','text'),'FontSize',30,'fontWeight','bold');
% h=stepplot(sys);
% xlabel('Time [s]') % x-axis label
% ylabel('Force [N]') % y-axis label
% title('Engine Model Step Response');
% set(h(1),'linewidth',2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %DRY LATERAL FORCE COEFF plot vs. speed
vFy = zeros(61,1);
vFy1 = zeros(61,1);
vFy2 = zeros(61,1);
vFy3 = zeros(61,1);
vFy4 = zeros(61,1);
aalpha = 20*0.01745;
velo = 0:0.5:30;
for i = 1:61
    vFy(i) = lateral_friction(DRY,aalpha,Fz,p,pr,diam,width,velo(i),Kb);
    vFy1(i) = lateral_friction(DRY,aalpha,0.8*Fz,p,pr,diam,width,velo(i),Kb);
    vFy2(i) = lateral_friction(DRY,aalpha,1.2*Fz,p,pr,diam,width,velo(i),Kb);
    vFy3(i) = lateral_friction(DRY,aalpha,Fz,p,pr,diam,width,velo(i),0.3);
    vFy4(i) = lateral_friction(DRY,aalpha,Fz,p,pr,diam,width,velo(i),1);

end

figure();
set(gca,'FontSize',25);
set(findall(gcf,'type','text'),'FontSize',25);
plot(velo,vFy,velo,vFy1,velo,vFy2,velo,vFy3,velo,vFy4);
legend('nominal','0.8Fz','1.2Fz','kB = 0.3','kB = 1');
xlabel('Speed [m/s]') % x-axis label
ylabel('Friction coeff.') % y-axis label
title(sprintf('Lateral Friction Coefficient vs. Velocity, (PSI = %.1f deg, Fz=%d kN, DRY)',aalpha/0.01745,Fz/1000));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DRY/WET LATERAL FORCE COEFF plot vs. speed
wFy = zeros(61,1);
wFy1 = zeros(61,1);
wFy2 = zeros(61,1);
wFy3 = zeros(61,1);
wFy4 = zeros(61,1);
walpha = 20*0.01745;
v_i = 0:0.5:30;
for i = 1:61
    wFy(i) = lateral_friction(DRY,walpha,Fz,p,pr,diam,width,v_i(i),Kb);
    wFy1(i) = lateral_friction(WET,walpha,Fz,p,pr,diam,width,v_i(i),Kb);
    wFy2(i) = lateral_friction(ICE,walpha,Fz,p,pr,diam,width,v_i(i),Kb);
    wFy3(i) = lateral_friction(DRY,walpha,1.2*Fz,p,pr,diam,width,v_i(i),Kb);
    wFy4(i) = lateral_friction(WET,walpha,1.2*Fz,p,pr,diam,width,v_i(i),Kb);
end

figure();
set(gca,'FontSize',25);
set(findall(gcf,'type','text'),'FontSize',25);
h=plot(v_i,wFy,'b-',v_i,wFy1,'r-',v_i,wFy2,'g-',v_i,wFy3,'bo',v_i,wFy4,'ro');
set(h(1),'linewidth',2);
set(h(2),'linewidth',2);
set(h(3),'linewidth',2);
set(h(4),'linewidth',2);
set(h(5),'linewidth',2);
legend('nominal DRY','nominal WET','nominal ICE','1.2Fz DRY','1.2Fz WET');
xlabel('Speed [m/s]') % x-axis label
ylabel('Friction coeff.') % y-axis label
alphaDeg = walpha/0.01745;
title(sprintf('Lateral Friction Coeff. (PSI=%.1f deg, Fz=%d kN and Kb=%.1f)',alphaDeg, Fz/1000,Kb));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %DRY LATERAL FORCE COEFF plot vs. yaw for multiple of FORCEs
% Fy = zeros(217,1);
% Fy1 = zeros(217,1);
% Fy2 = zeros(217,1);
% Fyl = zeros(217,1);
% Fy1l = zeros(217,1);
% Fy2l = zeros(217,1);
% Fyh = zeros(217,1);
% Fy1h = zeros(217,1);
% Fy2h = zeros(217,1);
% alpha = -0.08:0.005:1;
% 
% A = 40000;
% B = 140000;
% C = 200000;
% v = 10;
% 
% for i = 1:217
%     Fy(i)  = lateral_friction(DRY,alpha(i),A,p,pr,diam,width,v,Kb);
%     Fy1(i) = lateral_friction(DRY,alpha(i),B,p,pr,diam,width,v,Kb);
%     Fy2(i) = lateral_friction(DRY,alpha(i),C,p,pr,diam,width,v,Kb);
%     
%     Fyl(i)  = lateral_friction(DRY,alpha(i),0.8*A,p,pr,diam,width,v,Kb);
%     Fy1l(i) = lateral_friction(DRY,alpha(i),0.8*B,p,pr,diam,width,v,Kb);
%     Fy2l(i) = lateral_friction(DRY,alpha(i),0.8*C,p,pr,diam,width,v,Kb);
%     
%     Fyh(i)  = lateral_friction(DRY,alpha(i),1.2*A,p,pr,diam,width,v,Kb);
%     Fy1h(i) = lateral_friction(DRY,alpha(i),1.2*B,p,pr,diam,width,v,Kb);
%     Fy2h(i) = lateral_friction(DRY,alpha(i),1.2*C,p,pr,diam,width,v,Kb);
% 
% end
% 
% alpha = alpha.*57.2957795;
% figure();
% plot(alpha,Fy,'b',alpha,Fy1,'g',alpha,Fy2,'r',alpha,Fyl,'bo',alpha,Fy1l,'go',alpha,Fy2l,'ro',alpha,Fyh,'bx',alpha,Fy1h,'gx',alpha,Fy2h,'rx');
% legend(sprintf('Fz = %d kN',A/1000),sprintf('Fz = %d kN',B/1000),sprintf('Fz = %d kN',C/1000),'.8Fz','.8Fz','.8Fz','1.2Fz','1.2Fz','1.2Fz');
% xlabel('Tire angle [deg]') % x-axis label
% ylabel('friction coeff.') % y-axis label
% title(sprintf('Lateral friction coefficient vs. tire yaw angle for multiple tire loads, v=%d m/s',v));
 
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DRY LATERAL FORCE COEFF plot vs.  FORCE
% Fy = zeros(1500,1);
% Fy1 = zeros(1500,1);
% 
% Fz_i = 1:100:150000;
% 
% aalpha = 10*0.01745;
% v1 = 10;
% v2 = 50;
% 
% for i = 1:1500
%     Fy(i)  = lateral_friction(DRY,aalpha,Fz_i(i),p,pr,diam,width,v1,Kb);
%     Fy1(i) = lateral_friction(DRY,aalpha,Fz_i(i),p,pr,diam,width,v2,Kb);
%     
% end
% 
% aalpha = aalpha.*57.2957795;
% figure();
% set(gca,'FontSize',25);
% set(findall(gcf,'type','text'),'FontSize',25);
% plot(Fz_i,Fy,'b',Fz_i,Fy1,'g');
% legend(sprintf('v = %d m/s',v1),sprintf('v = %d m/s',v2));
% xlabel('Tire load [N]') % x-axis label
% ylabel('Friction coeff.') % y-axis label
% title(sprintf('Lateral Friction Coefficient vs. Tire Load (psi=%d deg)',aalpha));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Effect of braking on DRY LATERAL FORCE COEFF
Fy = zeros(217,1);
Fy1 = zeros(217,1);
Fy2 = zeros(217,1);
Fy3 = zeros(217,1);
Fy4 = zeros(217,1);
Fy5 = zeros(217,1);
Fy44 = zeros(217,1);
Fy55 = zeros(217,1);

walpha = -0.08:0.005:1;

for i = 1:217
    Fy(i)  = lateral_friction(DRY,walpha(i),Fz,p,pr,diam,width,v,0);
    Fy1(i)  = lateral_friction(DRY,walpha(i),Fz,p,pr,diam,width,v,0.3);
    Fy2(i)  = lateral_friction(DRY,walpha(i),Fz,p,pr,diam,width,v,0.6); 
    Fy3(i)  = lateral_friction(DRY,walpha(i),Fz,p,pr,diam,width,v,1);
    Fy4(i)  = lateral_friction(WET,walpha(i),Fz,p,pr,diam,width,v,0);
    Fy5(i)  = lateral_friction(WET,walpha(i),Fz,p,pr,diam,width,v,1);
    Fy44(i)  = lateral_friction(ICE,walpha(i),Fz,p,pr,diam,width,v,0);
    Fy55(i)  = lateral_friction(ICE,walpha(i),Fz,p,pr,diam,width,v,1);
end

figure();
set(gca,'FontSize',25);
set(findall(gcf,'type','text'),'FontSize',25);
walpha = walpha./0.01745;
h = plot(walpha,Fy,'b',walpha,Fy1,'g',walpha,Fy2,'r',walpha,Fy3,'k',walpha,Fy4,'ob',walpha,Fy5,'ok',walpha,Fy44,'xb',walpha,Fy55,'xk');
set(h(1),'linewidth',2);
set(h(2),'linewidth',2);
set(h(3),'linewidth',2);
set(h(4),'linewidth',2);
set(h(5),'linewidth',1);
set(h(6),'linewidth',1);
set(h(7),'linewidth',1);
set(h(8),'linewidth',1);
legend('Kb = 0','Kb = 0.3','Kb = 0.6','Kb = 1', 'Kb = 0 WET', 'Kb = 1 WET', 'Kb = 0 ICE', 'Kb = 1 ICE');
xlabel('Yaw angle [deg]') % x-axis label
ylabel('Friction coeff.') % y-axis label
xlim([-5 60]);
title(sprintf('Lateral Friction Coefficient during Braking (v=%d m/s, Fz=%d kN)',v, Fz/1000));