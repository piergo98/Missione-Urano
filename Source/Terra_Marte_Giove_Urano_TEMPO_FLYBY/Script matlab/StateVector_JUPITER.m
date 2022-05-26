%matrice di rotazione

R_j = [cosd(delta_deg_Jupiter)  -sind(delta_deg_Jupiter)    0;
       sind(delta_deg_Jupiter)  cosd(delta_deg_Jupiter)     0;
       0                        0                           1];

%velocità finale flyby

v_fin_Jupiter_tr = ( R_j* v_inf_down_Jupiter' ) + v2_j';
v_fin_Jupiter = v_fin_Jupiter_tr';

%deltaV necessario

delta_V_Jupiter = v2_l_j - v_fin_Jupiter;
norm_delta_V_Jupiter = norm(delta_V_Jupiter);

%posizione dopo flyby
date_post_flyby_Jupiter = datetime(2032, 07, 01, 00, 00, 00) + seconds(t_flyby_tot_Jupiter);
DateVector_Jupiter = datevec(date_post_flyby_Jupiter);

[coe_j_new , r2_j_new, v2_j_new, ~] = planet_elements_and_sv(5, DateVector_Jupiter(1),...
    DateVector_Jupiter(2), DateVector_Jupiter(3), DateVector_Jupiter(4), DateVector_Jupiter(5), DateVector_Jupiter(6));

r2_fin_j = r2_j_new;