% This script calculates a vector containing each row position of
% Dawn_spacecraft with respect to solar system

% Risolvo il problema di Lambert per tutta la missione (senza plot)
Earth_Earth_Jupiter_Uranus

% Dimensioni dello spacecraft
radius = 100;
% Mu sun (km^2/s^3)
mu = 1.327*10^11; 

%% Earth to Earth
% from day (01/10/22) to (01/03/2024)
ee_days = datenum([arrival_Earth.year arrival_Earth.month arrival_Earth.day]) - datenum([departure_Earth.year departure_Earth.month departure_Earth.day]);

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
% Giorni in cui lo spacecraft sta sull'orbita ottenuta dal flyby
fl_days = ceil(dT / days2seconds(1));

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

%% Earth to Jupiter
% from (1/8/32) to (1/8/36) (il flyby sulla terra impiega meno di un
% giorno ???
ej_days = datenum([arrival_Jupiter.year arrival_Jupiter.month arrival_Jupiter.day]) - datenum([arrival_Earth.year arrival_Earth.month arrival_Earth.day]);

Delta_TA_ej = abs(TA2_ej - TA1_ej);
%   Minima variazione di anomalia vera in un giorno
dTA = Delta_TA_ej / ej_days;

h = coe_ej(1);          % Momento angolare
e = coe_ej(2);          % Eccentricità
RA = coe_ej(3);         % Ascensione retta
incl = coe_ej(4);       % Inclinazione orbita di trasferimento
w = coe_ej(5);          % Argomento del periasse

p = h^2 / mu;       % Semilato retto    

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);

for t = 1:(ej_days)
%       Anomalia vera nel tempo
    f = dTA * t + TA1_ej;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t+ee_days+fl_days) = Q_pX * [x y z]';
end


%% Jupiter to Uranus
% from (1/8/36) to (1/12/42) (il flyby sulla terra impiega meno di un
% giorno ???
ju_days = datenum([arrival_Uranus.year arrival_Uranus.month arrival_Uranus.day])- datenum([arrival_Jupiter.year arrival_Jupiter.month arrival_Jupiter.day]);

Delta_TA_ju = abs(TA2_ju - TA1_ju);
%   Minima variazione di anomalia vera in un giorno
dTA = Delta_TA_ju / ju_days;

h = coe_ju(1);          % Momento angolare
e = coe_ju(2);          % Eccentricità
RA = coe_ju(3);         % Ascensione retta
incl = coe_ju(4);       % Inclinazione orbita di trasferimento
w = coe_ju(5);          % Argomento del periasse
a = coe_ju(7);

p = h^2 / mu;       % Semilato retto    

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);        

for t = 1:(ju_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + TA1_ju;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t+ee_days+fl_days+ej_days) = Q_pX * [x y z]';
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