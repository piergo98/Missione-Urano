%% Orbit plane change with single pulse maneuver on Earth from equatorial plane (-23.4 deg) to ecliptical plane (0 deg)

i1_e = -23.4;     % inclination parking orbit around Earth (deg)
i2_e = 0;  % inclination parking orbit on the ecliptic plane (deg)

RAAN1_e = 0;  % right ascention equatorial orbit (deg)
RAAN2_e = 0;  % right ascention ecliptical orbit (deg)

cos_theta_e = cosd(i1_e)*cosd(i2_e) + sind(i1_e)*sind(i2_e)*cosd(RAAN2_e-RAAN1_e);
theta_e = acosd(cos_theta_e);

% Raggio orbita di parcheggio intorno alla Terra(km)
r_orbit = r_Earth + Epark_radius;

mu_e = 3.986*10^5;    % mu Earth (km^3/s^2)

v_orbit_e = sqrt(mu_e / r_orbit);     % orbit velocity (km/s)

deltaV_orbit_e = 2*v_orbit_e*sind(theta_e/2);    % delta v to ecliptical orbit

% Plot orbital plane shift

% Plot planet
figure(2)
[xx, yy, zz] = sphere(100);
surf(r_Earth*xx, r_Earth*yy, r_Earth*zz, 'EdgeColor','green','FaceColor','green',...
    'FaceAlpha','1');

% Circlar initial orbit
f = 0:1:360;
e = 0;
p = r_orbit;
color = 'k';
pos = [];
for i = 1:length(f)
%   Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f(i)));
%       Converto in coordinate cartesiane
    x = r*cosd(f(i));
    y = r*sind(f(i));
    z = 0;
%   Cambio di coordinate il vettore posizione per plottarlo
    Q_pX = perifocal2helio(RAAN1_e, deg2rad(i1_e), 0);
    pos = Q_pX * [x y z]';
%     pos = [x y z];

    if i == 1
        ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',1);
    end
    addpoints(ra, pos(1), pos(2), pos(3));
    drawnow;
end

% Final circular orbit
f = 0:1:360;
e = 0;
p = r_orbit;
color = 'r';
pos = [];
for i = 1:length(f)
%   Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f(i)));
%       Converto in coordinate cartesiane
    x = r*cosd(f(i));
    y = r*sind(f(i));
    z = 0;
%   Cambio di coordinate il vettore posizione per plottarlo
    Q_pX = perifocal2helio(RAAN2_e, deg2rad(i2_e), 0);
    pos = Q_pX * [x y z]';
%     pos = [x y z];

    if i == 1
        ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',1);
    end
    addpoints(ra, pos(1), pos(2), pos(3));
    drawnow;
end

fprintf('\n\n Results Earth plane shift:')
fprintf('\n   deltaV cambio piano orbita terrestre (km/s)     = %g', deltaV_orbit_e)
% fprintf('\n   TOF (days)            = %g', deltaT_min/(24*3600))
fprintf('\n -----------------------------------------------------------\n');

  
% xlim([-1e5 1e5])
% ylim([-1e5 1e5])
% zlim([-1e5 1e5])
% xlabel('x (km)')
% ylabel('y (km)')
% zlabel('z (km)')
view([0 0 1])

Escape_from_Earth