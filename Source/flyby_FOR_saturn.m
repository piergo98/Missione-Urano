%Calcolo il tempo t di flyby Saturn usando l'equazione di keplero

GM_Saturn = 3.7931187e7; %[km^3/s^2] 
v_inf_down_Saturn = v2_l_s - v2_s ;  
v_inf_down_norm_Saturn = norm(v_inf_down_Saturn); 

a_flyby_Saturn = - GM_Saturn/((v_inf_down_norm_Saturn)^2); %semiaxis major 

r_p_flyby_Saturn = 1e5:1e5:4e7;  %hp  
for i = 1:length(r_p_flyby_Saturn)
    e_flyby_Saturn(i) = 1-(r_p_flyby_Saturn(i)/a_flyby_Saturn); 
    
    delta_Saturn(i) = 2*asin(1/e_flyby_Saturn(i)); %angolo tra gli asintoti 
    delta_deg_Saturn(i) = rad2deg(delta_Saturn(i)); 
    
    %ricavo l'anomalia vera f
    
    f_Saturn(i) = acos((a_flyby_Saturn*(1-e_flyby_Saturn(i)^2)-r_p_flyby_Saturn(i)) ...
        / (e_flyby_Saturn(i)*r_p_flyby_Saturn(i))); 
    f_deg_Saturn(i) = rad2deg(f_Saturn(i));
    
    %trovo p semilato retto [km] 
    p_Saturn(i) = r_p_flyby_Saturn(i)*(1+e_flyby_Saturn(i)*cos(f_Saturn(i))); 
     
    r = R_SOI_Saturn; 
    
    %calcolo anomalia vera per r 
    f1_Saturn(i) = acos((1/e_flyby_Saturn(i))*((p_Saturn(i)/r)-1)); 
    
    E_2_Saturn(i) = atanh(sqrt((e_flyby_Saturn(i)-1)/(e_flyby_Saturn(i)+1))*tan(f1_Saturn(i)/2)); 
    E_Saturn(i) = E_2_Saturn(i)/2;
    E_deg_Saturn(i) = rad2deg(E_Saturn(i)); 
    
    %trovo anomalia media M 
     
    M_Saturn(i) = e_flyby_Saturn(i)*sinh(E_Saturn(i))-E_Saturn(i); 
    M_deg_Saturn(i)=rad2deg(M_Saturn(i)); 
     
    %trovo il tempo 
     
    t_flyby_Saturn(i) = M_Saturn(i)*sqrt(-a_flyby_Saturn^3/GM_Saturn); %in secondi 
    t_flyby_tot_Saturn(i) = 2*t_flyby_Saturn(i);  
    t_flyby_tot_hours_Saturn(i) = t_flyby_tot_Saturn(i)/3600; 
     
    [years_S months_S days_S hours_S minutes_S seconds_S] = sec2date(t_flyby_tot_Saturn) ;
    T_s = [years_S; months_S; days_S; hours_S; minutes_S; seconds_S];
end

