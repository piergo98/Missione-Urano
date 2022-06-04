%% Movie
% k = 1;
% movie_fps = 60;

%% Orbit plane change with three pulse maneuver on Uranus from ecliptical 
% plane (0 deg) to equatorial plane (97.77 deg)

r_orbit_u = r_Uranus + 1000; 

plot_Uranus;

deltaT_min = 1e20;            % Initialization minimum tof 
color = 'b';
i1_u = 0;     % inclination ecliptic orbit around Uranus (rad)
i2_u = deg2rad(97.77);  % inclination equatorial parking orbit around Uranus (rad)
RAAN1_u = 3*pi/2;  % right ascention ecliptical orbit (rad)
RAAN2_u = 3*pi/2;  % right ascention equatorial orbit (rad)

for j = r_orbit_u:1e5:5e7 
    
    r2 = j;
    rho = r2/r_orbit_u;
    cos_theta_u = cos(i1_u)*cos(i2_u) + sin(i1_u)*sin(i2_u)*cos(RAAN2_u-RAAN1_u);
    theta_u = acos(cos_theta_u);
    
    v_orbit_u = sqrt(mu_Uranus / r_orbit_u);     % orbit velocity (km/s)
    deltaV_1 = 2*(sqrt(2*rho/(1+rho))- 1)* v_orbit_u;   %considering dv1 and dv3
    
    v_a = sqrt(mu_Uranus/r_orbit_u)*sqrt(2/(rho*(1+rho)));
    deltaV_2 = 2*v_a*sin(theta_u/2);   % delta v to equatorial orbit
    deltaV_tot = deltaV_1 + deltaV_2;   %dv3 is considered in dv1
    
%   Compute the time of flight
    Tc = 2*pi*sqrt(r_orbit_u^3 / mu_Uranus);
    deltaT = Tc * sqrt((1+rho)^3 / 8);
    if deltaT/(24*3600*365.25) < 1 && deltaV_tot < 13         % Considero le traiettorie che impiegano meno di 1 anno
        if deltaT < deltaT_min
            rho_ottimo = rho;
            deltaV_ottimo = deltaV_tot;
            deltaT_min = deltaT;

            % Prima orbita di trasferimento
            e_tf_1 = (j - r_orbit_u) / (j + r_orbit_u);   % eccentricità
            a_tf_1 = (j + r_orbit_u) / 2;  % semiasse maggiore
            p_tf_1 = a_tf_1 * (1-e_tf_1^2); % semilato retto
            i_tf_1 = i1_u;  % inclinazione (eclittica)
            RA_tf_1 = RAAN1_u;  % Right ascention 
            w_tf_1 = 0;

            % Seconda orbita di trasferimento
            e_tf_2 = (j - r_orbit_u) / (j + r_orbit_u);   % eccentricità
            a_tf_2 = (j + r_orbit_u) / 2;  % semiasse maggiore
            p_tf_2 = a_tf_2 * (1-e_tf_2^2); % semilato retto
            i_tf_2 = i2_u;  % inclinazione (eclittica)
            RA_tf_2 = RAAN2_u;  % Right ascention 
            w_tf_2 = 0;
        end
    end
end
deltaT_min_days = deltaT_min/(24*3600);
fprintf('\n Cambio di piano su Urano:')
fprintf("\n Tempo di cambio di piano su Urano = %g (giorni) \n", deltaT_min_days)
fprintf('\n-----------------------------------------------------\n')

% Plot orbital plane shift
hold on
% Circlar initial orbit
f = 0:1:270;
e = 0;
r = r_orbit_u;
p = r;
pos = [];
for i = 1:length(f)
%   Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f(i)));
%       Converto in coordinate cartesiane
    x = r*cosd(f(i));
    y = r*sind(f(i));
    z = 0;
%   Cambio di coordinate il vettore posizione per plottarlo
    Q_pX = perifocal2helio(0, 0, 0);
    pos = Q_pX * [x y z]';

    if i == 1
        ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',2);
    end
    addpoints(ra, pos(1), pos(2), pos(3));
    drawnow;

    % Write video    
%     movieVector(k) = getframe(gcf);
%     k = k+1;

end

% First transfer orbit
f = 0:1:180;
color = 'c';
pos = [];
for i = 1:length(f)
%   Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p_tf_1 / (1 + e_tf_1*cosd(f(i)));
%       Converto in coordinate cartesiane
    x = r*cosd(f(i));
    y = r*sind(f(i));
    z = 0;
%   Cambio di coordinate il vettore posizione per plottarlo
    Q_pX = perifocal2helio(RA_tf_1, i_tf_1, w_tf_1);
    pos = Q_pX * [x y z]';

    if i == 1
        ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',2);
    end
    addpoints(ra, pos(1), pos(2), pos(3));
    drawnow;

    % Write video    
%     movieVector(k) = getframe(gcf);
%     k = k+1;

end

% Second transfer orbit
f = 180:1:360;
pos = [];
color = 'c';
for i = 1:length(f)
%    Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p_tf_2 / (1 + e_tf_2*cosd(f(i)));
%    Converto in coordinate cartesiane
    x = r*cosd(f(i));
    y = r*sind(f(i));
    z = 0;
%   Cambio di coordinate il vettore posizione per plottarlo
    Q_pX = perifocal2helio(RA_tf_2, i_tf_2, w_tf_2);
    pos = Q_pX * [x y z]';
%     pos = [x y z];

    if i == 1 
        ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',2);
    end
    addpoints(ra, pos(1), pos(2), pos(3));
    drawnow;

    % Write video    
%     movieVector(k) = getframe(gcf);
%     k = k+1;

end

% Final circular orbit
f = 0:1:360;
e = 0;
r = r_orbit_u;
p = r;
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
    Q_pX = perifocal2helio(RA_tf_2, i_tf_2, w_tf_2);
    pos = Q_pX * [x y z]';

    if i == 1
        ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',2);
    end
    addpoints(ra, pos(1), pos(2), pos(3));
    drawnow;

    % Write video    
%     movieVector(k) = getframe(gcf);
%     k = k+1;

end



axis equal

xlim([-1e5 1e5])
ylim([-1e5 1e5])
zlim([-1e5 1e5])
view([1, 1, 0])
   
%% Video stuff
% movie = VideoWriter('Uranus_orbital_plane_shift', 'MPEG-4');
% movie.FrameRate = movie_fps;
% 
% open(movie);
% writeVideo(movie, movieVector);
% close(movie);
% 
