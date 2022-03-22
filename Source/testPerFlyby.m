GM_jupiter = 126686534; %[km^3/s^2]
v_inf_down = v2_l_j - v2_j ; 
v_inf_down_norm = norm(v_inf_down);
%v_inf_up_norm = norm(v_inf_up);
a= - GM_jupiter/((v_inf_down_norm)^2);%semiaxis major
r_p= 2e5-69911;
e= 1-(r_p/a);
delta= 2*asind(1/e);