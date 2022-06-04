%% Calcolo Lambert fra posizione iniziale Terra e Marte al momento del flyby 
 
% Dati per posizione e velocità Terra alla partenza della spedizione e al 
% momento della cattura per il primo flyby 
 
[~, r1_e, v1_e, ~] = planet_elements_and_sv(3, 2022, 09, 01, 18, 00, 00); 
 
[coe_m, r2_m, v2_m, ~] = planet_elements_and_sv(4, 2023, 10, 01, 18, 00, 00);

% Tempo di volo Terra-Marte
t_E = datetime(2022, 9, 1, 18, 0, 0);
t_M = datetime(2023, 10, 1, 18, 0, 0);
t_EM_days = days(t_M - t_E);
t_EM = t_EM_days * 24 * 60 * 60; 
 
string = 'pro'; %direzione lambert 
 
% Calcolo la traiettoria di Lambert Terra-Terra 
[v1_l_e, v2_l_m] = lambert(r1_e, r2_m, t_EM, string); % '1' = partenza, '2' = arrivo 
 
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
 
flyby_Mars_time;
 
% Uso script per calcolare state vector dopo flyby 
 
StateVector_Mars; 
 
%% Calcolo traiettoria lambert post flyby Marte con arrivo su Saturno 
 
% Trovo la posizione e velocità di Saturno 
[coe_s, r2_s, v2_s, ~] = planet_elements_and_sv(6, 2028, 11, 01, 00, 00, 00); 
 
% Definisco il tempo di volo dal punto scelto post flyby e Saturno 
t_MS_days = datenum([2028 11 01]) - datenum([DateVector_Mars(1),...
    DateVector_Mars(2), DateVector_Mars(3)]);
t_MS = t_MS_days * 24 * 60 * 60; 
 
% Risolvo Lambert per arrivare su Saturno 
[V1_l_m, V2_l_s] = lambert(r2_fin_m, r2_s, t_MS, 'pro');
 
% Delta V necessario per portarmi sulla traiettoria di Lambert 
d_V_MS = v_fin_Mars - V1_l_m;    % 'MS' = da punto post flyby a Saturno      
d_V_MS_norm = norm(d_V_MS);    % in norma 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza) 
coe_ms = coe_from_sv(r2_fin_m, V1_l_m, mu); 
% Anomalia vera alla partenza della missione r-Saturno 
TA1_ms = rad2deg(coe_ms(6)); 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo) 
coe_ms = coe_from_sv(r2_s, V2_l_s, mu); 
% Anomalia vera alla fine della missione r-Saturno 
TA2_ms = rad2deg(coe_ms(6)); 
 
%% Calcolo per risolvere flyby intorno a Saturno 
 
flyby_Saturn_time;
 
% Uso script per calcolare state vector dopo flyby 
 
StateVector_Saturn; 
 
%% Calcolo traiettoria di Lambert post Flyby su Saturno  
 
% Trovo la posizione e velocità di Urano 
[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2034, 11, 01, 00, 00, 00); 
 
% Definisco il tempo di volo Saturno-Urano 
t_SU_days = datenum([2034 11 01])- datenum([DateVector_Saturn(1),...
    DateVector_Saturn(2), DateVector_Saturn(3)]);
t_SU = t_SU_days * 24 * 60 * 60;

% Calcolo la traiettoria di Lambert Terra-Terra 
[V1_l_s, V2_l_u] = lambert(r2_fin_s, r2_u, t_SU, 'pro'); % '1' = partenza, '2' = arrivo 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza) 
coe_su = coe_from_sv(r2_fin_s, V1_l_s, mu); 
% Anomalia vera alla partenza della missione Terra-Terra 
TA1_su = rad2deg(coe_su(6)); 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo) 
coe_su = coe_from_sv(r2_u, V2_l_u, mu); 
% Anomalia vera alla fine della missione Terra-Terra 
TA2_su = rad2deg(coe_su(6)); 
 
% Delta V necessario per portarmi sulla traiettoria di Lambert 
d_V_SU = v_fin_Saturn - V1_l_s;    % 'MS' = da punto post flyby a Saturno      
d_V_SU_norm = norm(d_V_SU);    % in norma 
