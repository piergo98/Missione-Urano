%matrice di rotazione

R_j = [cosd(delta_deg_Venus)  -sind(delta_deg_Venus)    0;
       sind(delta_deg_Venus)  cosd(delta_deg_Venus)     0;
       0                        0                           1];

%velocità finale flyby

v_fin_Venus_tr = ( R_j* v_inf_down_Venus' ) + v2_v';
v_fin_Venus = v_fin_Venus_tr';

%deltaV necessario

delta_V_Venus = v2_l_v - v_fin_Venus;
norm_delta_V_Mars = norm(delta_V_Venus);

%posizione dopo flyby
r2_fin_v = r2_v ;