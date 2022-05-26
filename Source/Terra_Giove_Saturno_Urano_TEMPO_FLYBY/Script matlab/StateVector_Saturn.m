% Matrice di rotazione

R_s = [cosd(delta_deg_Saturn)   -sind(delta_deg_Saturn)     0;
       sind(delta_deg_Saturn)   cosd(delta_deg_Saturn)      0;
       0                        0                           1];

% Velocità finale flyby

v_fin_Saturn_tr = ( R_s* v_inf_down_Saturn' ) + v2_s';
v_fin_Saturn = v_fin_Saturn_tr';

% DeltaV necessario

delta_V_Saturn = V2_l_s - v_fin_Saturn;
norm_delta_V_Saturn = norm(delta_V_Saturn);

% Posizione dopo flyby
date_post_flyby_Saturn = datetime(2030, 9, 1, 12, 00, 00) + seconds(t_flyby_tot_Saturn);
DateVector_Saturn = datevec(date_post_flyby_Saturn);

[coe_s_new , r2_s_new, v2_s_new, ~] = planet_elements_and_sv(4, DateVector_Saturn(1),...
    DateVector_Saturn(2), DateVector_Saturn(3), DateVector_Saturn(4), DateVector_Saturn(5), DateVector_Saturn(6));

r2_fin_s = r2_s_new;