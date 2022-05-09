%% MISSIONE COMPLETA: Terra-Terra-Saturno-Urano

    % Inizializzo la missione
    init_Terra_Terra_Saturno_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Earth_Saturn_Uranus;

%% Fase Terra-Terra

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;

    % Fly-by sulla Terra
    flyby_Earth_time;
    plot_flyby(r_Earth, R_SOI_Earth, e_flyby_Earth, p_Earth, f_in_Earth_deg, r_p_flyby_Earth);

%% Fase Terra-Saturno

    % Fly-by su Saturno
    flyby_Saturn_time;
    plot_flyby(r_Saturn, R_SOI_Saturn, e_flyby_Saturn, p_Saturn, f_in_Saturn_deg, r_p_flyby_Saturn);

%% Fase Saturno-Urano

    % Cattura su Urano
    Uranus_capture;
    
    % Cambio piano da Eclittica a Equatoriale
    Uranus_orbital_plane_shift;
    
%% Cacolo Delta Velocita' totale

    DeltaV;

%% Time of Flight totale