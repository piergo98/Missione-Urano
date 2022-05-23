%% MISSIONE COMPLETA: Terra-Marte-Saturno-Urano

    % Inizializzo la missione
    init_Terra_Marte_Saturno_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Mars_Saturn_Uranus;

%% Fase Terra-Marte

    fprintf("\n Partenza dall'orbita di parcheggio sulla Terra il 2022/09/01 ore 18:00:00 \n");

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;

%% Fase Marte-Saturno

    fprintf('\n Ingresso nella sfera di influenza di Marte il 2023/10/01 ore 18:00:00\n');

    % Fly-by su Marte
    flyby_Mars_time;
    
%% Fase Marte-Saturno

%     [years, months, days, hours, minutes, seconds] = sec2date(dT_post_flyby);
%     fprintf('\n Continuo su una traiettoria eliocentrica per %g mesi, %g giorni, %g ore, %g minuti \n',...
%         months,days,hours,minutes);
%     fprintf('\n--------------------------------------------------------\n\n')

    fprintf('\n Ingresso nella sfera di influenza di Saturno il 2028/10/01 ore 00:00:00\n');

    % Fly-by su Saturno
    flyby_Saturn_time;

%% Flight totale

    Solar_System_animation;

%% Fase Saturno-Urano

    fprintf('\n Ingresso nella sfera di influenza di Urano il 2034/10/01 ore 00:00:00');

    % Cattura su Urano
    Uranus_capture;
    
    % Cambio piano da Eclittica a Equatoriale
    Uranus_orbital_plane_shift;

%% Cacolo Delta Velocita' totale

    DeltaV;
