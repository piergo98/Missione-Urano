%%Orbit plane change on Uranus from ecliptical plane (0 deg) to equatorial
%%plane (97.77 deg)

clear, clc

i1_u = 0;     % inclination ecliptic orbit around Uranus (deg)
i2_u = 97.77;  % inclination equatorial parking orbit around Uranus (deg)


RAAN1_u = 0;  % right ascention ecliptical orbit (deg)
RAAN2_u = 0;  % right ascention equatorial orbit (deg)

cos_theta_u = cosd(i1_u)*cosd(i2_u) + sind(i1_u)*sind(i2_u)*cosd(RAAN2_u-RAAN1_u);
theta_u = acosd(cos_theta_u);

r_orbit_u = 25362 + 1000;     % Uranus radius + orbit altitude (km)
mu_u = 5.7939*10^6;            % Uranus mu (km^3/s^2)

v_orbit_u = sqrt(mu_u / r_orbit_u);     % orbit velocity (km/s)

deltaV_orbit_u = 2*v_orbit_u*sind(theta_u/2)    % delta v to equatorial orbit

