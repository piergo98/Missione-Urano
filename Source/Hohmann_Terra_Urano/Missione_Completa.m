%% MISSIONE COMPLETA: Terra-Terra-Saturno-Urano

    % Inizializzo la missione
    init_Hohmann;

    % Calcolo le Traiettorie di Hohmann
    Hohmann;

%% Fase Sfera di influenza Terra

    fprintf("\n Partenza dall'orbita di parcheggio sulla Terra il 2022/07/16 ore 23:59:30 \n");
    fprintf('\n-----------------------------------------------------\n')

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;

%% Fase Terra-Urano

    fprintf('\n Parametri Hohmann Terra-Urano \n')
    fprintf('\n Eccentricità orbita di trasferimento = %g \n', e_Hohmann)
    fprintf('\n Data di partenza dalla Terra = [%g, %g, %g, %g, %g, %g] (anno, mese, giorno, ora, min, sec) \n', departure_date);
    fprintf('\n-----------------------------------------------------\n')
   
    Solar_System_animation;

%% Fase Saturno-Urano
    
    fprintf('\n Data Ingresso nella sfera di influenza di Urano = [%g, %g, %g, %g, %g, %g] (anno, mese, giorno, ora, min, sec) \n', arrive_date);
 
    % Cattura su Urano
    Uranus_capture;
    
    % Cambio piano da Eclittica a Equatoriale
    Uranus_orbital_plane_shift;

%% Cacolo Delta Velocita' totale

    DeltaV;
