% This script calculates a vector containing each row position of
% Dawn_spacecraft with respect to solar system

% Risolvo la Hohmann

 Hohmann;

% Dimensioni dello spacecraft
radius = 100;
% Mu sun (km^2/s^3)
mu = 1.327*10^11; 

%% Earth to Uranus

eu_days = TOF_Hohmann / (24*3600);

% Parametri orbitali terra alla partenza
[coe_e, ~, ~, ~] = planet_elements_and_sv(3, anno_d, mese_d, giorno_d, ora_d, min_d, sec_d);

% Parametri orbitali di urano all'arrivo
[coe_u, ~, ~, ~] = planet_elements_and_sv(7, anno_a, mese_a, giorno_a, ora_a, min_a, sec_a);

% Variazione di anomalia vera durante il trasferimento interplanetario
Delta_TA_eu = rad2deg(coe_u(6) - coe_e(6));     %[deg]

% Minima variazione di anomalia vera in un giorno
%dTA = Delta_TA_eu / (TOF_Hohmann * 60 * 60 * 24);
dTA = Delta_TA_eu / eu_days;

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

%%
pos_spcr = [];

%%
%for t = 1:((TOF_Hohmann * 60 * 60 * 24)+1)
for t = 1:1:(eu_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + rad2deg(coe_e(6));
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t) = Q_pX * [x y z]';
end
