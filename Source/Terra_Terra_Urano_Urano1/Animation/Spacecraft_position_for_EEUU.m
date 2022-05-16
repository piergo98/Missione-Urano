% This script calculates a vector containing each row position of
% Dawn_spacecraft with respect to solar system

% Risolvo il problema di Lambert per tutta la missione (senza plot)
Earth_Earth_Uranus_Uranus;

% Dimensioni dello spacecraft
radius = 100;
% Mu sun (km^2/s^3)
%mu = 1.327*10^11; 

%% Earth to Earth
ee_days = datenum([2023 01 01]) - datenum([2022 06 01]);


Delta_TA_ee = abs(TA2_ee - TA1_ee);
% Variazione di anomalia vera in un giorno
dTA = Delta_TA_ee / ee_days;

h = coe_ee(1);          % Momento angolare
e = coe_ee(2);          % Eccentricità
RA = coe_ee(3);         % Ascensione retta
incl = coe_ee(4);       % Inclinazione orbita di trasferimento
w = coe_ee(5);          % Argomento del periasse

p = h^2 / mu_Sun;           % Semilato retto

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);  

pos_spcr = [];

for t = 1:(ee_days)
%       Anomalia vera nel tempo
    f = dTA * t + TA1_ee;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t) = Q_pX * [x y z]';
end

%% Earth to Uranus
eu1_days = datenum([2039 1 1]) - datenum([2023 1 1]);

Delta_TA_eu1 = abs(TA2_eu1 - TA1_eu1);
%   Minima variazione di anomalia vera in un giorno
dTA = Delta_TA_eu1 / eu1_days;

h = coe_eu1(1);          % Momento angolare
e = coe_eu1(2);          % Eccentricità
RA = coe_eu1(3);         % Ascensione retta
incl = coe_eu1(4);       % Inclinazione orbita di trasferimento
w = coe_eu1(5);          % Argomento del periasse

p = h^2 / mu_Sun;       % Semilato retto    

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);

for t = 1:(eu1_days)
%       Anomalia vera nel tempo
    f = dTA * t + TA1_eu1;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
%    pos_spcr(:,t+ee_days+fl_days) = Q_pX * [x y z]'; %vecchio
    pos_spcr(:,t+eu1_days) = Q_pX * [x y z]';
end


%% Uranus to Uranus
u1u2_days = datenum([2040 1 1]) - datenum([2039 1 1]);

Delta_TA_u1u2 = abs(TA2_u1u2 - TA1_u1u2);
% Variazione di anomalia vera in un giorno
dTA = Delta_TA_u1u2 / u1u2_days;

h = coe_u1u2(1);          % Momento angolare
e = coe_u1u2(2);          % Eccentricità
RA = coe_u1u2(3);         % Ascensione retta
incl = coe_u1u2(4);       % Inclinazione orbita di trasferimento
w = coe_u1u2(5);          % Argomento del periasse

p = h^2 / mu_Sun;           % Semilato retto

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);  

pos_spcr = [];

for t = 1:(u1u2_days)
%       Anomalia vera nel tempo
    f = dTA * t + TA1_u1u2;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t) = Q_pX * [x y z]';
end
