%% COMPUTE THE ANGLE AND TRAJECTORY TO THE ESCAPE FROM EARTH SOI

% Recupero dati Terra
Earth_Earth_Jupiter_Uranus;
v_infp_escape_Earth = v1_l_e1 - v1_e1;   % Differenza fra velocità necessaria per Lambert e velocità del pianeta    
v_infp_escape_Earth_mod = norm(v_infp_escape_Earth);  % In norma

r_orbit = 6571; % Raggio orbita di parcheggio intorno alla Terra(km)     
v_park = sqrt(mu_Earth/r_orbit);    % Velocità sull'orbita di parcheggio


% Calcolo elementi orbitali del flyby

% Semiasse maggiore
a_escape_Earth = - mu_Earth / v_infp_escape_Earth_mod^2;

% Eccentricità traiettoria di Escape
e_escape_Earth = 1 - (r_orbit/a_escape_Earth);        

% Angolo tra gli asintoti 
delta_escape_Earth = 2*asin(1/e_escape_Earth);   
delta_deg_escape_Earth = rad2deg(delta_escape_Earth); % in gradi 

% Ricavo l'anomalia vera f
f_escape_Earth = acos((a_escape_Earth*(1-e_escape_Earth^2)-r_orbit) ...
    / (e_escape_Earth*r_orbit)); 
f_deg_escape_Earth = rad2deg(f_escape_Earth);

% Trovo p semilato retto [km] 
p_escape_Earth = r_orbit*(1+e_escape_Earth*cos(f_escape_Earth)); 

% Distanza per la quale voglio calcolare il tempo di volo
r = R_SOI_Earth; 

% Calcolo anomalia vera per r 
f1_escape_Earth = acos((1/e_escape_Earth)*((p_escape_Earth/r)-1)); 

% Calcolo anomalia eccentrica
E_2_escape_Earth = atanh(sqrt((e_escape_Earth-1)/(e_escape_Earth+1))*tan(f1_escape_Earth/2)); 
E_escape_Earth = E_2_escape_Earth/2;
E_deg_escape_Earth = rad2deg(E_escape_Earth);   % In gradi 

% Trovo anomalia media M 
M_escape_Earth = e_escape_Earth*sinh(E_escape_Earth)-E_escape_Earth; 
M_deg_escape_Earth = rad2deg(M_escape_Earth);   % In gradi 

% Trovo il tempo 
t_escape_Earth = M_escape_Earth*sqrt(-a_escape_Earth^3/mu_Earth); %in secondi 
t_tot_escape_Earth = 2*t_escape_Earth;  
t_tot_hours_escape_Earth = t_tot_escape_Earth/3600; 
 
[years_eE months_eE days_E hours_eE minutes_eE seconds_eE] = sec2date(t_tot_escape_Earth); 

%% Calcolo la differenza di velocità necessaria

% Velocità al perigeo dell'iperbole
v_burn = sqrt(v_infp_escape_Earth_mod^2 + 2*v_park^2);

% Variazione di velocità necessaria per uscire dalla sfera di influenza
% della terra
D_v_escape_Earth = v_burn - v_park; 


 
