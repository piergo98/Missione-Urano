%Calcolo il tempo t di flyby giove usando l'equazione di keplero

Earth_Jupiter_Saturn_Uranus;

%velocità in uscita da Jupiter
v_inf_down_Jupiter = v2_l_j - v2_j;  
v_inf_down_norm_Jupiter = norm(v_inf_down_Jupiter); 

%semiaxis major
a_flyby_Jupiter = - mu_Jupiter / ((v_inf_down_norm_Jupiter)^2);   

%rp (km)
r_p_flyby_Jupiter = 503800;    

%eccentricity
e_flyby_Jupiter = 1-(r_p_flyby_Jupiter/a_flyby_Jupiter); 

%angolo tra gli asintoti 
delta_Jupiter = 2*asin(1/e_flyby_Jupiter);  
delta_deg_Jupiter = rad2deg(delta_Jupiter); 
% Angolo semiasse minore
b_flyby_Jupiter = a_flyby_Jupiter * tand((180-delta_deg_Jupiter)/2);

%ricavo l'anomalia vera f 
f_Jupiter = acos((a_flyby_Jupiter*(1-e_flyby_Jupiter^2)-r_p_flyby_Jupiter) / (e_flyby_Jupiter*r_p_flyby_Jupiter)); 
f_deg_Jupiter =rad2deg(f_Jupiter);

%trovo p semilato retto [km] 
p_Jupiter = r_p_flyby_Jupiter*(1+e_flyby_Jupiter*cos(f_Jupiter)); 
 
%distanza per la quale voglio calcolare il tempo di volo
r = R_SOI_Jupiter; 

%calcolo anomalia vera per r (in ingresso alla SOI) 
f1_Jupiter = acos((1/e_flyby_Jupiter)*((p_Jupiter/r)-1)); 

%calcolo anomalia eccentrica
E_2_Jupiter = atanh(sqrt((e_flyby_Jupiter-1)/(e_flyby_Jupiter+1))*tan(f1_Jupiter/2)); 
E_Jupiter = E_2_Jupiter/2;
E_deg_Jupiter = rad2deg(E_Jupiter); 

%trovo anomalia media M 
M_Jupiter = e_flyby_Jupiter*sinh(E_Jupiter)-E_Jupiter; 
M_deg_Jupiter=rad2deg(M_Jupiter); 
 
%trovo il tempo 
t_flyby_Jupiter = M_Jupiter*sqrt(-a_flyby_Jupiter^3/mu_Jupiter); %in secondi 
t_flyby_tot_Jupiter = 2*t_flyby_Jupiter;  
t_flyby_tot_hours_Jupiter = t_flyby_tot_Jupiter/3600; 
 
[years_J months_J days_J hours_J minutes_J seconds_J] = sec2date(t_flyby_tot_Jupiter);