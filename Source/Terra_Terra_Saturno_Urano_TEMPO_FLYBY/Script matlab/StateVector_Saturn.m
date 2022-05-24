% Matrice di rotazione

R_s = [cosd(delta_deg_Saturn)   -sind(delta_deg_Saturn)     0;
       sind(delta_deg_Saturn)   cosd(delta_deg_Saturn)      0;
       0                        0                           1];

% Velocità finale flyby

v_fin_Saturn_tr = ( R_s* v_inf_down_Saturn' ) + v2_s';
v_fin_Saturn = v_fin_Saturn_tr';

% DeltaV necessario

delta_V_Saturn = V2_l_s - v_fin_Saturn;
norm_delta_V_saturn = norm(delta_V_Saturn);

% Posizione dopo flyby
%r2_fin_s = r2_s;

%versione con tempo di flyby
date_post_flyby_Saturn = datetime(2030, 08, 01, 00, 00, 00) + seconds(t_flyby_tot_Saturn);
DateVector_Saturn = datevec(date_post_flyby_Saturn);

[coe_s_new , r2_s_new, v2_s_new, ~] = planet_elements_and_sv(6, DateVector_Saturn(1),...
    DateVector_Saturn(2), DateVector_Saturn(3), DateVector_Saturn(4), DateVector_Saturn(5), DateVector_Saturn(6));
%TA2_s_soi = rad2deg(coe_s_new(6));

% Estrazione elementi orbitali dall'orbita ottenuta nella SOI
coe_s_SOI = coe_from_sv(r2_s_new, v2_s_new, mu);
% Anomalia vera alla fine della missione Terra-Venere
TA2_s_soi = rad2deg(coe_s_SOI(6));

%r2_fin_s = r2_s_new + R_SOI_Saturn;

r2_fin_s = r2_s_new;