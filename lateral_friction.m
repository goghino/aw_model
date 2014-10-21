%Lateral force 
function res = lateral_friction(ENVIRON,yaw_alpha,Fz,p,pr,diam,width,v)
Kb = 1; %full braking
res = -10;

if ENVIRON == 0
    %DRY RUNWAY friction for longitudal braking force
    mu_Bmax = (1 - 0.0011*p)*0.912 + v*1.94384*(-0.00079);
    mu_Beff = mu_Bmax*0.94 - 0.03; 
    mu_PSImax = mu_Bmax;
    mu_PSIlim = sqrt(1-(mu_Beff/mu_Bmax*Kb)^2) * mu_Bmax;
    Fxb = Kb * mu_Beff * Fz;
else
    %WET RUNWAY friction for longitudal braking force 
    mu_Bmax = (0.91 - 0.001*p)*(1 + v*1.94384*(-0.0052));
    mu_Beff = mu_Bmax*0.94 - 0.03; 
    mu_PSImax = 0.64 * mu_Bmax + 0.15*(mu_Bmax)^2;
    mu_PSIlim = sqrt(1-(mu_Beff/mu_Bmax*Kb)^2) * mu_Bmax;
    Fxb = Kb * mu_Beff * Fz;
end

x = Fz / (p * diam*39.3701 * sqrt(width*39.3701*diam*39.3701));
N = 31.3 * (width*39.3701)^2 * (p + 0.44*pr)*(1-3.17*x)*x;
phi = (N * yaw_alpha) / (mu_PSImax * Fz);
if(abs(phi)<1.5)
    res = abs(phi - (4/27)*phi^3) * mu_PSImax;
else
    res = mu_PSImax;
end

end

