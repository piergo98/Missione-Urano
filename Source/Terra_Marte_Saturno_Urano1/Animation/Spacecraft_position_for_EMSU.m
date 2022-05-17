% This script calculates a vector containing each row position of 
% Dawn_spacecraft with respect to solar system 
 
% Risolvo il problema di Lambert per tutta la missione (senza plot) 
%Earth_Mars_Saturn_Uranus 
 
% Dimensioni dello spacecraft 
radius = 100; 
% Mu sun (km^2/s^3) 
%mu = 1.327*10^11;  
 
%% Earth to Mars 
em_days = datenum([2023 10 01]) - datenum([2022 09 01]); 
 
 
Delta_TA_em = abs(TA2_em - TA1_em); 
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
 
for t = 1:(em_days) 
%       Anomalia vera nel tempo 
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
 
%% Flyby orbit 
% Giorni in cui lo spacecraft sta sull'orbita ottenuta dal flyby 
[years, months, days, hours, minutes, seconds] = sec2date(dT_post_flyby);
fl_days = days + (months * 30);

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
    pos_spcr(:,t+em_days) = Q_pX * [x y z]'; 
end 
 
%% Mars to Saturn 
ms_days = datenum([2028 10 01]) - datenum([2023 10 17]); 
 
Delta_TA_ms = abs(TA2_ms - TA1_ms); 
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
    f = dTA * t + TA1_ms; 
%       Legge oraria dello spacecraft in funzione dell'anomalia vera 
    r = p / (1 + e*cosd(f)); 
%       Converto in coordinate cartesiane 
    x = r*cosd(f); 
    y = r*sind(f); 
    z = 0; 
%       Cambio di coordinate il vettore posizione 
%    pos_spcr(:,t+ee_days+fl_days) = Q_pX * [x y z]'; %vecchio 
    pos_spcr(:,t+em_days+fl_days) = Q_pX * [x y z]'; 
end 
 
 
%% Saturn to Uranus 
su_days = datenum([2034 10 01])- datenum([2028 10 01]); 
 
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
    pos_spcr(:,t+em_days+fl_days+ms_days) = Q_pX * [x y z]'; 
end 
 