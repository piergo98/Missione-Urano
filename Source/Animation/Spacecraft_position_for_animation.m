% This script calculates a vector containing each row position of
% Dawn_spacecraft with respect to solar system

% Risolvo il problema di Lambert per tutta la missione (senza plot)
LambertTotale

% Dimensioni dello spacecraft
radius = 100;
% Mu sun (km^2/s^3)
mu = 1.327*10^11; 

%% Earth to Jupiter
% from day 1 (01/7/22) to Jupiter arrival/departure (01/07/2024)
ej_days = datenum([2024 07 01]) - datenum([2022 07 01]);

Delta_TA_ej = abs(TA_final_j - TA_init_e);
% Variazione di anomalia vera in un giorno
dTA = Delta_TA_ej / ej_days;

h = coe_ej(1);          % Momento angolare
e = coe_ej(2);          % Eccentricità
RA = coe_ej(3);         % Ascensione retta
incl = coe_ej(4);       % Inclinazione orbita di trasferimento
w = coe_ej(5);          % Argomento del periasse

p = h^2 / mu;       % Semilato retto    

% Rotazione rispetto a Z dell'ascensione retta
R3_W = [ cos(RA)  sin(RA)  0
        -sin(RA)  cos(RA)  0
            0        0     1];

% Rotazione rispetto a X dell'inclinazione dell'orbita
R1_i = [1       0          0
        0   cos(incl)  sin(incl)
        0  -sin(incl)  cos(incl)];

% Rotazione attorno a Z dell'argomento del periasse
R3_w = [ cos(w)  sin(w)  0 
        -sin(w)  cos(w)  0
           0       0     1];

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = (R3_w*R1_i*R3_W)';        


pos_spcr = [];

for t = 1:(ej_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + TA_init_e;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t) = Q_pX * [x y z]';
end

%% Stay with Jupiter
% Duration of the flyby
j_days = datenum([2024 7 1]) - datenum([2024 7 1]);
% Variation of true anomaly
Delta_TA_j = abs(coe1_j(6) - coe2_j(6));
% Minimum variation
dTA = Delta_TA_j / j_days;

% Extraction of orbital elements
h = coe1_j(1);
e = coe1_j(2);
RA = coe1_j(3);
incl = coe1_j(4);
w = coe1_j(5);

% Semilato retto
p = h^2 / mu;

% Rotazione rispetto a Z dell'ascensione retta
R3_W = [ cos(RA)  sin(RA)  0
        -sin(RA)  cos(RA)  0
            0        0     1];

% Rotazione rispetto a X dell'inclinazione dell'orbita
R1_i = [1       0          0
        0   cos(incl)  sin(incl)
        0  -sin(incl)  cos(incl)];

% Rotazione attorno a Z dell'argomento del periasse
R3_w = [ cos(w)  sin(w)  0 
        -sin(w)  cos(w)  0
           0       0     1];

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = (R3_w*R1_i*R3_W)';

for t = 1:(js_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + coe2_j(6);
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t+ej_days) = Q_pX * [x y z]';
end

%% Jupiter to Saturn
% from (03/7/24) to (1/4/31)
js_days = datenum([2031 4 1]) - datenum([2024 7 1]);

Delta_TA_js = abs(TA_final_s - TA_init_j);
% Minima variazione di anomalia vera in un giorno
dTA = Delta_TA_js / js_days;

h = coe_js(1);          % Momento angolare
e = coe_js(2);          % Eccentricità
RA = coe_js(3);         % Ascensione retta
incl = coe_js(4);       % Inclinazione orbita di trasferimento
w = coe_js(5);          % Argomento del periasse

p = h^2 / mu;       % Semilato retto    

% Rotazione rispetto a Z dell'ascensione retta
R3_W = [ cos(RA)  sin(RA)  0
        -sin(RA)  cos(RA)  0
            0        0     1];

% Rotazione rispetto a X dell'inclinazione dell'orbita
R1_i = [1       0          0
        0   cos(incl)  sin(incl)
        0  -sin(incl)  cos(incl)];

% Rotazione attorno a Z dell'argomento del periasse
R3_w = [ cos(w)  sin(w)  0 
        -sin(w)  cos(w)  0
           0       0     1];

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = (R3_w*R1_i*R3_W)';        

for t = 1:(js_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + TA_init_j;
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
su_days = datenum([2035 12 25])- datenum([2031 4 1]);

Delta_TA_su = abs(TA_final_u - TA_init_s);
%   Minima variazione di anomalia vera in un giorno
dTA = Delta_TA_su / su_days;

h = coe_su(1);          % Momento angolare
e = coe_su(2);          % Eccentricità
RA = coe_su(3);         % Ascensione retta
incl = coe_su(4);       % Inclinazione orbita di trasferimento
w = coe_su(5);          % Argomento del periasse
a = coe_su(7);

p = h^2 / mu;       % Semilato retto    

% Rotazione rispetto a Z dell'ascensione retta
R3_W = [ cos(RA)  sin(RA)  0
        -sin(RA)  cos(RA)  0
            0        0     1];

% Rotazione rispetto a X dell'inclinazione dell'orbita
R1_i = [1       0          0
        0   cos(incl)  sin(incl)
        0  -sin(incl)  cos(incl)];

% Rotazione attorno a Z dell'argomento del periasse
R3_w = [ cos(w)  sin(w)  0 
        -sin(w)  cos(w)  0
           0       0     1];

% Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
% il centro è sempre il sole
Q_pX = (R3_w*R1_i*R3_W)';        

for t = 1:(su_days+1)
%       Anomalia vera nel tempo
    f = dTA * t + TA_init_s;
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
