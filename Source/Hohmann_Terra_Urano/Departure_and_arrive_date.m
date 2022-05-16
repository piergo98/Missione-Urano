%% Scelta data di partenza
% A spanne sembra che il momento migliore sia ad agosto del 2022

% Angolo in rad che devo avere alla partenza tra Terra e Urano
theta_Hohmann = pi * (1 - sqrt(((1 + r_iniziale_Hohmann / r_finale_Hohoman) / 2)^3));  % Formula (8.2) Mengali 

% Data di partenza
anno_d = 2022;
mese_d = 7;
giorno_d = 16;
ora_d = 23;
min_d = 59;
sec_d = 30;
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
[coe_U, r_Ud, ~, ~] = planet_elements_and_sv(7, anno_d, mese_d, giorno_d, ora_d, min_d, sec_d);

% Vettore posizione di Urano all'arrivo
[coe_U_fin, r_Ua, ~, ~] = planet_elements_and_sv(7, anno_a, mese_a, giorno_a, ora_a, min_a, sec_a);


% Angolo effettivo tra Urano e Terra alla partenza calcolato dagli sv
theta = acos(r_Ud * r_T' / (norm(r_Ud) * norm(r_T)));

% Differenza tra l'angolo alla partenza richiesto dalla Hohmann e quello
% che si ha nella data di partenza scelta
error = theta_Hohmann - theta;





