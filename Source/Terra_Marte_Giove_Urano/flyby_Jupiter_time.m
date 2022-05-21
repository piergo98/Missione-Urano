%Calcolo il tempo t di flyby giove usando l'equazione di keplero

%velocità in uscita da Jupiter
v_inf_down_Jupiter = V2_l_j - v2_j;  
v_inf_down_norm_Jupiter = norm(v_inf_down_Jupiter); 

%semiaxis major
a_flyby_Jupiter = - mu_Jupiter / ((v_inf_down_norm_Jupiter)^2);   

%rp (km)
r_p_flyby_Jupiter = 100000;    

%eccentricity
e_flyby_Jupiter = 1-(r_p_flyby_Jupiter/a_flyby_Jupiter); 

%angolo tra gli asintoti 
delta_Jupiter = 2*asin(1/e_flyby_Jupiter);  
delta_deg_Jupiter = rad2deg(delta_Jupiter); 
% Angolo semiasse minore
b_flyby_Jupiter = a_flyby_Jupiter * tand((180-delta_deg_Jupiter)/2);

%ricavo l'anomalia vera f 
f_Jupiter = acos((a_flyby_Jupiter*(1-e_flyby_Jupiter^2)-r_p_flyby_Jupiter)...
    / (e_flyby_Jupiter*r_p_flyby_Jupiter)); 
f_deg_Jupiter = rad2deg(f_Jupiter);

%trovo p semilato retto [km] 
p_Jupiter = r_p_flyby_Jupiter*(1+e_flyby_Jupiter*cos(f_Jupiter)); 
 
%distanza per la quale voglio calcolare il tempo di volo
r = R_SOI_Jupiter; 

% Calcolo anomalia vera per r (in ingresso alla SOI) 
f_in_Jupiter = acos((1/e_flyby_Jupiter)*((p_Jupiter/r)-1)); 
f_in_Jupiter_deg = rad2deg(f_in_Jupiter);   % in gradi
cosh_F_Jupiter = (e_flyby_Jupiter+cos(f_in_Jupiter))/(e_flyby_Jupiter*cos(f_in_Jupiter)+1);

% Calcolo anomalia eccentrica
F_Jupiter = log(cosh_F_Jupiter+sqrt((cosh_F_Jupiter)^2-1));
F_Jupiter_deg = rad2deg(F_Jupiter);

% Trovo anomalia media M 
M_Jupiter = e_flyby_Jupiter*sinh(F_Jupiter)-F_Jupiter;
M_Jupiter_deg = rad2deg(M_Jupiter);  % in gradi 

%trovo il tempo 
t_flyby_Jupiter = M_Jupiter*sqrt(-a_flyby_Jupiter^3/mu_Jupiter); %in secondi 
t_flyby_tot_Jupiter = 2*t_flyby_Jupiter;  
t_flyby_tot_hours_Jupiter = t_flyby_tot_Jupiter/3600; 
 
[years_J months_J days_J hours_J minutes_J seconds_J] = sec2date(t_flyby_tot_Jupiter);

%...Output to the command window:
fprintf('\n Posizione iniziale [%g, %g, %g] (km).',...
                                                     r2_j(1), r2_j(2), r2_j(3))
fprintf('\n Velocità iniziale [%g, %g, %g] (km/s).',...
                                                     V2_l_j(1), V2_l_j(2), V2_l_j(3))
fprintf('\n Altezza minima passaggio su Giove %g km', r_p_flyby_Jupiter)
fprintf('\n Posizione finale [%g, %g, %g] (km).',...
    r2_fin_j(1), r2_fin_j(2), r2_fin_j(3))
fprintf('\n Velocità finale [%g, %g, %g] (km/s).',...
    v_fin_Jupiter(1), v_fin_Jupiter(2), v_fin_Jupiter(3))
fprintf('\n Tempo di volo nella sfera di influenza di Giove [%g Y, %g M, %g D, %g h, %g m, %g s] (km/s).',...
    years_J, months_J, days_J, hours_J, minutes_J, seconds_J)
fprintf('\n--------------------------------------------------------\n\n')
  
plot_flyby(r_Jupiter, R_SOI_Jupiter, e_flyby_Jupiter, p_Jupiter, f_in_Jupiter_deg, r_p_flyby_Jupiter, 'J'); 
