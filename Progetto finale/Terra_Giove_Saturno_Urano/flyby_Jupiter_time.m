%Calcolo il tempo t di flyby giove usando l'equazione di keplero

Earth_Jupiter_Saturn_Uranus;

%velocità in uscita da Jupiter
v_inf_down_Jupiter = v2_l_j - v2_j;  
v_inf_down_norm_Jupiter = norm(v_inf_down_Jupiter); 

%semiaxis major
a_flyby_Jupiter = - mu_Jupiter / ((v_inf_down_norm_Jupiter)^2);   

%rp (km)
r_p_flyby_Jupiter = 5e6;    

%eccentricity
e_flyby_Jupiter = 1-(r_p_flyby_Jupiter/a_flyby_Jupiter); 

%angolo tra gli asintoti 
delta_Jupiter = 2*asin(1/e_flyby_Jupiter);  
delta_deg_Jupiter = rad2deg(delta_Jupiter); 
% Angolo semiasse minore
b_flyby_Jupiter = a_flyby_Jupiter * tand((180-delta_deg_Jupiter)/2);

%ricavo l'anomalia vera f 
f_Jupiter = acos((a_flyby_Jupiter*(1-e_flyby_Jupiter^2)-r_p_flyby_Jupiter) / (e_flyby_Jupiter*r_p_flyby_Jupiter)); 
f_deg_Jupiter = rad2deg(f_Jupiter);

%trovo p semilato retto [km] 
p_Jupiter = r_p_flyby_Jupiter*(1+e_flyby_Jupiter*cos(f_Jupiter)); 
 
%distanza per la quale voglio calcolare il tempo di volo
r = R_SOI_Jupiter; 

%calcolo anomalia vera per r (in ingresso alla SOI) 
f_in_Jupiter = acos((1/e_flyby_Jupiter)*((p_Jupiter/r)-1)); 
f_in_Jupiter_deg = rad2deg(f_in_Jupiter);   % in gradi
cosh_F_jupiter=(e_flyby_Jupiter+cos(f_in_Jupiter))/(e_flyby_Jupiter*cos(f_in_Jupiter)+1);

%calcolo anomalia eccentrica
F_jupiter=log(cosh_F_jupiter+sqrt((cosh_F_jupiter)^2-1));
F_jupiter_deg=rad2deg(F_jupiter);

%trovo anomalia media M 
M_Jupiter=e_flyby_Jupiter*sinh(F_jupiter)-F_jupiter; 
M_deg_Jupiter=rad2deg(M_Jupiter); 
 
%trovo il tempo 
t_flyby_Jupiter = M_Jupiter*sqrt(-a_flyby_Jupiter^3/mu_Jupiter); %in secondi 
t_flyby_tot_Jupiter = 2*t_flyby_Jupiter;  
t_flyby_tot_hours_Jupiter = t_flyby_tot_Jupiter/3600; 
 
[years_J months_J days_J hours_J minutes_J seconds_J] = sec2date(t_flyby_tot_Jupiter);

%...Output to the command window:
% fprintf('\n\n--------------------------------------------------------\n')
% fprintf('\n fly-by orbit Jupiter\n')
% fprintf('\n The initial position is [%g, %g, %g] (km).',...
%                                                      r2_j(1), r2_j(2), r2_j(3))
% fprintf('\n The initial velocity is [%g, %g, %g] (km/s).',...
%                                                      v2_l_j(1), v2_l_j(2), v2_l_j(3))
% fprintf('\n The minimum altitude is %g km', r_p_flyby_Jupiter)
% fprintf('\n The final position is [%g, %g, %g] (km).',...
%                                                      r2_fin_j(1), r2_fin_j(2), r2_fin_j(3))
% fprintf('\n The final velocity is [%g, %g, %g] (km/s).',...
%                                                      v_fin_Jupiter(1), v_fin_Jupiter(2), v_fin_Jupiter(3))
% fprintf('\n Time of flyby [%g Y, %g M, %g D, %g h, %g m, %g s] (km/s).',years_J, months_J, days_J, hours_J, minutes_J, seconds_J)
% 
% fprintf('\n--------------------------------------------------------\n\n')

plot_flyby(r_Jupiter, R_SOI_Jupiter, e_flyby_Jupiter, p_Jupiter, f_in_Jupiter_deg, r_p_flyby_Jupiter, 'J');


