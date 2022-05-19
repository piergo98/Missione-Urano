% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
% LAMBERT'S PROBLEM FROM EARTH TO MARS 
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
addpath './Script matlab' 
init_Terra_Marte_Giove_Urano; 
 
%% calcolo Lambert fra posizione iniziale Terra e Marte al momento del flyby 
 
% Dati per posizione e velocità Terra alla partenza della spedizione e al 
% momento della cattura per il primo flyby 
 
%[~, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2022, 10, 01, 18, 00, 00); %date vecchie 
[~, r1_e, v1_e, ~] = planet_elements_and_sv(3, 2027, 05, 01, 18, 00, 00); 
 
%[~, r2_e2, v2_e2, ~] = planet_elements_and_sv(3, 2024, 03, 01, 18, 00, 00); %date vecchie 
[~, r2_m, v2_m, ~] = planet_elements_and_sv(4, 2028, 10, 01, 18, 00, 00); 
% Tempo di volo Terra-Terra 
t_EE = month2seconds(17); 
 
string = 'pro'; %direzione lambert 
 
% Calcolo la traiettoria di Lambert Terra-Terra 
[v1_l_e, v2_l_m] = lambert(r1_e, r2_m, t_EE, string); % '1' = partenza, '2' = arrivo 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza) 
coe_em = coe_from_sv(r1_e, v1_l_e, mu); 
% Anomalia vera alla partenza della missione Terra-Terra 
TA1_em = rad2deg(coe_em(6)); 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo) 
coe_em = coe_from_sv(r2_m, v2_l_m, mu); 
% Anomalia vera alla fine della missione Terra-Terra 
TA2_em = rad2deg(coe_em(6)); 
 
% Variazione angolo di anomalia vera 
d_theta = abs(TA2_em - TA1_em); 
 
% Velocità finale prima della cattura da parte della Terra 
V_final = norm(v2_l_m); 
 
%% Calcolo per risolvere flyby intorno alla Terra 
 
% Recupero dati pianeta attorno a cui faccio il flyby 
v_inf_down_Mars = v2_l_m - v2_m; % velocità in ingresso al flyby    
v_inf_down_norm_Mars = norm(v_inf_down_Mars); % in norma  
 
% Calcolo elementi orbitali del flyby 
 
% Semiasse maggiore 
a_flyby_Mars = - mu_Mars/((v_inf_down_norm_Mars)^2); 
 
% Distanza minima fra traiettoria di flyby e pianeta(km)  
%r_p_flyby_Earth = 30000;  %vecchio 
r_p_flyby_Mars = 6000;   
 
% Eccentricità traiettoria di flyby 
e_flyby_Mars = 1-(r_p_flyby_Mars/a_flyby_Mars);  
     
% Angolo tra gli asintoti  
delta_Mars = 2*asin(1/e_flyby_Mars);   
delta_deg_Mars = rad2deg(delta_Mars); % in gradi  
 
% Uso script per calcolare state vector dopo flyby 
 
StateVector_Mars; 
 
% %% Traiettoria eliocentrica dopo Flyby sulla Terra  
% % Modifico vettore di posizione nel tempo in dipendenza dell'angolo di 
% % Flyby, variando l'anomalia vera. 
%  
% % Elementi orbitali dell'orbita dopo il flyby 
coe_flyby = coe_from_sv(r2_fin_m,v_fin_Mars,mu); 
 
% Anomalia vera in partenza dalla SOI della Terra 
TA_post_flyby = rad2deg(coe_flyby(6)); 
 
% Anomalia vera nel punto di partenza della traiettoria di Lambert fra la 
% Terra e Saturno 
%TA_for_lambert = TA_post_flyby + 90; %vecchio 
TA_for_lambert = TA_post_flyby;  
 
% Calcolo delta T su traiettoria ellissoidale 
a = coe_flyby(7); 
e = coe_flyby(2); 
dT = time_post_flyby(TA_post_flyby, TA_for_lambert, a, e, mu); 
 
% Aggiorno il valore dell'anomalia vera per ottenere i coe prima del dV 
coe_flyby(6) = deg2rad(TA_for_lambert); 
%  
%% Calcolo traiettoria lambert post flyby terra con arrivo su saturno 
 
