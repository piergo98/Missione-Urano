% This script calculates a vector containing each row position of 
% Dawn_spacecraft with respect to solar system 
 
% Risolvo il problema di Lambert per tutta la missione (senza plot) 
Earth_Venus_Saturn_Uranus; 
 
% Dimensioni dello spacecraft 
radius = 100; 
% Mu sun (km^2/s^3) 
%mu = 1.327*10^11;  
 
%% Earth to Venus 
ev_days = datenum([2022 04 01]) - datenum([2022 01 01]); 
 
Delta_TA_ev = abs(TA2_ev - TA1_ev); 
% Variazione di anomalia vera in un giorno 
dTA = Delta_TA_ev / ev_days; 
 
h = coe_ev(1);         % Momento angolare 
e = coe_ev(2);         % Eccentricità 
RA = coe_ev(3);        % Ascensione retta 
incl = coe_ev(4); 
w = coe_ev(5); 
 
p = h^2 / mu_Sun;       % Semilato retto     
 
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
 
 
%% Venus to Saturn 
vs_days = datenum([2028 4 1]) - datenum([2022 4 1]); 
 
Delta_TA_vs = abs(TA2_vs - TA1_vs); 
%   Minima variazione di anomalia vera in un giorno 
dTA = Delta_TA_vs / vs_days; 
 
h = coe_vs(1);         % Momento angolare 
e = coe_vs(2);         % Eccentricità 
RA = coe_vs(3);        % Ascensione retta 
incl = coe_vs(4); 
w = coe_vs(5); 
 
p = h^2 / mu_Sun;       % Semilato retto     
 
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
    pos_spcr(:,t+ev_days) = Q_pX * [x y z]'; 
end 
 
 
%% Saturn  to Uranus 
su_days = datenum([2033 12 25])- datenum([2028 4 1]); 
 
Delta_TA_su = abs(TA2_su - TA1_su); 
%   Minima variazione di anomalia vera in un giorno 
dTA = Delta_TA_su / su_days; 
 
h = coe_su(1);         % Momento angolare 
e = coe_su(2);         % Eccentricità 
RA = coe_su(3);        % Ascensione retta 
incl = coe_su(4); 
w = coe_su(5); 
a = coe_su(7); 
 
p = h^2 / mu_Sun;       % Semilato retto     
 
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
    pos_spcr(:,t+ev_days+vs_days) = Q_pX * [x y z]'; 
end 
