% Kepler equation for hyperbolic equation

%SOI_JUPITER

mu_jupiter = 1.26686534e8;  %[km^3/s^2] 

% Velocità in uscita da Jupiter
v_inf_down_Jupiter = v2_l_j - v2_j;  
v_inf_down_norm_Jupiter = norm(v_inf_down_Jupiter); 

% Semimajor axis
a_flyby_Jupiter = - mu_jupiter / ((v_inf_down_norm_Jupiter)^2);   

% Rp
r_p_flyby_Jupiter = 2069911;    

% Eccentricity
e_flyby_Jupiter = 1-(r_p_flyby_Jupiter/a_flyby_Jupiter); 

% Angolo tra gli asintoti 
delta_Jupiter = 2*asin(1/e_flyby_Jupiter);  
delta_deg_Jupiter = rad2deg(delta_Jupiter); 
% Semiasse minore
b_flyby_Jupiter = a_flyby_Jupiter*tand((180-delta_deg_Jupiter)/2);
% Semilato retto
p_flyby_Jupiter = a_flyby_Jupiter*(1-e_flyby_Jupiter^2);


% y_ke=sqrt(((a_flyby_Jupiter^2*b_flyby_Jupiter^2)-(b_flyby_Jupiter^2*R_SOI_Jupiter^2))/(-a_flyby_Jupiter^2-b_flyby_Jupiter^2))
% x_ke=sqrt((R_SOI_Jupiter^2)-y_ke^2)

% Ricavo l'anomalia vera f
f_Jupiter = acos((p_flyby_Jupiter-R_SOI_Jupiter) / (e_flyby_Jupiter*R_SOI_Jupiter));
f_deg_Jupiter =rad2deg(f_Jupiter);

% Ricavo anomalia eccentrica F
cosh_F=((e_flyby_Jupiter+cos(f_Jupiter))/(e_flyby_Jupiter*cos(f_Jupiter)+1));
F=log(cosh_F+sqrt(cosh_F^2-1));
F_deg_Jupiter=rad2deg(F);

% Calcolo il tempo di volo del flyby
t_ke= sqrt((-a_flyby_Jupiter^3)/mu_jupiter)*(e_flyby_Jupiter*sinh(F)-F); % (s)

%t_hours_ke =t_ke/3600 
%t_day_ke = t_hours_ke/24 
% eq2grado1(a_flyby_Jupiter,b_flyby_Jupiter,R_SOI_Jupiter,r_p_flyby_Jupiter) 
% function [x1_int,x2_int,y1_int,y2_int]= eq2grado1(a_flyby_Jupiter,b_flyby_Jupiter,R_SOI_Jupiter,r_p_flyby_Jupiter) 
% Risolvo un'equazione di secondo grado per trovare le intersezioni tra la
% SOI e l'iperbole
A = a_flyby_Jupiter^2+b_flyby_Jupiter^2; 
B = -2*(b_flyby_Jupiter)^2*r_p_flyby_Jupiter; 
C = (b_flyby_Jupiter)^2*(r_p_flyby_Jupiter)^2-(a_flyby_Jupiter)^2*R_SOI_Jupiter^2-(a_flyby_Jupiter^2)*(b_flyby_Jupiter^2); 
D = B^2-4*A*C; 

% Prima intersezione iperbole-SOI
x1_int = (-B+sqrt(D))/(2*A); 
y1_int = sqrt(R_SOI_Jupiter^2-x1_int^2);
r1 = [x1_int y1_int r2_j(3)]
% Seconda intersezione iperbole-SOI
x2_int = (-B-sqrt(D))/(2*A);
y2_int = sqrt(R_SOI_Jupiter^2-x2_int^2);
r2 = [x2_int y2_int r2_j(3)]

% Calcolo coe iperbole
coe_jupiter = coe_from_sv(r2, v2_l_j, mu_jupiter);