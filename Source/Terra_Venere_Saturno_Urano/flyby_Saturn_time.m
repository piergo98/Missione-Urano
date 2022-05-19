%% Calcolo il tempo t di flyby Saturn usando l'equazione di keplero

% Recupero dati pianeta attorno al quale faccio il flyby
v_inf_down_Saturn = V2_l_s - v2_s; % velocità in ingresso al flyby     
v_inf_down_norm_Saturn = norm(v_inf_down_Saturn); % in norma  

% Calcolo elementi orbitali del flyby

% Semiasse maggiore
a_flyby_Saturn = - mu_Saturn/((v_inf_down_norm_Saturn)^2);

% Distanza minima fra traiettoria di flyby e pianeta(km) 
r_p_flyby_Saturn = 2e6;

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
f_in_Saturn = acos((1/e_flyby_Saturn)*((p_Saturn/r)-1)); 
f_in_Saturn_deg = rad2deg(f_in_Saturn);   % in gradi
cosh_F_saturn = (e_flyby_Saturn+cos(f_in_Saturn))/(e_flyby_Saturn*cos(f_in_Saturn)+1);

% Calcolo anomalia eccentrica
F_saturn = log(cosh_F_saturn+sqrt((cosh_F_saturn)^2-1));
F_saturn_deg = rad2deg(F_saturn);

% Trovo anomalia media M 
M_Saturn = e_flyby_Saturn*sinh(F_saturn)-F_saturn;
 
% Trovo il tempo 
t_flyby_Saturn = M_Saturn*sqrt(-a_flyby_Saturn^3/mu_Saturn); % In secondi 
t_flyby_tot_Saturn = 2*t_flyby_Saturn;  
t_flyby_tot_hours_Saturn = t_flyby_tot_Saturn/3600; % In ore
 
[years_S months_S days_S hours_S minutes_S seconds_S] = sec2date(t_flyby_tot_Saturn); 

%...Output to the command window:
fprintf('\n Posizione iniziale [%g, %g, %g] (km).',...
                                                     r2_s(1), r2_s(2), r2_s(3))
fprintf('\n Velocità iniziale [%g, %g, %g] (km/s).',...
                                                     V2_l_s(1), V2_l_s(2), V2_l_s(3))
fprintf('\n Altezza minima passaggio su Saturno %g km', r_p_flyby_Saturn)
fprintf('\n Posizione finale [%g, %g, %g] (km).',...
    r2_fin_s(1), r2_fin_s(2), r2_fin_s(3))
fprintf('\n Velocità finale [%g, %g, %g] (km/s).',...
    v_fin_saturn(1), v_fin_saturn(2), v_fin_saturn(3))
fprintf('\n Tempo di volo nella sfera di influenza di Saturno [%g Y, %g M, %g D, %g h, %g m, %g s] (km/s).',...
    years_S, months_S, days_S, hours_S, minutes_S, seconds_S)
fprintf('\n--------------------------------------------------------\n\n')

plot_flyby(r_Saturn, R_SOI_Saturn, e_flyby_Saturn, p_Saturn, f_in_Saturn_deg, r_p_flyby_Saturn, 'S');


 
