%% Lambert Terra Marte
addpath './Script matlab'
global mu
deg = pi/180;

%...Data declaration:

mu = 1.327*10^11;                   % mu sun (km^3/s^2)
% TOF 
% dt_y = year2seconds(1):year2seconds(1):year2seconds(10);
%dt_m = month2seconds(3):month2seconds(1):month2seconds(8);
dt = year2seconds(1) + month2seconds(5) ;

% for i = 1:length(dt)
    % Position of Earth at the departure (km)
    [coe1_e, r1_e, v1_e, jd1_e] = planet_elements_and_sv(3, 2027, 05, 01, 18, 00, 00);
    
    
    % Position of Jupiter at the arrival  (km)     
    [coe2_m, r2_m, v2_m, jd2_m] = planet_elements_and_sv(4, 2028, 10, 01, 18, 00, 00);
    
    string = 'pro';
    %...
    %dt = year2seconds(3)+ month2seconds(2)+days2seconds(9);     % Total TOF (speriamo)
    %...Algorithm 5.2:
    [v1_l_m, v2_l_m] = lambert(r1_e, r2_m, dt, string);
    v2_l_m
    norm(v2_l_m)


%           plot_orbit(3,2023)
%           plot_orbit(5,2030)

    
    
    % Estrazione elementi orbitali orbita di trasferimento (using r1 and v1):
    coe_e = coe_from_sv(r1_e, v1_l_m, mu);
    % Initial true anomaly:
    TA1_e = rad2deg(coe_e(6));
    
    % Estrazione elementi orbitali orbita di trasferimento (using r2 and v2):
    coe_e = coe_from_sv(r2_m, v2_l_m, mu);
    % Final true anomaly:
    TA2 = rad2deg(coe_e(6));
%     plot_traiettoria_spacecraft(coe, TA1, TA2, 'g')

    %% Assist gravitazionale su Marte
    % Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby.

%Trovo la posizione del pianeta Target

[~, r2_j, v2_j, ~] = planet_elements_and_sv(5, 2032, 07, 01, 00, 00, 00);

%definisco il tempo di volo

t = year2seconds(3) + month2seconds(9);

%Eseguo un ciclo for che varia la posizione di rp e mi modifica delta
GM_Mars = 42828; %[km^3/s^2] 
v_inf_down_Mars = v2_l_m - v2_m ;  
v_inf_down_norm_Mars = norm(v_inf_down_Mars); 

a_flyby_Mars = - GM_Mars/((v_inf_down_norm_Mars)^2);%semiaxis major 
r_p_flyby_Mars = 4e3:2e3:5e5 ;  %hp  
%r_p_flyby_Jupiter = 1e5;
for j = 1:length(r_p_flyby_Mars)
e_flyby_Mars = 1-(r_p_flyby_Mars/a_flyby_Mars); 

delta_Mars = 2*asin(1/e_flyby_Mars(j)); %angolo tra gli asintoti 
delta_deg_Mars = rad2deg(delta_Mars); 

%Uso scrpit per calcolare state vector dopo flyby

StateVector_Mars;

