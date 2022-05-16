%% Calcolo il tempo t di flyby Uranus usando l'equazione di keplero

% Recupero dati pianeta attorno a cui faccio il flyby
v_inf_down_Uranus = V2_l_u2 - v2_u2; % velocità in ingresso al flyby   
v_inf_down_norm_Uranus = norm(v_inf_down_Uranus); % in norma 

% Calcolo elementi orbitali del flyby

% Semiasse maggiore
a_flyby_Uranus = - mu_Uranus/((v_inf_down_norm_Uranus)^2);

% Distanza minima fra traiettoria di flyby e pianeta(km) 
r_p_flyby_Uranus = 30000;  

% Eccentricità traiettoria di flyby
e_flyby_Uranus = 1-(r_p_flyby_Uranus/a_flyby_Uranus); 
    
% Angolo tra gli asintoti 
delta_Uranus = 2*asin(1/e_flyby_Uranus);  
delta_deg_Uranus = rad2deg(delta_Uranus); % in gradi 

% Ricavo l'anomalia vera f
f_Uranus = acos((a_flyby_Uranus*(1-e_flyby_Uranus^2)-r_p_flyby_Uranus) ...
    / (e_flyby_Uranus*r_p_flyby_Uranus)); 
f_deg_Uranus = rad2deg(f_Uranus); % in gradi

% Trovo p semilato retto [km] 
p_Uranus = r_p_flyby_Uranus*(1+e_flyby_Uranus*cos(f_Uranus)); 

% Distanza per la quale voglio calcolare il tempo di volo
r = R_SOI_Uranus; 

% Calcolo anomalia vera per r 
f_in_Uranus = acos((1/e_flyby_Uranus)*((p_Uranus/r)-1)); 
f_in_Uranus_deg = rad2deg(f_in_Uranus);   % in gradi

% Calcolo anomalia eccentrica
E_2_Uranus = atanh(sqrt((e_flyby_Uranus-1)/(e_flyby_Uranus+1))*tan(f_in_Uranus/2)); 
E_Uranus = E_2_Uranus/2;
E_deg_Uranus = rad2deg(E_Uranus); % in gradi 

% Trovo anomalia media M 
M_Uranus = e_flyby_Uranus*sinh(E_Uranus)-E_Uranus; 
M_deg_Uranus = rad2deg(M_Uranus); % in gradi
 
% Trovo il tempo 
t_flyby_Uranus = M_Earth*sqrt(-a_flyby_Uranus^3/mu_Uranus); % in secondi 
t_flyby_tot_Uranus = 2*t_flyby_Uranus;  
t_flyby_tot_hours_Uranus = t_flyby_tot_Uranus/3600; 
 
[years_U months_U days_U hours_U minutes_U seconds_U] = sec2date(t_flyby_tot_Uranus); 

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


plot_flyby(r_Uranus, R_SOI_Uranus, e_flyby_Uranus, p_Uranus, f_in_Uranus_deg, r_p_flyby_Uranus, 'U');
