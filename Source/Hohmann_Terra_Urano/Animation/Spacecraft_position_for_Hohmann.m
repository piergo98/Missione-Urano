% This script calculates a vector containing each row position of
% Dawn_spacecraft with respect to solar system

% Risolvo la Hohmann

% Hohmann;

% Dimensioni dello spacecraft
radius = 100;
% Mu sun (km^2/s^3)
mu = 1.327*10^11; 

%% Earth to Uranus
% from (17/7/2022) to (29/6/38)
eu_days = datenum([2038 6 29])- datenum([2022 7 17]);

% Parametri orbitali terra alla partenza
[coe_e, ~, ~, ~] = planet_elements_and_sv(3, anno_d, mese_d, giorno_d, ora_d, min_d, sec_d);

% Variazione di anomalia vera durante il trasferimento interplanetario
Delta_TA_eu = 180;     %[deg]

%   Minima variazione di anomalia vera in un giorno
dTA = Delta_TA_eu / (TOF_Hohmann * 60 * 60 * 24);

h = coe_Hohmann(1);         % Momento angolare
e = coe_Hohmann(2);         % Eccentricità
RA = coe_Hohmann(3);        % Ascensione retta
incl = coe_Hohmann(4);
w = coe_Hohmann(5);
a = coe_Hohmann(7);

p = a*(1 - e^2);    % Semilato retto    

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);        

for t = 1:((TOF_Hohmann * 60 * 60 * 24)+1)
%       Anomalia vera nel tempo
    f = dTA * t + coe_e(6);
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t) = Q_pX * [x y z]';
end

%% tests
%sanity check
%(em_days + mv_days + v_days + vc_days) - (n_days-1)


%% days

% day_left_earth	= 1;
% day_mars		= 1 + ej_days;
% day_vesta		= 1 + ej_days + js_days;
% day_left_vesta	= 1 + ej_days + js_days + v_days;
% day_ceres		= 1 + ej_days + js_days + v_days + vc_days;