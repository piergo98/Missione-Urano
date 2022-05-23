%% MISSIONE COMPLETA: Terra-Terra-Saturno-Urano

    % Inizializzo la missione
    init_Terra_Giove_Saturno_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Jupiter_Saturn_Uranus;

%% Fase Terra-Terra

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;

%% Fase Terra-Giove

    % Fly-by su Giove
    flyby_Jupiter_time;
%% Fase Giove-Saturno

    % Fly-by su Saturno
    flyby_Saturn_time;


%% Flight totale

    % volo totale
    Solar_System_animation


%% Fase Saturno-Urano

    % Cattura su Urano
    Uranus_capture;
    
    % Cambio piano da Eclittica a Equatoriale
    Uranus_orbital_plane_shift;
    
%% Cacolo Delta Velocita' totale

    DeltaV;

%% Time of Flight totale