%% Capture trajectory
% Transfer between hyperbolic capture to a parking orbit
% R_hyperbola_perigee = R_parking_orbit
r_orbit_u = r_Uranus + Upark_radius;

% V_spacecraft respect to Uranus
V_inf_sp_uranus = v2_l_u - v2_u;
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

%% Calcolo tempo di volo

% Trovo p semilato retto [km] 
p_hyp_u = a_hyp_u * (1-e_hyp_u^2); 
% Angolo tra gli asintoti 
delta_capture_Uranus = 2 * asin(1/e_hyp_u);   
delta_deg_capture_Uranus = rad2deg(delta_capture_Uranus); % in gradi 
% Ricavo l'anomalia vera f
f_hyp_u = acos((p_hyp_u-R_SOI_Uranus) / (e_hyp_u*R_SOI_Uranus)); 
f_deg_capture_Uranus = rad2deg(f_hyp_u);
cosh_F_Uranus = (e_hyp_u+cos(f_hyp_u))/(e_hyp_u*cos(f_hyp_u)+1);

% Calcolo anomalia eccentrica
F_hyp_u = log(cosh_F_Uranus+sqrt((cosh_F_Uranus)^2-1));
F_capture_deg = rad2deg(F_hyp_u);

% Trovo anomalia media M 
M_capture_Uranus = e_hyp_u*sinh(F_hyp_u)-F_hyp_u; 
M_deg_capture_Uranus = rad2deg(M_capture_Uranus);   % In gradi 

% Trovo il tempo 
t_capture_Uranus = M_capture_Uranus*sqrt(-a_hyp_u^3/mu_Uranus); %in secondi 
t_tot_capture_Uranus = t_capture_Uranus;  
t_tot_hours_capture_Uranus = t_tot_capture_Uranus/3600; 

fprintf('\n Cattura su Urano:')
fprintf('\n Raggio orbita di parcheggio (km)  = %g', Upark_radius)
fprintf('\n Velocità orbita di parcheggio (km/s) = %g', V_uranus_park)
fprintf('\n Tempo di volo nella SOI di Urano (giorni)  = %g \n', t_tot_hours_capture_Uranus/24)
fprintf('\n -----------------------------------------------------------\n')

%% Plot capture 
plot_Uranus; 
 
% Hyperbolic orbit
% Semilato retto
p_hyp_u = a_hyp_u * (1 - e_hyp_u^2);
f_deg_Uranus = acosd((p_hyp_u - R_SOI_Uranus) / (R_SOI_Uranus*e_hyp_u));
f = -f_deg_Uranus:0.1:0;
radius = 10;
color = 'b';
pos = [];
for i = 1:10:length(f)
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
        ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',2);
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
color = 'b';
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
        ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',2);
    end
    addpoints(ra, pos(1), pos(2), pos(3));
    drawnow;
end
