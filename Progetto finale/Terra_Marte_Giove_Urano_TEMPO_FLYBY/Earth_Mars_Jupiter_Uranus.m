%% calcolo Lambert fra posizione iniziale Terra e Marte al momento del flyby 
 
% Dati per posizione e velocità Terra alla partenza della spedizione e al 
% momento della cattura per il primo flyby 
 
[~, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2027, 05, 01, 18, 00, 00); 
 
[coe_m, r2_m, v2_m, ~] = planet_elements_and_sv(4, 2028, 10, 01, 18, 00, 00); 

% Tempo di volo Terra-Marte 
t_E = datetime(2027, 5, 1, 18, 0, 0);
t_MJ = datetime(2028, 10, 1, 18, 0, 0);
t_EM_days = days(t_MJ - t_E);
t_EM = t_EM_days * 24 * 60 * 60; 
 
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
 
%% Calcolo per risolvere flyby intorno a Marte
 
flyby_Mars_time;

% Uso script per calcolare state vector dopo flyby 
 
StateVector_Mars; 
 
%% Calcolo traiettoria lambert post flyby Marte con arrivo su Giove 
 
% Trovo la posizione e velocità di Giove 

[coe_j, r2_j, v2_j, ~] = planet_elements_and_sv(5, 2032, 07, 01, 00, 00, 00); 
 
% Definisco il tempo di volo dal punto scelto post flyby e Giove 
t_MJ_days = datenum([2032 07 01]) - datenum([DateVector_Mars(1),...
    DateVector_Mars(2), DateVector_Mars(3)]);
t_MJ = t_MJ_days * 24 * 60 * 60; 
 
% Risolvo Lambert per arrivare su Giove 
[v1_l_m, v2_l_j] = lambert(r2_fin_m, r2_j, t_MJ, 'pro'); 
 
% Delta V necessario per portarmi sulla traiettoria di Lambert 
d_V_MJ = v_fin_Mars - v1_l_m;    % 'MJ' = da punto post flyby a Giove      
d_V_MJ_norm = norm(d_V_MJ);    % in norma 
  
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza) 
coe_mj = coe_from_sv(r2_fin_m, v1_l_m, mu); 
% Anomalia vera alla partenza della missione r-Giove 
TA1_mj= rad2deg(coe_mj(6)); 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo) 
coe_mj = coe_from_sv(r2_j, v2_l_j, mu); 
% Anomalia vera alla fine della missione r-Giove 
TA2_mj = rad2deg(coe_mj(6)); 
  
%% Calcolo per risolvere flyby intorno a Giove 

flyby_Jupiter_time;

% Uso script per calcolare state vector dopo flyby 
 
StateVector_JUPITER; 
 
%% Calcolo traiettoria di Lambert post Flyby su Giove  
 
% Trovo la posizione e velocità di Urano 
[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2038, 07, 01, 00, 00, 00); 
 
% Definisco il tempo di volo Giove-Urano
t_JU_days = datenum([2038 07 01])- datenum([DateVector_Jupiter(1),...
    DateVector_Jupiter(2), DateVector_Jupiter(3)]);
t_JU = t_JU_days * 24 * 60 * 60;
 
% Calcolo la traiettoria di Lambert Terra-Terra 
[v1_l_j, v2_l_u] = lambert(r2_fin_j, r2_u, t_JU, 'pro'); % '1' = partenza, '2' = arrivo 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza) 
coe_ju = coe_from_sv(r2_fin_j, v1_l_j, mu); 
% Anomalia vera alla partenza della missione Terra-Terra 
TA1_ju = rad2deg(coe_ju(6)); 
 
% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo) 
coe_ju = coe_from_sv(r2_u, v2_l_u, mu); 
% Anomalia vera alla fine della missione Terra-Terra 
TA2_ju = rad2deg(coe_ju(6)); 
 
% Delta V necessario per portarmi sulla traiettoria di Lambert 
d_V_JU = v_fin_Jupiter - v1_l_j;    % 'fS' = da punto post flyby a Giove      
d_V_JU_norm = norm(d_V_JU);    % in norma 
