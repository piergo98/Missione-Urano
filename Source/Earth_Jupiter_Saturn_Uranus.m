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

%}
% ---------------------------------------------


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LAMBERT'S PROBLEM FROM EARTH TO JUPITER
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

addpath './Script matlab'
global mu
deg = pi/180;
color = 'g';

% Colore della traiettoria dello spacecraft
% color = 'g';

%...Data declaration:

mu = 1.327*10^11;                   % mu sun (km^3/s^2)


% Position of Earth at the departure (km) 2022/07/01_12:00:00
[~, r1_e, v1_e, ~] = planet_elements_and_sv(3, 2022, 07, 01, 12, 00, 00);

% Position of Jupiter at the arrival  (km) 2024/07/21_12:00:00    
[~, r2_j, v2_j, ~] = planet_elements_and_sv(5, 2024, 07, 01, 12, 00, 00);
r_giove = r2_j;
string = 'pro';

%definisco il tempo di volo
t_Earth = datetime(2022,07,01,12,00,00);
t_Jupiter = datetime(2024,07,21,12,00,00);

time_diff =days(t_Jupiter - t_Earth);
t = time_diff*24*3600;

%...Algorithm 5.2:
[v1_l_e, v2_l_j] = lambert(r1_e, r2_j, t, string);

%...Algorithm 4.1 (using r1 and v1):
coe_ej = coe_from_sv(r1_e, v1_l_e, mu);
%...Save the initial true anomaly:
TA_init_e = rad2deg(coe_ej(6));

%...Algorithm 4.1 (using r2 and v2):
coe_ej = coe_from_sv(r2_j, v2_l_j, mu);
%...Save the final true anomaly:
TA_final_j = rad2deg(coe_ej(6));


% d_theta = abs(TA2_ej - TA1_ej);
% V_final = norm(v2_l_e2);

% Plot of planets orbit and trajectory orbit
plot_orbit(3, 2022)
plot_orbit(4, 2023)
plot_orbit(5, 2024)

plot_traiettoria_spacecraft(coe_ej, TA_init_e, TA_final_j, color)

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%% Calcolo per risolvere Lambert dopo Flyby su un pianeta
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby.

% Recupero dati pianeta attorno a cui faccio il flyby
SOI_JUPITER;

mu_Jupiter = 1.26686534e8; %[km^3/s^2] 

%velocità in uscita da Jupiter
v_inf_down_Jupiter = v2_l_j - v2_j;  
v_inf_down_norm_Jupiter = norm(v_inf_down_Jupiter); 

%semiaxis major
a_flyby_Jupiter = - mu_Jupiter / ((v_inf_down_norm_Jupiter)^2);   

%hp
r_p_flyby_Jupiter = 105000 ;    

%eccentricity
e_flyby_Jupiter = 1-(r_p_flyby_Jupiter/a_flyby_Jupiter); 
    
%angolo tra gli asintoti 
delta_Jupiter = 2*asin(1/e_flyby_Jupiter);  
delta_deg_Jupiter = rad2deg(delta_Jupiter); 

% Uso scrpit per calcolare state vector dopo flyby

StateVector_JUPITER;

% Sposto il vettore posizione dello spacecraft lungo la direzione dopo il
% flyby sfruttando l'anomalia vera
% Elementi orbitali dell'orbita dopo il flyby
coe_flyby = coe_from_sv(r2_fin_j,v_fin_Jupiter,mu);

% Anomalia vera in partenza dalla SOI di Giove
TA_post_flyby = rad2deg(coe_flyby(6));

% Anomalia vera nel punto di partenza della traiettoria di Lambert fra la
% Giove e Saturno
%calcolata con LambertFromJupiter_flyby2Sat
TA_for_lambert = TA_post_flyby + 10;

% Aggiorno il valore dell'anomalia vera per ottenere i coe prima del dV
coe_flyby(6) = deg2rad(TA_for_lambert);

