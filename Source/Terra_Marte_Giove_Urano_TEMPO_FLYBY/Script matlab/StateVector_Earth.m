% Matrice di rotazione

R_j = [cosd(delta_deg_Earth)    -sind(delta_deg_Earth)    0;
       sind(delta_deg_Earth)    cosd(delta_deg_Earth)     0;
       0                        0                         1];

% Velocità finale flyby

v_fin_Earth_tr = ( R_j* v_inf_down_Earth' )+ v2_e2';
v_fin_Earth = v_fin_Earth_tr';

% DeltaV necessario??? non è il dV guadagnato tramite flyby?

%delta_V_Earth = v_inf_down_Earth - v_fin_Earth;  %velocità in uscita flyby-in ingresso
delta_V_Earth = v_fin_Earth - v2_l_e2;

norm_delta_V_Earth = norm(delta_V_Earth);

% Posizione dopo flyby
r2_fin_e = r2_e2 + R_SOI_Earth;