v_nav = V2_l_u;
v_sc = norm(v_nav);
v_u = norm(v2_u);
sc_produt = dot(v_nav,v2_u);
% versore_sa = v_sa/norm(v_sa);
% versore_u = v_u/norm(v_u);
gamma = acos((sc_produt)/(v_sc*v_u));
gamma_deg = rad2deg(gamma);
v_inf_capt = sqrt(v_sc^2+v_u^2-(2*v_sc*v_u*cos(gamma)));
rp_c = 1000+25362; %altitudine orbita di parcheggio 1000km + raggio urano 25362 km
SOI_uranus
GM_Uranus = 5793939;
ac_capt = -GM_Uranus - v_inf_capt^2;
e_capt_gen = 1 - rp_c/ac_capt;
v_f = sqrt(GM_Uranus/rp_c);
delta_v = sqrt(v_inf_capt^2 + 2*v_f^2) - v_f


