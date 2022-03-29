 
GM_jupiter = 1.26686534e8; %[km^3/s^2] 
v_inf_down_Jupiter = v2_l_j - v2_j ;  
v_inf_down_norm_Jupiter = norm(v_inf_down_Jupiter); 

a_flyby_Jupiter = - GM_jupiter/((v_inf_down_norm_Jupiter)^2);%semiaxis major 
r_p_flyby_Jupiter = 1e5:1e5:4e7 ;  %hp  
for i = 1:length(r_p_flyby_Jupiter)
e_flyby_Jupiter(i) = 1-(r_p_flyby_Jupiter(i)/a_flyby_Jupiter); 

delta_Jupiter(i) = 2*asin(1/e_flyby_Jupiter(i)); %angolo tra gli asintoti 
delta_deg_Jupiter(i) = rad2deg(delta_Jupiter(i)); 

%ricavo l'anomalia vera f

f_Jupiter(i) = acos((a_flyby_Jupiter*(1-e_flyby_Jupiter(i)^2)-r_p_flyby_Jupiter(i)) ...
    / (e_flyby_Jupiter(i)*r_p_flyby_Jupiter(i))); 
f_deg_Jupiter =rad2deg(f_Jupiter(i));

%trovo p semilato retto [km] 
p_Jupiter(i) = r_p_flyby_Jupiter(i)*(1+e_flyby_Jupiter(i)*cos(f_Jupiter(i))); 
 
r=R_SOI_Jupiter; 

%calcolo anomalia vera per r 
f1_Jupiter(i) = acos((1/e_flyby_Jupiter(i))*((p_Jupiter(i)/r)-1)); 

E_2_Jupiter(i) = atanh(sqrt((e_flyby_Jupiter(i)-1)/(e_flyby_Jupiter(i)+1))*tan(f1_Jupiter(i)/2)); 
E_Jupiter(i) = E_2_Jupiter(i)/2;
E_deg_Jupiter(i) = rad2deg(E_Jupiter(i)); 

%trovo anomalia media M 
 
M_Jupiter(i) = e_flyby_Jupiter(i)*sinh(E_Jupiter(i))-E_Jupiter(i); 
M_deg_Jupiter(i) =rad2deg(M_Jupiter(i)); 
 
%trovo il tempo 
 
t_flyby_Jupiter(i) = M_Jupiter(i) *sqrt(-a_flyby_Jupiter^3/GM_jupiter); %in secondi 
t_flyby_tot_Jupiter(i) = 2*t_flyby_Jupiter (i);  
t_flyby_tot_hours_Jupiter(i) = t_flyby_tot_Jupiter(i) /3600; 
 
[years_J months_J days_J hours_J minutes_J seconds_J] = sec2date(t_flyby_tot_Jupiter) ;

T_j = [years_J; months_J; days_J; hours_J; minutes_J; seconds_J];

end

