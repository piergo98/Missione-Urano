%% MISSIONE COMPLETA: Terra-Terra-Saturno-Urano

    % Inizializzo la missione
    init_Terra_Terra_Saturno_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Earth_Saturn_Uranus;

    fprintf("\n MISSIONE TERRA-TERRA-SATURNO-URANO \n");
    fprintf('\n-----------------------------------------------------\n')

%% Fase Terra-Terra

    fprintf("\n Partenza dall'orbita di parcheggio sulla Terra il 2023/03/01 ore 18:00:00 \n");
    fprintf('\n-----------------------------------------------------\n')

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;
    
    fprintf('\n Tempo di volo trascorso sulla traiettoria di Lambert da Terra a Terra %g (s)\n',t_EE);
    fprintf('\n Ingresso nella sfera di influenza della Terra il 2024/03/01 ore 18:00:00 \n');
    fprintf('\n-----------------------------------------------------\n')

    % Fly-by sulla Terra
    flyby_Earth_time;
    
%% Fase Terra-Saturno

    fprintf('\n Tempo di volo trascorso sulla traiettoria di Lambert da Terra a Saturno %g (s)\n',t_fS);
    fprintf('\n Ingresso nella sfera di influenza di Saturno il 2030/08/01 ore 00:00:00 \n');
    fprintf('\n-----------------------------------------------------\n')

    % Fly-by su Saturno
    flyby_Saturn_time;

%% Flight totale
    
    Solar_System_animation;

%% Fase Saturno-Urano

    fprintf('\n Tempo di volo trascorso sulla traiettoria di Lambert da Saturno a Urano %g (s)\n',t_SU);
    fprintf('\n Ingresso nella sfera di influenza di Urano il 2036/08/01 ore 00:00:00');
    fprintf('\n-----------------------------------------------------\n')

    % Cattura su Urano
    Uranus_capture;
    
    % Cambio piano da Eclittica a Equatoriale
    Uranus_orbital_plane_shift;

    arrivo = datetime(2036, 08, 01, 00, 00, 00) + ...
        seconds(t_tot_capture_Uranus) + seconds(deltaT_min);
    str_arrivo = datestr(arrivo);
    fprintf("\n Data di fine missione = %s \n", str_arrivo)

%% Cacolo Delta Velocita' totale

    DeltaV;
