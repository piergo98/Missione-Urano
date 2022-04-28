%% Calcolo il tempo t di flyby Saturn usando l'equazione di keplero

% Recupero dati pianeta attorno al quale faccio il flyby
Earth_Jupiter_Saturn_Uranus;
v_inf_down_Saturn = V2_l_s - v2_s; % velocità in ingresso al flyby     
v_inf_down_norm_Saturn = norm(v_inf_down_Saturn); % in norma  

% Calcolo elementi orbitali del flyby

% Semiasse maggiore
a_flyby_Saturn = - mu_Saturn/((v_inf_down_norm_Saturn)^2);

% Distanza minima fra traiettoria di flyby e pianeta(km) 
r_p_flyby_Saturn = 1.8e6;

% Eccentricità traiettoria di flyby
e_flyby_Saturn = 1-(r_p_flyby_Saturn/a_flyby_Saturn); 

% Angolo tra gli asintoti 
delta_Saturn = 2*asin(1/e_flyby_Saturn); 
delta_deg_Saturn = rad2deg(delta_Saturn);   % in gradi 

% Ricavo l'anomalia vera f
f_Saturn = acos((a_flyby_Saturn*(1-e_flyby_Saturn^2)-r_p_flyby_Saturn) ...
    / (e_flyby_Saturn*r_p_flyby_Saturn)); 
f_deg_Saturn = rad2deg(f_Saturn);

% Trovo p semilato retto [km] 
p_Saturn = r_p_flyby_Saturn*(1+e_flyby_Saturn*cos(f_Saturn)); 

% Distanza per la quale voglio calcolare il tempo di volo
r = R_SOI_Saturn; 

% Calcolo anomalia vera per r 
f1_Saturn = acos((1/e_flyby_Saturn)*((p_Saturn/r)-1)); 

% Calcolo anomalia eccentrica
E_2_Saturn = atanh(sqrt((e_flyby_Saturn-1)/(e_flyby_Saturn+1))*tan(f1_Saturn/2)); 
E_Saturn = E_2_Saturn/2;
E_deg_Saturn = rad2deg(E_Saturn);   % In gradi 

% Trovo anomalia media M 
M_Saturn = e_flyby_Saturn*sinh(E_Saturn)-E_Saturn; 
M_deg_Saturn=rad2deg(M_Saturn); % In gradi
 
% Trovo il tempo 
t_flyby_Saturn = M_Saturn*sqrt(-a_flyby_Saturn^3/mu_Saturn); % In secondi 
t_flyby_tot_Saturn = 2*t_flyby_Saturn;  
t_flyby_tot_hours_Saturn = t_flyby_tot_Saturn/3600; % In ore
 
[years_S months_S days_S hours_S minutes_S seconds_S] = sec2date(t_flyby_tot_Saturn); 



 
