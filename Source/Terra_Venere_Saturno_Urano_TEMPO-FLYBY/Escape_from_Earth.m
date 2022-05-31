%% COMPUTE THE ANGLE AND TRAJECTORY TO THE ESCAPE FROM EARTH SOI

% Recupero dati Terra
% Earth_Earth_Saturn_Uranus;
v_infp_escape_Earth = v1_l_e1 - v1_e1;   % Differenza fra velocità necessaria per Lambert e velocità del pianeta    
v_infp_escape_Earth_mod = norm(v_infp_escape_Earth);  % In norma

% Raggio orbita di parcheggio intorno alla Terra(km)
r_orbit = r_Earth + Epark_radius;
% Velocità sull'orbita di parcheggio (km/s)
V_park_e = sqrt(mu_Earth/r_orbit);    
% Semiasse maggiore
a_escape_Earth = - mu_Earth / v_infp_escape_Earth_mod^2;
% Eccentricità traiettoria di Escape
e_escape_Earth = 1 - (r_orbit/a_escape_Earth);  
% Trovo p semilato retto [km] 
p_escape_Earth = a_escape_Earth * (1-e_escape_Earth^2); 
% Angolo tra gli asintoti 
delta_escape_Earth = 2 * asin(1/e_escape_Earth);   
delta_deg_escape_Earth = rad2deg(delta_escape_Earth); % in gradi 
% Ricavo l'anomalia vera f
f_escape_Earth = acos((p_escape_Earth-R_SOI_Earth) / (e_escape_Earth*R_SOI_Earth)); 
f_deg_escape_Earth = rad2deg(f_escape_Earth);
cosh_F_Earth = (e_escape_Earth+cos(f_escape_Earth))/(e_escape_Earth*cos(f_escape_Earth)+1);

% Velocità al perigeo dell'iperbole
V_escape_perigee = sqrt(v_infp_escape_Earth_mod^2 + (2*mu_Earth/r_orbit));
% Delta V
deltaV_escape_Earth = V_escape_perigee - V_park_e;

% Calcolo anomalia eccentrica
F_escape_Earth = log(cosh_F_Earth+sqrt((cosh_F_Earth)^2-1));
F_escape_deg = rad2deg(F_escape_Earth);

% Trovo anomalia media M 
M_escape_Earth = e_escape_Earth*sinh(F_escape_Earth)-F_escape_Earth; 
M_deg_escape_Earth = rad2deg(M_escape_Earth);   % In gradi 

% Trovo il tempo 
t_escape_Earth = M_escape_Earth*sqrt(-a_escape_Earth^3/mu_Earth); %in secondi 
t_tot_escape_Earth = t_escape_Earth;  
t_tot_hours_escape_Earth = t_tot_escape_Earth/3600; 

fprintf('\n Fuga dalla Terra:')
fprintf('\n Raggio orbita di parcheggio = %g (km)', Epark_radius)
fprintf('\n Velocità orbita di parcheggio = %g (km/s)\n', V_park_e)
fprintf('\n Tempo di fuga dalla Terra = %g (giorni)\n', t_tot_hours_escape_Earth/24)
fprintf('\n -----------------------------------------------------------\n')

%% Plot escape
% Plot planet
plot_Earth;

% Circular parking orbit
f = 0:1:360;
% Semilato retto
p_earth_park = r_orbit;
% Eccentricity
e_earth_park = 0;
color = 'r';
pos = [];
for i = 1:length(f)
%   Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p_earth_park / (1 + e_earth_park*cosd(f(i)));
%       Converto in coordinate cartesiane
    x = r*cosd(f(i));
    y = r*sind(f(i));
    z = 0;
%   Cambio di coordinate il vettore posizione per plottarlo
    Q_pX = perifocal2helio(0, 0, 0);
    pos = Q_pX * [x y z]';
    if i == 1 
        ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',3);
    end
    addpoints(ra, pos(1), pos(2), pos(3));
    drawnow;
end

% Hyperbolic orbit
% Semilato retto
f = 0:0.1:f_deg_escape_Earth;
color = 'b';
pos = [];
for i = 1:length(f)
%   Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p_escape_Earth / (1 + e_escape_Earth*cosd(f(i)));
%       Converto in coordinate cartesiane
    x = r*cosd(f(i));
    y = r*sind(f(i));
    z = 0;
%   Cambio di coordinate il vettore posizione per plottarlo
    Q_pX = perifocal2helio(0, 0, 0);
    pos = Q_pX * [x y z]';

    if i == 1
        ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',3);
    end
    addpoints(ra, pos(1), pos(2), pos(3));
    drawnow;
end

