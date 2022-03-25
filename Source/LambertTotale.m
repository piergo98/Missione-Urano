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


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%VERSIONE SENZA FOR CON UNA SOLA TRAIETTORIA 

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LAMBERT'S PROBLEM FROM EARTH TO JUPITER
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

addpath './Script matlab'
global mu
deg = pi/180;

%...Data declaration:

mu = 1.327*10^11;                   % mu sun (km^3/s^2)

% TOF 
t_Earth = datetime(2022,07,01,12,00,00);
t_Jupiter = datetime(2024,07,21,12,00,00);

time_diff =days(t_Jupiter - t_Earth);
dt = time_diff*24*3600;
%time_diff = between(t_Earth,t_Jupiter);
%dt = caldays(time_diff)
%dt = time_diff.days
%%dt = daysact(t_Earth,t_Jupiter)

r_giove = zeros(10,3);
v_giove = zeros(10,3);


% Position of Earth at the departure (km) 2022/07/01_12:00:00
[coe1_e, r1_e, v1_e, jd1_e] = planet_elements_and_sv(3, 2022, 07, 01, 12, 00, 00);

% Position of Jupiter at the arrival  (km) 2024/07/21_12:00:00    
[coe2_j, r2_j, v2_j, jd2_j] = planet_elements_and_sv(5, 2023, 07, 01, 12, 00, 00);
r_giove = r2_j;
string = 'pro';

%...Algorithm 5.2:
[v1_l_e, v2_l_j] = lambert(r1_e, r2_j, dt, string);
v_giove = v2_j;

%...Algorithm 4.1 (using r1 and v1):
coe      = coe_from_sv(r1_e, v1_l_e, mu);
%...Save the initial true anomaly:
TA1      = coe(6);

%...Algorithm 4.1 (using r2 and v2):
coe      = coe_from_sv(r2_j, v2_l_j, mu);
%...Save the final true anomaly:
TA2      = coe(6);

 
% Plot of planets orbit and trajectory orbit
y = orbit_Earth2Jupiter(r1_e, v1_l_e, dt);
plot_orbit(5, 2024)

plot_orbit(3, 2022)

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LAMBERT'S PROBLEM FROM JUPITER TO SATURN
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% TOF

%aggiorno la data di partenza da Giove stimandola dal tempo di flyby
%t_Jupiter = datetime(2024,08,01,12,00,00);
t_Jupiter = datetime(2024, 07, 22, 00, 53, 40);
t_Saturn = datetime(2031, 04, 01, 12, 00, 00);
  
time_diff = days(t_Saturn - t_Jupiter);
dt = time_diff*24*3600;


% Position of Jupiter at the departure (km) 2024/07/21_12:00:00 
<<<<<<< HEAD
[coe1_j, r1_j, v1_j, jd1_j] = planet_elements_and_sv(5, 2024, 07, 02, 00, 00, 00);
=======
[coe1_j, r1_j, v1_j, jd1_j] = planet_elements_and_sv(5, 2024, 07, 22, 00, 53, 40);
>>>>>>> Grafica

% Position of Saturn at the arrival  (km) 2031/07/27_12:00:00     
[coe2_s, r2_s, v2_s, jd2_s] = planet_elements_and_sv(6, 2031, 04, 01, 12, 00, 00);


% TOF (s)

string = 'pro';

[v1_l_j, v2_l_s] = lambert(r1_j, r2_s, dt, string);


%...Algorithm 4.1 (using r1 and v1):
coe      = coe_from_sv(r1_j, v1_l_j, mu);
%...Save the initial true anomaly:
TA1      = coe(6);

%...Algorithm 4.1 (using r2 and v2):
coe      = coe_from_sv(r2_s, v2_l_s, mu);
%...Save the final true anomaly:
TA2      = coe(6);

%   Plot of the orbit
y = orbit_Jupiter2Saturn(r1_j, v1_l_j, dt);
plot_orbit(6, 2031)     % plot Saturn orbit

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LAMBERT'S PROBLEM FROM SATURN TO URANUS
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


% TOF
t_Saturn = datetime(2031,04,10,12,00,00);
t_Uranus = datetime(2035,12,25,12,00,00);

time_diff = days(t_Uranus - t_Saturn);
dt = time_diff*24*3600;


% Position of Saturn at the departure (km) 2031/07/27_12:00:00  
[coe1_s, r1_s, v1_s, jd1_s] = planet_elements_and_sv(6, 2031, 04, 10, 12, 00, 00);

% % Position of Uranus at the arrival  (km) 2028/06/09_12:00:00
% [coe2_u, r2_u, v2_u, jd2_u] = planet_elements_and_sv(6, 2028, 06, 09, 12, 00, 00);

% Position of Uranus at the arrival  (km) 2035/12/25_12:00:00
[coe2_u, r2_u, v2_u, jd2_u] = planet_elements_and_sv(7, 2035, 12, 25, 12, 00, 00);


% TOF (s)
string = 'pro';

%...Algorithm 5.2:
[v1_l_s, v2_l_u] = lambert(r1_s, r2_u, dt, string);

%...Algorithm 4.1 (using r1 and v1):
coe      = coe_from_sv(r1_s, v1_l_s, mu);
%...Save the initial true anomaly:
TA1      = coe(6);

%...Algorithm 4.1 (using r2 and v2):
coe      = coe_from_sv(r2_u, v2_l_u, mu);
%...Save the final true anomaly:
TA2      = coe(6);

y = orbit_Saturn2Uranus(r1_s, v1_l_s, dt);
%plot_orbit(7, 2026)     % plot Uranus orbit
plot_orbit(7, 2035)     % plot Uranus orbit

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%VERSIONE CON FOR ORIGINALE

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


