function res = braking_friction(ENVIRON,p,v)
    res = -10;

    if ENVIRON == 0
        %DRY RUNWAY friction for longitudal braking force
        mu_Bmax = (1 - 0.0011*p)*0.912 + (v*1.94384)*(-0.00079);
        mu_Beff = mu_Bmax*0.94 - 0.03; 
        if(v < 54.5)
            mu_skid = 48.1/(50.2 + v*1.94384) * mu_Bmax;
        else
            mu_skid = 0.31 * mu_Bmax;
        end
    else
        %WET RUNWAY friction for longitudal braking force 
        mu_Bmax = (0.91 - 0.001*p)*(1 + (v*1.94384)*(-0.0052));
        mu_Beff = mu_Bmax*0.94 - 0.03; 
        mu_skid = (23.2 - 0.031*p)/(26.5 + v*1.94384);
    end
    
    res = mu_Beff;
end