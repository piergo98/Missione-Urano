% Matrice di rotazione

R_j = [cosd(delta_deg_Uranus)    -sind(delta_deg_Uranus)    0;
       sind(delta_deg_Uranus)    cosd(delta_deg_Uranus)     0;
       0                        0                         1];

% Velocità finale flyby

v_fin_Uranus_tr = ( R_j* v_inf_down_Uranus' )+ v2_u';
v_fin_Uranus = v_fin_Uranus_tr';

% DeltaV necessario
delta_V_Uranus = V2_l_u - v_fin_Uranus;
norm_delta_V_Uranus = norm(delta_V_Uranus);

% Posizione dopo flyby
r2_fin_u = r2_u + R_SOI_Uranus;