%sposto il vettore posizione dello spacecraft lungo la direzione dopo il
%flyby sfruttando l'anomalia vera
mu  = 1.327*10^11;
coe_flyby = coe_from_sv(r2_fin_m,v_fin_Mars,mu);
Ta_post_flyby = coe_flyby(6);
Ta_for_lambert = Ta_post_flyby:10*(pi/180):Ta_post_flyby+180*(pi/180);
%plotto orbita di Giove
%plot_orbit(5, 2026);
for i = 1:length(Ta_for_lambert)
    coe_new = coe_flyby;
    coe_new(6)= Ta_for_lambert(i);
    [r, v] = sv_from_coe(coe_new,mu);
    [V1, V2] = lambert(r, r2_j, t, 'pro');
    d_theta = abs((Ta_post_flyby - Ta_for_lambert)*180/pi);
    d_V = v - V1;
    d_V_norm = norm(d_V);
     %calcolo del tempo (in sec) per sposatrmi sull'elissoide nel punto in cui
        %faccio lambert
        dT = time_post_flyby(Ta_post_flyby, Ta_for_lambert(i), coe_flyby(7), ...
            coe_flyby(2), mu); 
    
    if d_V_norm < 15.4 && e_flyby_Mars(j)< 15 && dT < month2seconds(6)
         
        %tempo riscritto 
         [years, months, days, hours, minutes, seconds] = sec2date(dT);
        TBF = [years, months, days, hours, minutes, seconds]

        % Estrazione elementi orbitali orbita di trasferimento (using r1 and v1):
        coe = coe_from_sv(r, V1, mu);
        % Initial true anomaly:
        TA1 = rad2deg(coe(6));
    
        % Estrazione elementi orbitali orbita di trasferimento (using r2 and v2):
        coe = coe_from_sv(r2_j, V2, mu);
        % Final true anomaly:
        TA2 = rad2deg(coe(6));
        % Plot of planets orbit and trajectory orbit
%         figure()
%           plot_traiettoria_spacecraft(coe, TA1, TA2, 'g')
%           plot_orbit(4,2023)
%           plot_orbit(5,2030)
        %fprintf('\n Starting speed = %s (Km/s)\n ', V1)
        fprintf('\n Delta True anomaly = %g (deg)\n ', d_theta(i))
        %fprintf('\n Starting speed = [%c %c %c] (Km/s)\n ', d_V(1),d_V(2), d_V(3))
        fprintf('\n Starting speed = [%c %c %c] (Km/s)\n ', V1(1),V1(2), V1(3))
        fprintf('\n Final speed = [%c %c %c] (Km/s)\n ', V2(1),V2(2), V2(3))
        fprintf('\n Actual speed of sp = [%c %c %c] (Km/s)\n ', v(1),v(2), v(3))
        fprintf('\n delta v = %s (Km/s)\n ', d_V_norm)
        fprintf('\n Distance from Jupiter = %g (Km)\n ',r_p_flyby_Mars(j))
        fprintf('\n eccentricity = %g \n ',e_flyby_Mars(j))
        fprintf('\n eccentricity from coe = %g \n ',coe_flyby(2))
        fprintf('\n starting point lambert = [%c %c %c] \n ',r(1),r(2),r(3))
        fprintf('\n-----------------------------------------------------\n')
    end

end
end


   


    %% Lambert Marte Saturno
addpath './Script matlab'
global mu
deg = pi/180;

%...Data declaration:

mu = 1.327*10^11;                   % mu sun (km^3/s^2)
% TOF 

%dt = year2seconds(4);

% for i = 1:length(dt)
    
    
    % Position of Jupiter at the arrival  (km)     
    [coe2_s, r2_s, v2_s, jd2_s] = planet_elements_and_sv(5, 2032, 07, 01, 18, 00, 00);
    
    string = 'pro';
    %...
    dt = year2seconds(3)+ month2seconds(9);     % Total TOF (speriamo)
    %...Algorithm 5.2:
    [v1_l_m, v2_l_s] = lambert(r2_m, r2_s, dt, string);
    Dv = v1_l_m - v2_l_m;
    norm (Dv)
    norm(v1_l_m)
    
    % Estrazione elementi orbitali orbita di trasferimento (using r1 and v1):
    coe_m = coe_from_sv(r1_m, v1_l_m, mu);
    % Initial true anomaly:
    TA1_m = rad2deg(coe_m(6));
    
    % Estrazione elementi orbitali orbita di trasferimento (using r2 and v2):
    coe_m = coe_from_sv(r2_s, v2_l_s, mu);
    % Final true anomaly:
    TA2_m = rad2deg(coe_m(6));
%  plot_traiettoria_spacecraft(coe, TA1, TA2, 'g')
%           plot_orbit(4,2023)
%           plot_orbit(5,2030)
