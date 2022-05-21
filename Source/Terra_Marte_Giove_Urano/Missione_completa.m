%% MISSIONE COMPLETA: Terra-Marte-Giove-Urano

    % Inizializzo la missione
    init_Terra_Marte_Giove_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Mars_Jupiter_Uranus;

%% Fase Terra-Marte

    fprintf("\n Partenza dall'orbita di parcheggio sulla Terra il 2027/05/01 ore 18:00:00 \n");

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;

    fprintf('\n Ingresso nella sfera di influenza di Marte il 2028/10/01 ore 18:00:00 \n');

    % Fly-by sulla Marte
    flyby_Mars_time;
    
%% Fase Terra-Giove

    fprintf('\n Ingresso nella sfera di influenza di Giove il 2032/07/01 ore 00:00:00 \n');
    
    % Fly-by su Giove
    flyby_Jupiter_time;

%% Flight totale
    
    Solar_System_animation;

%% Fase Giove-Urano

    fprintf('\n Ingresso nella sfera di influenza di Urano il 2038/07/01 ore 00:00:00');

    % Cattura su Urano
    Uranus_capture;
    
    % Cambio piano da Eclittica a Equatoriale
    Uranus_orbital_plane_shift;
    
%% Cacolo Delta Velocita' totale

    DeltaV;
