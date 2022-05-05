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
f_deg_Earth = rad2deg(f_Earth); % In gradi

% Trovo p semilato retto [km] 
p_Earth = r_p_flyby_Earth*(1+e_flyby_Earth*cos(f_Earth)); 

% Distanza per la quale voglio calcolare il tempo di volo
r = R_SOI_Earth; 

% Calcolo anomalia vera per r 
f1_Earth = acos((1/e_flyby_Earth)*((p_Earth/r)-1)); 

% Calcolo anomalia eccentrica
E_2_Earth = atanh(sqrt((e_flyby_Earth-1)/(e_flyby_Earth+1))*tan(f1_Earth/2)); 
E_Earth = E_2_Earth/2;
E_deg_Earth = rad2deg(E_Earth); % In gradi 

% Trovo anomalia media M 
M_Earth = e_flyby_Earth*sinh(E_Earth)-E_Earth; 
M_deg_Earth = rad2deg(M_Earth); % In gradi
 
% Trovo il tempo 
t_flyby_Earth = M_Earth*sqrt(-a_flyby_Earth^3/mu_Earth); %in secondi 
t_flyby_tot_Earth = 2*t_flyby_Earth;  
t_flyby_tot_hours_Earth = t_flyby_tot_Earth/3600; 
 
[years_E months_E days_E hours_E minutes_E seconds_E] = sec2date(t_flyby_tot_Earth); 

%...Output to the command window:
fprintf('\n\n--------------------------------------------------------\n')
fprintf('\n fly-by orbit jupiter\n')
fprintf(' %s\n', datestr(now))
fprintf('\n The initial position is [%g, %g, %g] (km).',...
                                                     r1(1), r1(2), r1(3))
fprintf('\n   Magnitude = %g km\n', norm(r1))
fprintf('\n The initial velocity is [%g, %g, %g] (km/s).',...
                                                     v_inf_down_Earth(1), v_inf_down_Earth(2), v_inf_down_Earth(3))
fprintf('\n   Magnitude = %g km/s\n', norm(v_inf_down_Earth))
fprintf('\n Initial time = %g h.\n Final time   = %g h.\n',0,tf/hours) 
fprintf('\n The minimum altitude is %g km at time = %g h.',...
            rmin-R, t(imin)/hours)
fprintf('\n The speed at that point is %g km/s.\n', v_at_rmin)
fprintf('\n The maximum altitude is %g km at time = %g h.',...
            rmax-R, t(imax)/hours)
fprintf('\n The speed at that point is %g km/s\n', v_at_rmax)
fprintf('\n--------------------------------------------------------\n\n')



 
