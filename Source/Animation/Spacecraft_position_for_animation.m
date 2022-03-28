% This script calculates a vector containing each row position of
% Dawn_spacecraft with respect to solar system

%% Earth to Jupiter
% from day 1 (01/7/22) to Jupiter arrival/departure (01/07/2024)
ej_days = - datenum([2022 07 01]) + datenum([2024 07 01]);

Delta_TA_ej = TA_final_j - TA_init_e;
%   Minima variazione di anomalia vera in un giorno
TA_min = Delta_TA_ej / ej_days;

h = coe_ej(1);         % Momento angolare
e = coe_ej(2);         % Eccentricità
RA = coe_ej(3);        % Ascensione retta
incl = coe_ej(4);
w = coe_ej(5);
a = coe_ej(7);

mu = 1.327*10^11;   % mu sun (km^2/s^3)

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

for t = 1:ej_days
%       Anomalia vera nel tempo
    f = TA_min * t;
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
js_days = datenum([2031 4 1])- datenum([2024 4 3]);

Delta_TA_js = TA_final_s - TA_init_j;
%   Minima variazione di anomalia vera in un giorno
TA_min = Delta_TA_js / js_days;

h = coe_js(1);         % Momento angolare
e = coe_js(2);         % Eccentricità
RA = coe_js(3);        % Ascensione retta
incl = coe_js(4);
w = coe_js(5);
a = coe_js(7);

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

for t = (ej_days+2):(js_days+ej_days+2)
%       Anomalia vera nel tempo
    f = TA_min * t;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t) = Q_pX * [x y z]';
end

%% Saturn  to Uranus
% from (6/4/31) to (25/12/35)
su_days = datenum([2035 12 25])- datenum([2031 4 6]);

Delta_TA_su = TA_final_u - TA_init_s;
%   Minima variazione di anomalia vera in un giorno
TA_min = Delta_TA_su / su_days;

h = coe_su(1);         % Momento angolare
e = coe_su(2);         % Eccentricità
RA = coe_su(3);        % Ascensione retta
incl = coe_su(4);
w = coe_su(5);
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

for t = (ej_days+js_days+4):(js_days+ej_days+su_days+4)
%       Anomalia vera nel tempo
    f = TA_min * t;
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
    r = p / (1 + e*cosd(f));
%       Converto in coordinate cartesiane
    x = r*cosd(f);
    y = r*sind(f);
    z = 0;
%       Cambio di coordinate il vettore posizione
    pos_spcr(:,t) = Q_pX * [x y z]';
end


%% Vesta to Ceres
% from (5/9/12) to (6/3/15)
vc_days = datenum([2015 3 6])- datenum([2012 9 5]);

[body_pos3, sp_v3, body_posf3, sp_vf3, tof3, orb_elem3] = ...
                gen_orbit2(10,11,[2012 9 5 0 0 0],[2015 3 5 0 0 0],0);
VC_orbit = intpl_orbit2(tof3,Vesta_r3,sp_v3);
vc_pos = VC_orbit(:,1:3);
q = floor(size(vc_pos,1)/vc_days); % rate of samples for each day
for i = 1:vc_days
    pos_spcr(i+ej_days+js_days+v_days,:) = vc_pos(q * i,:);
end

%tmp
pos_spcr(end,:) = pos_spcr(end-1,:);

%% tests
%sanity check
%(em_days + mv_days + v_days + vc_days) - (n_days-1);


%% days

day_left_earth	= 1;
day_mars		= 1 + ej_days;
day_vesta		= 1 + ej_days + js_days;
day_left_vesta	= 1 + ej_days + js_days + v_days;
day_ceres		= 1 + ej_days + js_days + v_days + vc_days;