% % addpath './Script matlab'
% % global mu
% % deg = pi/180;
% % 
% % %...Data declaration:
% % 
% % mu = 1.327*10^11;                   % mu sun (km^3/s^2)
% % 
% % 
% % dt = month2seconds(1):month2seconds(1):month2seconds(12);
% % 
% % r_giove = zeros(10,3);
% % v_giove = zeros(10,3);
% % 
% % for i = 1:3:length(dt)
% %     % Position of Earth at the departure (km) 2022/10/01_18:00:00
% %     [coe1_e, r1_e, v1_e, jd1_e] = planet_elements_and_sv(3, 2022, 10, 01, 18, 00, 00);
% %     
% %     % Position of Jupiter at the arrival  (km) 2024/01/21_12:00:00    
% %     [coe2_j, r2_j, v2_j, jd2_j] = planet_elements_and_sv(5, 2024, 01, 21, 12, 00, 00);
% %     r_giove(i, 1:3) = r2_j;
% %     string = 'pro';
% %     
% %     %...Algorithm 5.2:
% %     [v1_l_e, v2_l_j] = lambert(r1_e, r2_j, dt(i), string);
% %     v_giove(i, 1:3) = v2_j;
% %     
% %     %...Algorithm 4.1 (using r1 and v1):
% %     coe      = coe_from_sv(r1_e, v1_l_e, mu);
% %     %...Save the initial true anomaly:
% %     TA1      = coe(6);
% %     
% %     %...Algorithm 4.1 (using r2 and v2):
% %     coe      = coe_from_sv(r2_j, v2_l_j, mu);
% %     %...Save the final true anomaly:
% %     TA2      = coe(6);
% %     
% %      
% % %     % Plot of planets orbit and trajectory orbit
% %      y = orbit_Earth2Jupiter(r1_e, v1_l_e, dt(i), i);
% %      plot_orbit(5, 2024)
% %  end
% %  plot_orbit(3, 2022)
% % 
% % % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% % 
% % 
% % % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% % % LAMBERT'S PROBLEM FROM JUPITER TO SATURN
% % % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% % 
% % % TOF
% % dt     = year2seconds(1):year2seconds(1):year2seconds(10);
% % 
% % for i = 1:length(dt)
% %     % Position of Jupiter at the departure (km)
% % 
% % %    [coe1_j, r1_j, v1_j, jd1_j] = planet_elements_and_sv(5, 2026, 06, 09, 12, 00, 00);
% %     [coe1_j, r1_j, v1_j, jd1_j] = planet_elements_and_sv(5, 2024, 01, 21, 12, 00, 00);
% % 
% %     % Position of Saturn at the arrival  (km)     
% % %tolgo il contatore i
% % % [coe2_s, r2_s, v2_s, jd2_s] = planet_elements_and_sv(6, 2028+i, 06, 09, 12, 00, 00);
% %      [coe2_s, r2_s, v2_s, jd2_s] = planet_elements_and_sv(6, 2028, 06, 09, 12, 00, 00);
% % 
% % 
% %     % TOF (s)
% %     
% %     string = 'pro';
% %     
% %     [v1_l_j, v2_l_s] = lambert(r1_j, r2_s, dt(i), string);
% % 
% % 
% %     %...Algorithm 4.1 (using r1 and v1):
% %     coe      = coe_from_sv(r1_j, v1_l_j, mu);
% %     %...Save the initial true anomaly:
% %     TA1      = coe(6);
% %     
% %     %...Algorithm 4.1 (using r2 and v2):
% %     coe      = coe_from_sv(r2_s, v2_l_s, mu);
% %     %...Save the final true anomaly:
% %     TA2      = coe(6);
% % 
% % %   Plot of the orbit
% %     y = orbit_Jupiter2Saturn(r1_j, v1_l_j, dt(i));
% % end
% % % 
% % plot_orbit(6, 2028)     % plot Saturn orbit
% % 
% % % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% % 
% % % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% % % LAMBERT'S PROBLEM FROM SATURN TO URANUS
% % % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% % 
% % 
% % % TOF
% % dt = year2seconds(1):year2seconds(1):year2seconds(10);
% % % Position of Saturn at the departure (km)
% % %[coe1_s, r1_s, v1_s, jd1_s] = planet_elements_and_sv(6, 2026, 07, 27, 12, 00, 00);
% % [coe1_s, r1_s, v1_s, jd1_s] = planet_elements_and_sv(6, 2028, 06, 09, 12, 00, 00);
% % 
% % 
% % for i=1:length(dt)
% %     % Position of Uranus at the arrival  (km)     
% %     %tolgo il contatore i
% % %    [coe2_u, r2_u, v2_u, jd2_u] = planet_elements_and_sv(7, 2026+i, 07, 27, 12, 00, 00);
% %      [coe2_u, r2_u, v2_u, jd2_u] = planet_elements_and_sv(7, 2026, 07, 27, 12, 00, 00);
% % 
% % 
% %     % TOF (s)
% %     string = 'pro';
% %     
% %     %...Algorithm 5.2:
% %     [v1_l_s, v2_l_u] = lambert(r1_s, r2_u, dt(i), string);
% %     
% %     %...Algorithm 4.1 (using r1 and v1):
% %     coe      = coe_from_sv(r1_s, v1_l_s, mu);
% %     %...Save the initial true anomaly:
% %     TA1      = coe(6);
% %     
% %     %...Algorithm 4.1 (using r2 and v2):
% %     coe      = coe_from_sv(r2_u, v2_l_u, mu);
% %     %...Save the final true anomaly:
% %     TA2      = coe(6);
% % 
% %      y = orbit_Saturn2Uranus(r1_s, v1_l_s, dt(i));
% % end
% %  plot_orbit(7, 2026)     % plot Uranus orbit
% % 
% % % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~