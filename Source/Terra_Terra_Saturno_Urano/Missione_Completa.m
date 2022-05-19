%% MISSIONE COMPLETA: Terra-Terra-Saturno-Urano

    % Inizializzo la missione
    init_Terra_Terra_Saturno_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Earth_Saturn_Uranus;

%% Fase Terra-Terra

    fprintf("\n Partenza dall'orbita di parcheggio sulla Terra il 2023/03/01 ore 18:00:00 \n");

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;

    fprintf('\n Ingresso nella sfera di influenza della Terra il 2024/03/01 ore 18:00:00 \n');

    % Fly-by sulla Terra
    flyby_Earth_time;
    
%% Fase Terra-Saturno

    fprintf('\n Ingresso nella sfera di influenza di Saturno il 2030/08/01 ore 00:00:00 \n');

    % Fly-by su Saturno
    flyby_Saturn_time;

%% Flight totale
    
    Solar_System_animation;

%% Fase Saturno-Urano

    fprintf('\n Ingresso nella sfera di influenza di Urano il 2036/08/01 ore 00:00:00');

    % Cattura su Urano
    Uranus_capture;
    
    % Cambio piano da Eclittica a Equatoriale
    Uranus_orbital_plane_shift;
    
%% Cacolo Delta Velocita' totale

    DeltaV;
