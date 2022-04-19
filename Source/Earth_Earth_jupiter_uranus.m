% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LAMBERT'S PROBLEM FROM EARTH TO EARTH
% ~~~~~~~~~~~~
%{
 
  deg    - factor for converting between degrees and radians
  pi     - 3.1415926...
  mu     - gravitational parameter (km^3/s^2)
  r1, r2 - initial and final position vectors (km)
  dt     - time between r1 and r2 (s)
  string - = 'pro' if the orbit is prograde
           = 'retro if the orbit is retrograde
  v1, v2 - initial and final velocity vectors (km/s)
  coe    - orbital elements [h e RA incl w TA a]
           where h    = angular momentum (km^2/s)
                 e    = eccentricity
                 RA   = right ascension of the ascending node (rad)
                 incl = orbit inclination (rad)
                 w    = argument of perigee (rad)
                 TA   = true anomaly (rad)
                 a    = semimajor axis (km)
  TA1    - Initial true anomaly (rad)
  TA2    - Final true anomaly (rad)
  T      - period of an elliptic orbit (s)

  User M-functions required: lambert, coe_from_sv
%}
% ---------------------------------------------

% clear all; 
% clc
addpath './Script matlab'
global mu
deg = pi/180;

%...Data declaration:

mu = 1.327*10^11;                   % mu sun (km^3/s^2)
% TOF 
dt = month2seconds(17);

[~, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2027, 11, 01, 18, 00, 00);

[~, r2_e2, v2_e2, ~] = planet_elements_and_sv(3, 2029, 03, 01, 18, 00, 00);

string = 'pro';

[v1_l_e1, v2_l_e2] = lambert(r1_e1, r2_e2, dt, string);

% Orbital elements Lambert's orbit
coe_ee = coe_from_sv(r1_e1, v1_l_e1, mu);
% True anomaly at the beginning of the mission
TA1_ee = rad2deg(coe_ee(6));

% Estrazione elementi orbitali orbita di trasferimento (using r2_e2 and v2_l_e2):
coe_ee = coe_from_sv(r2_e2, v2_l_e2, mu);
% True anomaly at the arrival on Earth
TA2_ee = rad2deg(coe_ee(6));

d_theta = abs(TA2_ee - TA1_ee);
V_final = norm(v2_l_e2);

% if d_theta < 181 && d_theta > 89
% %     Plot of planets orbit and trajectory orbit
    plot_traiettoria_spacecraft(coe_ee, TA1_ee, TA2_ee, 'g')
%     fprintf('\n TOF = %g\n', dt);
%     fprintf('\n Final speed = %g (Km/s)\n ', V_final)
%     fprintf('\n Delta True Anomaly = %g (deg)\n', d_theta);
%     fprintf('\n-----------------------------------------------------\n')
% end

 plot_orbit(3, 2022)
 plot_orbit(4,2030);
 %plot_orbit(5,2030);


%% Calcolo per risolvere flyby e Lambert dopo Flyby sulla Terra
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby.

% Recupero dati pianeta attorno a cui faccio il flyby
SOI_Earth;

mu_Earth = 3986004418; %[km^3/s^2] 
v_inf_down_Earth = v2_l_e2 - v2_e2;  
v_inf_down_norm_Earth = norm(v_inf_down_Earth); 

a_flyby_Earth = - mu_Earth/((v_inf_down_norm_Earth)^2); %semiaxis major 
r_p_flyby_Earth = 35000 ;  %rp  

e_flyby_Earth = 1-(r_p_flyby_Earth/a_flyby_Earth); 
    
delta_Earth = 2*asin(1/e_flyby_Earth); %angolo tra gli asintoti 
delta_deg_Earth = rad2deg(delta_Earth); 

% Uso scrpit per calcolare state vector dopo flyby

StateVector_Earth;


% Elementi orbitali dell'orbita dopo il flyby
coe_flyby = coe_from_sv(r2_fin_e,v_fin_Earth,mu);

% Anomalia vera in partenza dalla SOI della Terra
TA_post_flyby = rad2deg(coe_flyby(6));

% Anomalia vera nel punto di partenza della traiettoria di Lambert fra la
% Terra e Giove
TA_for_lambert = TA_post_flyby + 100;

% Calcolo delta T su traiettoria ellissoidale
a = coe_flyby(7);
e = coe_flyby(2);
dT = time_post_flyby(TA_post_flyby, TA_for_lambert, a, e, mu);

% Aggiorno il valore dell'anomalia vera per ottenere i coe prima del dV
coe_flyby(6) = deg2rad(TA_for_lambert);

%plotto la traiettoria fra SOI Terra e punto partenza di Lambert fra Terra
%e Giove
 plot_traiettoria_spacecraft(coe_flyby, TA_post_flyby, TA_for_lambert, 'g')

%% Punto partenza lambert post flyby terra con arrivo su giove
% Trovo la posizione di Giove
[~, r2_j, v2_j, ~] = planet_elements_and_sv(5, 2032, 03, 01, 00, 00, 00);

% Definisco il tempo di volo
t = year2seconds(3);


