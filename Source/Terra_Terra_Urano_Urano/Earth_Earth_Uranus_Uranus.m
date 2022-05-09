% clear all; 
% clc
addpath './Script matlab'
%...Data declaration:

init_Terra_Terra_Urano_Urano

%% Calcolo per risolvere Lambert Terra-Terra
% [coe_u1, ~, ~, ~] = planet_elements_and_sv(7, 2022, 10, 01, 00, 00, 00);
% 
% [coe_u2, ~, ~, ~] = planet_elements_and_sv(7, 2036, 04, 03, 00, 00, 00);

[~, r1_e1, v1_e1, ~] = planet_elements_and_sv(3, 2022, 10, 01, 18, 00, 00);
[~, r2_e2, v2_e2, ~] = planet_elements_and_sv(3, 2023, 10, 01, 18, 00, 00);
% TOF 
dt_ee = month2seconds(12);
string = 'pro';

[v1_l_e1, v2_l_e2] = lambert(r1_e1, r2_e2, dt_ee, string);

% Orbital elements Lambert's orbit
coe_ee = coe_from_sv(r1_e1, v1_l_e1, mu_Sun);
% True anomaly at the beginning of the mission
TA1_ee = rad2deg(coe_ee(6));

% Estrazione elementi orbitali orbita di trasferimento (using r2_e2 and v2_l_e2):
coe_ee = coe_from_sv(r2_e2, v2_l_e2, mu_Sun);
% True anomaly at the arrival on Earth
TA2_ee = rad2deg(coe_ee(6));

d_theta = abs(TA2_ee - TA1_ee);

%% Calcolo per risolvere flyby e Lambert dopo Flyby sulla Terra
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby.

v_inf_down_Earth = v2_l_e2 - v2_e2;  
v_inf_down_norm_Earth = norm(v_inf_down_Earth); 
% Asintote angle
delta_deg_Earth = 200;
% Hyperbola perigee
r_p_flyby_Earth = 30000 ;  %rp  
% Flyby eccentricity
e_flyby_Earth = 1 / sind(delta_deg_Earth/2); 
% Semimajor axis
a_flyby_Earth = r_p_flyby_Earth / (1-e_flyby_Earth);
% V_inf
v_inf = sqrt(-mu_Earth / a_flyby_Earth);

% Uso scrpit per calcolare state vector dopo flyby

StateVector_Earth;

% Sposto il vettore posizione dello spacecraft lungo la direzione dopo il
% flyby sfruttando l'anomalia vera
% Elementi orbitali dell'orbita dopo il flyby
coe_flyby = coe_from_sv(r2_fin_e, v_fin_Earth, mu_Sun);

% Anomalia vera in partenza dalla SOI della Terra
TA_post_flyby = rad2deg(coe_flyby(6));

% Anomalia vera nel punto di partenza della traiettoria di Lambert fra la
% Terra e Saturno
TA_for_lambert = TA_post_flyby + 90;

% Calcolo delta T su traiettoria ellissoidale
a = coe_flyby(7);
e = coe_flyby(2);
dt_flyby = time_post_flyby(TA_post_flyby, TA_for_lambert, a, e, mu_Sun);

% Aggiorno il valore dell'anomalia vera per ottenere i coe prima del dV
coe_flyby(6) = deg2rad(TA_for_lambert);

%% Punto partenza Lambert post flyby Terra con arrivo su Urano

% Trovo la posizione di Urano
[~, r2_u, ~, ~] = planet_elements_and_sv(7, 2039, 05, 13, 00, 00, 00);

% Definisco il tempo di volo
dt_eu = year2seconds(15);

% Estraggo il vettore di stato con i coe aggiornati all'ultima posizione
[r, v] = sv_from_coe(coe_flyby, mu_Sun);
% Risolvo Lambert per arrivare su Saturno
[V1_l_f, V2_l_u] = lambert(r, r2_u, dt_eu, string);

d_V_1 = v - V1_l_f;
deltaV_Earth_Uranus = norm(d_V_1);


% Estrazione elementi orbitali orbita di trasferimento (using r1 and v1_l):
coe_eu = coe_from_sv(r, V1_l_f, mu_Sun);
% Initial true anomaly:
TA1_eu = rad2deg(coe_eu(6));

% Estrazione elementi orbitali orbita di trasferimento (using r2 and v2):
coe_eu = coe_from_sv(r2_u, V2_l_u, mu_Sun);
% Final true anomaly:
TA2_eu = rad2deg(coe_eu(6));

% Total time of flight
total_tof = dt_ee + dt_flyby + dt_eu;

fprintf('\n Lambert Earth-Uranus after fly-by results \n')
fprintf('\n Initial speed = %g (km/s)\n', norm(v))
fprintf('\n Final speed = %g (Km/s)\n ', norm(V2_l_u))
fprintf('\n Delta V = %g (km/s)\n', deltaV_Earth_Uranus)
fprintf('\n TOF = %g (s)\n', total_tof)
% fprintf('\n Delta True Anomaly = %g (deg)\n', d_theta)
fprintf('\n-----------------------------------------------------\n')

%% Plot della traiettoria (debug)

% if d_theta < 181 && d_theta > 89
% %     Plot trajectory orbit
%     plot_traiettoria_spacecraft(coe_ee, TA1_ee, TA2_ee, 'g')
% end

% Plot planets orbit
plot_orbit(3, 2022);    % Earth
% plot_traiettoria_spacecraft(coe_ee, TA1_ee, TA1_ee+360, 'g')
plot_traiettoria_spacecraft(coe_ee, TA1_ee, TA2_ee, 'r')
plot_orbit(4, 2030);    % Mars
plot_orbit(5, 2030);    % Jupiter
plot_orbit(6,2030);     % Saturn
plot_orbit(7,2036);     % Uranus

% Plot della traiettoria fra SOI Terra e punto partenza di Lambert fra Terra
% e Urano
plot_traiettoria_spacecraft(coe_flyby, TA_post_flyby, TA_post_flyby+360, 'g')

% Plot della traiettoria di Lambert fra Terra e Urano
% plot_traiettoria_spacecraft(coe_eu, TA1_eu, TA1_eu+360 , 'g');
% plot_traiettoria_spacecraft(coe_eu, TA1_eu, TA2_eu, 'r');
