%Calcolo il tempo t di flyby Venere usando l'equazione di keplero

%Earth_Venus_Saturn_Uranus;

%velocità in uscita da Venus
v_inf_down_Venus = v2_l_v - v2_v;  
v_inf_down_norm_Venus = norm(v_inf_down_Venus); 

%semiaxis major
a_flyby_Venus = - mu_Venus / ((v_inf_down_norm_Venus)^2);   

%rp (km)
r_p_flyby_Venus = r_Venus + 8000;    

%eccentricity
e_flyby_Venus = 1-(r_p_flyby_Venus/a_flyby_Venus); 

%angolo tra gli asintoti 
delta_Venus = 2*asin(1/e_flyby_Venus);  
delta_deg_Venus = rad2deg(delta_Venus); 
% Angolo semiasse minore
b_flyby_Venus = a_flyby_Venus * tand((180-delta_deg_Venus)/2);

%ricavo l'anomalia vera f 
f_Venus = acos((a_flyby_Venus*(1-e_flyby_Venus^2)-r_p_flyby_Venus) / (e_flyby_Venus*r_p_flyby_Venus)); 
f_deg_Venus = rad2deg(f_Venus);

%trovo p semilato retto [km] 
p_Venus = r_p_flyby_Venus*(1+e_flyby_Venus*cos(f_Venus)); 
 
%distanza per la quale voglio calcolare il tempo di volo
r = R_SOI_Venus; 

%calcolo anomalia vera per r (in ingresso alla SOI) 
f_in_Venus = acos((1/e_flyby_Venus)*((p_Venus/r)-1)); 
f_in_Venus_deg = rad2deg(f_in_Venus);   % in gradi
cosh_F_Venus = (e_flyby_Venus+cos(f_in_Venus))/(e_flyby_Venus*cos(f_in_Venus)+1);

%calcolo anomalia eccentrica
F_Venus = log(cosh_F_Venus+sqrt((cosh_F_Venus)^2-1));
F_Venus_deg = rad2deg(F_Venus);

%trovo anomalia media M 
M_Venus = e_flyby_Venus*sinh(F_Venus)-F_Venus; 
M_deg_Venus=rad2deg(M_Venus); 
 
%trovo il tempo 
t_flyby_Venus = M_Venus*sqrt(-a_flyby_Venus^3/mu_Venus); %in secondi 
t_flyby_tot_Venus = 2*t_flyby_Venus;  
t_flyby_tot_hours_Venus = t_flyby_tot_Venus/3600; 
 
[years_V months_V days_V hours_V minutes_V seconds_V] = sec2date(t_flyby_tot_Venus);

%...Output to the command window:
fprintf('\n Posizione iniziale [%g, %g, %g] (km).',...
                                                     r2_v(1), r2_v(2), r2_v(3))
fprintf('\n Velocità iniziale [%g, %g, %g] (km/s).',...
                                                     v2_l_v(1), v2_l_v(2), v2_l_v(3))
fprintf('\n Altezza minima passaggio su Venere %g km', r_p_flyby_Venus)
fprintf('\n Posizione finale [%g, %g, %g] (km).', r2_fin_v(1), r2_fin_v(2), r2_fin_v(3))
fprintf('\n Velocità finale [%g, %g, %g] (km/s).', v_fin_Venus(1), v_fin_Venus(2), v_fin_Venus(3))
fprintf('\n Tempo di volo nella sfera di influenza di Venere [%g Y, %g M, %g D, %g h, %g m, %g s] (km/s).' ...
    ,years_V, months_V, days_V, hours_V, minutes_V, seconds_V)
fprintf('\n--------------------------------------------------------\n\n')

plot_flyby(r_Venus, R_SOI_Venus, e_flyby_Venus, p_Venus, f_in_Venus_deg, r_p_flyby_Venus, 'V');


