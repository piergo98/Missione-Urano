% Matrice di rotazione

R_u = [cosd(delta_deg_Uranus)   -sind(delta_deg_Uranus)     0;
       sind(delta_deg_Uranus)   cosd(delta_deg_Uranus)      0;
       0                        0                           1];

% Velocità finale flyby

v_fin_Uranus_tr = ( R_u* v_inf_down_Uranus' ) + v2_u';
v_fin_Uranus = v_fin_Uranus_tr';

% DeltaV necessario

%delta_V_Uranus = [-1.308904e+00 9.744000e+00 -2.282013e-01] - v_fin_saturn;
%norm_delta_V_saturn = norm(delta_V_saturn);

% Posizione dopo flyby
r2_fin_u = r2_u;