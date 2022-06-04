% Matrice di rotazione

R_j = [cosd(delta_deg_Earth)    -sind(delta_deg_Earth)    0;
       sind(delta_deg_Earth)    cosd(delta_deg_Earth)     0;
       0                        0                         1];

% Velocità finale flyby

v_fin_Earth_tr = ( R_j* v_inf_down_Earth' ) + v2_e2';
v_fin_Earth = v_fin_Earth_tr';

% DeltaV necessario

delta_V_Earth = v2_l_e2 - v_fin_Earth;
norm_delta_V_Earth = norm(delta_V_Earth);

% Posizione dopo flyby
date_post_flyby_Earth = datetime(2024, 08, 01, 18, 00, 00) + seconds(t_flyby_tot_Earth);
DateVector_Earth = datevec(date_post_flyby_Earth);

[coe_e2_new, r2_e2_new, v2_e2_new, ~] = planet_elements_and_sv(3, DateVector_Earth(1),...
    DateVector_Earth(2), DateVector_Earth(3), DateVector_Earth(4),...
    DateVector_Earth(5), DateVector_Earth(6));

r2_fin_e = r2_e2_new;