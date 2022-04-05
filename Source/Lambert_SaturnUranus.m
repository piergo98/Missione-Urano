%% Calcolo per risolvere Lambert dopo Flyby su un pianeta
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby.

SOI_Saturn;

%Trovo la posizione del pianeta Target

[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2036, 10, 03, 00, 00, 00);

%definisco il tempo di volo

t = year2seconds(6);

%Eseguo un ciclo for che varia la posizione di rp e mi modifica delta
GM_saturn = 37931187; %[km^3/s^2] 
v_inf_down_saturn = [-1.308904e+00 9.744000e+00 -2.282013e-01] - v2_s ;  
v_inf_down_norm_saturn = norm(v_inf_down_saturn); 

a_flyby_saturn = - GM_saturn/((v_inf_down_norm_saturn)^2);%semiaxis major 
r_p_flyby_saturn = 3e5:1e5:3e7 ;  %hp  
%r_p_flyby_Jupiter = 1e5;
for j = 1:length(r_p_flyby_saturn)
e_flyby_saturn(j) = 1-(r_p_flyby_saturn(j)/a_flyby_saturn); 

delta_saturn = 2*asin(1/e_flyby_saturn(j)); %angolo tra gli asintoti 
delta_deg_saturn = rad2deg(delta_saturn); 

%Uso scrpit per calcolare state vector dopo flyby

stateVector_saturn;

%sposto il vettore posizione dello spacecraft lungo la direzione dopo il
%flyby sfruttando l'anomalia vera
mu  = 1.327*10^11;
coe_flyby = coe_from_sv(r2_fin_s,v_fin_saturn,mu);
Ta_post_flyby = coe_flyby(6);
Ta_for_lambert = Ta_post_flyby:10*(pi/180):Ta_post_flyby+pi;
%plotto orbita di Giove
%plot_orbit(5, 2026);
for i = 1:length(Ta_for_lambert)
    coe_new = coe_flyby;
    coe_new(6)= Ta_for_lambert(i);
    [r, v] = sv_from_coe(coe_new,mu);
    [V1, V2] = lambert(r, r2_u, t, 'pro');
    d_theta = abs((Ta_post_flyby - Ta_for_lambert)*180/pi);
    d_V = v - V1;
    d_V_norm = norm(d_V);
    
    if d_V_norm < 2 && e_flyby_saturn(j) < 6

        % Estrazione elementi orbitali orbita di trasferimento (using r1 and v1):
        coe = coe_from_sv(r, V1, mu);
        % Initial true anomaly:
        TA1 = rad2deg(coe(6));
    
        % Estrazione elementi orbitali orbita di trasferimento (using r2 and v2):
        coe = coe_from_sv(r2_u, V2, mu);
        % Final true anomaly:
        TA2 = rad2deg(coe(6));
        % Plot of planets orbit and trajectory orbit
%         plot_traiettoria_spacecraft(coe, TA1, TA2, 'g')
        %fprintf('\n Starting speed = %s (Km/s)\n ', V1)
        fprintf('\n Delta True anomaly = %g (deg)\n ', d_theta(i))
        %fprintf('\n Starting speed = [%c %c %c] (Km/s)\n ', d_V(1),d_V(2), d_V(3))
        fprintf('\n Starting speed = [%c %c %c] (Km/s)\n ', V1(1),V1(2), V1(3))
        fprintf('\n Final speed = [%c %c %c] (Km/s)\n ', V2(1),V2(2), V2(3))
        fprintf('\n Actual speed of sp = [%c %c %c] (Km/s)\n ', v(1),v(2), v(3))
        fprintf('\n delta v = %s (Km/s)\n ', d_V_norm)
        fprintf('\n Distance from Jupiter = %g (Km)\n ',r_p_flyby_saturn(j))
        fprintf('\n eccentricity = %g \n ',e_flyby_saturn(j))
        fprintf('\n eccentricity from coe = %g \n ',coe_flyby(2))
        fprintf('\n starting point lambert = [%c %c %c] \n ',r(1),r(2),r(3))
        fprintf('\n-----------------------------------------------------\n')
    end

end
end
