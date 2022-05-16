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

init_Terra_Terra_Urano_Urano;

%% calcolo Lambert fra posizione iniziale Terra e posizione finale terra al momento del flyby

% Dati per posizione e velocità Terra alla partenza della spedizione e al
% momento della cattura per il primo flyby

[~, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2022, 06, 01, 18, 00, 00);

[~, r2_e2, v2_e2, ~] = planet_elements_and_sv(3, 2023, 01, 01, 18, 00, 00);

% Tempo di volo Terra-Terra
t_EE = month2seconds(7);

string = 'pro'; %direzione lambert

% Calcolo la traiettoria di Lambert Terra-Terra
[v1_l_e1, v2_l_e2] = lambert(r1_e1, r2_e2, t_EE, string); % '1' = partenza, '2' = arrivo

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza)
coe_ee = coe_from_sv(r1_e1, v1_l_e1, mu_Sun);
% Anomalia vera alla partenza della missione Terra-Terra
TA1_ee = rad2deg(coe_ee(6));

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo)
coe_ee = coe_from_sv(r2_e2, v2_l_e2, mu_Sun);
% Anomalia vera alla fine della missione Terra-Terra
TA2_ee = rad2deg(coe_ee(6));

% Variazione angolo di anomalia vera
d_theta = abs(TA2_ee - TA1_ee);

% Velocità finale prima della cattura da parte della Terra
V_final = norm(v2_l_e2);

%% Calcolo per risolvere flyby intorno alla Terra

% Recupero dati pianeta attorno a cui faccio il flyby
v_inf_down_Earth = v2_l_e2 - v2_e2; % velocità in ingresso al flyby   
v_inf_down_norm_Earth = norm(v_inf_down_Earth); % in norma 

% Calcolo elementi orbitali del flyby

% Semiasse maggiore
a_flyby_Earth = - mu_Earth/((v_inf_down_norm_Earth)^2);

% Distanza minima fra traiettoria di flyby e pianeta(km) 
r_p_flyby_Earth = 10000;  

% Eccentricità traiettoria di flyby
e_flyby_Earth = 1-(r_p_flyby_Earth/a_flyby_Earth); 
    
% Angolo tra gli asintoti 
delta_Earth = 2*asin(1/e_flyby_Earth);  
delta_deg_Earth = rad2deg(delta_Earth); % in gradi 

% Uso script per calcolare state vector dopo flyby

StateVector_Earth;

%% Traiettoria eliocentrica dopo Flyby sulla Terra 
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby, variando l'anomalia vera.

% Elementi orbitali dell'orbita dopo il flyby
coe_flyby = coe_from_sv(r2_fin_e,v_fin_Earth,mu_Sun);

% Anomalia vera in partenza dalla SOI della Terra
TA_post_flyby = rad2deg(coe_flyby(6));

% Anomalia vera nel punto di partenza della traiettoria di Lambert fra la
% Terra e Urano
TA_for_lambert = TA_post_flyby;

% Calcolo delta T su traiettoria ellissoidale
a = coe_flyby(7);
e = coe_flyby(2);
dT = time_post_flyby(TA_post_flyby, TA_for_lambert, a, e, mu_Sun);

% Aggiorno il valore dell'anomalia vera per ottenere i coe prima del dV
coe_flyby(6) = deg2rad(TA_for_lambert);

%% Calcolo traiettoria lambert post flyby terra con arrivo su Urano

% Trovo la posizione e velocità di Urano
[~, r2_u1, v2_u1, ~] = planet_elements_and_sv(7, 2039, 01, 01, 18, 00, 00);
% Definisco il tempo di volo dal punto scelto post flyby e Urano
t_EU = year2seconds(16); % 'fu' = da punto post flyby a Urano

% Estraggo il vettore di stato con i coe aggiornati all'ultima posizione
[r, v] = sv_from_coe(coe_flyby, mu_Sun);
% Risolvo Lambert per arrivare su Urano
[V1_l_f, V2_l_u1] = lambert(r, r2_u1, t_EU, 'pro');

