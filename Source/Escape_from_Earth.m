%% COMPUTE THE ANGLE AND TRAJECTORY TO THE ESCAPE FROM EARTH SOI

% Defining the velocity of the Earth
[coe_earth, r_earth, v_earth, jd_earth] = planet_elements_and_sv(3, 2024, 07, 21, 12, 00, 00);

r_orbit = 6571;     % Earth parking orbit radius (km)
mu_e = 3.986*10^5;  % mu Earth (km^3/s^2)

v_infp = v1_l_e - v_earth;    % V_inf vectorial form
v_infp_mod = norm(v_infp);

v_park = sqrt(mu_e/r_orbit);    % parking orbit velocity

v_burn = sqrt(v_infp_mod^2 + 2*v_park^2);   % velocity at the perigee of the hyperbola
D_v_escape = v_burn - v_park % velocity variation to escape

a = - mu_e / v_infp_mod^2;  % hyperbola semiaxis
e = 1 - (r_orbit/a);        % hyperbola eccentricity

delta = 2*asind(1/e)        % angle between hyperbola asintoti
