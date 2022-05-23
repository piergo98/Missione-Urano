% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LAMBERT'S PROBLEM FROM EARTH TO JUPITER
% ~~~~~~~~~~~~

% init_Terra_Giove_Saturno_Urano;

%% calcolo Lambert fra posizione iniziale Terra e posizione finale Giove

% Dati per posizione e velocità Terra alla partenza della spedizione e al
% momento della cattura su Giove

[~, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2022, 07, 01, 12, 00, 00);

[~, r2_j, v2_j, ~] = planet_elements_and_sv(5, 2024, 07, 01, 12, 00, 00);

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

% Recupero dati pianeta attorno a cui faccio il flyby
v_inf_down_Jupiter = v2_l_j - v2_j; % velocità in ingresso al flyby   
v_inf_down_norm_Jupiter = norm(v_inf_down_Jupiter); % in norma 

% Calcolo elementi orbitali del flyby

% Semiasse maggiore
a_flyby_Jupiter = - mu_Jupiter / ((v_inf_down_norm_Jupiter)^2);

% Distanza minima fra traiettoria di flyby e pianeta(km) 
r_p_flyby_Jupiter = 5e6;   

% Eccentricità traiettoria di flyby
e_flyby_Jupiter = 1-(r_p_flyby_Jupiter/a_flyby_Jupiter); 
    
% Angolo tra gli asintoti 
delta_Jupiter = 2*asin(1/e_flyby_Jupiter);
delta_deg_Jupiter = rad2deg(delta_Jupiter); % in gradi 

% Uso script per calcolare state vector dopo flyby

StateVector_Jupiter;

%% Calcolo traiettoria di Lambert post Flyby su Giove 

% Trovo la posizione e velocità di Saturno
[~, r2_s, v2_s, ~] = planet_elements_and_sv(6, 2030, 9, 1, 12, 00, 00);

% Definisco il tempo di volo Giove Saturno
t_Jupiter = datetime(2024, 07, 01, 08, 14, 54);
t_Saturn = datetime(2030, 09, 01, 12, 00, 00);
  
t_JS_days = days(t_Saturn - t_Jupiter);
t_JS = t_JS_days*24*3600;

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

% Recupero dati pianeta attorno al quale faccio il flyby
v_inf_down_saturn = V2_l_s - v2_s; % velocità in ingresso al flyby     
v_inf_down_norm_saturn = norm(v_inf_down_saturn); % in norma  

% Calcolo elementi orbitali del flyby

% Semiasse maggiore
a_flyby_saturn = - mu_Saturn/((v_inf_down_norm_saturn)^2);

% Distanza minima fra traiettoria di flyby e pianeta(km) 
r_p_flyby_saturn = 2e6;

% Eccentricità traiettoria di flyby
e_flyby_saturn = 1-(r_p_flyby_saturn/a_flyby_saturn); 
    
% Angolo tra gli asintoti 
delta_saturn = 2*asin(1/e_flyby_saturn); 
delta_deg_saturn = rad2deg(delta_saturn);   % in gradi 

% Uso script per calcolare state vector dopo flyby

StateVector_Saturn;

%% Calcolo traiettoria di Lambert post Flyby su Saturno 

% Trovo la posizione e velocità di Urano
[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2035, 12, 25, 12, 00, 00);

% Definisco il tempo di volo Saturno-Urano
t_Saturn = datetime(2030, 9, 1, 15, 45, 41);
t_Uranus = datetime(2035, 12, 25, 12, 00, 00);

t_SU_days = days(t_Uranus - t_Saturn);
t_SU = t_SU_days*24*3600;

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
d_V_SU = v_fin_saturn - V1_l_s;    % 'fS' = da punto post flyby a Saturno     
d_V_SU_norm = norm(d_V_SU);    % in norma
