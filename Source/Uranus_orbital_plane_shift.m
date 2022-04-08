%% Orbit plane change with three pulse maneuver on Uranus from ecliptical 
% plane (0 deg) to equatorial plane (97.77 deg)

clear, clc
r_orbit_u = 25362 + 1000;     % Uranus radius + orbit altitude (km)
mu_u = 5.7939*10^6;            % Uranus mu (km^3/s^2)
SOI_uranus
for j = r_orbit_u:1e5:5e7 

    i1_u = 0;     % inclination ecliptic orbit around Uranus (deg)
    i2_u = 97.77;  % inclination equatorial parking orbit around Uranus (deg)
    r2 = j;
    rho = r2/r_orbit_u;
    RAAN1_u = 0;  % right ascention ecliptical orbit (deg)
    RAAN2_u = 0;  % right ascention equatorial orbit (deg)
    

    cos_theta_u = cosd(i1_u)*cosd(i2_u) + sind(i1_u)*sind(i2_u)*cosd(RAAN2_u-RAAN1_u);
    theta_u = acosd(cos_theta_u);
    
    v_orbit_u = sqrt(mu_u / r_orbit_u);     % orbit velocity (km/s)
    deltaV_1 = 2*(sqrt(2*rho/(1+rho))- 1)* v_orbit_u;   %considering dv1 and dv3
    
    v_a = sqrt(mu_u/r_orbit_u)*sqrt(2/(rho*(1+rho)));
    deltaV_2 = 2*v_a*sind(theta_u/2);   % delta v to equatorial orbit
    deltaV_tot = deltaV_1 + deltaV_2;   %dv3 is considered in dv1
    if deltaV_tot < 13
        rho
        deltaV_1
        deltaV_2
        deltaV_tot/v_orbit_u
    end

end


