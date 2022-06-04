%% MISSIONE COMPLETA: Hohmann
    
    close all
    clear
    clc
    
    % Inizializzo la missione
    init_Hohmann;

    % Calcolo le Traiettorie di Hohmann
    Hohmann;

    fprintf("\n MISSIONE URANO - HOHMANN \n");
    fprintf('\n-----------------------------------------------------\n')

%% Fase Sfera di influenza Terra
    
    partenza = datetime(2022, 7, 16, 23, 59, 30);
    str_partenza = datestr(partenza);
    fprintf("\n Data di partenza dall'orbita di parcheggio sulla Terra = %s \n", str_partenza);
    fprintf('\n-----------------------------------------------------\n')

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;
    

%% Fase Terra-Urano

    fprintf('\n Parametri Hohmann Terra-Urano:')
    fprintf('\n Eccentricità orbita di trasferimento = %g \n', e_Hohmann)
%     fprintf('\n Data di partenza dalla Terra = [%g, %g, %g, %g, %g, %g] (anno, mese, giorno, ora, min, sec) \n', departure_date);
    fprintf('\n TOF_HOHMANN = %g (anni)\n', seconds2year(TOF_Hohmann))
    fprintf('\n Data Ingresso nella sfera di influenza di Urano = [%g, %g, %g, %g, %g, %g] (anno, mese, giorno, ora, min, sec) \n', arrive_date)
    fprintf('\n-----------------------------------------------------\n')
   
    Solar_System_animation;

%% Fase cattura su Urano
 
    % Cattura su Urano
    Uranus_capture;
    
    % Cambio piano da Eclittica a Equatoriale
    Uranus_orbital_plane_shift;
    
%% Calcolo tempo di volo complessivo

    arrivo = datetime(2022, 7, 16, 23, 59, 30) + seconds(TOF_Hohmann) + ...
        seconds(t_tot_capture_Uranus) + seconds(deltaT_min);
    str_arrivo = datestr(arrivo);
    fprintf("\n Data di fine missione = %s \n", str_arrivo)

 %% Calcolo Delta Velocita' totale

    DeltaV;