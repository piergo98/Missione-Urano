
clear, clc

i1_e = 0;     % inclination parking orbit around Earth (deg)
i2_e = 23.4;  % inclination parking orbit on the ecliptic plane (deg)

% RAAN2_e = 0:1:360;

RAAN1_e = 0;  % right ascention equatorial orbit (deg)
RAAN2_e = 0;  % right ascention ecliptical orbit (deg)

cos_theta_e = cosd(i1_e)*cosd(i2_e) + sind(i1_e)*sind(i2_e)*cosd(RAAN2_e-RAAN1_e);
theta_e = acosd(cos_theta_e);

r_orbit_e = 6571;     % Earth radius (km)
mu_e = 3.986*10^5;    % mu Earth (km^3/s^2)

v_orbit_e = sqrt(mu_e / r_orbit_e);     % orbit velocity (km/s)

deltaV_orbit_e = 2*v_orbit_e*sind(theta_e/2)    % delta v to equatorial orbit

% plot(RAAN2_e, deltaV_orbit_e);
% grid
