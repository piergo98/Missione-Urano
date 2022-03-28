
%CALCOLO DELTA V NECESSARIO PER USARE LA TRAIETTORIA DI LAMBERT CALCOLATA 
%TRA GIOVE E SATURNO

%USO delta_deg_Jupiter,v_inf_down_Jupiter,v2_j

%matrice di rotazione

R_j = [cosd(delta_deg_Jupiter)  -sind(delta_deg_Jupiter)    0;
       sind(delta_deg_Jupiter)  cosd(delta_deg_Jupiter)     0;
       0                        0                           1]

%velocità finale flyby

v_fin_Jupiter = ( R_j* v_inf_down_Jupiter' ) + v2_j'

%deltaV necessario

delta_V_Jupiter = v1_l_j' - v_fin_Jupiter
norm_delta_V_Jupiter = norm(delta_V_Jupiter)

%--------------------------------------------------------------------------


%CALCOLO DELTA V NECESSARIO PER USARE LA TRAIETTORIA DI LAMBERT CALCOLATA 
%TRA SATURNO E URANO

%USO delta_deg_Saturn,v_inf_down_Saturn,v2_s

%matrice di rotazione

R_s = [cosd(delta_deg_Saturn)   -sind(delta_deg_Saturn)     0;
       sind(delta_deg_Saturn)   cosd(delta_deg_Saturn)      0;
       0                        0                           1]

%velocità finale flyby

v_fin_Saturn = ( R_s* v_inf_down_Saturn' ) + v2_s'

%deltaV necessario

delta_V_Saturn = v1_l_s' - v_fin_Saturn
norm_delta_V_Saturn = norm(delta_V_Saturn)
