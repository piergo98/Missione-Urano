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

% clear all; 
clc
addpath './Script matlab'
global mu
deg = pi/180;

%...Data declaration:

mu = 1.327*10^11;                   % mu sun (km^3/s^2)
% TOF 
% dt_y = year2seconds(1):year2seconds(1):year2seconds(10);
dt = month2seconds(3):month2seconds(1):month2seconds(8);
%dt = year2seconds(0.1): year2seconds(0.1):year2seconds(2);

for i = 1:length(dt)
    % Position of Earth at the departure (km)
    [coe1_e1, r1_e1, v1_e1, jd1_e1] = planet_elements_and_sv(3, 2022, 06, 01, 18, 00, 00);
    
    
    % Position of Earth at the arrival  (km)     
    [coe2_e2, r2_e2, v2_e2, jd2_e2] = planet_elements_and_sv(3, 2022, 07+i, 01, 18, 00, 00);
    
    string = 'pro';
    %...
    %dt = year2seconds(3)+ month2seconds(2)+days2seconds(9);     % Total TOF (speriamo)
    %...Algorithm 5.2:
    [v1_l_e1, v2_l_e2] = lambert(r1_e1, r2_e2, dt(i), string);
    
    
    % Estrazione elementi orbitali orbita di trasferimento (using r1 and v1):
    coe = coe_from_sv(r1_e1, v1_l_e1, mu);
    % Initial true anomaly:
    TA1 = rad2deg(coe(6));
    
    % Estrazione elementi orbitali orbita di trasferimento (using r2 and v2):
    coe = coe_from_sv(r2_e2, v2_l_e2, mu);
    % Final true anomaly:
    TA2 = rad2deg(coe(6));
    d_theta(i) = (TA2 - TA1);
    V_final = norm(v2_l_e2);
    if d_theta(i) < 181 && d_theta(i) > 89
        % Plot of planets orbit and trajectory orbit
        plot_traiettoria_spacecraft(coe, TA1, TA2, 'g')
        %spcr_soi_in = SOI_input_point(coe, TA2, r2_j)
        fprintf('\n TOF = %g\n', dt(i));
        fprintf('\n Index = %g \n', i);
        fprintf('\n Final speed = %g (Km/s)\n ', V_final)
        fprintf('\n Delta True Anomaly = %g (deg)\n', d_theta(i));
        fprintf('\n-----------------------------------------------------\n')
    end
end

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