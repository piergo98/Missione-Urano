%% Calcolo Lambert fra posizione iniziale Terra e posizione finale Venere

% Dati per posizione e velocità Terra alla partenza della spedizione e al
% momento della cattura su Venere

[~, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2022, 01, 01, 12, 00, 00);

[~, r2_v, v2_v, ~] = planet_elements_and_sv(2, 2022, 04, 01, 12, 00, 00);

% Tempo di volo Terra-Venere
t_EV_days = datenum([2022 04 01 12 00 00]) - datenum([2022 01 01 12 00 00]);
t_EV = t_EV_days * 24 * 60 * 60; 

string = 'pro'; %direzione lambert

% Calcolo la traiettoria di Lambert Terra-Venere
[v1_l_e1, v2_l_v] = lambert(r1_e1, r2_v, t_EV, string); % '1' = partenza, '2' = arrivo

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza)
coe_ev = coe_from_sv(r1_e1, v1_l_e1, mu);
% Anomalia vera alla partenza della missione Terra-Venere
TA1_ev = rad2deg(coe_ev(6));

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo)
coe_ev = coe_from_sv(r2_v, v2_l_v, mu);
% Anomalia vera alla fine della missione Terra-Venere
TA2_ev = rad2deg(coe_ev(6));

% Variazione angolo di anomalia vera
d_theta = abs(TA2_ev - TA1_ev);

% Velocità finale prima della cattura da parte di Venere
V_final = norm(v2_l_v);

%% Calcolo per risolvere flyby intorno a Venere

flyby_Venus_time;

% Uso script per calcolare state vector dopo flyby

StateVector_Venus;

%% Calcolo traiettoria di Lambert post Flyby su Venere 

% Trovo la posizione e velocità della Saturno
[~, r2_s, v2_s, ~] = planet_elements_and_sv(6, 2028, 01, 01, 12, 00, 00);

% Definisco il tempo di volo Venere-Saturno
t_VS_days = datenum([2028 01 01]) - datenum([DateVector_Venus(1),...
    DateVector_Venus(2), DateVector_Venus(3)]);
t_VS = t_VS_days * 24 * 60 * 60; 

% Calcolo la traiettoria di Lambert Venere-Saturno
[V1_l_v, V2_l_s] = lambert(r2_fin_v, r2_s, t_VS, 'pro'); % '1' = partenza, '2' = arrivo

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza)
coe_vs = coe_from_sv(r2_fin_v, V1_l_v, mu);
% Anomalia vera alla partenza della missione Venere-Saturno
TA1_vs = rad2deg(coe_vs(6));

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo)
coe_vs = coe_from_sv(r2_s, V2_l_s, mu);
% Anomalia vera alla fine della missione Venere-Saturno
TA2_vs = rad2deg(coe_vs(6));

% Delta V necessario per portarmi sulla traiettoria di Lambert
d_V_VS = v_fin_Venus - V1_l_v;    
d_V_VS_norm = norm(d_V_VS);    % in norma

%% Calcolo per risolvere flyby intorno a Saturno

flyby_Saturn_time; 

% Uso script per calcolare state vector dopo flyby

StateVector_Saturn;

%% Calcolo traiettoria di Lambert post Flyby su Saturno 

% Trovo la posizione e velocità di Urano
[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2033, 12, 25, 12, 00, 00);

% Definisco il tempo di volo Saturno-Urano
t_SU_days = datenum([2033 12 25])- datenum([DateVector_Saturn(1),...
    DateVector_Saturn(2), DateVector_Saturn(3)]);
t_SU = t_SU_days * 24 * 60 * 60;

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
d_V_SU = v_fin_Saturn - V1_l_s;    % 'fS' = da punto post flyby a Saturno     
d_V_SU_norm = norm(d_V_SU);    % in norma
