%kepler equation for hyperbolic equation
GM_jupiter = 1.26686534e8;  %[km^3/s^2] 

%velocità in uscita da Jupiter
v_inf_down_Jupiter = v2_l_j - v2_j;  
v_inf_down_norm_Jupiter = norm(v_inf_down_Jupiter); 

%semiaxis major
a_flyby_Jupiter = - GM_jupiter / ((v_inf_down_norm_Jupiter)^2);   

%hp
r_p_flyby_Jupiter =500000;    
% SOI_JUPITER
% hold on
%eccentricity
e_flyby_Jupiter = 1-(r_p_flyby_Jupiter/a_flyby_Jupiter); 

%angolo tra gli asintoti 
delta_Jupiter = 2*asin(1/e_flyby_Jupiter);  
delta_deg_Jupiter = rad2deg(delta_Jupiter); 
b_flyby_Jupiter = a_flyby_Jupiter*tand((180-delta_deg_Jupiter)/2)


% y_ke=sqrt(((a_flyby_Jupiter^2*b_flyby_Jupiter^2)-(b_flyby_Jupiter^2*R_SOI_Jupiter^2))/(-a_flyby_Jupiter^2-b_flyby_Jupiter^2))
% x_ke=sqrt((R_SOI_Jupiter^2)-y_ke^2)

% %ricavo l'anomalia vera f
f_Jupiter = acos((a_flyby_Jupiter*(1-e_flyby_Jupiter^2)-R_SOI_Jupiter) / (e_flyby_Jupiter*R_SOI_Jupiter)) ;
f_deg_Jupiter =rad2deg(f_Jupiter);
% %ricavo anomalia eccentrica F
cosh_F=((e_flyby_Jupiter+cos(f_Jupiter))/(1+e_flyby_Jupiter*cos(f_Jupiter)));
F=log(cosh_F+sqrt(cosh_F^2-1));
F_deg_Jupiter=rad2deg(F);
t_ke= (e_flyby_Jupiter*sinh(F)-F)*sqrt((-a_flyby_Jupiter^3)/GM_jupiter) %in s
%t_hours_ke =t_ke/3600
%t_day_ke = t_hours_ke/24
% eq2grado1(a_flyby_Jupiter,b_flyby_Jupiter,R_SOI_Jupiter,r_p_flyby_Jupiter)
% function [x1_int,x2_int,y1_int,y2_int]= eq2grado1(a_flyby_Jupiter,b_flyby_Jupiter,R_SOI_Jupiter,r_p_flyby_Jupiter)
A=a_flyby_Jupiter^2+b_flyby_Jupiter^2;
B= -2*(b_flyby_Jupiter)^2*r_p_flyby_Jupiter;
C= (b_flyby_Jupiter)^2*(r_p_flyby_Jupiter)^2-(a_flyby_Jupiter)^2*R_SOI_Jupiter^2-(a_flyby_Jupiter^2)*(b_flyby_Jupiter^2);
D=B^2-4*A*C;
x1_int=(-B+sqrt(D))/(2*A)
x2_int=(-B-sqrt(D))/(2*A)
y1_int= sqrt(R_SOI_Jupiter^2-x1_int^2)
y2_int= sqrt(R_SOI_Jupiter^2-x2_int^2)
% [x1_int,y1_int]
% [x2_int,y2_int]
% end
vect_init=[x2_int,y2_int,0]
coe_jupiter= coe_from_sv(vect_init,v_inf_down_Jupiter,GM_jupiter)

%[vect_pos]=m_roto_trasl(vect_init,5, 2025, 07, 01, 18, 00, 00)