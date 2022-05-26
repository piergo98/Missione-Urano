%% calcolo Lambert fra posizione iniziale Terra e posizione finale Giove

% Dati per posizione e velocità Terra alla partenza della spedizione e al
% momento della cattura su Giove

[~, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2022, 07, 01, 12, 00, 00);

[coe_j, r2_j, v2_j, ~] = planet_elements_and_sv(5, 2024, 07, 01, 12, 00, 00);

% Tempo di volo Terra-Giove
t_Earth = datetime(2022,07,01,12,00,00);
t_Jupiter = datetime(2024,07,01,12,00,00);

t_EJ_days = days(t_Jupiter - t_Earth);
t_EJ = t_EJ_days*24*3600;

string = 'pro'; %direzione lambert

% Calcolo la traiettoria di Lambert Terra-Giove
[v1_l_e1, v2_l_j] = lambert(r1_e1, r2_j, t_EJ, string); % '1' = partenza, '2' = arrivo

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza)
coe_ej = coe_from_sv(r1_e1, v1_l_e1, mu);
% Anomalia vera alla partenza della missione Terra-Giove
TA1_ej = rad2deg(coe_ej(6));

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo)
coe_ej = coe_from_sv(r2_j, v2_l_j, mu);
% Anomalia vera alla fine della missione Terra-Terra
TA2_ej = rad2deg(coe_ej(6));

% Variazione angolo di anomalia vera
d_theta = abs(TA2_ej - TA1_ej);

% Velocità finale prima della cattura da parte di Giove
V_final = norm(v2_l_j);

%% Calcolo per risolvere flyby intorno a Giove

flyby_Jupiter_time;

% Uso script per calcolare state vector dopo flyby

StateVector_Jupiter;

%% Calcolo traiettoria di Lambert post Flyby su Giove 

% Trovo la posizione e velocità di Saturno
[coe_s, r2_s, v2_s, ~] = planet_elements_and_sv(6, 2030, 9, 1, 12, 00, 00);

% Definisco il tempo di volo Giove Saturno
t_JS_days = datenum([2030 09 01]) - datenum([DateVector_Jupiter(1),...
    DateVector_Jupiter(2), DateVector_Jupiter(3)]);
t_JS = t_JS_days * 24 * 60 * 60; 

% Calcolo la traiettoria di Lambert Giove-Saturno
[V1_l_j, V2_l_s] = lambert(r2_fin_j, r2_s, t_JS, 'pro'); % '1' = partenza, '2' = arrivo

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza)
coe_js = coe_from_sv(r2_fin_j, V1_l_j, mu);
% Anomalia vera alla partenza della missione Terra-Terra
TA1_js = rad2deg(coe_js(6));

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo)
coe_js = coe_from_sv(r2_s, V2_l_s, mu);
% Anomalia vera alla fine della missione Terra-Terra
TA2_js = rad2deg(coe_js(6));

% Delta V necessario per portarmi sulla traiettoria di Lambert
d_V_JS = v_fin_Jupiter - V1_l_j;    
d_V_JS_norm = norm(d_V_JS);    % in norma

%% Calcolo per risolvere flyby intorno a Saturno

flyby_Saturn_time;

% Uso script per calcolare state vector dopo flyby

StateVector_Saturn;

%% Calcolo traiettoria di Lambert post Flyby su Saturno 

% Trovo la posizione e velocità di Urano
[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2035, 12, 25, 12, 00, 00);

% Definisco il tempo di volo Saturno-Urano
t_SU_days = datenum([2035 12 25])- datenum([DateVector_Saturn(1),...
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
d_V_SU = v_fin_Saturn - V1_l_s;    % 'fS' = da punto post flyby a Saturno     
d_V_SU_norm = norm(d_V_SU);    % in norma
