% This script calculates a vector containing each row position of 
% Dawn_spacecraft with respect to solar system 
 
% Risolvo il problema di Lambert per tutta la missione (senza plot) 
%Earth_Venus_Saturn_Uranus; 
 
% Dimensioni dello spacecraft 
radius = 100; 
 
%% Earth to Venus 
ev_days = datenum([2022 04 01 12 00 00]) - datenum([2022 01 01 12 00 00]); 
 
Delta_TA_ev = abs(TA2_ev+360 - TA1_ev); 
% Variazione di anomalia vera in un giorno 
dTA = Delta_TA_ev / ev_days; 
 
h = coe_ev(1);         % Momento angolare 
e = coe_ev(2);         % Eccentricità 
RA = coe_ev(3);        % Ascensione retta 
incl = coe_ev(4); 
w = coe_ev(5); 
 
p = h^2 / mu;       % Semilato retto     
 
% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D 
% il centro è sempre il sole 
Q_pX = perifocal2helio(RA, incl, w);  
 
pos_spcr = []; 
 
for t = 1:(ev_days+1) 
%       Anomalia vera nel tempo 
    f = dTA * t + TA1_ev; 
%       Legge oraria dello spacecraft in funzione dell'anomalia vera 
    r = p / (1 + e*cosd(f)); 
%       Converto in coordinate cartesiane 
    x = r*cosd(f); 
    y = r*sind(f); 
    z = 0; 
%       Cambio di coordinate il vettore posizione 
    pos_spcr(:,t) = Q_pX * [x y z]'; 
end 
 
%% SOI Venus
v_soi_days = datenum([DateVector_Venus(1) DateVector_Venus(2) DateVector_Venus(3)]) -...
    datenum([2022 04 01]);

[coe_v, r2_v, v2_v, ~] = planet_elements_and_sv(2, 2022, 04, 01, 12, 00, 00);
TA1_v = rad2deg(coe_v(6));
[coe_v, ~, ~,  ~] = planet_elements_and_sv(2, DateVector_Venus(1), DateVector_Venus(2), ...
    DateVector_Venus(3), DateVector_Venus(4), DateVector_Venus(5), DateVector_Venus(6));
TA2_v = rad2deg(coe_v(6));
Delta_TA_v_soi = abs(TA2_v - TA1_v);

% Variazione di anomalia vera in un giorno
dTA = Delta_TA_v_soi / v_soi_days;

h = coe_v_new(1);          % Momento angolare
e = coe_v_new(2);          % Eccentricità
RA = coe_v_new(3);         % Ascensione retta
incl = coe_v_new(4);       % Inclinazione orbita di trasferimento
w = coe_v_new(5);          % Argomento del periasse

p = h^2 / mu;           % Semilato retto

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);  

for t = 1:(v_soi_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + TA1_v;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t + ev_days) = Q_pX * [x y z]';
end 

%% Venus to Saturn 
vs_days = datenum([2028 1 1]) -...
    datenum([DateVector_Venus(1) DateVector_Venus(2) DateVector_Venus(3)]); 
 
Delta_TA_vs = abs(TA2_vs - TA1_vs); 
%   Minima variazione di anomalia vera in un giorno 
dTA = Delta_TA_vs / vs_days; 
 
h = coe_vs(1);         % Momento angolare 
e = coe_vs(2);         % Eccentricità 
RA = coe_vs(3);        % Ascensione retta 
incl = coe_vs(4); 
w = coe_vs(5); 
 
p = h^2 / mu;       % Semilato retto     
 
% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D 
% il centro è sempre il sole 
Q_pX = perifocal2helio(RA, incl, w);         
 
for t = 1:(vs_days+1) 
%       Anomalia vera nel tempo 
    f = dTA * t + TA1_vs; 
%       Legge oraria dello spacecraft in funzione dell'anomalia vera 
    r = p / (1 + e*cosd(f)); 
%       Converto in coordinate cartesiane 
    x = r*cosd(f); 
    y = r*sind(f); 
    z = 0; 
%       Cambio di coordinate il vettore posizione 
     pos_spcr(:,t+ev_days+v_soi_days) = Q_pX * [x y z]';
end 
 
%% SOI Saturn
s_soi_days = datenum([DateVector_Saturn(1), DateVector_Saturn(2), DateVector_Saturn(3)]) - ...
    datenum([2028 01 01]);

[coe_s,  ~,  ~, ~] = planet_elements_and_sv(6, 2028, 01, 01, 12, 00, 00);
TA1_s = rad2deg(coe_s(6));
[coe_s, ~, ~,  ~] = planet_elements_and_sv(6, DateVector_Saturn(1), DateVector_Saturn(2), ...
    DateVector_Saturn(3), DateVector_Saturn(4), DateVector_Saturn(5), DateVector_Saturn(6));
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

%pos_spcr = [];

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
    pos_spcr(:,t + ev_days + v_soi_days + vs_days) = Q_pX * [x y z]';
end
 
%% Saturn  to Uranus 
su_days = datenum([2033 12 25])-...
    datenum([DateVector_Saturn(1), DateVector_Saturn(2), DateVector_Saturn(3)]); 
 
Delta_TA_su = abs(TA2_su - TA1_su); 
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
    pos_spcr(:,t + ev_days + v_soi_days + vs_days + s_soi_days) = Q_pX * [x y z]'; 
end 
