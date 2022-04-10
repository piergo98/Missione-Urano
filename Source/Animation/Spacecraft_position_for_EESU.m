% This script calculates a vector containing each row position of
% Dawn_spacecraft with respect to solar system

% Risolvo il problema di Lambert per tutta la missione (senza plot)
Earth_Earth_Saturn_Uranus

% Dimensioni dello spacecraft
radius = 100;
% Mu sun (km^2/s^3)
mu = 1.327*10^11; 

%% Earth to Earth
% from day (01/10/22) to (01/03/2024)
ee_days = datenum([2024 03 01]) - datenum([2022 10 01]);

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

%% Flyby orbit
% from (1/3/2024) to (3/4/2024)
% Giorni in cui lo spacecraft sta sull'orbita ottenuta dal flyby
fl_days = datenum([2024 4 3]) - datenum([2024 3 1]);

Delta_TA_fl = abs(TA_for_lambert - TA_post_flyby);
% Variazione di anomalia vera in un giorno
dTA = Delta_TA_fl/ fl_days;

h = coe_flyby(1);          % Momento angolare
e = coe_flyby(2);          % Eccentricità
RA = coe_flyby(3);         % Ascensione retta
incl = coe_flyby(4);       % Inclinazione orbita di trasferimento
w = coe_flyby(5);          % Argomento del periasse

p = h^2 / mu;           % Semilato retto

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);  

for t = 1:(fl_days)
%       Anomalia vera nel tempo
    f = dTA * t + TA_post_flyby;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t+ee_days) = Q_pX * [x y z]';
end

%% Earth to Saturn
% from (03/4/24) to (3/4/30)
es_days = datenum([2030 4 3]) - datenum([2024 4 3]);

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

for t = 1:(es_days)
%       Anomalia vera nel tempo
    f = dTA * t + TA1_es;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t+ee_days+fl_days) = Q_pX * [x y z]';
end


%% Saturn to Uranus
% from (3/4/30) to (3/4/36)
su_days = datenum([2036 4 3])- datenum([2030 4 3]);

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
    pos_spcr(:,t+ee_days+fl_days+es_days) = Q_pX * [x y z]';
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