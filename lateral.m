%Boeing 747-200 parameters
v = 10/1.94384;     %m/s [10 knots] 
Kb = 1;             %braking ratio
alpha = 0.01;       %[rad]
Fz = 140000;        %[N]

%tire spec [AGARD and http://www.b737.org.uk/techspecsdetailed.htm]
diam = 1.2446;  %m [49 ins]
width = 0.4318; %m [17 ins]
p = 190;    %[psi]
pr = 210;   %[psi] 220 web, 500->x=0.2

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

%DRY coefs based on speed
bmaxi = zeros(161,1);
beffi = zeros(161,1);
pslimi = zeros(161,1);
Wmu_Bmaxi = zeros(161,1);
Wmu_Beffi = zeros(161,1);
Wmu_PSImaxi = zeros(161,1);
Wmu_PSIlimi = zeros(161,1);
vi = 0:0.1:16;
for i = 1:161
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

%DRY LATERAL FORCE
Fy = zeros(85,1);
Fy1 = zeros(85,1);
Fy2 = zeros(85,1);
Fy3 = zeros(85,1);
Fy4 = zeros(85,1);
alpha = -0.08:0.005:0.34;
for i = 1:85
    Fy(i) = lateral_friction(alpha(i),Fz,p,pr,diam,width,mu_PSImax);
    Fy1(i) = lateral_friction(alpha(i),0.8*Fz,p,pr,diam,width,mu_PSImax);
    Fy2(i) = lateral_friction(alpha(i),1.2*Fz,p,pr,diam,width,mu_PSImax);
    Fy3(i) = lateral_friction(alpha(i),Fz,0.8*p,pr,diam,width,mu_PSImax);
    Fy4(i) = lateral_friction(alpha(i),Fz,1.2*p,pr,diam,width,mu_PSImax);

end

alpha = alpha.*57.2957795;
figure();
plot(alpha,Fy,alpha,Fy1,alpha,Fy2,alpha,Fy3,alpha,Fy4);
legend('nominal','0.8Fz','1.2Fz','0.8p','1.2p');
xlabel('Tire angle [rad]') % x-axis label
ylabel('friction coeffs.') % y-axis label
title('Lateral friction coefficients vs. tire yaw angle');


%WET LATERAL FORCE
wFy = zeros(85,1);
wFy1 = zeros(85,1);
wFy2 = zeros(85,1);
wFy3 = zeros(85,1);
wFy4 = zeros(85,1);
walpha = -0.08:0.005:0.34;
for i = 1:85
    wFy(i) = lateral_friction(walpha(i),Fz,p,pr,diam,width,Wmu_PSImax);
    wFy1(i) = lateral_friction(walpha(i),0.8*Fz,p,pr,diam,width,Wmu_PSImax);
    wFy2(i) = lateral_friction(walpha(i),1.2*Fz,p,pr,diam,width,Wmu_PSImax);
    wFy3(i) = lateral_friction(walpha(i),Fz,0.8*p,pr,diam,width,Wmu_PSImax);
    wFy4(i) = lateral_friction(walpha(i),Fz,1.2*p,pr,diam,width,Wmu_PSImax);

end

walpha = walpha.*57.2957795;
figure();
plot(walpha,Fy,'-',walpha,wFy,'o',walpha,Fy2,'-',walpha,wFy2,'go');
legend('nominal dry','nominal wet','1.2Fz dry','1.2Fz wet');
xlabel('Tire angle [rad]') % x-axis label
ylabel('friction coeffs.') % y-axis label
title('Lateral friction coefficients in different environ. conditions');