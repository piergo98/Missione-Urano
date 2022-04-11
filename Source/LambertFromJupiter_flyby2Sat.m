%% Calcolo per risolvere Lambert dopo Flyby su un pianeta
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby.

SOI_JUPITER;

%Trovo la posizione del pianeta Target

[~, r2_s, v2_s, ~] = planet_elements_and_sv(6, 2031, 04, 01, 12, 00, 00);

%definisco il tempo di volo

% Definisco il tempo di volo
t_Jupiter = datetime(2024, 07, 24, 08, 14, 54);
t_Saturn = datetime(2031, 04, 01, 12, 00, 00);
  
time_diff = days(t_Saturn - t_Jupiter);
t = time_diff*24*3600;

%Eseguo un ciclo for che varia la posizione di rp e mi modifica delta
mu_Jupiter = 1.26686534e8; %[km^3/s^2] 

%velocità in uscita da Jupiter
v_inf_down_Jupiter = v2_l_j - v2_j;  
v_inf_down_norm_Jupiter = norm(v_inf_down_Jupiter); 

%semiaxis major
a_flyby_Jupiter = - mu_Jupiter / ((v_inf_down_norm_Jupiter)^2);   

%hp
%r_p_flyby_Jupiter =503800 ;    

r_p_flyby_Jupiter = 1e4:5e3:9e5 ;  %hp  

for j = 1:length(r_p_flyby_Jupiter)
    e_flyby_Jupiter = 1-(r_p_flyby_Jupiter/a_flyby_Jupiter); 
    
    delta_Jupiter = 2*asin(1/e_flyby_Jupiter(j)); %angolo tra gli asintoti 
    delta_deg_Jupiter = rad2deg(delta_Jupiter); 
    
    %Uso scrpit per calcolare state vector dopo flyby
    
    StateVector_JUPITER;
    
    %sposto il vettore posizione dello spacecraft lungo la direzione dopo il
    %flyby sfruttando l'anomalia vera
    mu  = 1.327*10^11;
    coe_flyby = coe_from_sv(r2_fin_e,v_fin_Jupiter,mu);
    Ta_post_flyby = coe_flyby(6);
    Ta_for_lambert = Ta_post_flyby:10*(pi/180):2*pi;
    %plotto orbita di Saturno
%    plot_orbit(6, 2026);
    for i = 1:length(Ta_for_lambert)
        coe_new = coe_flyby;
        coe_new(6)= Ta_for_lambert(i);
        [r, v] = sv_from_coe(coe_new,mu);
        [V1, V2] = lambert(r, r2_s, t, 'pro');
        d_theta = abs((Ta_post_flyby - Ta_for_lambert)*180/pi);
        d_V = v - V1;
        d_V_norm = norm(d_V);
        
        if d_V_norm < 33.8
    
            % Estrazione elementi orbitali orbita di trasferimento (using r1 and v1):
            coe = coe_from_sv(r, V1, mu);
            % Initial true anomaly:
            TA1 = rad2deg(coe(6));
        
            % Estrazione elementi orbitali orbita di trasferimento (using r2 and v2):
            coe = coe_from_sv(r2_s, V2, mu);
            % Final true anomaly:
            TA2 = rad2deg(coe(6));
            % Plot of planets orbit and trajectory orbit
            plot_traiettoria_spacecraft(coe, TA1, TA2, 'g')
            %fprintf('\n Starting speed = %s (Km/s)\n ', V1)
            fprintf('\n Delta True anomaly = %g (deg)\n ', d_theta(i))
            %fprintf('\n Starting speed = [%c %c %c] (Km/s)\n ', d_V(1),d_V(2), d_V(3))
            fprintf('\n delta v = %s (Km/s)\n ', d_V_norm)
            fprintf('\n Distance from Jupiter = %g (Km)\n ',r_p_flyby_Jupiter(j))
            fprintf('\n eccentricity = %g \n ',e_flyby_Jupiter(j))
            fprintf('\n eccentricity from coe = %g \n ',coe_flyby(2))
            fprintf('\n starting point lambert = [%c %c %c] \n ',r(1),r(2),r(3))
            fprintf('\n-----------------------------------------------------\n')
        end
    
    end
end

