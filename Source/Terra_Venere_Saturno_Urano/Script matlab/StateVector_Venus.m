% Matrice di rotazione

R_v = [cosd(delta_deg_Venus)    -sind(delta_deg_Venus)    0;
       sind(delta_deg_Venus)    cosd(delta_deg_Venus)     0;
       0                        0                         1];

% Velocità finale flyby

v_fin_Venus_tr = ( R_v* v_inf_down_Venus' ) + v2_v';
v_fin_Venus = v_fin_Venus_tr';

% DeltaV necessario

delta_V_Venus = v2_l_v - v_fin_Venus;
norm_delta_V_Venus = norm(delta_V_Venus);

% Posizione dopo flyby
r2_fin_v = r2_v;