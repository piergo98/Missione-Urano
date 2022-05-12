%% Hohmann Transfer from Earth to Uranus
% Manovra di trasferimento a due impulsi su orbita ellittica da Terra ad Urano

%% Dati del problema 

init_Hohmann;

% Raggio delle orbite circolari iniziale e finale
r_iniziale_Hohmann = d_Earth2Sun;
r_finale_Hohoman = d_Uranus2Sun;

% Velocità sulle orbite circolari iniziale e finale
v_circolare_Earth = sqrt(mu_Sun/d_Earth2Sun);
v_circolare_Uranus = sqrt(mu_Sun/d_Uranus2Sun);

% Periodo delle orbite circolari iniziale e finale ( in secondi)
T_circolare_Earth = 2*pi*sqrt((d_Earth2Sun)^3 / mu_Sun);
T_circolare_Uranus = 2*pi*sqrt((d_Uranus2Sun)^3 / mu_Sun);

%% Parmaetri orbita di trasferimento 

% Apoasse dell'orbita di trasferimento
a_Hohmann = (r_iniziale_Hohmann + r_finale_Hohoman) / 2;

% Eccentricità dell'orbita di trasferimento
e_Hohmann = 1 - r_iniziale_Hohmann/a_Hohmann;

% Velocità pericentro orbita di trasferimento (ricavata dall'eq dell'Ener)
v_p_Hohmann = sqrt((mu_Sun/r_iniziale_Hohmann) * (2 - 2 / (1 + (r_finale_Hohoman/r_iniziale_Hohmann))));

% DeltaV del primo impulso (pericentro)
deltaV_p = v_p_Hohmann - v_circolare_Earth;

% Velocità apocentro orbita di trasferimento (ricavata da eq dell'Ener)
v_a_Hohmann = sqrt((mu_Sun/r_finale_Hohoman)*(2 - (2*r_finale_Hohoman/r_iniziale_Hohmann)/(1 + r_finale_Hohoman/r_iniziale_Hohmann))); 

% DeltaV del secondo impulso (apocentro)
deltaV_a = v_circolare_Uranus - v_a_Hohmann;

% DeltaV totale di Hohmann
deltaV_Hohmann = deltaV_p + deltaV_a;

% Tempo necessario per effettuare la Manovra di Hohmann (metà periodo
% orbita di trasferimento)
TOF_Hohmann = pi * sqrt(a_Hohmann^3 / mu_Sun); % in [sec]

%% Date di partenza e arrivo

Departure_and_arrive_date;

%% Info

fprintf('\n Hohmann Earth-Uranus results \n')
fprintf('\n Eccentricità orbita di trasferimento = %g \n', e_Hohmann)
fprintf('\n Delta V = %g (km/s)\n', deltaV_Hohmann)
fprintf('\n TOF = %g (years)\n', seconds2year(TOF_Hohmann))
if abs(error) <= 1e-5
    fprintf('\n La data di partenza scelta soddisfa i requisiti della Hohmann!\n')
    fprintf('\n Data di partenza dalla Terra = [%g, %g, %g, %g, %g, %g] (anno, mese, giorno, ora, min, sec) \n', departure_date);
    fprintf('\n Data di arrivo su Urano = [%g, %g, %g, %g, %g, %g] (anno, mese, giorno, ora, min, sec) \n', arrive_date);
else
    fprintf('\n La data di partenza scelta NON soddisfa i requisiti della Hohmann!\n')
end
fprintf('\n-----------------------------------------------------\n')

%% Plot

% % coe dell'orbita di Hohmann
% coe_Hohmann = [ 0, e_Hohmann, 0, 0, 0, 0, a_Hohmann];
% 
% % Orbita della Terra
% plot_orbit(3, 2022);
% 
% hold on
% grid on
% 
% % Orbita di Urano
% circle_plot(0,0,d_Uranus2Sun, "#4DBEEE");
% 
% % Orbita di Hohmann
% plot_traiettoria_spacecraft(coe_Hohmann, 0, 180, 'g');
% 
% axis equal

