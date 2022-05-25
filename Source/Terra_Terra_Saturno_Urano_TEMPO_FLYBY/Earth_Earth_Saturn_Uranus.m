%% Calcolo Lambert fra posizione iniziale Terra e posizione finale terra al momento del flyby

% Dati per posizione e velocità Terra alla partenza della spedizione e al
% momento della cattura per il primo flyby

%[~, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2022, 10, 01, 18, 00, 00); %date vecchie
[~, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2023, 03, 01, 18, 00, 00);

%[~, r2_e2, v2_e2, ~] = planet_elements_and_sv(3, 2024, 03, 01, 18, 00, 00); %date vecchie
[coe_e, r2_e2, v2_e2, ~] = planet_elements_and_sv(3, 2024, 08, 01, 18, 00, 00);

% Tempo di volo Terra-Terra
t_EE_days = datenum([2024 08 01 18 00 00]) - datenum([2023 3 01 18 00 00]);
t_EE = t_EE_days * 24 * 60 * 60; 

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

flyby_Earth_time;

% Uso script per calcolare state vector dopo flyby

StateVector_Earth;

%% Calcolo traiettoria lambert post flyby terra con arrivo su saturno

% Trovo la posizione e velocità di Saturno
%[~, r2_s, v2_s, ~] = planet_elements_and_sv(6, 2030, 04, 03, 00, 00, 00); %vecchio
[coe_s, r2_s, v2_s, ~] = planet_elements_and_sv(6, 2030, 08, 01, 18, 00, 00);

% Definisco il tempo di volo dal punto scelto post flyby e Saturno
%t_fS = year2seconds(6); % 'fS' = da punto post flyby a Saturno 6anni-il tempo trascorso sull'orbita eliocentrica
t_fS_days = datenum([2030 08 01 18 00 00]) - datenum([DateVector_Earth(1),...
    DateVector_Earth(2), DateVector_Earth(3), DateVector_Earth(4),...
    DateVector_Earth(5), DateVector_Earth(6)]);
t_fS = t_fS_days * 24 * 60 * 60; 

% Estraggo il vettore di stato con i coe aggiornati all'ultima posizione
%[r, v] = sv_from_coe(coe_flyby, mu);
% Risolvo Lambert per arrivare su Saturno
[V1_l_f, V2_l_s] = lambert(r2_fin_e, r2_s, t_fS, 'pro');

% Delta V necessario per portarmi sulla traiettoria di Lambert
d_V_fS = v_fin_Earth - V1_l_f;    % 'fS' = da punto post flyby a Saturno     
d_V_fS_norm = norm(d_V_fS);    % in norma

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza)
coe_es = coe_from_sv(r2_fin_e, V1_l_f, mu);
% Anomalia vera alla partenza della missione r-Saturno
TA1_es = rad2deg(coe_es(6));

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo)
coe_es = coe_from_sv(r2_s, V2_l_s, mu);
% Anomalia vera alla fine della missione r-Saturno
TA2_es = rad2deg(coe_es(6));


%% Calcolo per risolvere flyby intorno a Saturno

flyby_Saturn_time;

% Uso script per calcolare state vector dopo flyby

StateVector_Saturn;

%% Calcolo traiettoria di Lambert post Flyby su Saturno e arrivo su Urano

% Trovo la posizione e velocità di Urano
%[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2036, 04, 03, 00, 00, 00); %vecchio
[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2036, 08, 01, 18, 00, 00);

% Definisco il tempo di volo Saturno-Urano
%t_SU = year2seconds(6);
t_SU_days = datenum([2036 08 01 18 00 00])- datenum([DateVector_Saturn(1),...
    DateVector_Saturn(2), DateVector_Saturn(3), DateVector_Saturn(4),...
    DateVector_Saturn(5), DateVector_Saturn(6)]);
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
d_V_SU = v_fin_Saturn - V1_l_s; 
d_V_SU_norm = norm(d_V_SU);    % in norma
