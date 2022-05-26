% This script calculates a vector containing each row position of
% Dawn_spacecraft with respect to solar system

% Dimensioni dello spacecraft
radius = 100;

%% Earth to Jupiter
ej_days = datenum([2024 07 01]) - datenum([2022 07 1]);

Delta_TA_ej = abs(TA2_ej - TA1_ej);
% Variazione di anomalia vera in un giorno
dTA = Delta_TA_ej / ej_days;

h = coe_ej(1);         % Momento angolare
e = coe_ej(2);         % Eccentricità
RA = coe_ej(3);        % Ascensione retta
incl = coe_ej(4);
w = coe_ej(5);

p = h^2 / mu;       % Semilato retto    

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w); 

pos_spcr = [];

for t = 1:(ej_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + TA1_ej;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t) = Q_pX * [x y z]';
end

%% SOI Jupiter
j_soi_days = datenum([ DateVector_Jupiter(1),...
    DateVector_Jupiter(2), DateVector_Jupiter(3)]) - datenum([2024 07 01]);

TA1_j = rad2deg(coe_j(6));
[coe_j, ~, ~,  ~] = planet_elements_and_sv(5,  DateVector_Jupiter(1),...
    DateVector_Jupiter(2), DateVector_Jupiter(3), DateVector_Jupiter(4),...
    DateVector_Jupiter(5), DateVector_Jupiter(6));
TA2_j = rad2deg(coe_j(6));
Delta_TA_j_soi = abs(TA2_j - TA1_j);

% Variazione di anomalia vera in un giorno
dTA = Delta_TA_j_soi / j_soi_days;

h = coe_j_new(1);          % Momento angolare
e = coe_j_new(2);          % Eccentricità
RA = coe_j_new(3);         % Ascensione retta
incl = coe_j_new(4);       % Inclinazione orbita di trasferimento
w = coe_j_new(5);          % Argomento del periasse

p = h^2 / mu;           % Semilato retto

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);  

for t = 1:(j_soi_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + TA1_j;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t + ej_days) = Q_pX * [x y z]';
end

%% Jupiter to Saturn
js_days = datenum([2030 09 01]) - datenum([ DateVector_Jupiter(1),...
    DateVector_Jupiter(2), DateVector_Jupiter(3)]);

Delta_TA_js = abs(TA2_js + 360- TA1_js);
%   Minima variazione di anomalia vera in un giorno
dTA = Delta_TA_js / js_days;

h = coe_js(1);         % Momento angolare
e = coe_js(2);         % Eccentricità
RA = coe_js(3);        % Ascensione retta
incl = coe_js(4);
w = coe_js(5);

p = h^2 / mu;       % Semilato retto    

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);        

for t = 1:(js_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + TA1_js;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t + ej_days + j_soi_days) = Q_pX * [x y z]';
end

%% SOI Saturn
s_soi_days = datenum([ DateVector_Saturn(1),...
    DateVector_Saturn(2), DateVector_Saturn(3)]) - datenum([2030 09 01]);

TA1_s = rad2deg(coe_s(6));
[coe_s, ~, ~,  ~] = planet_elements_and_sv(6,  DateVector_Saturn(1),...
    DateVector_Saturn(2), DateVector_Saturn(3), DateVector_Saturn(4),...
    DateVector_Saturn(5), DateVector_Saturn(6));
TA2_s = rad2deg(coe_s(6));
Delta_TA_s_soi = abs(TA2_s - TA1_s);
% Variazione di anomalia vera in un giorno
dTA = Delta_TA_s_soi / s_soi_days;

h = coe_s(1);          % Momento angolare
e = coe_s(2);          % Eccentricità
RA = coe_s(3);         % Ascensione retta
incl = coe_s(4);       % Inclinazione orbita di trasferimento
w = coe_s(5);          % Argomento del periasse

p = h^2 / mu;           % Semilato retto

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);  

for t = 1:(s_soi_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + TA1_s;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t + ej_days + j_soi_days + js_days) = Q_pX * [x y z]';
end

%% Saturn  to Uranus
su_days = datenum([2035 12 25])- datenum([ DateVector_Saturn(1),...
    DateVector_Saturn(2), DateVector_Saturn(3)]); %con flyby

Delta_TA_su = abs(TA2_su + 360 - TA1_su);
%   Minima variazione di anomalia vera in un giorno
dTA = Delta_TA_su / su_days;

h = coe_su(1);         % Momento angolare
e = coe_su(2);         % Eccentricità
RA = coe_su(3);        % Ascensione retta
incl = coe_su(4);
w = coe_su(5);
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
    pos_spcr(:,t + ej_days + j_soi_days + js_days + s_soi_days) = Q_pX * [x y z]';
end
