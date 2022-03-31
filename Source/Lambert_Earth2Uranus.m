% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LAMBERT'S PROBLEM FROM EARTH TO URANUS
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
%dt = month2seconds(3):month2seconds(1):month2seconds(8);
dt = year2seconds(1): year2seconds(1):year2seconds(12);

for i = 1:length(dt)
    
    % Position of Earth at the departure (km)
    [coe1_e, r1_e, v1_e, jd1_e] = planet_elements_and_sv(3, 2022, 10, 01, 18, 00, 00);
    
    
    % Position of Uranus at the arrival  (km)     
    [coe2_u, r2_u, v2_u, jd2_u] = planet_elements_and_sv(7, 2022+i, 07, 01, 18, 00, 00);
    
    string = 'pro';
    %...
    %dt = year2seconds(3)+ month2seconds(2)+days2seconds(9);     % Total TOF (speriamo)
    %...Algorithm 5.2:
    [v1_l_e, v2_l_u] = lambert(r1_e, r2_u, dt(i), string);
    
    
    % Estrazione elementi orbitali orbita di trasferimento (using r1 and v1):
    coe = coe_from_sv(r1_e, v1_l_e, mu);
    % Initial true anomaly:
    TA1 = rad2deg(coe(6));
    
    % Estrazione elementi orbitali orbita di trasferimento (using r2 and v2):
    coe = coe_from_sv(r2_u, v2_l_u, mu);
    % Final true anomaly:
    TA2 = rad2deg(coe(6));
    d_theta(i) = (TA2 - TA1);
    V_final = norm(v2_l_u);
%     if d_theta(i) < 181 && d_theta(i) > 89
        % Plot of planets orbit and trajectory orbit
        plot_traiettoria_spacecraft(coe, TA1, TA2, 'g')
        %spcr_soi_in = SOI_input_point(coe, TA2, r2_j)
        fprintf('\n TOF = %g\n', dt(i));
        fprintf('\n Index = %g \n', i);
        fprintf('\n Final speed = %g (Km/s)\n ', V_final)
        fprintf('\n Delta True Anomaly = %g (deg)\n', d_theta(i));
        fprintf('\n-----------------------------------------------------\n')
%     end
end

plot_orbit(7, 2028)