% Estraggo il vettore di stato con i coe aggiornati all'ultima posizione
[r, v] = sv_from_coe(coe_flyby, mu);
% Risolvo Lambert per arrivare su Giove
[V1_l_f, V2_l_j] = lambert(r, r2_j, t, 'pro');

%d_V_1 = v - V1_l_f;
%d_V_norm = norm(d_V_1);


% Estrazione elementi orbitali orbita di trasferimento (using r and v1_l_f):
coe_ej = coe_from_sv(r, V1_l_f, mu);
% Initial true anomaly:
TA1_ej = rad2deg(coe_ej(6));

% Estrazione elementi orbitali orbita di trasferimento (using r2_j and v2_l_j):
coe_ej = coe_from_sv(r2_j, V2_l_j, mu);
% Final true anomaly:
TA2_ej = rad2deg(coe_ej(6));

% Plot of planets orbit and trajectory orbit

 plot_orbit(5,2030);
 plot_traiettoria_spacecraft(coe_ej, TA1_ej, TA2_ej , 'g');

     
% fprintf('\n Starting speed = [%c %c %c] (Km/s)\n ', V1(1),V1(2), V1(3))
% fprintf('\n Final speed = [%c %c %c] (Km/s)\n ', V2(1),V2(2), V2(3))
% fprintf('\n Actual speed of sp = [%c %c %c] (Km/s)\n ', v(1),v(2), v(3))
% fprintf('\n delta v = %s (Km/s)\n ', d_V_norm)
% fprintf('\n Distance from Jupiter = %g (Km)\n ',r_p_flyby_Earth)
% fprintf('\n eccentricity = %g \n ',e_flyby_Earth)
% fprintf('\n eccentricity from coe = %g \n ',coe_flyby(2))
% fprintf('\n starting point lambert = [%c %c %c] \n ',r(1),r(2),r(3))
% fprintf('\n-----------------------------------------------------\n')





%% Calcolo per risolvere Lambert dopo Flyby su un pianeta
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby.

SOI_JUPITER;

%Trovo la posizione del pianeta Target

[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2036, 02, 01, 00, 00, 00);

%definisco il tempo di volo
t = year2seconds(6);

%Eseguo un ciclo for che varia la posizione di rp e mi modifica delta
GM_saturn = 37931187; %[km^3/s^2] 
v_inf_down_saturn = V2_l_j - v2_j ;  
v_inf_down_norm_saturn = norm(v_inf_down_saturn); 

a_flyby_saturn = - GM_saturn/((v_inf_down_norm_saturn)^2);%semiaxis major 
r_p_flyby_saturn = 650000 ;  %hp  
%r_p_flyby_Jupiter = 1e5;

e_flyby_saturn = 1-(r_p_flyby_saturn/a_flyby_saturn); 

delta_saturn = 2*asin(1/e_flyby_saturn); %angolo tra gli asintoti 
delta_deg_saturn = rad2deg(delta_saturn); 

%Uso scrpit per calcolare state vector dopo flyby

StateVector_JUPITER;

% Calcolo elementi orbitali nel sistema eliocentrico all'uscita della SOI
coe_flyby = coe_from_sv(r2_fin_j,v_fin_Jupiter,mu);

% Anomalia vera in partenza dalla SOI di Giove
TA_post_flyby = rad2deg(coe_flyby(6));

% Anomalia vera nel punto di partenza della traiettoria di Lambert fra
% Giove e Urano
TA_for_lambert = TA_post_flyby + 170 ;

% Calcolo delta T su traiettoria ellissoidale
a = coe_flyby(7);
e = coe_flyby(2);
dT = time_post_flyby(TA_post_flyby, TA_for_lambert, a, e, mu);

% Aggiorno il valore dell'anomalia vera per ottenere i coe prima del dV
coe_flyby(6) = deg2rad(TA_for_lambert);

%plotto la traiettoria fra SOI Giove e punto partenza di Lambert fra Giove
%e Urano
plot_traiettoria_spacecraft(coe_flyby, TA_post_flyby, TA_for_lambert, 'g')

%trovo state vector da parametri orbitali
[r, v] = sv_from_coe(coe_flyby,mu) ;
%  Faccio Lambert appena uscito dalla SOI
[V1_l_f, V2_l_u] = lambert(r, r2_u, t, 'pro');

d_V_2 = v_fin_Jupiter - V1_l_f;
d_V_norm = norm(d_V_2);


% Estrazione elementi orbitali orbita di trasferimento (using r1 and v1):
coe_ju = coe_from_sv(r, V1_l_f, mu);
% Initial true anomaly:
TA1_ju = rad2deg(coe_ju(6));

% Estrazione elementi orbitali orbita di trasferimento (using r2 and v2):
coe_ju = coe_from_sv(r2_u, V2_l_u, mu);
% Final true anomaly:
TA2_ju = rad2deg(coe_ju(6));
% Plot of planets orbit and trajectory orbit
plot_orbit(7,2036)
plot_traiettoria_spacecraft(coe_ju, TA1_ju, TA2_ju , 'g');
plot_orbit(1,2036)