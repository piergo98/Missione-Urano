%% Calcolo per risolvere Lambert dopo Flyby su un pianeta
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby.

%Trovo la posizione del pianeta Target

[~, r2_j, v2_j, ~] = planet_elements_and_sv(5, 2024, 10, 01, 12, 00, 00);

%definisco il tempo di volo

t = year2seconds(1);

%Eseguo un ciclo for che varia la posizione di rp e mi modifica delta
GM_Earth = 3986004418; %[km^3/s^2] 
v_inf_down_Earth = v2_l_e2 - v2_e2 ;  
v_inf_down_norm_Earth = norm(v_inf_down_Earth); 

a_flyby_Earth = - GM_Earth/((v_inf_down_norm_Earth)^2);%semiaxis major 
 r_p_flyby_Earth = 1e4:5e3:9e5 ;  %hp  
%r_p_flyby_Jupiter = 1e5;
for j = 1:length(r_p_flyby_Earth)
e_flyby_Earth = 1-(r_p_flyby_Earth/a_flyby_Earth); 

delta_Earth = 2*asin(1/e_flyby_Earth(j)); %angolo tra gli asintoti 
delta_deg_Earth = rad2deg(delta_Earth); 

%Uso scrpit per calcolare state vector dopo flyby

StateVector_Earth;

%sposto il vettore posizione dello spacecraft lungo la direzione dopo il
%flyby sfruttando l'anomalia vera
mu  = 1.327*10^11;
coe_flyby = coe_from_sv(r2_fin_e,v_fin_Earth,mu);
Ta_post_flyby = coe_flyby(6);
Ta_for_lambert = Ta_post_flyby:10*(pi/180):2*pi;
for i = 1:length(Ta_for_lambert)
    coe_new = coe_flyby;
    coe_new(6)= Ta_for_lambert(i);
    [r, v] = sv_from_coe(coe_new,mu);
    [V1, V2] = lambert(r, r2_j, t, 'pro');
    d_theta = abs((Ta_post_flyby - Ta_for_lambert)*180/pi);
    d_V = v - V1;
    d_V_norm = norm(d_V);
    if d_V_norm < 26
    %fprintf('\n Starting speed = %s (Km/s)\n ', V1)
    fprintf('\n Delta True anomaly = %g (deg)\n ', d_theta(i))
    %fprintf('\n Starting speed = [%c %c %c] (Km/s)\n ', d_V(1),d_V(2), d_V(3))
    fprintf('\n delta v = %s (Km/s)\n ', d_V_norm)
    fprintf('\n Distance from Jupiter = %g (Km)\n ',r_p_flyby_Earth(j))
    fprintf('\n eccentricity = %g \n ',e_flyby_Earth(j))
    fprintf('\n eccentricity from coe = %g \n ',coe_flyby(2))
    fprintf('\n starting point lambert = [%c %c %c] \n ',r(1),r(2),r(3))
    fprintf('\n-----------------------------------------------------\n')
    end

end
end

