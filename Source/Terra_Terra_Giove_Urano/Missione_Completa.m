%% MISSIONE COMPLETA: Terra-Terra-Saturno-Urano

    % Inizializzo la missione
    init_Terra_Terra_Giove_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Earth_Jupiter_Uranus;

%% Fase Terra-Terra

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;

    % Fly-by sulla Terra
    flyby_Earth_time;
    
%% Fase Terra-Giove

    % Fly-by su Saturno
    flyby_Jupiter_time;

%% Flight totale
    
    Solar_System_animation;
    
%% Fase Saturno-Urano

    % Cattura su Urano
    Uranus_capture;
    
    % Cambio piano da Eclittica a Equatoriale
    Uranus_orbital_plane_shift;
    
%% Cacolo Delta Velocita' totale

    DeltaV;
