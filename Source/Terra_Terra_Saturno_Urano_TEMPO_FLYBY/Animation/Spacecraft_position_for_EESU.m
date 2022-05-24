% This script calculates a vector containing each row position of
% Dawn_spacecraft with respect to solar system

% Risolvo il problema di Lambert per tutta la missione (senza plot)
radius = 100; 

%% Earth to Earth
%ee_days = datenum([2024 03 01]) - datenum([2022 10 01]);
ee_days = datenum([2024 08 01]) - datenum([2023 3 01]);

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

%% SOI Earth
e_soi_days = datenum([DateVector_Earth(1) DateVector_Earth(2) DateVector_Earth(3)]) - datenum([2024 08 01]);

Delta_TA_e_soi = abs(TA2_e_soi - TA2_ee);
% Variazione di anomalia vera in un giorno
dTA = Delta_TA_e_soi / e_soi_days;

h = coe_e2_new(1);          % Momento angolare
e = coe_e2_new(2);          % Eccentricità
RA = coe_e2_new(3);         % Ascensione retta
incl = coe_e2_new(4);       % Inclinazione orbita di trasferimento
w = coe_e2_new(5);          % Argomento del periasse

p = h^2 / mu;           % Semilato retto

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);  

for t = 1:(e_soi_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + TA2_ee;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t + ee_days) = Q_pX * [x y z]';
end

%% Earth to Saturn
%es_days = datenum([2030 04 03]) - datenum([2024 03 01]); %vecchio
%es_days = datenum([2030 08 01]) - datenum([2024 8 1]);

%versione con tempo flyby
%es_days = datenum([2030 08 01]) - datenum([2024 8 2]);
es_days = datenum([2030 08 01]) - datenum([DateVector_Earth(1),...
    DateVector_Earth(2), DateVector_Earth(3)]);

%Delta_TA_es = abs(TA2_es - TA1_es);
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
%    pos_spcr(:,t+ee_days) = Q_pX * [x y z]';
     pos_spcr(:,t+ee_days+e_soi_days) = Q_pX * [x y z]';
end

%% SOI Saturn
s_soi_days = datenum([DateVector_Saturn(1) DateVector_Saturn(2) DateVector_Saturn(3)]) - datenum([2030 08 01]);

Delta_TA_s_soi = abs(TA2_s_soi - TA2_es);
% Variazione di anomalia vera in un giorno
dTA = Delta_TA_s_soi / s_soi_days;

h = coe_s_new(1);          % Momento angolare
e = coe_s_new(2);          % Eccentricità
RA = coe_s_new(3);         % Ascensione retta
incl = coe_s_new(4);       % Inclinazione orbita di trasferimento
w = coe_s_new(5);          % Argomento del periasse
% h = coe_s_SOI(1);          % Momento angolare
% e = coe_s_SOI(2);          % Eccentricità
% RA = coe_s_SOI(3);         % Ascensione retta
% incl = coe_s_SOI(4);       % Inclinazione orbita di trasferimento
% w = coe_s_SOI(5);          % Argomento del periasse

p = h^2 / mu;           % Semilato retto

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);  

%pos_spcr = [];

for t = 1:(s_soi_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + TA2_es;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t + ee_days + e_soi_days + es_days) = Q_pX * [x y z]';
end

%% Saturn to Uranus
%su_days = datenum([2036 04 03])- datenum([2030 04 03]); %vecchio
%su_days = datenum([2036 08 01])- datenum([2030 08 01]); 
su_days = datenum([2036 08 01])- datenum([DateVector_Saturn(1),...
    DateVector_Saturn(2), DateVector_Saturn(3)]); %con flyby

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
%    pos_spcr(:,t+ee_days+es_days) = Q_pX * [x y z]';
    pos_spcr(:,t + ee_days + e_soi_days + es_days + s_soi_days) = Q_pX * [x y z]'; %con flyby
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