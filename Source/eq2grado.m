fyby_jupiter_time
% eq2grado1(a_flyby_Jupiter,b_flyby_Jupiter,R_SOI_Jupiter,r_p_flyby_Jupiter)
% function [x1_int,x2_int,y1_int,y2_int]= eq2grado1(a_flyby_Jupiter,b_flyby_Jupiter,R_SOI_Jupiter,r_p_flyby_Jupiter)
A = a_flyby_Jupiter^2+b_flyby_Jupiter^2;
B = -2*(b_flyby_Jupiter)^2*r_p_flyby_Jupiter;
C = (b_flyby_Jupiter)^2*(r_p_flyby_Jupiter)^2-(a_flyby_Jupiter)^2*R_SOI_Jupiter^2-(a_flyby_Jupiter^2)*(b_flyby_Jupiter^2);
D = B^2-4*A*C;
% Prima intersezione orbita SOI
x1_int = (-B+sqrt(D))/(2*A)
y1_int = sqrt(R_SOI_Jupiter^2-x1_int^2)
% Seconda intersezione orbita SOI
x2_int = (-B-sqrt(D))/(2*A)
y2_int = sqrt(R_SOI_Jupiter^2-x2_int^2)
% [x1_int,y1_int]
% [x2_int,y2_int]
% end

% Compute classical orbital elements for flyby orbit
% coe_flyby_jupiter = coe_from_sv(r1, v2_l_j, mu_jupiter);