% Trovo la posizione e velocità di Saturno 

%[~, r2_s, v2_s, ~] = planet_elements_and_sv(6, 2030, 04, 03, 00, 00, 00); %vecchio 
[~, r2_j, v2_j, ~] = planet_elements_and_sv(5, 2032, 07, 01, 00, 00, 00); 
 
% Definisco il tempo di volo dal punto scelto post flyby e Saturno 
t_mj = year2seconds(3) + month2seconds(9); % 'fS' = da punto post flyby a Saturno 6anni-il tempo trascorso sull'orbita eliocentrica 
 
% Estraggo il vettore di stato con i coe aggiornati all'ultima posizione 
[r, v] = sv_from_coe(coe_flyby, mu); 
% Risolvo Lambert per arrivare su Saturno 
[V1_l_m, V2_l_j] = lambert(r2_m, r2_j, t_mj, 'pro'); 
 
% Delta V necessario per portarmi sulla traiettoria di Lambert 
d_V_mj = v_fin_Mars - V1_l_m;    % 'fS' = da punto post flyby a Saturno      
d_V_mj_norm = norm(d_V_mj);    % in norma 
 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza) 
coe_mj = coe_from_sv(r2_m, V1_l_m, mu); 
% Anomalia vera alla partenza della missione r-Saturno 
TA1_mj= rad2deg(coe_mj(6)); 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo) 
coe_mj = coe_from_sv(r2_j, V2_l_j, mu); 
% Anomalia vera alla fine della missione r-Saturno 
TA2_mj = rad2deg(coe_mj(6)); 
%  plot_traiettoria_spacecraft(coe_mj, TA1_mj, TA2_mj, 'g')
%           plot_orbit(4,2023)
%           plot_orbit(5,2030)
 
 
%% Calcolo per risolvere flyby intorno a Saturno 
 
% Recupero dati pianeta attorno al quale faccio il flyby 
v_inf_down_jupiter = V2_l_j - v2_j; % velocità in ingresso al flyby      
v_inf_down_norm_jupiter = norm(v_inf_down_jupiter); % in norma   
 
% Calcolo elementi orbitali del flyby 
 
% Semiasse maggiore 
a_flyby_jupiter = - mu_Jupiter/((v_inf_down_norm_jupiter)^2); 
 
% Distanza minima fra traiettoria di flyby e pianeta(km)  
%r_p_flyby_saturn = 1.8e6; %vecchio 
r_p_flyby_jupiter = 100000; 
 
% Eccentricità traiettoria di flyby 
e_flyby_jupiter = 1-(r_p_flyby_jupiter/a_flyby_jupiter);  
     
% Angolo tra gli asintoti  
delta_jupiter = 2*asin(1/e_flyby_jupiter);  
delta_deg_jupiter = rad2deg(delta_jupiter);   % in gradi  
 
% Uso script per calcolare state vector dopo flyby 
 
StateVector_JUPITER; 




 
%% Calcolo traiettoria di Lambert post Flyby su Saturno  
 
% Trovo la posizione e velocità di Urano 
%[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2036, 04, 03, 00, 00, 00); %vecchio 
[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2038, 07, 01, 00, 00, 00); 
 
% Definisco il tempo di volo Saturno-Urano 
t_JU = year2seconds(6); 
 
% Calcolo la traiettoria di Lambert Terra-Terra 
[V1_l_j, V2_l_u] = lambert(r2_fin_j, r2_u, t_JU, 'pro'); % '1' = partenza, '2' = arrivo 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza) 
coe_ju = coe_from_sv(r2_fin_j, V1_l_j, mu); 
% Anomalia vera alla partenza della missione Terra-Terra 
TA1_ju = rad2deg(coe_ju(6)); 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo) 
coe_ju = coe_from_sv(r2_u, V2_l_u, mu); 
% Anomalia vera alla fine della missione Terra-Terra 
TA2_ju = rad2deg(coe_ju(6)); 
 
% Delta V necessario per portarmi sulla traiettoria di Lambert 
d_V_JU = v_fin_Jupiter - V1_l_j;    % 'fS' = da punto post flyby a Saturno      
d_V_JU_norm = norm(d_V_JU);    % in norma 
