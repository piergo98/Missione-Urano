% This script calculates a vector containing each row position of
% Dawn_spacecraft with respect to solar system

% Risolvo il problema di Lambert per tutta la missione (senza plot)
Earth_Earth_Saturn_Uranus

% Dimensioni dello spacecraft
radius = 100;
% Mu sun (km^2/s^3)
mu = 1.327*10^11; 

%% Earth to Earth
% from day (01/3/23) to (01/08/2024)
%ee_days = datenum([2024 03 01]) - datenum([2022 10 01]);
ee_days = datenum([arrival_Earth.year arrival_Earth.month arrival_Earth.day]) - ...
    datenum([departure_Earth.year departure_Earth.month departure_Earth.day]);


Delta_TA_ee = abs(TA2_ee - TA1_ee);
% Variazione di anomalia vera in un giorno
dTA = Delta_TA_ee / ee_days;

h = coe_ee(1);          % Momento angolare
e = coe_ee(2);          % Eccentricità
RA = coe_ee(3);         % Ascensione retta
incl = coe_ee(4);       % Inclinazione orbita di trasferimento
w = coe_ee(5);          % Argomento del periasse

p = h^2 / mu;           % Semilato retto

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);  

pos_spcr = [];

for t = 1:(ee_days+1)
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

%% Earth to Saturn
% from (01/8/24) to (1/8/30)
%es_days = datenum([2030 04 03]) - datenum([2024 03 01]); %vecchio
es_days = datenum([arrival_Saturn.year arrival_Saturn.month arrival_Saturn.day]) - ...
    datenum([arrival_Earth.year arrival_Earth.month arrival_Earth.day]);

Delta_TA_es = abs(TA2_es - TA1_es);
%   Minima variazione di anomalia vera in un giorno
dTA = Delta_TA_es / es_days;

h = coe_es(1);          % Momento angolare
e = coe_es(2);          % Eccentricità
RA = coe_es(3);         % Ascensione retta
incl = coe_es(4);       % Inclinazione orbita di trasferimento
w = coe_es(5);          % Argomento del periasse

p = h^2 / mu;       % Semilato retto    

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);

for t = 1:(es_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + TA1_es;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
%    pos_spcr(:,t+ee_days+fl_days) = Q_pX * [x y z]'; %vecchio
    pos_spcr(:,t+ee_days) = Q_pX * [x y z]';
end


%% Saturn to Uranus
% from (1/8/30) to (1/8/36)
%su_days = datenum([2036 04 03])- datenum([2030 04 03]); %vecchio
su_days = datenum([arrival_Uranus.year arrival_Uranus.month arrival_Uranus.day])- ...
    datenum([arrival_Saturn.year arrival_Saturn.month arrival_Saturn.day]);

Delta_TA_su = abs(TA2_su - TA1_su);
%   Minima variazione di anomalia vera in un giorno
dTA = Delta_TA_su / su_days;

h = coe_su(1);          % Momento angolare
e = coe_su(2);          % Eccentricità
RA = coe_su(3);         % Ascensione retta
incl = coe_su(4);       % Inclinazione orbita di trasferimento
w = coe_su(5);          % Argomento del periasse
a = coe_su(7);

p = h^2 / mu;       % Semilato retto    

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);        

for t = 1:(su_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + TA1_su;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
%    pos_spcr(:,t+ee_days+fl_days+es_days) = Q_pX * [x y z]'; %vecchia
    pos_spcr(:,t+ee_days+es_days) = Q_pX * [x y z]';
end

%% tests
%sanity check
%(em_days + mv_days + v_days + vc_days) - (n_days-1);


%% days

% day_left_earth	= 1;
% day_mars		= 1 + ej_days;
% day_vesta		= 1 + ej_days + js_days;
% day_left_vesta	= 1 + ej_days + js_days + v_days;
% day_ceres		= 1 + ej_days + js_days + v_days + vc_days;