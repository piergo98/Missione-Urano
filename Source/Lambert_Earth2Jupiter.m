% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LAMBERT'S PROBLEM FROM EARTH TO JUPITER
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

% clear all; 
clc
addpath './Script matlab'
global mu
deg = pi/180;

%...Data declaration:

mu = 1.327*10^11;                   % mu sun (km^3/s^2)
% TOF 
% dt_y = year2seconds(1):year2seconds(1):year2seconds(10);
% dt_m = month2seconds(1):month2seconds(1):month2seconds(12);
dt = year2seconds(1): year2seconds(1):year2seconds(100);

for i = 1:length(dt)
% Position of Earth at the departure (km)
[coe1_e, r1_e, v1_e, jd1_e] = planet_elements_and_sv(3, 2022, 07, 01, 18, 00, 00);


% Position of Jupiter at the arrival  (km)     
[coe2_j, r2_j, v2_j, jd2_j] = planet_elements_and_sv(5, 2022+i, 07, 01, 18, 00, 00);

string = 'pro';
%...
%dt = year2seconds(3)+ month2seconds(2)+days2seconds(9);     % Total TOF (speriamo)
%...Algorithm 5.2:
[v1_l_e, v2_l_j] = lambert(r1_e, r2_j, dt(i), string);


%...Algorithm 4.1 (using r1 and v1):
coe      = coe_from_sv(r1_e, v1_l_e, mu);
%...Save the initial true anomaly:
TA1      = coe(6);

%...Algorithm 4.1 (using r2 and v2):
coe      = coe_from_sv(r2_j, v2_l_j, mu);
%...Save the final true anomaly:
TA2      = coe(6);
d_theta(i) = abs((TA1 - TA2)*180/pi);
if d_theta(i)< 190 && d_theta(i)> 170
    % Plot of planets orbit and trajectory orbit
    y = orbit_Earth2Jupiter(r1_e, v1_l_e, dt);
end
end
plot_orbit(5, 2024)
plot_orbit(3, 2022)

% %...Echo the input data and output the results to the command window:
% fprintf('-----------------------------------------------------')		
% fprintf('\n Lambert''s Problem from Earth to Jupiter\n')
% fprintf('\n\n Input data:\n');
% fprintf('\n   Gravitational parameter (km^3/s^2) = %g\n', mu);
% fprintf('\n   r1_e (km)                       = [%g  %g  %g]', ...
%                                             r1_e(1), r1_e(2), r1_e(3))
% fprintf('\n   r2_j (km)                       = [%g  %g  %g]', ...
%                                             r2_j(1), r2_j(2), r2_j(3))
% fprintf('\n   Elapsed time (s)              = %g', dt);
% fprintf('\n\n Solution:\n')
% 
% fprintf('\n   v1_e (km/s)                     = [%g  %g  %g]', ...
%                                             v1_l_e(1), v1_l_e(2), v1_l_e(3))
% fprintf('\n   v2_j (km/s)                     = [%g  %g  %g]', ...
%                                             v2_l_j(1), v2_l_j(2), v2_l_j(3))
% 																							 
% fprintf('\n\n Orbital elements:')
% fprintf('\n   Angular momentum (km^2/s)     = %g', coe(1))
% fprintf('\n   Eccentricity                  = %g', coe(2))
% fprintf('\n   Inclination (deg)             = %g', coe(4)/deg)
% fprintf('\n   RA of ascending node (deg)    = %g', coe(3)/deg)
% fprintf('\n   Argument of perigee (deg)     = %g', coe(5)/deg)
% fprintf('\n   True anomaly initial (deg)    = %g', TA1/deg)
% fprintf('\n   True anomaly final   (deg)    = %g', TA2/deg)
% fprintf('\n   Semimajor axis (km)           = %g', coe(7))
% fprintf('\n   Periapse radius (km)          = %g', coe(1)^2/mu/(1 + coe(2)))
% %...If the orbit is an ellipse, output its period:
% if coe(2)<1
% 	T = 2*pi/sqrt(mu)*coe(7)^1.5; 
% 	fprintf('\n   Period:')
% 	fprintf('\n     Seconds                     = %g', T) 
% 	fprintf('\n     Minutes                     = %g', T/60)
% 	fprintf('\n     Hours                       = %g', T/3600)
% 	fprintf('\n     Days                        = %g', T/24/3600)
% end
% fprintf('\n-----------------------------------------------------\n')		
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~