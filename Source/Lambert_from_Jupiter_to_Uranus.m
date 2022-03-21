% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LAMBERT'S PROBLEM FROM JUPITER TO SATURN
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
addpath 'Script matlab'
global mu
deg = pi/180;

%...Data declaration:

mu = 1.327*10^11; % mu sun (km^3/s^2)
dt = year2seconds(6):year2seconds(1):year2seconds(10);  % Time Of Flight
% Position of Jupiter at the departure (km)
[coe1_j, r1_j, v1_j, jd1_j] = planet_elements_and_sv(5, 2026, 06, 09, 12, 00, 00);
for i = 1:length(dt)
    % Position of Saturn at the arrival  (km)     
    [coe2_s, r2_s, v2_s, jd2_s] = planet_elements_and_sv(6, 2027+i+5, 06, 09, 12, 00, 00);
    string = 'pro';
    % Solving Lambert Problem from Jupiter to Saturn
    [v1_l_j, v2_l_s] = lambert(r1_j, r2_s, dt(i), string);

    coe = coe_from_sv(r1_j, v1_l_j, mu);
    %Save the initial true anomaly:
    TA1_js = coe(6);

    coe      = coe_from_sv(r2_s, v2_l_s, mu);
    %Save the final true anomaly:
    TA2_js = coe(6);

    % Plot orbit
    y_js = orbit_Jupiter2Saturn(r1_j, v1_l_j, dt(i));

    % Position of Uranus at the arrival  (km)     
    [coe2_u, r2_u, v2_u, jd2_u] = planet_elements_and_sv(7, 2028+i+5, 07, 27, 12, 00, 00);

    % Solving Lambert Problem from Jupiter to Saturn
    [v2_l_s, v2_l_u] = lambert(r2_s, r2_u, dt(i), string);

    coe = coe_from_sv(r1_s, v1_l_s, mu);
    %Save the initial true anomaly:
    TA1_su = coe(6);
    
    %...Algorithm 4.1 (using r2 and v2):
    coe = coe_from_sv(r2_u, v2_l_u, mu);
    %Save the final true anomaly:
    TA2_su = coe(6);

    % Plot orbit
%     y_su = orbit_Saturn2Uranus(r2_s, v2_l_s, dt(i));

end

plot_orbit(5, 2024)     % plot Jupiter orbit
plot_orbit(6, 2028)     % plot Saturn orbit
plot_orbit(7, 2032)     % plot Uranus orbit