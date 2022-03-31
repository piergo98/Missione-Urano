%CAMBIO VELOCITA' E POSIZIONE DOPO FLYBY PER GIOVE 

%USO delta_deg_Jupiter,v_inf_down_Jupiter,v2_j

%matrice di rotazione

R_j = [cosd(delta_deg_Jupiter)  -sind(delta_deg_Jupiter)    0;
       sind(delta_deg_Jupiter)  cosd(delta_deg_Jupiter)     0;
       0                        0                           1];

% vettore velocità finale spacecraft dopo flyby

v_fin_Jupiter_trasp = ( R_j* v_inf_down_Jupiter' ) + v2_j';
v_fin_Jupiter = v_fin_Jupiter_trasp';

%vettore posiione spacecraft dopo flyby

r2_fin_j_trasp = ( R_j* r2_j' );
r2_fin_j= r2_fin_j_trasp';