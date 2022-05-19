init_Terra_Marte_Saturno_Urano; 
 
%% calcolo Lambert fra posizione iniziale Terra e Marte al momento del flyby 
 
% Dati per posizione e velocità Terra alla partenza della spedizione e al 
% momento della cattura per il primo flyby 
 
[~, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2022, 09, 01, 18, 00, 00); 
 
[~, r2_m, v2_m, ~] = planet_elements_and_sv(4, 2023, 10, 01, 18, 00, 00); 

% Tempo di volo Terra-Marte 
t_EM = month2seconds(25); 
 
string = 'pro'; %direzione lambert 
 
% Calcolo la traiettoria di Lambert Terra-Marte 
[v1_l_e1, v2_l_m] = lambert(r1_e1, r2_m, t_EM, string); % '1' = partenza, '2' = arrivo 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza) 
coe_em = coe_from_sv(r1_e1, v1_l_e1, mu); 
% Anomalia vera alla partenza della missione Terra-Marte 
TA1_em = rad2deg(coe_em(6)); 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo) 
coe_em = coe_from_sv(r2_m, v2_l_m, mu); 
% Anomalia vera alla fine della missione Terra-Marte 
TA2_em = rad2deg(coe_em(6)); 
 
% Variazione angolo di anomalia vera 
d_theta = abs(TA2_em - TA1_em); 
 
% Velocità finale prima della cattura da parte di Marte 
V_final = norm(v2_l_m); 
 
%% Calcolo per risolvere flyby intorno alla Marte 
 
% Recupero dati pianeta attorno a cui faccio il flyby 
v_inf_down_Mars = v2_l_m - v2_m; % velocità in ingresso al flyby    
v_inf_down_norm_Mars = norm(v_inf_down_Mars); % in norma  
 
% Calcolo elementi orbitali del flyby 
 
% Semiasse maggiore 
a_flyby_Mars = - mu_Mars/((v_inf_down_norm_Mars)^2); 
 
% Distanza minima fra traiettoria di flyby e pianeta(km)  
r_p_flyby_Mars = 36000;   
 
% Eccentricità traiettoria di flyby 
e_flyby_Mars = 1-(r_p_flyby_Mars/a_flyby_Mars);  
     
% Angolo tra gli asintoti  
delta_Mars = 2*asin(1/e_flyby_Mars);   
delta_deg_Mars = rad2deg(delta_Mars); % in gradi  
 
% Uso script per calcolare state vector dopo flyby 
 
StateVector_Mars; 
 
%% Traiettoria eliocentrica dopo Flyby su Marte  
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di 
% Flyby, variando l'anomalia vera. 
 
% Elementi orbitali dell'orbita dopo il flyby 
coe_flyby = coe_from_sv(r2_fin_m,v_fin_Mars,mu); 
 
% Anomalia vera in partenza dalla SOI della Marte 
TA_post_flyby = rad2deg(coe_flyby(6)); 
 
% Anomalia vera nel punto di partenza della traiettoria di Lambert fra la 
% Marte e Saturno 
TA_for_lambert = TA_post_flyby + 0;  
 
% Calcolo delta T su traiettoria ellissoidale 
a = coe_flyby(7); 
e = coe_flyby(2); 
dT_post_flyby = time_post_flyby(TA_post_flyby, TA_for_lambert, a, e, mu); 

% Aggiorno il valore dell'anomalia vera per ottenere i coe prima del dV 
coe_flyby(6) = deg2rad(TA_for_lambert); 
 
%% Calcolo traiettoria lambert post flyby su Marte con arrivo su Saturno 
 
% Trovo la posizione e velocità di Saturno 
[~, r2_s, v2_s, ~] = planet_elements_and_sv(6, 2028, 10, 01, 00, 00, 00); 
 
% Definisco il tempo di volo dal punto scelto post flyby e Saturno 
t_fS = year2seconds(5); % 'fS' = da punto post flyby a Saturno 6anni-il tempo trascorso sull'orbita eliocentrica 
 
% Estraggo il vettore di stato con i coe aggiornati all'ultima posizione 
[r, v] = sv_from_coe(coe_flyby, mu); 
% Risolvo Lambert per arrivare su Saturno 
[V1_l_f, V2_l_s] = lambert(r, r2_s, t_fS, 'pro'); 
 
% Delta V necessario per portarmi sulla traiettoria di Lambert 
d_V_fS = v - V1_l_f;    % 'fS' = da punto post flyby a Saturno      
d_V_fS_norm = norm(d_V_fS);    % in norma 
  
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza) 
coe_ms = coe_from_sv(r, V1_l_f, mu); 
% Anomalia vera alla partenza della missione r-Saturno 
TA1_ms = rad2deg(coe_ms(6)); 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo) 
coe_ms = coe_from_sv(r2_s, V2_l_s, mu); 
% Anomalia vera alla fine della missione r-Saturno 
TA2_ms = rad2deg(coe_ms(6)); 
 
%% Calcolo per risolvere flyby intorno a Saturno 
 
% Recupero dati pianeta attorno al quale faccio il flyby 
v_inf_down_saturn = V2_l_s - v2_s; % velocità in ingresso al flyby      
v_inf_down_norm_saturn = norm(v_inf_down_saturn); % in norma   
 
% Calcolo elementi orbitali del flyby 
 
% Semiasse maggiore 
a_flyby_saturn = - mu_Saturn/((v_inf_down_norm_saturn)^2); 
 
% Distanza minima fra traiettoria di flyby e pianeta(km)  
r_p_flyby_saturn = 500000; 
 
% Eccentricità traiettoria di flyby 
e_flyby_saturn = 1-(r_p_flyby_saturn/a_flyby_saturn);  
     
% Angolo tra gli asintoti  
delta_saturn = 2*asin(1/e_flyby_saturn);  
delta_deg_saturn = rad2deg(delta_saturn);   % in gradi  
 
% Uso script per calcolare state vector dopo flyby 
 
StateVector_Saturn; 
 
%% Calcolo traiettoria di Lambert post Flyby su Saturno  
 
% Trovo la posizione e velocità di Urano 
[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2034, 10, 01, 00, 00, 00); 
 
% Definisco il tempo di volo Saturno-Urano 
t_SU = year2seconds(6); 
 
% Calcolo la traiettoria di Lambert Saturno-Urano
[V1_l_s, V2_l_u] = lambert(r2_fin_s, r2_u, t_SU, 'pro'); % '1' = partenza, '2' = arrivo 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza) 
coe_su = coe_from_sv(r2_fin_s, V1_l_s, mu); 
% Anomalia vera alla partenza della missione Saturno-Urano
TA1_su = rad2deg(coe_su(6)); 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo) 
coe_su = coe_from_sv(r2_u, V2_l_u, mu); 
% Anomalia vera alla fine della missione Saturno-Urano
TA2_su = rad2deg(coe_su(6)); 
 
% Delta V necessario per portarmi sulla traiettoria di Lambert 
d_V_SU = v_fin_saturn - V1_l_s;    % 'fS' = da punto post flyby a Saturno      
d_V_SU_norm = norm(d_V_SU);    % in norma 