%plotto la traiettoria fra SOI Giove e punto partenza di Lambert fra Giove
%e Saturno
plot_traiettoria_spacecraft(coe_flyby, TA_post_flyby, TA_for_lambert, 'g')


%% Punto partenza lambert post flyby giove con arrivo su saturno
% Trovo la posizione di Saturno
[~, r2_s, v2_s, ~] = planet_elements_and_sv(6, 2031, 04, 01, 12, 00, 00);

% Definisco il tempo di volo
t_Jupiter = datetime(2024, 07, 24, 08, 14, 54);
t_Saturn = datetime(2031, 04, 01, 12, 00, 00);
  
time_diff = days(t_Saturn - t_Jupiter);
t = time_diff*24*3600;

% Estraggo il vettore di stato con i coe aggiornati all'ultima posizione
[r, v] = sv_from_coe(coe_flyby, mu);
% Risolvo Lambert per arrivare su Saturno
[V1_l_f, V2_l_s] = lambert(r, r2_s, t, 'pro');

d_V_1 = v - V1_l_f;
d_V_norm = norm(d_V_1);


% Estrazione elementi orbitali orbita di trasferimento (using r1 and v1_l):
coe_js = coe_from_sv(r, V1_l_f, mu);
% Initial true anomaly:
TA1_js = rad2deg(coe_js(6));

% Estrazione elementi orbitali orbita di trasferimento (using r2 and v2):
coe_js = coe_from_sv(r2_s, V2_l_s, mu);
% Final true anomaly:
TA2_js = rad2deg(coe_js(6));

% Plot of planets orbit and trajectory orbit

plot_orbit(6,2031);
plot_traiettoria_spacecraft(coe_js, TA1_js, TA2_js , 'g');


%% Calcolo per risolvere Lambert dopo Flyby su un pianeta
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby.

SOI_Saturn;

%Trovo la posizione del pianeta Target

[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2035, 12, 25, 12, 00, 00);

%definisco il tempo di volo
t_Saturn = datetime(2031, 04, 01, 12, 00, 00);
t_Uranus = datetime(2035, 12, 25, 12, 00, 00);

time_diff =days(t_Uranus - t_Saturn);
t = time_diff*24*3600;


%Eseguo un ciclo for che varia la posizione di rp e mi modifica delta
GM_saturn = 37931187; %[km^3/s^2] 
v_inf_down_saturn = V2_l_s - v2_s ;  
v_inf_down_norm_saturn = norm(v_inf_down_saturn); 

a_flyby_saturn = - GM_saturn/((v_inf_down_norm_saturn)^2);%semiaxis major 
r_p_flyby_saturn = 1.8e6 ;  %hp  
%r_p_flyby_Jupiter = 1e5;

e_flyby_saturn = 1-(r_p_flyby_saturn/a_flyby_saturn); 

delta_saturn = 2*asin(1/e_flyby_saturn); %angolo tra gli asintoti 
delta_deg_saturn = rad2deg(delta_saturn); 

%Uso scrpit per calcolare state vector dopo flyby
stateVector_saturn;

%  Faccio Lambert appena uscito dalla SOI
[V1_l_s, V2_l_u] = lambert(r2_fin_s, r2_u, t, 'pro');

d_V_2 = v_fin_saturn - V1_l_s;
d_V_norm = norm(d_V_2);


% Estrazione elementi orbitali orbita di trasferimento (using r1 and v1):
coe_su = coe_from_sv(r2_fin_s, V1_l_s, mu);
% Initial true anomaly:
TA1_su = rad2deg(coe_su(6));

% Estrazione elementi orbitali orbita di trasferimento (using r2 and v2):
coe_su = coe_from_sv(r2_u, V2_l_u, mu);
% Final true anomaly:
TA2_su = rad2deg(coe_su(6));
% Plot of planets orbit and trajectory orbit
plot_orbit(7,2036)
plot_traiettoria_spacecraft(coe_su, TA1_su, TA2_su , 'g');
