
clear, clc

mu_s = 1.327*10^11; % mu sun (km^3/s^2)
r_e = 149.9*10^6;   % earth rivolution radius (km)
r_u = 2870.66*10^6;  % uranus rivolution radius (km)

p_e = 365.25636 * 24 * 3600;    % earth revolution period (s)
p_u = 30685.1868 * 24 * 3600;   % Uranus revolution period (s)

a_t = (r_e + r_u)/2;        % semimajor axis transfer orbit (km)
e_t = (r_u - r_e)/2*a_t;    % transfer orbit eccentricity

P = 2*pi * sqrt(a_t^3 / mu_s);  % transfer orbit period (s)

v_ie = sqrt(mu_s / r_e);        % initial velocity on Earth orbit (km/s)
v_tp = sqrt((2*mu_s/r_e) - (mu_s/a_t));   %transfer velocity at periapsis (km/s)

deltaV_1 = v_tp - v_ie;     % initial impulse

v_ta = sqrt((2*mu_s/r_u) - (mu_s/a_t));   %transfer velocity at apoapsis (km/s)
v_fu = sqrt(mu_s / r_u);        % final velocity on Uranus orbit (km/s)

deltaV_2 = v_fu - v_ta;     % final impulse

tof = P/2 / p_e      % time of flight from Earth to Uranus (years)

deltaV_TOT = deltaV_1 + deltaV_2

% Position of Earth at the departure (km)
[coe1_eh, r1_eh, v1_eh, jd1_eh] = planet_elements_and_sv(3, 2022, 07, 21, 12, 00, 00);

y = orbit_Homann_Earth2Uranus(r1_eh, v1_eh, year2seconds(tof));

plot_orbit(3, 2022);
plot_orbit(7, 2022+tof)
