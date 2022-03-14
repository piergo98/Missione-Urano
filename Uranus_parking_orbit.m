
clear, clc

i1_u = 23.4;  % inclination parking orbit on the ecliptic plane (deg)
i2_u = 97.77; % inclination parking orbit around Uranus (deg)

% RAAN2 = 0:1:360;

RAAN1_u = 0;  % right ascention equatorial orbit (deg)
RAAN2_u = 0;  % right ascention ecliptical orbit (deg)

cos_theta_u = cosd(i1_u)*cosd(i2_u) + sind(i1_u)*sind(i2_u)*cosd(RAAN2_u-RAAN1_u);
theta_u = acosd(cos_theta_u);

r_orbit_u = 26559;     % Uranus radius (km)
mu_u = 5.79*10^6;      % mu Uranus (km^3/s^2)

v_orbit_u = sqrt(mu_u / r_orbit_u);     % orbit velocity (km/s)

deltaV_orbit_u = 2*v_orbit_u*sind(theta_u/2)    % delta v to equatorial orbit

% plot(RAAN2_u, deltaV_orbit_u);
% grid
