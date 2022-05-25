% This script calculates a vector containing each row position of 
% Dawn_spacecraft with respect to solar system 

% Dimensioni dello spacecraft 
radius = 100; 
 
%% Earth to Mars 
em_days = datenum([2023 10 01]) - datenum([2022 09 01]); 
 
Delta_TA_em = abs(TA2_em +360 - TA1_em); 
% Variazione di anomalia vera in un giorno 
dTA = Delta_TA_em / em_days; 
 
h = coe_em(1);          % Momento angolare 
e = coe_em(2);          % Eccentricità 
RA = coe_em(3);         % Ascensione retta 
incl = coe_em(4);       % Inclinazione orbita di trasferimento 
w = coe_em(5);          % Argomento del periasse 
 
p = h^2 / mu;           % Semilato retto 
 
% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D 
% il centro è sempre il sole 
Q_pX = perifocal2helio(RA, incl, w);   
 
pos_spcr = []; 
 
for t = 1:(em_days+1) 
%       Anomalia vera nel tempo 
    %f = 1.7*dTA * t + TA1_em; 
    f = dTA * t + TA1_em; 
%       Legge oraria dello spacecraft in funzione dell'anomalia vera 
    r = p / (1 + e*cosd(f)); 
%       Converto in coordinate cartesiane 
    x = r*cosd(f); 
    y = r*sind(f); 
    z = 0; 
%       Cambio di coordinate il vettore posizione 
    pos_spcr(:,t) = Q_pX * [x y z]'; 
end 
 
%% SOI Mars
m_soi_days = datenum([ DateVector_Mars(1),...
    DateVector_Mars(2), DateVector_Mars(3)]) - datenum([2023 10 01]);

TA1_m = rad2deg(coe_m(6));
[coe_m, ~, ~,  ~] = planet_elements_and_sv(4,  DateVector_Mars(1),...
    DateVector_Mars(2), DateVector_Mars(3), DateVector_Mars(4),...
    DateVector_Mars(5), DateVector_Mars(6));
TA2_m = rad2deg(coe_m(6));
Delta_TA_m_soi = abs(TA2_m - TA1_m);

% Variazione di anomalia vera in un giorno
dTA = Delta_TA_m_soi / m_soi_days;

h = coe_m_new(1);          % Momento angolare
e = coe_m_new(2);          % Eccentricità
RA = coe_m_new(3);         % Ascensione retta
incl = coe_m_new(4);       % Inclinazione orbita di trasferimento
w = coe_m_new(5);          % Argomento del periasse

p = h^2 / mu;           % Semilato retto

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = perifocal2helio(RA, incl, w);  

for t = 1:(m_soi_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + TA1_m;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t + em_days) = Q_pX * [x y z]';
end

%% Mars to Saturn 
ms_days = datenum([2028 11 01]) - datenum([ DateVector_Mars(1),...
    DateVector_Mars(2), DateVector_Mars(3)]);

Delta_TA_ms = abs(TA2_ms+360 - TA1_ms); 
%   Minima variazione di anomalia vera in un giorno 
dTA = Delta_TA_ms / ms_days; 
 
h = coe_ms(1);          % Momento angolare 
e = coe_ms(2);          % Eccentricità 
RA = coe_ms(3);         % Ascensione retta 
incl = coe_ms(4);       % Inclinazione orbita di trasferimento 
w = coe_ms(5);          % Argomento del periasse 
 
p = h^2 / mu;       % Semilato retto     
 
% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D 
% il centro è sempre il sole 
Q_pX = perifocal2helio(RA, incl, w); 
 
for t = 1:(ms_days) 
%       Anomalia vera nel tempo 
    %f = 1.07*dTA * t + TA1_ms; 
    f = dTA * t + TA1_ms;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera 
    r = p / (1 + e*cosd(f)); 
%       Converto in coordinate cartesiane 
    x = r*cosd(f); 
    y = r*sind(f); 
    z = 0; 
%       Cambio di coordinate il vettore posizione 
    pos_spcr(:,t+em_days+m_soi_days) = Q_pX * [x y z]'; 
end 
 
%% SOI Saturn
s_soi_days = datenum([ DateVector_Saturn(1),...
    DateVector_Saturn(2), DateVector_Saturn(3)]) - datenum([2028, 11, 01]);

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
    pos_spcr(:,t + em_days + m_soi_days + ms_days) = Q_pX * [x y z]';
end

%% Saturn to Uranus 
su_days = datenum([2034 11 01])- datenum([ DateVector_Saturn(1),...
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
    pos_spcr(:,t + em_days + m_soi_days + ms_days + s_soi_days) = Q_pX * [x y z]'; 
end 
 