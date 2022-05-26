% This script calculates a vector containing each row position of 
% Dawn_spacecraft with respect to solar system 
 
% Dimensioni dello spacecraft 
radius = 100; 
 
%% Earth to Mars 
em_days = datenum([2028 10 01]) - datenum([2027 05 01]); 
  
Delta_TA_em = abs(TA2_em + 360 - TA1_em); 
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
    %f = 2*dTA * t + TA1_mj;
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
    DateVector_Mars(2), DateVector_Mars(3)]) - datenum([2028 10 01]);

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

%% Mars to Jupiter 
mj_days = datenum([2032 07 01]) - datenum([ DateVector_Mars(1),...
    DateVector_Mars(2), DateVector_Mars(3)]);
 
Delta_TA_mj = abs(TA2_mj - TA1_mj); 
%   Minima variazione di anomalia vera in un giorno 
dTA = Delta_TA_mj / mj_days; 
 
h = coe_mj(1);          % Momento angolare 
e = coe_mj(2);          % Eccentricità 
RA = coe_mj(3);         % Ascensione retta 
incl = coe_mj(4);       % Inclinazione orbita di trasferimento 
w = coe_mj(5);          % Argomento del periasse 
 
p = h^2 / mu;       % Semilato retto     
 
% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D 
% il centro è sempre il sole 
Q_pX = perifocal2helio(RA, incl, w); 
 
for t = 1:(mj_days) 
%       Anomalia vera nel tempo 
    f = dTA * t + TA1_mj; 
%       Legge oraria dello spacecraft in funzione dell'anomalia vera 
    r = p / (1 + e*cosd(f)); 
%       Converto in coordinate cartesiane 
    x = r*cosd(f); 
    y = r*sind(f); 
    z = 0; 
%       Cambio di coordinate il vettore posizione 
    pos_spcr(:,t+em_days+m_soi_days) = Q_pX * [x y z]'; 
end 

%% SOI Jupiter
j_soi_days = datenum([ DateVector_Jupiter(1),...
    DateVector_Jupiter(2), DateVector_Jupiter(3)]) - datenum([2032 07 01]);

TA1_j = rad2deg(coe_j(6));
[coe_j, ~, ~,  ~] = planet_elements_and_sv(5,  DateVector_Jupiter(1),...
    DateVector_Jupiter(2), DateVector_Jupiter(3), DateVector_Jupiter(4),...
    DateVector_Jupiter(5), DateVector_Jupiter(6));
TA2_j = rad2deg(coe_j(6));
Delta_TA_j_soi = abs(TA2_j - TA1_j);
% Variazione di anomalia vera in un giorno
dTA = Delta_TA_j_soi / j_soi_days;

h = coe_j(1);          % Momento angolare
e = coe_j(2);          % Eccentricità
RA = coe_j(3);         % Ascensione retta
incl = coe_j(4);       % Inclinazione orbita di trasferimento
w = coe_j(5);          % Argomento del periasse

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
    pos_spcr(:,t + em_days + m_soi_days + mj_days) = Q_pX * [x y z]';
end

%% Jupiter to Uranus 
ju_days = datenum([2038 07 01])- datenum([ DateVector_Jupiter(1),...
    DateVector_Jupiter(2), DateVector_Jupiter(3)]); %con flyby
 
Delta_TA_ju = abs(TA2_ju+360 - TA1_ju); 
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
    pos_spcr(:,t + em_days+ m_soi_days + mj_days + j_soi_days) = Q_pX * [x y z]'; 
end  