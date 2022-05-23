% This script calculates a vector containing each row position of 
% Dawn_spacecraft with respect to solar system 
 
% Risolvo il problema di Lambert per tutta la missione (senza plot) 
 
% Dimensioni dello spacecraft 
radius = 100; 
 
%% Earth to Mars 
em_days = datenum([2028 10 01]) - datenum([2027 05 01]); 
  
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
    f = 2*dTA * t + TA1_mj; 
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
% % Giorni in cui lo spacecraft sta sull'orbita ottenuta dal flyby 
% fl_days = datenum([2023 10 17]) - datenum([2023 10 1]); 
% %fl_days = ceil(dT / days2seconds(1)); 
%  
% Delta_TA_fl = abs(TA_for_lambert - TA_post_flyby); 
% % Variazione di anomalia vera in un giorno 
% dTA = Delta_TA_fl/ fl_days; 
%  
% h = coe_flyby(1);          % Momento angolare 
% e = coe_flyby(2);          % Eccentricità 
% RA = coe_flyby(3);         % Ascensione retta 
% incl = coe_flyby(4);       % Inclinazione orbita di trasferimento 
% w = coe_flyby(5);          % Argomento del periasse 
%  
% p = h^2 / mu;           % Semilato retto 
%  
% % Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D 
% % il centro è sempre il sole 
% Q_pX = perifocal2helio(RA, incl, w);   
%  
% for t = 1:(fl_days) 
% %       Anomalia vera nel tempo 
%     f = dTA * t + TA_post_flyby; 
% %       Legge oraria dello spacecraft in funzione dell'anomalia vera 
%     r = p / (1 + e*cosd(f)); 
% %       Converto in coordinate cartesiane 
%     x = r*cosd(f); 
%     y = r*sind(f); 
%     z = 0; 
% %       Cambio di coordinate il vettore posizione 
%     pos_spcr(:,t+em_days) = Q_pX * [x y z]'; 
% end 
%  
%% Mars to Jupiter 
mj_days = datenum([2032 07 01]) - datenum([2028 10 01]); 
 
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
%    pos_spcr(:,t+ee_days+fl_days) = Q_pX * [x y z]'; %vecchio 
    pos_spcr(:,t+em_days) = Q_pX * [x y z]'; 
end 
 
 
%% Saturn to Uranus 
ju_days = datenum([2038 07 01])- datenum([2032 07 01]); 
 
Delta_TA_ju = abs(TA2_ju - TA1_ju); 
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
%    pos_spcr(:,t+ee_days+fl_days+es_days) = Q_pX * [x y z]'; %vecchia 
    pos_spcr(:,t+em_days+mj_days) = Q_pX * [x y z]'; 
end  