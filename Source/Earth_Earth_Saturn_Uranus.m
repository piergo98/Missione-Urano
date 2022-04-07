% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LAMBERT'S PROBLEM FROM EARTH TO EARTH
% ~~~~~~~~~~~~
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

  User M-functions required: lambert, coe_from_sv
%}
% ---------------------------------------------

clear all; 
clc
addpath './Script matlab'
global mu
deg = pi/180;

%...Data declaration:

mu = 1.327*10^11;                   % mu sun (km^3/s^2)
% TOF 
dt = month2seconds(23);

[coe1_e1, r1_e1, v1_e1, jd1_e1] = planet_elements_and_sv(3, 2022, 05, 01, 18, 00, 00);


[coe2_e2, r2_e2, v2_e2, jd2_e2] = planet_elements_and_sv(3, 2024, 04, 01, 18, 00, 00);

string = 'pro';
[v1_l_e1, v2_l_e2] = lambert(r1_e1, r2_e2, dt, string);


coe = coe_from_sv(r1_e1, v1_l_e1, mu);

% Initial true anomaly:
TA1 = rad2deg(coe(6));

% Estrazione elementi orbitali orbita di trasferimento (using r2_e2 and v2_l_e2):
coe = coe_from_sv(r2_e2, v2_l_e2, mu);
% Final true anomaly:
TA2 = rad2deg(coe(6));
d_theta = abs(TA2 - TA1);
V_final = norm(v2_l_e2);
%if d_theta < 181 && d_theta > 89
    % Plot of planets orbit and trajectory orbit
    plot_traiettoria_spacecraft(coe, TA1, TA2, 'g')
    fprintf('\n TOF = %g\n', dt);
    fprintf('\n Final speed = %g (Km/s)\n ', V_final)
    fprintf('\n Delta True Anomaly = %g (deg)\n', d_theta);
    fprintf('\n-----------------------------------------------------\n')
%end

plot_orbit(3, 2022)
plot_orbit(4,2030);
plot_orbit(5,2030);


%% Calcolo per risolvere Lambert dopo Flyby su un pianeta
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby.

%Recupero dati pianeta attorno a cui faccio il flyby
SOI_Earth;

%Trovo la posizione del pianeta Target

[~, r2_s, v2_s, ~] = planet_elements_and_sv(6, 2030, 04, 03, 00, 00, 00);

%definisco il tempo di volo

t = year2seconds(6);

mu_Earth = 3986004418; %[km^3/s^2] 
v_inf_down_Earth = v2_l_e2 - v2_e2 ;  
v_inf_down_norm_Earth = norm(v_inf_down_Earth); 

a_flyby_Earth = - mu_Earth/((v_inf_down_norm_Earth)^2);%semiaxis major 
r_p_flyby_Earth = 10000 ;  %rp  

e_flyby_Earth = 1-(r_p_flyby_Earth/a_flyby_Earth); 
    
delta_Earth = 2*asin(1/e_flyby_Earth); %angolo tra gli asintoti 
delta_deg_Earth = rad2deg(delta_Earth); 

%Uso scrpit per calcolare state vector dopo flyby

StateVector_Earth;

%sposto il vettore posizione dello spacecraft lungo la direzione dopo il
%flyby sfruttando l'anomalia vera

coe_flyby = coe_from_sv(r2_fin_e,v_fin_Earth,mu);

%anomalia vera in partenza dalla SOI della Terra
Ta_post_flyby = coe_flyby(6);

%anomalia vera nel punto di partenza della traiettoria di Lambert fra la
%Terra e Saturno
Ta_for_lambert = Ta_post_flyby + 30*(pi/180);

%aggiorno l'anomalia vera per plottare la traiettoria
coe_new = coe_flyby;
coe_new(6)= Ta_for_lambert;

%plotto la traiettoria fra SOI Terra e punto partenza di Lambert fra Terra
%e Saturno
plot_traiettoria_spacecraft(coe_new, rad2deg(Ta_post_flyby), rad2deg(Ta_for_lambert), 'g')

%punto partenza lambert post flyby terra con arrivo su saturno
[r, v] = sv_from_coe(coe_new,mu);

[V1_l, V2_l_s] = lambert(r, r2_s, t, 'pro');

d_V = v - V1_l;
d_V_norm = norm(d_V);


% Estrazione elementi orbitali orbita di trasferimento (using r1 and v1_l):
coe_ES = coe_from_sv(r, V1_l, mu);
% Initial true anomaly:
TA1_ES = rad2deg(coe_ES(6));

% Estrazione elementi orbitali orbita di trasferimento (using r2 and v2):
coe_ES = coe_from_sv(r2_s, V2_l_s, mu);
% Final true anomaly:
TA2_ES = rad2deg(coe_ES(6));

% Plot of planets orbit and trajectory orbit

plot_orbit(6,2030);
plot_traiettoria_spacecraft(coe_ES, TA1_ES, TA2_ES + 360, 'g');

     
% fprintf('\n Starting speed = [%c %c %c] (Km/s)\n ', V1(1),V1(2), V1(3))
% fprintf('\n Final speed = [%c %c %c] (Km/s)\n ', V2(1),V2(2), V2(3))
% fprintf('\n Actual speed of sp = [%c %c %c] (Km/s)\n ', v(1),v(2), v(3))
% fprintf('\n delta v = %s (Km/s)\n ', d_V_norm)
% fprintf('\n Distance from Jupiter = %g (Km)\n ',r_p_flyby_Earth)
% fprintf('\n eccentricity = %g \n ',e_flyby_Earth)
% fprintf('\n eccentricity from coe = %g \n ',coe_flyby(2))
% fprintf('\n starting point lambert = [%c %c %c] \n ',r(1),r(2),r(3))
% fprintf('\n-----------------------------------------------------\n')


%%




% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LAMBERT'S PROBLEM FROM SATURN TO URANUS
% ~~~~~~~~~~~~
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

  User M-functions required: lambert, coe_from_sv
%}
% ---------------------------------------------


%...Data declaration:

% TOF
dt = year2seconds(6);
% Position of Saturn at the departure (km)
[coe1_s, r1_s, v1_s, jd1_s] = planet_elements_and_sv(6, 2030, 10, 10, 12, 00, 00);

    % Position of Uranus at the arrival  (km)     
    [coe2_u, r2_u, v2_u, jd2_u] = planet_elements_and_sv(7, 2036, 10, 27, 12, 00, 00);
    % TOF (s)
    % dt     = 139276800;                   
    string = 'pro';
    %...
    
    %...Algorithm 5.2:
    [v1_l_s, v2_l_u] = lambert(r1_s, r2_u, dt, string);
    
    %...Algorithm 4.1 (using r1 and v1):
    coe = coe_from_sv(r1_s, v1_l_s, mu);
    %...Save the initial true anomaly:
    TA1 = rad2deg(coe(6));
    
    %...Algorithm 4.1 (using r2 and v2):
    coe = coe_from_sv(r2_u, v2_l_u, mu);
    %...Save the final true anomaly:
    TA2 = rad2deg(coe(6));
    d_theta = norm(TA1 - TA2);
   % if d_theta < 181 && d_theta > 89
%         y = orbit_Saturn2Uranus(r1_s, v1_l_s, dt(i));
    
    plot_traiettoria_spacecraft(coe, TA1, TA2, 'g')
        fprintf('\n   delta t (s) = %g \n', dt)
        %fprintf('\n index = %g \n', i)
    %end


plot_orbit(7, 2032)     % plot Uranus orbit

