%Eseguo un ciclo for che varia la posizione di rp e mi modifica delta
GM_Earth = 3986004418; %[km^3/s^2] 
v_inf_down_Earth = v2_l_e2 - v2_e2 ;  
v_inf_down_norm_Earth = norm(v_inf_down_Earth); 

a_flyby_Earth = - GM_Earth/((v_inf_down_norm_Earth)^2);%semiaxis major 
r_p_flyby_Earth = 1e4:5e3:9e5 ;  %hp  
%r_p_flyby_Jupiter = 1e5;
for i = 1:length(r_p_flyby_Earth)
    e_flyby_Earth = 1-(r_p_flyby_Earth/a_flyby_Earth); 
    
    delta_Earth = 2*asin(1/e_flyby_Earth(i)); %angolo tra gli asintoti 
    delta_deg_Earth = rad2deg(delta_Earth); 
    
    % %ricavo l'anomalia vera f

    f_k_Earth(i) = acos((a_flyby_Earth*(1-e_flyby_Earth(i)^2)-R_SOI_Earth)...
        / (e_flyby_Earth(i)*R_SOI_Earth)) ;
    f_deg_k_Earth =rad2deg(f_k_Earth);

    % %ricavo anomalia eccentrica F

    cosh_F(i)=((e_flyby_Earth(i)+cos(f_k_Earth(i)))/(e_flyby_Earth(i)*cos(f_k_Earth(i))+1));
    F_k_Earth(i)=log(cosh_F(i)+sqrt(cosh_F(i)^2-1));
    F_deg_k_Earth(i)=rad2deg(F_k_Earth(i));
    
    %calcolo il tempo per effettuare il flyby
    t_ke_Earth(i)= sqrt((-a_flyby_Earth^3)/GM_Earth)*(e_flyby_Earth(i)*sinh(F_k_Earth(i))-F_k_Earth(i)); %in s
    t_hours_ke(i) =t_ke_Earth(i)/3600;
    t_day_ke(i) = t_hours_ke(i)/24;
    
    [years_k_E months_k_E days_k_E hours_k_E minutes_k_E seconds_k_E] = sec2date(t_ke_Earth) ;
    
    T_E_kep = [years_k_E; months_k_E; days_k_E; hours_k_E; minutes_k_E; seconds_k_E];
 end

