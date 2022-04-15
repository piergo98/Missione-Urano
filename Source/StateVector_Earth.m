%matrice di rotazione

R_j = [cosd(delta_deg_Earth)  -sind(delta_deg_Earth)    0;
       sind(delta_deg_Earth)  cosd(delta_deg_Earth)     0;
       0                        0                           1];

%velocità finale flyby

v_fin_Earth_tr = ( R_j* v_inf_down_Earth' ) + v2_e2';
v_fin_Earth = v_fin_Earth_tr';

%deltaV necessario

delta_V_Earth = v2_l_e2 - v_fin_Earth;
norm_delta_V_Earth = norm(delta_V_Earth);

%posizione dopo flyby
r2_fin_e = r2_e2 ;