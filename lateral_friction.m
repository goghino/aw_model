%Lateral force  as a function of:
%ENVIRON - environmental conditions, 0-DRY, 1-WET runway
%yaw_alpha - angle between longitudal tyre axis and direction of movement
%Fz - vertical force on wheel
%p,pr - tire pressure, rated tire pressure
%diam,width - tire diameter and width
%v - velocity scalar
%Kb - braking ratio

function res = lateral_friction(ENVIRON,yaw_alpha,Fz,p,pr,diam,width,v,Kb)
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
        mu_PSImax = mu_Bmax;
        mu_PSIlim = sqrt(1-(mu_Beff/mu_Bmax*Kb)^2) * mu_Bmax;
    else
        %WET RUNWAY friction for longitudal braking force 
        mu_Bmax = (0.91 - 0.001*p)*(1 + (v*1.94384)*(-0.0052));
        mu_Beff = mu_Bmax*0.94 - 0.03; 
        mu_skid = (23.2 - 0.031*p)/(26.5 + v*1.94384);
        mu_PSImax = 0.64 * mu_Bmax + 0.15*(mu_Bmax)^2;
        mu_PSIlim = sqrt(1-((mu_Beff/mu_Bmax)*Kb)^2) * mu_Bmax;
    end


    %effect of braking on lateral forces
    if(Kb > 0)
        mu_PSI = mu_PSIlim;
    else
        mu_PSI = mu_PSImax;
    end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x = Fz / (p * diam*39.3701 * sqrt(width*39.3701*diam*39.3701));
    N = 31.3 * (width*39.3701)^2 * (p + 0.44*pr)*(1-3.17*x)*x;
    h = 2*mu_PSI * Fz / N;
    
    %SMALL YAW ANGLE, PSI < 20deg (0.349rad)
    if(abs(yaw_alpha) < abs(h))
        phi = (N * yaw_alpha) / (mu_PSI * Fz);
        if(abs(phi)<1.5)
            res = abs(phi - (4/27)*phi^3) * mu_PSI;
        else
            res = mu_PSI;
        end
    %LARGE YAW ANGLE, PSI > 20deg
    else
         %subsidiary function i
        if(0 < abs(yaw_alpha) && abs(yaw_alpha) < h)
            i = 0;
        elseif(h < abs(yaw_alpha) && abs(yaw_alpha)<1.57)
            i = (abs(yaw_alpha)-h)/(1.57-h);
        elseif(1.57 < abs(yaw_alpha) && abs(yaw_alpha) < 3.14)
            i = 2 + (h-abs(yaw_alpha))/(1.57-h);
        elseif(3.14-h <= abs(yaw_alpha))
            i = 0;
        else
            errordlg('Non-valid range for i-function!!!');
        end

        %subsidiary function j
        if(i < 0.3)
            j = 1 - 1.93*i;
        else
            j = 0.58 - 0.575*i;

        end
        
        %LYA Lateral friction coeff. for large yaw angles
        if(mu_PSI > mu_skid)
            res = mu_skid + j*(mu_PSI - mu_skid);
        else
            res = mu_PSI;
        end
    end    
end

