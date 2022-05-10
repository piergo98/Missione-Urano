%% Scelta data di partenza
% A spanne sembra che il momento migliore sia ad agosto del 2022

% Angolo in deg spazzato da Urano durante il TOF
theta = 360 * (TOF_Hohmann/T_circolare_Uranus);

% Angolo relativo tra Terra e Urano alla partenza che devo averee
alpha = 180 - theta;

% noto alpha e imponendo il vettore della terra mi calcolo il vettore
% posizione dalla formula inversa del prodotto scalare, devo fare dei cicli
% for per anno mese e giorno!

% Data di partenza
anno_d = 2022;
mese_d = 7;
giorno_d = 16;
ora_d = 23;
min_d = 59;
sec_d = 32;
departure_date = [anno_d, mese_d, giorno_d, ora_d, min_d, sec_d];

% Data di arrivo
anno_a = 0;
mese_a = 0;
giorno_a = 0;
ora_a = 0;
min_a = 0;
sec_a = 0;
arrive_date = [anno_a, mese_a, giorno_a, ora_a, min_a, sec_a];

% Transformo tutto in sec e calcolo il giorno di arrivo
departure_date_sec = year2seconds(anno_d) + month2seconds(mese_d) + days2seconds(giorno_d) + ora_d * 3600 + min_d * 60 + sec_d;
arrive_date_sec = departure_date_sec + TOF_Hohmann;
arrive_date = sec2date(arrive_date_sec);

% Vettore posizione della terra
[~, r_T, ~, ~] = planet_elements_and_sv(3, anno_d, mese_d, giorno_d, ora_d, min_d, sec_d);

% Vettore posizione di Urano
[~, r_U, ~, ~] = planet_elements_and_sv(7, anno_d, mese_d, giorno_d, ora_d, min_d, sec_d);

% Angolo tra i due vettori posizione
gamma = acosd( (r_T * r_U') / (norm(r_T)*norm(r_U)));

% Differenza tra l'angolo alla partenza richiesto dalla Hohmann e quello
% che si ha nella data di partenza scelta
error = alpha - gamma;
 