% Delta V necessario per portarmi sulla traiettoria di Lambert
d_V_eu1 = v_fin_Earth - V1_l_f;    % 'fS' = da punto post flyby a Urano
d_V_eu1_norm = norm(d_V_eu1);    % in norma

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza)
coe_eu1 = coe_from_sv(r, V1_l_f, mu_Sun);
% Anomalia vera alla partenza della missione r-Urano
TA1_eu1 = rad2deg(coe_eu1(6));

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo)
coe_eu1 = coe_from_sv(r2_u1, V2_l_u1, mu_Sun);
% Anomalia vera alla fine della missione r-Urano
TA2_eu1 = rad2deg(coe_eu1(6));

% Variazione angolo di anomalia vera
d_theta = abs(TA2_eu1 - TA1_eu1);

% Velocità finale prima del flyby su Urano
V_final = norm(V2_l_u1);

%% Calcolo per risolvere flyby intorno a Urano

% Recupero dati pianeta attorno a cui faccio il flyby
v_inf_down_Uranus = V2_l_u1 - v2_u1; % velocità in ingresso al flyby   
v_inf_down_norm_Uranus = norm(v_inf_down_Uranus); % in norma 

% Calcolo elementi orbitali del flyby

% Semiasse maggiore
a_flyby_Uranus = - mu_Uranus/((v_inf_down_norm_Uranus)^2);

% Distanza minima fra traiettoria di flyby e pianeta(km) 
r_p_flyby_Uranus = 1000000;  

% Eccentricità traiettoria di flyby
e_flyby_Uranus = 1-(r_p_flyby_Uranus/a_flyby_Uranus); 
    
% Angolo tra gli asintoti 
delta_Uranus = 2*asin(1/e_flyby_Uranus);  
delta_deg_Uranus = rad2deg(delta_Uranus); % in gradi 

% Uso script per calcolare state vector dopo flyby

StateVector_Uranus;

%% Traiettoria eliocentrica dopo Flyby su Urano
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby, variando l'anomalia vera.

% Elementi orbitali dell'orbita dopo il flyby
coe_flyby = coe_from_sv(r2_fin_u,v_fin_Uranus,mu_Sun);

% Anomalia vera in partenza dalla SOI di Urano
TA_post_flyby = rad2deg(coe_flyby(6));

% Anomalia vera nel punto di partenza della traiettoria di Lambert fra la
% Urano e Urano
TA_for_lambert = TA_post_flyby;

% Calcolo delta T su traiettoria ellissoidale
a = coe_flyby(7);
e = coe_flyby(2);
dT = time_post_flyby(TA_post_flyby, TA_for_lambert, a, e, mu_Sun);

% Aggiorno il valore dell'anomalia vera per ottenere i coe prima del dV
coe_flyby(6) = deg2rad(TA_for_lambert);

%% Calcolo traiettoria lambert post flyby Urano con arrivo su Urano

% Trovo la posizione e velocità di Urano
[~, r2_u2, v2_u2, ~] = planet_elements_and_sv(7, 2040, 01, 01, 18, 00, 00);
% Definisco il tempo di volo dal punto scelto post flyby e Urano
t_UU = year2seconds(1); % 'fu' = da punto post flyby a Urano

% Estraggo il vettore di stato con i coe aggiornati all'ultima posizione
[r, v] = sv_from_coe(coe_flyby, mu_Sun);
% Risolvo Lambert per arrivare su Urano
[V1_l_f2, V2_l_u2] = lambert(r, r2_u2, t_UU, 'pro');

% Delta V necessario per portarmi sulla traiettoria di Lambert
d_V_u1u2 = v_fin_Uranus - V1_l_f2;
d_V_u1u2_norm = norm(d_V_u1u2);    % in norma

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza)
coe_u1u2 = coe_from_sv(r, V1_l_f2, mu_Sun);
% Anomalia vera alla partenza della missione r-Urano
TA1_u1u2 = rad2deg(coe_u1u2(6));

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo)
coe_u1u2 = coe_from_sv(r2_u2, V2_l_u2, mu_Sun);
% Anomalia vera alla fine della missione r-Urano
TA2_u1u2 = rad2deg(coe_u1u2(6));

% Variazione angolo di anomalia vera
d_theta = abs(TA2_u1u2 - TA1_u1u2);

% Velocità finale prima del flyby su Urano
V_final = norm(V2_l_u2);

