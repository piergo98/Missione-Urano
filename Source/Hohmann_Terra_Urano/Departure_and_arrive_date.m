%% Scelta data di partenza
% A spanne sembra che il momento migliore sia ad agosto del 2022

% Angolo in deg spazzato da Urano durante il TOF
theta = 360 * (TOF_Hohmann/T_circolare_Uranus);

% noto alpha e imponendo il vettore della terra mi calcolo il vettore
% posizione dalla formula inversa del prodotto scalare, devo fare dei cicli
% for per anno mese e giorno!

% Data di partenza
anno_d = 2023;
mese_d = 1;
giorno_d = 31;
ora_d = 10;
min_d = 35;
sec_d = 50;
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

% Aggiorno le date
anno_a = arrive_date(1);
mese_a = arrive_date(2);
giorno_a = arrive_date(3);
ora_a = arrive_date(4);
min_a = arrive_date(5);
sec_a = arrive_date(6);

% Vettore posizione della terra
[coe_T, r_T, ~, ~] = planet_elements_and_sv(3, anno_d, mese_d, giorno_d, ora_d, min_d, sec_d);

% % Vettore posizione di Urano alla partenza
% [coe_U, r_U, ~, ~] = planet_elements_and_sv(7, anno_d, mese_d, giorno_d, ora_d, min_d, sec_d);

% Vettore posizione di Urano all'arrivo
[coe_U, r_U, ~, ~] = planet_elements_and_sv(7, anno_a, mese_a, giorno_a, ora_a, min_a, sec_a);

% % Angolo relativo tra Terra e Urano alla partenza che devo averee NOOOO!!!!
% % QUESTA È L'ANOMALIA VERA CHE URANO DEVE AVERE ALLA PARTENZA!!!!!
% alpha =rad2deg(coe_T(6)) + 180 - theta;

% Angolo tra i due vettori posizione
% gamma = acosd( (r_T * r_U') / (norm(r_T)*norm(r_U)));

% Anomalia vera di Urano all'arrivo
 gamma = rad2deg(coe_U(6) - coe_U(5));

% Differenza tra l'angolo alla partenza richiesto dalla Hohmann e quello
% che si ha nella data di partenza scelta

% Anomalia vera che Urano deve avere all'arrivo meno quella calcolata
% se zero la data di partenza è corretta
error = rad2deg(coe_T(6) + pi) - gamma

%% Lambert come Hohmann

[v1_H, v2_H] = lambert(r_T, r_U, TOF_Hohmann, mu_Sun);

coe_Hohmann = coe_from_sv(r_T, v1_H, mu_Sun);
TA1_eu = rad2deg(coe_Hohmann(6));

coe_Hohmann = coe_from_sv(r_U, v2_H, mu_Sun);
TA2_eu = rad2deg(coe_Hohmann(6));



