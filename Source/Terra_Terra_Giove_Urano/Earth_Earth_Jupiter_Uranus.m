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

init_Terra_Terra_Giove_Urano;

%% calcolo Lambert fra posizione iniziale Terra e posizione finale terra al momento del flyby

% Dati per posizione e velocità Terra alla partenza della spedizione e al
% momento della cattura per il primo flyby

%[~, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2022, 10, 01, 18, 00, 00);
[~, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2031, 03, 01, 18, 00, 00);

%[~, r2_e2, v2_e2, ~] = planet_elements_and_sv(3, 2024, 03, 01, 18, 00, 00);
[~, r2_e2, v2_e2, ~] = planet_elements_and_sv(3, 2032, 08, 01, 18, 00, 00);

% Tempo di volo Terra-Terra
t_EE = month2seconds(17);

string = 'pro'; %direzione lambert

% Calcolo la traiettoria di Lambert Terra-Terra
[v1_l_e1, v2_l_e2] = lambert(r1_e1, r2_e2, t_EE, string); % '1' = partenza, '2' = arrivo

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza)
coe_ee = coe_from_sv(r1_e1, v1_l_e1, mu);
% Anomalia vera alla partenza della missione Terra-Terra
TA1_ee = rad2deg(coe_ee(6));

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo)
coe_ee = coe_from_sv(r2_e2, v2_l_e2, mu);
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
%r_p_flyby_Earth = 30000;  
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
coe_flyby = coe_from_sv(r2_fin_e,v_fin_Earth,mu);

% Anomalia vera in partenza dalla SOI della Terra
TA_post_flyby = rad2deg(coe_flyby(6));

% Anomalia vera nel punto di partenza della traiettoria di Lambert fra la
% Terra e Saturno
%TA_for_lambert = TA_post_flyby + 90;
TA_for_lambert = TA_post_flyby;


% Calcolo delta T su traiettoria ellissoidale
a = coe_flyby(7);
e = coe_flyby(2);
dT = time_post_flyby(TA_post_flyby, TA_for_lambert, a, e, mu);

% Aggiorno il valore dell'anomalia vera per ottenere i coe prima del dV
coe_flyby(6) = deg2rad(TA_for_lambert);

%% Calcolo traiettoria lambert post flyby terra con arrivo su Giove

% Trovo la posizione e velocità di Giove
% [~, r2_s, v2_s, ~] = planet_elements_and_sv(6, 2030, 04, 03, 00, 00, 00);
[~, r2_j, v2_j, ~] = planet_elements_and_sv(5, 2036, 08, 01, 00, 00, 00);
% Definisco il tempo di volo dal punto scelto post flyby e Saturno
t_EJ = year2seconds(4); % 'fS' = da punto post flyby a Saturno

% Estraggo il vettore di stato con i coe aggiornati all'ultima posizione
[r, v] = sv_from_coe(coe_flyby, mu);
% Risolvo Lambert per arrivare su Saturno
[V1_l_f, V2_l_j] = lambert(r, r2_j, t_EJ, 'pro');

% Delta V necessario per portarmi sulla traiettoria di Lambert
d_V_ej = v_fin_Earth - V1_l_f;    % 'fS' = da punto post flyby a Saturno     
d_V_ej_norm = norm(d_V_ej);    % in norma


% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza)
coe_ej = coe_from_sv(r, V1_l_f, mu);
% Anomalia vera alla partenza della missione r-Saturno
TA1_ej = rad2deg(coe_ej(6));

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo)
coe_ej = coe_from_sv(r2_j, V2_l_j, mu);
% Anomalia vera alla fine della missione r-Saturno
TA2_ej = rad2deg(coe_ej(6));


%% Calcolo per risolvere flyby intorno a Giove

% Recupero dati pianeta attorno al quale faccio il flyby
v_inf_down_Jupiter = V2_l_j - v2_j; % velocità in ingresso al flyby     
v_inf_down_norm_Jupiter = norm(v_inf_down_Jupiter); % in norma  

% Calcolo elementi orbitali del flyby

% Semiasse maggiore
a_flyby_Jupiter = - mu_Jupiter/((v_inf_down_norm_Jupiter)^2);

% Distanza minima fra traiettoria di flyby e pianeta(km) 
%r_p_flyby_saturn = 1.8e6;
r_p_flyby_Jupiter = 100000;

% Eccentricità traiettoria di flyby
e_flyby_Jupiter = 1-(r_p_flyby_Jupiter/a_flyby_Jupiter); 
    
% Angolo tra gli asintoti 
delta_Jupiter = 2*asin(1/e_flyby_Jupiter); 
delta_deg_Jupiter = rad2deg(delta_Jupiter);   % in gradi 

% Uso script per calcolare state vector dopo flyby

StateVector_JUPITER;

%% Calcolo traiettoria di Lambert post Flyby su Saturno 

% Trovo la posizione e velocità di Urano
%[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2036, 04, 03, 00, 00, 00);
[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2042, 12, 01, 00, 00, 00);
% Definisco il tempo di volo Saturno-Urano
t_JU = year2seconds(6) + month2seconds(4);

% Calcolo la traiettoria di Lambert Terra-Terra
[V1_l_j, V2_l_u] = lambert(r2_fin_j, r2_u, t_JU, 'pro'); % '1' = partenza, '2' = arrivo

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza)
coe_ju = coe_from_sv(r2_fin_j, V1_l_j, mu);
% Anomalia vera alla partenza della missione Giove-Urano
TA1_ju = rad2deg(coe_ju(6));

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo)
coe_ju = coe_from_sv(r2_u, V2_l_u, mu);
% Anomalia vera alla fine della missione Giove-Urano
TA2_ju = rad2deg(coe_ju(6));

% Delta V necessario per portarmi sulla traiettoria di Lambert
d_V_JU = v_fin_Jupiter - V1_l_j;    % 'fS' = da punto post flyby a Saturno     
d_V_JU_norm = norm(d_V_JU);    % in norma
