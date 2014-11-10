wFyN = zeros(201,1);
wFyR = zeros(201,1);
walpha = 0:0.005:1;
walpha = walpha.*57.2957795;

% Nose wheel
Fz_N = 42200;
Fmax_N = -3.53*10^(-6)*Fz_N*Fz_N + 8.83*0.1*Fz_N;
Aopt_N = 3.52*10^(-9)*Fz_N*Fz_N + 2.8*10^(-5)*Fz_N + 13.8;

% Main wheel
Fz_R = 201610;
Fmax_R = -7.39*10^(-7)*Fz_R*Fz_R + 5.11*0.1*Fz_R;
Aopt_R = 1.34*10^(-10)*Fz_R*Fz_R + 1.06*10^(-5)*Fz_R + 6.72;

for i = 1:201
    wFyN(i) = (2*Fmax_N*Aopt_N*walpha(i))/(Aopt_N^2+walpha(i)^2);
    wFyR(i) = (2*Fmax_R*Aopt_R*walpha(i))/(Aopt_R^2+walpha(i)^2);
end

%mu_PSI = Fy/Fz
wFyN = wFyN;% ./ Fz_N; %absolute force / lateral coeff.
wFyR = wFyR;% ./ Fz_R;

figure();
plot(walpha,wFyN,'r-',walpha,wFyR,'b-');
legend('Nose wheel','Main wheel');
xlabel('Tire angle [deg]') % x-axis label
ylabel('friction coeff.') % y-axis label
title('Lateral friction coefficient');

