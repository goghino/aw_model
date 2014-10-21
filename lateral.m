%Boeing 747-200 parameters
v = 10;             %m/s [10 knots] 
Kb = 1;             %braking ratio
alpha = 0.01;       %[rad]
Fz_total = 140000;        %[N]
Fz = 40000;

%tire spec [AGARD and http://www.b737.org.uk/techspecsdetailed.htm]
diam = 1.2446;  %m [49 ins]
width = 0.4318; %m [17 ins]
p = 140;    %[psi]
pr = 210;   %[psi] 220 web

% x==0.2 at rated load
xxx = Fz / (p * diam*39.3701 * sqrt(width*39.3701*diam*39.3701));


%DRY RUNWAY friction for longitudal braking force
mu_Bmax = (1 - 0.0011*p)*0.912 + v*1.94384*(-0.00079);
mu_Beff = mu_Bmax*0.94 - 0.03; 
mu_PSImax = mu_Bmax;
mu_PSIlim = sqrt(1-(mu_Beff/mu_Bmax*Kb)^2) * mu_Bmax;
Fxb = Kb * mu_Beff * Fz;

%WET RUNWAY friction for longitudal braking force 
Wmu_Bmax = (0.91 - 0.001*p)*(1 + v*1.94384*(-0.0052));
Wmu_Beff = Wmu_Bmax*0.94 - 0.03; 
Wmu_PSImax = 0.64 * Wmu_Bmax + 0.15*(Wmu_Bmax)^2;
Wmu_PSIlim = sqrt(1-(Wmu_Beff/Wmu_Bmax*Kb)^2) * Wmu_Bmax;
WFxb = Kb * Wmu_Beff * Fz;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%DRY COEFS plot
bmaxi = zeros(101,1);
beffi = zeros(101,1);
pslimi = zeros(101,1);
Wmu_Bmaxi = zeros(101,1);
Wmu_Beffi = zeros(101,1);
Wmu_PSImaxi = zeros(101,1);
Wmu_PSIlimi = zeros(101,1);
vi = 0:1:100;
for i = 1:101
   bmaxi(i) = (1 - 0.0011*p)*0.912 + vi(i)*1.94384*(-0.00079);
   beffi(i) = bmaxi(i)*0.94 - 0.03;
   pslimi(i) = sqrt(1-(beffi(i)/bmaxi(i)*Kb)^2) * bmaxi(i);
   
    Wmu_Bmaxi(i) = (0.91 - 0.001*p)*(1 + vi(i)*1.94384*(-0.0052));
    Wmu_Beffi(i) = Wmu_Bmaxi(i)*0.94 - 0.03; 
    Wmu_PSImaxi(i) = 0.64 * Wmu_Bmaxi(i) + 0.15*(Wmu_Bmaxi(i))^2;
    Wmu_PSIlimi(i) = sqrt(1-(Wmu_Beffi(i)/Wmu_Bmaxi(i)*Kb)^2) * Wmu_Bmaxi(i);
end

close all;
plot(vi,bmaxi,'b',vi,beffi,'r',vi,pslimi,'g', vi,Wmu_Bmaxi,':b',vi,Wmu_Beffi,':r',vi,Wmu_PSIlimi,':g');
legend('muBmax','muBeff','muPSIlim','muBmax wet','muBeff wet','muPSIlim wet');
xlabel('velocity [m/s]') % x-axis label
ylabel('friction coeffs.') % y-axis label
title('Friction coefficients vs. speed');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%DRY LATERAL FORCE plot vs. yaw angle
Fy = zeros(85,1);
Fy1 = zeros(85,1);
Fy2 = zeros(85,1);
Fy3 = zeros(85,1);
Fy4 = zeros(85,1);
alpha = -0.08:0.005:0.34;
v = 10;
for i = 1:85
    Fy(i) = lateral_friction(0,alpha(i),Fz,p,pr,diam,width,v);
    Fy1(i) = lateral_friction(0,alpha(i),0.8*Fz,p,pr,diam,width,v);
    Fy2(i) = lateral_friction(0,alpha(i),1.2*Fz,p,pr,diam,width,v);
    Fy3(i) = lateral_friction(0,alpha(i),Fz,0.8*p,pr,diam,width,v);
    Fy4(i) = lateral_friction(0,alpha(i),Fz,1.2*p,pr,diam,width,v);

end

alpha = alpha.*57.2957795;
figure();
plot(alpha,Fy,alpha,Fy1,alpha,Fy2,alpha,Fy3,alpha,Fy4);
legend('nominal','0.8Fz','1.2Fz','0.8p','1.2p');
xlabel('Tire angle [deg]') % x-axis label
ylabel('friction coeff.') % y-axis label
title('Lateral friction coefficient vs. tire yaw angle, v=10m/s');


%DRY/WET LATERAL FORCE plot vs. yaw angle
wFy = zeros(85,1);
wFy1 = zeros(85,1);
wFy2 = zeros(85,1);
wFy3 = zeros(85,1);
wFy4 = zeros(85,1);
walpha = -0.08:0.005:0.34;
v = 10;
for i = 1:85
    wFy(i) = lateral_friction(0,walpha(i),Fz,p,pr,diam,width,v);
    wFy1(i) = lateral_friction(1,walpha(i),Fz,p,pr,diam,width,v);
    wFy2(i) = lateral_friction(0,walpha(i),1.2*Fz,p,pr,diam,width,v);
    wFy3(i) = lateral_friction(1,walpha(i),1.2*Fz,p,pr,diam,width,v);
end

walpha = walpha.*57.2957795;
figure();
plot(walpha,wFy,'-',walpha,wFy1,'o',walpha,wFy2,'-',walpha,wFy3,'go');
legend('nominal dry','nominal wet','1.2Fz dry','1.2Fz wet');
xlabel('Tire angle [deg]') % x-axis label
ylabel('friction coeff.') % y-axis label
title('Lateral friction coefficient in different environ. conditions, v=10m/s');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%DRY LATERAL FORCE plot vs. speed
vFy = zeros(101,1);
vFy1 = zeros(101,1);
vFy2 = zeros(101,1);
vFy3 = zeros(101,1);
vFy4 = zeros(101,1);
alpha = 5*0.01745;
velo = 0:1:100;
for i = 1:101
    vFy(i) = lateral_friction(0,alpha,Fz,p,pr,diam,width,velo(i));
    vFy1(i) = lateral_friction(0,alpha,0.8*Fz,p,pr,diam,width,velo(i));
    vFy2(i) = lateral_friction(0,alpha,1.2*Fz,p,pr,diam,width,velo(i));
    vFy3(i) = lateral_friction(0,alpha,Fz,0.8*p,pr,diam,width,velo(i));
    vFy4(i) = lateral_friction(0,alpha,Fz,1.2*p,pr,diam,width,velo(i));

end

figure();
plot(velo,vFy,velo,vFy1,velo,vFy2,velo,vFy3,velo,vFy4);
legend('nominal','0.8Fz','1.2Fz','0.8p','1.2p');
xlabel('Speed [m/s]') % x-axis label
ylabel('friction coeff.') % y-axis label
title('Lateral friction coefficient vs. velocity, PSI = 5deg');


%DRY/WET LATERAL FORCE plot vs. speed
wFy = zeros(101,1);
wFy1 = zeros(101,1);
wFy2 = zeros(101,1);
wFy3 = zeros(101,1);
wFy4 = zeros(101,1);
walpha = 5*0.01745;
v = 0:1:100;
for i = 1:101
    wFy(i) = lateral_friction(0,walpha,Fz,p,pr,diam,width,v(i));
    wFy1(i) = lateral_friction(1,walpha,Fz,p,pr,diam,width,v(i));
    wFy2(i) = lateral_friction(0,walpha,1.2*Fz,p,pr,diam,width,v(i));
    wFy3(i) = lateral_friction(1,walpha,1.2*Fz,p,pr,diam,width,v(i));
end

figure();
plot(v,wFy,'-',v,wFy1,'o',v,wFy2,'-',v,wFy3,'go');
legend('nominal dry','nominal wet','1.2Fz dry','1.2Fz wet');
xlabel('Speed [m/s]') % x-axis label
ylabel('friction coeff.') % y-axis label
title('Lateral friction coefficient in different environ. conditions, PSI=5deg');
