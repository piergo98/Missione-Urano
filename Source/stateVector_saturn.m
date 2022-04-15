%matrice di rotazione

R_j = [cosd(delta_deg_saturn)  -sind(delta_deg_saturn)    0;
       sind(delta_deg_saturn)  cosd(delta_deg_saturn)     0;
       0                        0                           1];

%velocità finale flyby

v_fin_saturn_tr = ( R_j* v_inf_down_saturn' ) + v2_s';
v_fin_saturn = v_fin_saturn_tr';

%deltaV necessario

delta_V_saturn = [-1.308904e+00 9.744000e+00 -2.282013e-01] - v_fin_saturn;
norm_delta_V_saturn = norm(delta_V_saturn);

%posizione dopo flyby
r2_fin_s = r2_s;