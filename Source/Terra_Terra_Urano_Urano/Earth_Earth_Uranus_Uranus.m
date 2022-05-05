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

%% Calcolo per risolvere Lambert Terra-Terra
% TOF 
dt = month2seconds(17);

% [coe_u1, ~, ~, ~] = planet_elements_and_sv(7, 2022, 10, 01, 00, 00, 00);
% 
% [coe_u2, ~, ~, ~] = planet_elements_and_sv(7, 2036, 04, 03, 00, 00, 00);

[azz, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2022, 10, 01, 18, 00, 00);

[~, r2_e2, v2_e2, ~] = planet_elements_and_sv(3, 2024, 03, 01, 18, 00, 00);

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

if d_theta < 181 && d_theta > 89
%     Plot of planets orbit and trajectory orbit
    plot_traiettoria_spacecraft(coe_ee, TA1_ee, TA2_ee, 'g')
    fprintf('\n TOF = %g (s)\n', dt);
    fprintf('\n Final speed = %g (Km/s)\n ', V_final)
    fprintf('\n Delta True Anomaly = %g (deg)\n', d_theta);
    fprintf('\n-----------------------------------------------------\n')
end

plot_orbit(3, 2022);    % Earth
plot_orbit(4, 2030);    % Mars
plot_orbit(5, 2030);    % Jupiter
plot_orbit(6,2030);     % Saturn
plot_orbit(7,2036);     % Uranus

%% Calcolo per risolvere flyby e Lambert dopo Flyby sulla Terra
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby.

% Recupero dati pianeta attorno a cui faccio il flyby
SOI_Earth;

mu_Earth = 3986004418; %[km^3/s^2] 
v_inf_down_Earth = v2_l_e2 - v2_e2;  
v_inf_down_norm_Earth = norm(v_inf_down_Earth); 

a_flyby_Earth = - mu_Earth/((v_inf_down_norm_Earth)^2); %semiaxis major 
r_p_flyby_Earth = 30000 ;  %rp  

e_flyby_Earth = 1-(r_p_flyby_Earth/a_flyby_Earth); 
    
delta_Earth = 2*asin(1/e_flyby_Earth); %angolo tra gli asintoti 
delta_deg_Earth = rad2deg(delta_Earth); 

% Uso scrpit per calcolare state vector dopo flyby

StateVector_Earth;

% Sposto il vettore posizione dello spacecraft lungo la direzione dopo il
% flyby sfruttando l'anomalia vera
% Elementi orbitali dell'orbita dopo il flyby
coe_flyby = coe_from_sv(r2_fin_e,v_fin_Earth,mu);

% Anomalia vera in partenza dalla SOI della Terra
TA_post_flyby = rad2deg(coe_flyby(6));

% Anomalia vera nel punto di partenza della traiettoria di Lambert fra la
% Terra e Saturno
TA_for_lambert = TA_post_flyby + 90;

% Calcolo delta T su traiettoria ellissoidale
a = coe_flyby(7);
e = coe_flyby(2);
dT = time_post_flyby(TA_post_flyby, TA_for_lambert, a, e, mu);

% Aggiorno il valore dell'anomalia vera per ottenere i coe prima del dV
coe_flyby(6) = deg2rad(TA_for_lambert);

%plotto la traiettoria fra SOI Terra e punto partenza di Lambert fra Terra
%e Saturno
plot_traiettoria_spacecraft(coe_flyby, TA_post_flyby, TA_for_lambert, 'g')
%% Punto partenza Lambert post flyby Terra con arrivo su Urano

% Trovo la posizione di Urano
[~, r2_u, ~, ~] = planet_elements_and_sv(7, 2039, 05, 13, 00, 00, 00);

% Definisco il tempo di volo
t = year2seconds(15);

% Estraggo il vettore di stato con i coe aggiornati all'ultima posizione
[r, v] = sv_from_coe(coe_flyby, mu);
% Risolvo Lambert per arrivare su Saturno
[V1_l_f, V2_l_u] = lambert(r, r2_u, t, string);

d_V_1 = v - V1_l_f;
d_V_norm = norm(d_V_1);


% Estrazione elementi orbitali orbita di trasferimento (using r1 and v1_l):
coe_eu = coe_from_sv(r, V1_l_f, mu);
% Initial true anomaly:
TA1_eu = rad2deg(coe_eu(6));

% Estrazione elementi orbitali orbita di trasferimento (using r2 and v2):
coe_eu = coe_from_sv(r2_u, V2_l_u, mu);
% Final true anomaly:
TA2_eu = rad2deg(coe_eu(6));

% Plot of planets orbit and trajectory orbit

plot_traiettoria_spacecraft(coe_eu, TA1_eu, TA1_eu+360 , 'g');
plot_traiettoria_spacecraft(coe_eu, TA1_eu, TA2_eu, 'r');

     
% fprintf('\n Starting speed = [%c %c %c] (Km/s)\n ', V1(1),V1(2), V1(3))
% fprintf('\n Final speed = [%c %c %c] (Km/s)\n ', V2(1),V2(2), V2(3))
% fprintf('\n Actual speed of sp = [%c %c %c] (Km/s)\n ', v(1),v(2), v(3))
fprintf('\n delta v = %s (Km/s)\n ', d_V_norm)
fprintf('\n Perigee flyby Earth = %g (Km)\n ',r_p_flyby_Earth)
fprintf('\n eccentricity = %g \n ',e_flyby_Earth)
fprintf('\n eccentricity from coe = %g \n ',coe_eu(2))
fprintf('\n starting point lambert = [%c %c %c] \n ',r(1),r(2),r(3))
fprintf('\n final point lambert = [%c %c %c] \n ',r2_u(1),r2_u(2),r2_u(3))
fprintf('\n-----------------------------------------------------\n')
