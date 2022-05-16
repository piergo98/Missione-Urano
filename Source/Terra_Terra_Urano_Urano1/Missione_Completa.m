%% MISSIONE COMPLETA: Terra-Terra-Saturno-Urano

    % Inizializzo la missione
    init_Terra_Terra_Urano_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Earth_Uranus_Uranus;

%% Fase Terra-Terra

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;

    % Fly-by sulla Terra
    flyby_Earth_time;
    
%% Fase Terra-Urano

    % Fly-by su Urano
    flyby_Uranus_time;

%% Flight totale
    
    Solar_System_animation;
    
%% Fase Urano-Urano

    % Cattura su Urano
    Uranus_capture;
    
    % Cambio piano da Eclittica a Equatoriale
    Uranus_orbital_plane_shift;
    
%% Cacolo Delta Velocita' totale

    DeltaV;
