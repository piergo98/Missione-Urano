% Funzione per il calcolo del tempo di volo su traiettoria ellittica a
% seguito dell'uscita dalla SOI di un pianeta dopo flyby

% f1 = anomalia vera nel punto in cui lo spacecraft esce dalla SOI
% f2 = anomalia vera nel punto in cui avverrà il delta V
% a = semiasse maggiore orbita ellittica
% e = eccentricità dell'orbita
% mu = mu pianeta/stella attorno a cui ruota l'orbita

function dT = time_post_flyby(f1, f2, a, e, mu)
    % Tangente anomalia eccentrica in uscita dalla SOI
    tg_E1 = sqrt((1-e) / (1+e)) * tan(f1/2);
    % Anomalia eccentrica
    E1 = 2 * atan(tg_E1);
    % Anomalia media
    M1 = E1 - e*sin(E1);
    % Mean motion
    n = sqrt(mu/a^3);
    % Tempo di volo dal perielio fino all'uscita dalla SOI (solo per i
    % calcoli)
    t1 = M1 / n;
    % Tangente anomalia eccentrica nel punto in cui avverrà il delta V
    tg_E2 = sqrt((1-e) / (1+e)) * tan(f2/2);
    % Anomalia eccentrica
    E2 = 2 * atan(tg_E2);
    % Anomalia media
    M2 = E2 - e*sin(E2);
    % Tempo di volo dal perielio fino al punto in cui avverrà il delta V
    t2 = M2 / n;
    % Calcolo il delta T
    dT = t2 - t1;
end