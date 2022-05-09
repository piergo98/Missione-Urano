%% Capture trajectory
% Transfer between hyperbolic capture to a parking orbit
% R_hyperbola_perigee = R_parking_orbit
r_orbit_u = r_Uranus + Upark_radius;

% V_spacecraft respect to Uranus
V_inf_sp_uranus = V2_l_u - v2_u;
% Semimajor axis hyperbola
a_hyp_u = - mu_Uranus / norm(V_inf_sp_uranus)^2;
% Eccentricity hyperbola
e_hyp_u = 1 - (r_orbit_u / a_hyp_u);
% Parking orbit speed
V_uranus_park = sqrt(mu_Uranus/r_orbit_u);
% Hyperbola perigee speed
V_hyp_perigee = sqrt(norm(V_inf_sp_uranus) + (2*mu_Uranus/r_orbit_u));
% Delta V
deltaV_uranus_capture = V_hyp_perigee - V_uranus_park;

fprintf('\n\n Results:')
fprintf('\n   Velocità iperbole al perigeo (km/s)  = %g', V_hyp_perigee)
fprintf('\n   Velocità orbita di parcheggio (km/s) = %g', V_uranus_park)
fprintf('\n   DeltaV cattura (km/s) = %g', deltaV_uranus_capture)
fprintf('\n -----------------------------------------------------------\n')

%% Plot capture
% Plot SOI Uranus
[X,Y,Z] = sphere;
figure(5)
surface(R_SOI_Uranus*X,R_SOI_Uranus*Y,...
    R_SOI_Uranus*Z,'EdgeColor','cyan','FaceColor','cyan',...
    'FaceAlpha','0');

% Hyperbolic orbit
% Semilato retto
p_hyp_u = a_hyp_u * (1 - e_hyp_u^2);
f_deg_Uranus = acosd((p_hyp_u - R_SOI_Uranus) / (R_SOI_Uranus*e_hyp_u));
f = -f_deg_Uranus:0.1:0;
radius = 10;
color = 'r';
pos = [];
for i = 1:length(f)
%   Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p_hyp_u / (1 + e_hyp_u*cosd(f(i)));
%       Converto in coordinate cartesiane
    x = r*cosd(f(i));
    y = r*sind(f(i));
    z = 0;
%   Cambio di coordinate il vettore posizione per plottarlo
    Q_pX = perifocal2helio(0, 0, 0);
    pos = Q_pX * [x y z]';
%     pos = [x y z];

    if i == 1
        ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',1);
    end
    addpoints(ra, pos(1), pos(2), pos(3));
    drawnow;
end

xlim([-1e5 1e5])
ylim([-1e5 1e5])

% Circular parking orbit
f = 0:1:360;
% Semilato retto
p_uranus_park = r_orbit_u;
% Eccentricity
e_uranus_park = 0;
radius = 10;
color = 'r';
pos = [];
for i = 1:length(f)
%   Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p_uranus_park / (1 + e_uranus_park*cosd(f(i)));
%       Converto in coordinate cartesiane
    x = r*cosd(f(i));
    y = r*sind(f(i));
    z = 0;
%   Cambio di coordinate il vettore posizione per plottarlo
    Q_pX = perifocal2helio(0, 0, 0);
    pos = Q_pX * [x y z]';
%     pos = [x y z];

    if i == 1 
        ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',1);
    end
    addpoints(ra, pos(1), pos(2), pos(3));
    drawnow;
end

% Plot planet
hold on
[xx, yy, zz] = sphere(100);
surf(r_Uranus*xx, r_Uranus*yy, r_Uranus*zz, 'EdgeColor','blue','FaceColor','blue',...
    'FaceAlpha','1');
% colormap light_gray
% caxis([-r_uranus/100 r_uranus/100])
% shading interp
  
xlim([-1e5 1e5])
ylim([-1e5 1e5])
zlim([-1e5 1e5])
xlabel('x (km)')
ylabel('y (km)')
zlabel('z (km)')

% Change plane
Uranus_orbital_plane_shift