%% Calcolo per risolvere Lambert dopo Flyby su un pianeta
% Modifico vettore di posizione nel tempo in dipendenza dell'angolo di
% Flyby.
%Uso scrpit per calcolare state vector dopo flyby

StateVector_flyby;

%Trovo la posizione del pianeta Target

[~, r2_s, v2_s, ~] = planet_elements_and_sv(6, 2031, 04, 01, 12, 00, 00);

%definisco il tempo di volo
t = year2seconds(2);
%sposto il vettore posizione dello spacecraft lungo la direzione dopo il
%flyby sfruttando l'anomalia vera

coe_flyby = coe_from_sv(r2_fin_j,v_fin_Jupiter,mu);
Ta_post_flyby = coe_flyby(6);
Ta_for_lambert = Ta_post_flyby:10*(pi/180):(3/2)*pi;
for i = 1:length(Ta_for_lambert)
    coe_new = coe_flyby;
    coe_new(6)= Ta_for_lambert(i);
    [r, v] = sv_from_coe(coe_new,mu);
    [V1, V2] = lambert(r, r2_s, t, 'pro');
    d_theta = abs((Ta_post_flyby - Ta_for_lambert)*180/pi);
    d_V = v_fin_Jupiter - V1;
    d_V_norm = norm(d_V);
    %fprintf('\n Starting speed = %s (Km/s)\n ', V1)
    fprintf('\n Delta True anomaly = %g (deg)\n ', d_theta(i))
    %fprintf('\n Starting speed = [%c %c %c] (Km/s)\n ', d_V(1),d_V(2), d_V(3))
    fprintf('\n delta v = %s (Km/s)\n ', d_V_norm)


end


