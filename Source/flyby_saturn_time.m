%Calcolo il tempo t di flyby Saturn usando l'equazione di keplero

GM_Saturn = 3.7931187e7; %[km^3/s^2] 
v_inf_down_Saturn = v2_l_s - v2_s ;  
v_inf_down_norm_Saturn = norm(v_inf_down_Saturn); 

a_flyby_Saturn = - GM_Saturn/((v_inf_down_norm_Saturn)^2); %semiaxis major 
r_p_flyby_Saturn = 1e6;  %hp  
e_flyby_Saturn = 1-(r_p_flyby_Saturn/a_flyby_Saturn); 

delta_Saturn = 2*asin(1/e_flyby_Saturn); %angolo tra gli asintoti 
delta_deg_Saturn = rad2deg(delta_Saturn); 

%ricavo l'anomalia vera f

f_Saturn = acos((a_flyby_Saturn*(1-e_flyby_Saturn^2)-r_p_flyby_Saturn) / (e_flyby_Saturn*r_p_flyby_Saturn)); 
f_deg_Saturn = rad2deg(f_Saturn);

%trovo p semilato retto [km] 
p_Saturn = r_p_flyby_Saturn*(1+e_flyby_Saturn*cos(f_Saturn)); 
 
r = R_SOI_Saturn; 

%calcolo anomalia vera per r 
f1_Saturn = acos((1/e_flyby_Saturn)*((p_Saturn/r)-1)); 

E_2_Saturn = atanh(sqrt((e_flyby_Saturn-1)/(e_flyby_Saturn+1))*tan(f1_Saturn/2)); 
E_Saturn = E_2_Saturn/2;
E_deg_Saturn = rad2deg(E_Saturn); 

%trovo anomalia media M 
 
M_Saturn = e_flyby_Saturn*sinh(E_Saturn)-E_Saturn; 
M_deg_Saturn=rad2deg(M_Saturn); 
 
%trovo il tempo 
 
t_flyby_Saturn = M_Saturn*sqrt(-a_flyby_Saturn^3/GM_Saturn); %in secondi 
t_flyby_tot_Saturn = 2*t_flyby_Saturn;  
t_flyby_tot_hours_Saturn = t_flyby_tot_Saturn/3600; 
 
[years_S months_S days_S hours_S minutes_S seconds_S] = sec2date(t_flyby_tot_Saturn) 
