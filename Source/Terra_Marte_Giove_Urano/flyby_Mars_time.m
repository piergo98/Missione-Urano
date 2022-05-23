%% Calcolo il tempo t di flyby Mars usando l'equazione di keplero 
 
% Recupero dati pianeta attorno a cui faccio il flyby 
% Mars_Mars_Saturn_Uranus; 
v_inf_down_Mars = v2_l_m - v2_m; % velocità in ingresso al flyby    
v_inf_down_norm_Mars = norm(v_inf_down_Mars); % in norma  
 
% Calcolo elementi orbitali del flyby 
 
% Semiasse maggiore 
a_flyby_Mars = - mu_Mars/((v_inf_down_norm_Mars)^2); 
 
% Distanza minima fra traiettoria di flyby e pianeta(km)  
r_p_flyby_Mars = 6000;   
 
% Eccentricità traiettoria di flyby 
e_flyby_Mars = 1-(r_p_flyby_Mars/a_flyby_Mars);  
     
% Angolo tra gli asintoti  
delta_Mars = 2*asin(1/e_flyby_Mars);   
delta_deg_Mars = rad2deg(delta_Mars); % in gradi  
 
% Ricavo l'anomalia vera f 
f_Mars = acos((a_flyby_Mars*(1-e_flyby_Mars^2)-r_p_flyby_Mars) ... 
    / (e_flyby_Mars*r_p_flyby_Mars));  
f_deg_Mars = rad2deg(f_Mars); % in gradi 
 
% Trovo p semilato retto [km]  
p_Mars = r_p_flyby_Mars*(1+e_flyby_Mars*cos(f_Mars));  
 
% Distanza per la quale voglio calcolare il tempo di volo 
r = R_SOI_Mars;  
 
% Calcolo anomalia vera per r (in ingresso alla SOI) 
f_in_Mars = acos((1/e_flyby_Mars)*((p_Mars/r)-1)); 
f_in_Mars_deg = rad2deg(f_in_Mars);   % in gradi
cosh_F_Mars = (e_flyby_Mars+cos(f_in_Mars))/(e_flyby_Mars*cos(f_in_Mars)+1);

% Calcolo anomalia eccentrica
F_Mars = log(cosh_F_Mars+sqrt((cosh_F_Mars)^2-1));
F_Mars_deg = rad2deg(F_Mars);

% Trovo anomalia media M 
M_Mars = e_flyby_Mars*sinh(F_Mars)-F_Mars;
M_Mars_deg = rad2deg(M_Mars);  % in gradi 
  
% Trovo il tempo  
t_flyby_Mars = M_Mars*sqrt(-a_flyby_Mars^3/mu_Mars); % in secondi  
t_flyby_tot_Mars = 2*t_flyby_Mars;   
t_flyby_tot_hours_Mars = t_flyby_tot_Mars/3600;  
  
[years_M months_M days_M hours_M minutes_M seconds_M] = sec2date(t_flyby_tot_Mars);  
 
%...Output to the command window:
fprintf('\n Posizione iniziale [%g, %g, %g] (km).',...
                                                     r2_m(1), r2_m(2), r2_m(3))
fprintf('\n Velocità iniziale [%g, %g, %g] (km/s).',...
                                                     v2_l_m(1), v2_l_m(2), v2_l_m(3))
fprintf('\n Altezza minima passaggio su Marte %g km', r_p_flyby_Mars)
fprintf('\n Posizione finale [%g, %g, %g] (km).',...
    r2_fin_m(1), r2_fin_m(2), r2_fin_m(3))
fprintf('\n Velocità finale [%g, %g, %g] (km/s).',...
    v_fin_Mars(1), v_fin_Mars(2), v_fin_Mars(3))
fprintf('\n Tempo di volo nella sfera di influenza di Marte [%g Y, %g M, %g D, %g h, %g m, %g s] (km/s).',...
    years_M, months_M, days_M, hours_M, minutes_M, seconds_M)
fprintf('\n--------------------------------------------------------\n\n')
  
plot_flyby(r_Mars, R_SOI_Mars, e_flyby_Mars, p_Mars, f_in_Mars_deg, r_p_flyby_Mars, 'M'); 
