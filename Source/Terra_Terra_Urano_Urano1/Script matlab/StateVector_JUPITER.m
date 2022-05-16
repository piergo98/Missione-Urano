%matrice di rotazione

R_j = [cosd(delta_deg_Jupiter)  -sind(delta_deg_Jupiter)    0;
       sind(delta_deg_Jupiter)  cosd(delta_deg_Jupiter)     0;
       0                        0                           1];

%velocità finale flyby

v_fin_Jupiter_tr = ( R_j* v_inf_down_Jupiter' ) + v2_j';
v_fin_Jupiter = v_fin_Jupiter_tr';

%deltaV necessario

%delta_V_Jupiter = v2_l_j - v_fin_Jupiter;
%norm_delta_V_Jupiter = norm(delta_V_Jupiter);

%posizione dopo flyby
r2_fin_j = r2_j;