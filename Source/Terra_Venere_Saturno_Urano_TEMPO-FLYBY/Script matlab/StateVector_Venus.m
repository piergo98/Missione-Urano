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
date_post_flyby_Venus = datetime(2022, 04, 01, 12, 00, 00) + seconds(t_flyby_tot_Venus);
DateVector_Venus = datevec(date_post_flyby_Venus);

[coe_v_new, r2_v_new, v2_v_new, ~] = planet_elements_and_sv(2, DateVector_Venus(1),...
    DateVector_Venus(2), DateVector_Venus(3), DateVector_Venus(4), DateVector_Venus(5), DateVector_Venus(6));

r2_fin_v = r2_v_new;