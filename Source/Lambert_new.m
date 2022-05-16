%% Calcolo per risolvere Lambert dopo Flyby su un pianeta
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby.

%Trovo la posizione del pianeta Target





[~, r2_u, v2_u, ~] = planet_elements_and_sv(7, 2042, 04, 01, 12, 00, 00);


%definisco il tempo di volo

t = year2seconds(6) ;

%definisco velocità finale (opzionale se l'ho definita in precedenza)

v2_l_j = [-8.123309e+00 -1.354161e+00 1.149054e-01];




%v2_l_j = [-6.628555e+00 3.546484e+00 8.320873e-02] ;

%Eseguo un ciclo for che varia la posizione di rp e mi modifica delta
GM_jupiter = 1.26686534e8; %[km^3/s^2] 
v_inf_down_Jupiter = v2_l_j - v2_j ;  
v_inf_down_norm_Jupiter = norm(v_inf_down_Jupiter); 

a_flyby_Jupiter = - GM_jupiter/((v_inf_down_norm_Jupiter)^2);%semiaxis major 
r_p_flyby_Jupiter = 1e5:5e4:1e6 ;  %hp  
%r_p_flyby_Jupiter = 1e5;
for j = 1:length(r_p_flyby_Jupiter)
e_flyby_Jupiter = 1-(r_p_flyby_Jupiter(j)/a_flyby_Jupiter); 

delta_Jupiter = 2*asin(1/e_flyby_Jupiter); %angolo tra gli asintoti 
delta_deg_Jupiter = rad2deg(delta_Jupiter); 

%Uso scrpit per calcolare state vector dopo flyby


StateVector_JUPITER;




mu  = 1.327*10^11;

coe_flyby = coe_from_sv(r2_fin_j,v_fin_Jupiter,mu);
Ta_post_flyby = coe_flyby(6);

Ta_for_lambert = Ta_post_flyby:10*(pi/180):Ta_post_flyby+50*(pi/180); % faccio variare l'anomalia vera

%sposto il vettore posizione dello spacecraft lungo l'elissoide dopo il
%flyby sfruttando l'anomalia vera

for i = 1:length(Ta_for_lambert)
    coe_new = coe_flyby;
    coe_new(6)= Ta_for_lambert(i);
    [r, v] = sv_from_coe(coe_new,mu);

    [V1, V2] = lambert(r, r2_u, t, 'pro');
    d_theta = abs((Ta_post_flyby - Ta_for_lambert)*180/pi);
    d_V = v - V1;
    d_V_norm = norm(d_V);


    %calcolo del tempo (in sec) per sposatrmi sull'elissoide nel punto in cui
        %faccio lambert
    dT = time_post_flyby(Ta_post_flyby, Ta_for_lambert(i), coe_flyby(7), ...
           coe_flyby(2), mu); 
    if d_V_norm < 4 && dT < month2seconds(6) % condizione di minimo deltaV
       
        % tempo riscritto 
        [years, months, days, hours, minutes, seconds] = sec2date(abs(dT));
        TBF = [years, months, days, hours, minutes, seconds]
         % Estrazione elementi orbitali orbita di trasferimento (using r1 and v1):
        coe = coe_from_sv(r, V1, mu);
        % Initial true anomaly:
        TA1(i,j) = rad2deg(coe(6));
    
        % Estrazione elementi orbitali orbita di trasferimento (using r2 and v2):
        coe = coe_from_sv(r2_j, V2, mu);
        % Final true anomaly:
        TA2(i,j) = rad2deg(coe(6));

        %fprintf('\n Starting speed = %s (Km/s)\n ', V1)
        fprintf('\n Delta True anomaly = %g (deg)\n ', d_theta(i))
        fprintf('\n Starting speed = [%c %c %c] (Km/s)\n ', V1(1),V1(2), V1(3))
        fprintf('\n Final speed = [%c %c %c] (Km/s)\n ', V2(1),V2(2), V2(3))
        fprintf('\n Actual speed of sp = [%c %c %c] (Km/s)\n ', v(1),v(2), v(3))
        fprintf('\n delta v = %s (Km/s)\n ', d_V_norm)
        fprintf('\n Distance from Jupiter = %g (Km)\n ',r_p_flyby_Jupiter(j))
        fprintf('\n eccentricity = %g \n ',e_flyby_Jupiter)
        fprintf('\n eccentricity from coe = %g \n ',coe_flyby(2))
        fprintf('\n starting point lambert = [%c %c %c] \n ',r(1),r(2),r(3))
        fprintf('\n time before lambert = %g \n ',dT)
        fprintf('\n indices = [%g %g] \n ',i , j)
        fprintf('\n-----------------------------------------------------\n')


    end

end
end

