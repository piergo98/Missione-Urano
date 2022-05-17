%matrice di rotazione

R_j = [cosd(delta_deg_Mars)  -sind(delta_deg_Mars)    0;
       sind(delta_deg_Mars)  cosd(delta_deg_Mars)     0;
       0                        0                           1];

%velocità finale flyby

v_fin_Mars_tr = ( R_j* v_inf_down_Mars' ) + v2_m';
v_fin_Mars = v_fin_Mars_tr';

%deltaV necessario

delta_V_Mars = v2_l_m - v_fin_Mars;
norm_delta_V_Mars = norm(delta_V_Mars);

%posizione dopo flyby
r2_fin_m = r2_m ;