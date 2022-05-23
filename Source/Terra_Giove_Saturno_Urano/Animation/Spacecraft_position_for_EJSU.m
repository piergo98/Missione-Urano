% This script calculates a vector containing each row position of
% Dawn_spacecraft with respect to solar system

% Risolvo il problema di Lambert per tutta la missione (senza plot)
Earth_Jupiter_Saturn_Uranus;

% Dimensioni dello spacecraft
radius = 100;
% Mu sun (km^2/s^3)
mu = 1.327*10^11; 

%% Earth to Jupiter
% from day 1 (01/10/22) to Jupiter arrival/departure (01/07/2024)
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


%% Jupiter to Saturn
% from (03/7/24) to (1/4/31)
js_days = datenum([2030 9 1]) - datenum([2024 7 1]);

Delta_TA_js = abs(TA2_js - TA1_js);
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
    pos_spcr(:,t+ej_days) = Q_pX * [x y z]';
end


%% Saturn  to Uranus
% from (1/4/31) to (25/12/35)
su_days = datenum([2035 12 25])- datenum([2030 9 1]);

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
    pos_spcr(:,t+ej_days+js_days) = Q_pX * [x y z]';
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