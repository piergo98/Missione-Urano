% Matrice di rotazione

R_e = [cosd(delta_deg_Earth)    -sind(delta_deg_Earth)    0;
       sind(delta_deg_Earth)    cosd(delta_deg_Earth)     0;
       0                        0                         1];

% Velocità finale flyby

v_fin_Earth_tr = ( R_e* v_inf_down_Earth' )+ v2_e2';
v_fin_Earth = v_fin_Earth_tr';

%delta_V_Earth = v_inf_down_Earth - v_fin_Earth;  %velocità in uscita flyby-in ingresso
delta_V_Earth = v_fin_Earth - v2_l_e2;

norm_delta_V_Earth = norm(delta_V_Earth);

% Posizione dopo flyby
%r2_fin_e = r2_e2 + R_SOI_Earth;

%versione con tempo di flyby
date_post_flyby_Earth = datetime(2024, 08, 01, 18, 00, 00) + seconds(t_flyby_tot_Earth);
DateVector_Earth = datevec(date_post_flyby_Earth);

[coe_e2_new, r2_e2_new, v2_e2_new, ~] = planet_elements_and_sv(3, DateVector_Earth(1),...
    DateVector_Earth(2), DateVector_Earth(3), DateVector_Earth(4), DateVector_Earth(5), DateVector_Earth(6));
%TA2_e_soi = rad2deg(coe_e2_new(6));
% %%
% % Estrazione elementi orbitali dall'orbita ottenuta nella SOI
% coe_e_SOI = coe_from_sv(r2_e2_new, v2_e2_new, mu);
% % Anomalia vera alla fine della missione Terra-Venere
% TA2_e_soi = rad2deg(coe_e_SOI(6));

%%
%r2_fin_e = r2_e2_new + R_SOI_Earth;
r2_fin_e = r2_e2_new;