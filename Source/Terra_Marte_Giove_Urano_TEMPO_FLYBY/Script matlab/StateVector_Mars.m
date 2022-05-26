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
date_post_flyby_Mars = datetime(2028, 10, 01, 18, 00, 00) + seconds(t_flyby_tot_Mars);
DateVector_Mars = datevec(date_post_flyby_Mars);

[coe_m_new , r2_m_new, v2_m_new, ~] = planet_elements_and_sv(4, DateVector_Mars(1),...
    DateVector_Mars(2), DateVector_Mars(3), DateVector_Mars(4), DateVector_Mars(5), DateVector_Mars(6));

r2_fin_m = r2_m_new;