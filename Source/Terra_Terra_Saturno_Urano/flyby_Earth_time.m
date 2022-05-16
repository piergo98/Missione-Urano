%% Calcolo il tempo t di flyby Earth usando l'equazione di keplero

% Recupero dati pianeta attorno a cui faccio il flyby
% Earth_Earth_Saturn_Uranus;
v_inf_down_Earth = v2_l_e2 - v2_e2; % velocità in ingresso al flyby   
v_inf_down_norm_Earth = norm(v_inf_down_Earth); % in norma 

% Calcolo elementi orbitali del flyby

% Semiasse maggiore
a_flyby_Earth = - mu_Earth/((v_inf_down_norm_Earth)^2);

% Distanza minima fra traiettoria di flyby e pianeta(km) 
r_p_flyby_Earth = 30000;  

% Eccentricità traiettoria di flyby
e_flyby_Earth = 1-(r_p_flyby_Earth/a_flyby_Earth); 
    
% Angolo tra gli asintoti 
delta_Earth = 2*asin(1/e_flyby_Earth);  
delta_deg_Earth = rad2deg(delta_Earth); % in gradi 

% Ricavo l'anomalia vera f
f_Earth = acos((a_flyby_Earth*(1-e_flyby_Earth^2)-r_p_flyby_Earth) ...
    / (e_flyby_Earth*r_p_flyby_Earth)); 
f_deg_Earth = rad2deg(f_Earth); % in gradi

% Trovo p semilato retto [km] 
p_Earth = r_p_flyby_Earth*(1+e_flyby_Earth*cos(f_Earth)); 

% Distanza per la quale voglio calcolare il tempo di volo
r = R_SOI_Earth; 

% Calcolo anomalia vera per r 
f_in_Earth = acos((1/e_flyby_Earth)*((p_Earth/r)-1)); 
f_in_Earth_deg = rad2deg(f_in_Earth);   % in gradi
cosh_F_Earth = (e_flyby_Earth+cos(f_in_Earth))/(e_flyby_Earth*cos(f_in_Earth)+1);

% Calcolo anomalia eccentrica
% E_2_Earth = atanh(sqrt((e_flyby_Earth-1)/(e_flyby_Earth+1))*tan(f_in_Earth/2)); 
% E_Earth = E_2_Earth/2;
% E_deg_Earth = rad2deg(E_Earth); % in gradi 
F_Earth = log(cosh_F_Earth+sqrt((cosh_F_Earth)^2-1));
F_Earth_deg = rad2deg(F_Earth);

% Trovo anomalia media M 
M_Earth = e_flyby_Earth*sinh(F_Earth)-F_Earth; 
M_deg_Earth = rad2deg(M_Earth); % in gradi
 
% Trovo il tempo 
t_flyby_Earth = M_Earth*sqrt(-a_flyby_Earth^3/mu_Earth); % in secondi 
t_flyby_tot_Earth = 2*t_flyby_Earth;  
t_flyby_tot_hours_Earth = t_flyby_tot_Earth/3600; 
 
[years_E months_E days_E hours_E minutes_E seconds_E] = sec2date(t_flyby_tot_Earth); 

%...Output to the command window:
fprintf('\n\n--------------------------------------------------------\n')
fprintf('\n fly-by orbit Earth\n')
fprintf('\n The initial position is [%g, %g, %g] (km).',...
                                                     r2_e2(1), r2_e2(2), r2_e2(3))
fprintf('\n The initial velocity is [%g, %g, %g] (km/s).',...
                                                     v2_l_e2(1), v2_l_e2(2), v2_l_e2(3))
fprintf('\n The minimum altitude is %g km', r_p_flyby_Earth)
fprintf('\n The final position is [%g, %g, %g] (km).',...
                                                     r2_fin_e(1), r2_fin_e(2), r2_fin_e(3))
fprintf('\n The final velocity is [%g, %g, %g] (km/s).',...
                                                     v_fin_Earth(1), v_fin_Earth(2), v_fin_Earth(3))
fprintf('\n Time of flyby [%g Y, %g M, %g D, %g h, %g m, %g s] (km/s).',years_E, months_E, days_E, hours_E, minutes_E, seconds_E)

fprintf('\n--------------------------------------------------------\n\n')


plot_flyby(r_Earth, R_SOI_Earth, e_flyby_Earth, p_Earth, f_in_Earth_deg, r_p_flyby_Earth, 'E');
