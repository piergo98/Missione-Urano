% Matrice di rotazione

R_j = [cosd(delta_deg_saturn)   -sind(delta_deg_saturn)     0;
       sind(delta_deg_saturn)   cosd(delta_deg_saturn)      0;
       0                        0                           1];

% Velocità finale flyby

v_fin_saturn_tr = ( R_j* v_inf_down_saturn' ) + v2_s';
v_fin_saturn = v_fin_saturn_tr';

% DeltaV necessario

delta_V_saturn = V2_l_s - v_fin_saturn;
norm_delta_V_saturn = norm(delta_V_saturn);

% Posizione dopo flyby
r2_fin_s = r2_s;