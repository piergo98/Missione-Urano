init_Terra_Venere_Saturno_Urano;

%% calcolo Lambert fra posizione iniziale Terra e posizione finale Venere

% Dati per posizione e velocità Terra alla partenza della spedizione e al
% momento della cattura su Giove

[~, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2022, 01, 01, 12, 00, 00);

[~, r2_v, v2_v, ~] = planet_elements_and_sv(2, 2022, 04, 01, 12, 00, 00);

% Tempo di volo Terra-Venere
t_EV = month2seconds(3);

string = 'pro'; %direzione lambert

% Calcolo la traiettoria di Lambert Terra-Venere
[v1_l_e1, v2_l_v] = lambert(r1_e1, r2_v, t_EV, string); % '1' = partenza, '2' = arrivo

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza)
coe_ev = coe_from_sv(r1_e1, v1_l_e1, mu_Sun);
% Anomalia vera alla partenza della missione Terra-Venere
TA1_ev = rad2deg(coe_ev(6));

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo)
coe_ev = coe_from_sv(r2_v, v2_l_v, mu_Sun);
% Anomalia vera alla fine della missione Terra-Venere
TA2_ev = rad2deg(coe_ev(6));

color = 'r';
plot_traiettoria_spacecraft(coe_ev, TA1_ev, TA2_ev+360,color);
plot_orbit(2,2022);
plot_orbit(3,2022);

% Variazione angolo di anomalia vera
d_theta = abs(TA2_ev - TA1_ev);

% Velocità finale prima della cattura da parte di Venere
V_final = norm(v2_l_v);

%% Calcolo per risolvere flyby intorno a Venere

% Recupero dati pianeta attorno a cui faccio il flyby
v_inf_down_Venus = v2_l_v - v2_v; % velocità in ingresso al flyby   
v_inf_down_norm_Venus = norm(v_inf_down_Venus); % in norma 

% Calcolo elementi orbitali del flyby

% Semiasse maggiore
a_flyby_Venus = - mu_Venus / ((v_inf_down_norm_Venus)^2);

% Distanza minima fra traiettoria di flyby e pianeta(km) 
r_p_flyby_Venus = r_Venus + 8000;   

% Eccentricità traiettoria di flyby
e_flyby_Venus = 1-(r_p_flyby_Venus/a_flyby_Venus); 
    
% Angolo tra gli asintoti 
delta_Venus = 2*asin(1/e_flyby_Venus);
delta_deg_Venus = rad2deg(delta_Venus); % in gradi 

% Uso script per calcolare state vector dopo flyby

StateVector_Venus;

%% Calcolo traiettoria di Lambert post Flyby su Venere 

% Trovo la posizione e velocità della Saturno
[~, r2_s, v2_s, ~] = planet_elements_and_sv(6, 2028, 04, 01, 12, 00, 00);

% Definisco il tempo di volo Giove Saturno
t_Venus = datetime(2022, 04, 01, 12, 00, 00);
t_Saturn = datetime(2028, 04, 01, 12, 00, 00);
  
time_diff = days(t_Saturn - t_Venus);
t_VS = time_diff*24*3600;

% Calcolo la traiettoria di Lambert Venere-Saturno
[V1_l_v, V2_l_s] = lambert(r2_fin_v, r2_s, t_VS, 'pro'); % '1' = partenza, '2' = arrivo

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza)
coe_vs = coe_from_sv(r2_fin_v, V1_l_v, mu_Sun);
% Anomalia vera alla partenza della missione Venere-Saturno
TA1_vs = rad2deg(coe_vs(6));

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo)
coe_vs = coe_from_sv(r2_s, V2_l_s, mu);
% Anomalia vera alla fine della missione Venere-Saturno
TA2_vs = rad2deg(coe_vs(6));

% Delta V necessario per portarmi sulla traiettoria di Lambert
d_V_VS = v_fin_Venus - V1_l_v;    
d_V_VS_norm = norm(d_V_VS);    % in norma

plot_traiettoria_spacecraft(coe_vs, TA1_vs, TA2_vs,color);
plot_orbit(6,2022);

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
[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2033, 12, 25, 12, 00, 00);

% Definisco il tempo di volo Saturno-Urano
t_Saturn = datetime(2028, 04, 01, 12, 00, 00);
t_Uranus = datetime(2033, 12, 25, 12, 00, 00);

time_diff = days(t_Uranus - t_Saturn);
t_SU = time_diff*24*3600;

% Calcolo la traiettoria di Lambert Terra-Terra
[V1_l_s, V2_l_u] = lambert(r2_fin_s, r2_u, t_SU, 'pro'); % '1' = partenza, '2' = arrivo

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(partenza)
coe_su = coe_from_sv(r2_fin_s, V1_l_s, mu_Sun);
% Anomalia vera alla partenza della missione Terra-Terra
TA1_su = rad2deg(coe_su(6));

% Estrazione elementi orbitali dall'orbita ottenuta con Lambert(arrivo)
coe_su = coe_from_sv(r2_u, V2_l_u, mu_Sun);
% Anomalia vera alla fine della missione Terra-Terra
TA2_su = rad2deg(coe_su(6));

% Delta V necessario per portarmi sulla traiettoria di Lambert
d_V_SU = v_fin_saturn - V1_l_s;    % 'fS' = da punto post flyby a Saturno     
d_V_SU_norm = norm(d_V_SU);    % in norma

plot_traiettoria_spacecraft(coe_su, TA1_su, TA2_su,color);
plot_orbit(7,2022);