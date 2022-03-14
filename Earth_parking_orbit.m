
clear, clc

i = 5.2;  % inclination parking orbit around Earth (deg)
lat = 5.2;  % latitude of Kourou base (deg)

beta = asind(cosd(i) / cosd(lat));     % azimuth necesary for the launch

r_orbit = 6571;     % Earth radius (km)
mu_e = 3.986*10^5;  % mu Earth (km^3/s^2)

v_orbit = sqrt(mu_e / r_orbit);     % orbit velocity (km/s)

deltaV_orbit = 2*v_orbit*sind(i/2)    % delta v to equatorial orbit