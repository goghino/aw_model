function res = lateral_friction(yaw_alpha,Fz,p,pr,diam,width,mu_PSImax)
%DRY RUNWAY lateral force   
    x = Fz / (p * diam*39.3701 * sqrt(width*39.3701*diam*39.3701));
    N = 31.3 * (width*39.3701)^2 * (p + 0.44*pr)*(1-3.17*x)*x;
    phi = (N * yaw_alpha) / (mu_PSImax * Fz);
    if(abs(phi)<1.5)
        res = abs(phi - (4/27)*phi^3) * mu_PSImax;
    else
        res = mu_PSImax;
    end
end

