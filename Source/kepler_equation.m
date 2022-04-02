%kepler equation for hyperbolic equation
GM_jupiter = 1.26686534e8;  %[km^3/s^2] 

%velocità in uscita da Jupiter
v_inf_down_Jupiter = v2_l_j - v2_j;  
v_inf_down_norm_Jupiter = norm(v_inf_down_Jupiter); 

%semiaxis major
a_flyby_Jupiter = - GM_jupiter / ((v_inf_down_norm_Jupiter)^2);   

%hp
r_p_flyby_Jupiter =500000;    
SOI_JUPITER
hold on
%eccentricity
e_flyby_Jupiter = 1-(r_p_flyby_Jupiter/a_flyby_Jupiter); 

%angolo tra gli asintoti 
delta_Jupiter = 2*asin(1/e_flyby_Jupiter);  
delta_deg_Jupiter = rad2deg(delta_Jupiter); 
b_flyby_Jupiter = a_flyby_Jupiter*tand((180-delta_deg_Jupiter)/2)


% y_ke=sqrt(((a_flyby_Jupiter^2*b_flyby_Jupiter^2)-(b_flyby_Jupiter^2*R_SOI_Jupiter^2))/(-a_flyby_Jupiter^2-b_flyby_Jupiter^2))
% x_ke=sqrt((R_SOI_Jupiter^2)-y_ke^2)

% %ricavo l'anomalia vera f
f_Jupiter = acos((a_flyby_Jupiter*(1-e_flyby_Jupiter^2)-R_SOI_Jupiter) / (e_flyby_Jupiter*R_SOI_Jupiter)) 
f_deg_Jupiter =rad2deg(f_Jupiter)
% %ricavo anomalia eccentrica F
cosh_F=((e_flyby_Jupiter+cos(f_Jupiter))/(e_flyby_Jupiter*cos(f_Jupiter)+1))
F=log(cosh_F+sqrt(cosh_F^2-1))
F_deg_Jupiter=rad2deg(F)
t_ke= sqrt((-a_flyby_Jupiter^3)/GM_jupiter)*(e_flyby_Jupiter*sinh(F)-F) %in s
t_hours_ke =t_ke/3600
t_day_ke = t_hours_ke/24