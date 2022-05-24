%% MISSIONE COMPLETA: Terra-Marte-Giove-Urano
    
    close all; clear; clc

    % Inizializzo la missione
    init_Terra_Marte_Giove_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Mars_Jupiter_Uranus;

    fprintf("\n MISSIONE TERRA-MARTE-GIOVE-URANO \n");
    fprintf('\n-----------------------------------------------------\n')

%% Fase Fase Sfera di influenza Terra

    partenza = datetime(2027, 5, 01, 18, 00, 00);
    str_partenza = datestr(partenza);
    fprintf("\n Data di partenza dall'orbita di parcheggio sulla Terra = %s \n", str_partenza);
    fprintf('\n-----------------------------------------------------\n')

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;

%% Fase Terra-Marte

    ingresso_SOI_Marte = partenza + seconds(t_EM) + seconds(t_tot_escape_Earth);
    str_ingresso_SOI_Marte = datestr(ingresso_SOI_Marte);
    
    % Fly-by sulla Marte
    flyby_Mars_time;
    fprintf("\n Fase Terra-Marte:")
    fprintf('\n Tempo di volo trascorso da Terra a Marte %g (giorni)\n', t_EM_days);
    fprintf('\n Data di ingresso nella sfera di influenza di Marte = %s \n', str_ingresso_SOI_Marte);
    
    fprintf('\n Quota minima del flyby su Marte = %g (km)', r_p_flyby_Mars)
    fprintf('\n Durata flyby Marte = %g (ore).',t_flyby_tot_hours_Mars)    
    fprintf('\n--------------------------------------------------------\n')
    
%% Fase Marte-Giove

    ingresso_SOI_Giove = ingresso_SOI_Marte + seconds(t_MJ) + seconds(t_flyby_tot_Mars);
    str_ingresso_SOI_Giove = datestr(ingresso_SOI_Giove);
    
    % Fly-by su Giove
    flyby_Jupiter_time;
    fprintf("\n Fase Marte-Giove:")
    fprintf('\n Tempo di volo trascorso da Terra a Giove %g (giorni)\n', t_MJ_days);
    fprintf('\n Data di ingresso nella sfera di influenza di Giove = %s \n', str_ingresso_SOI_Giove);
    
    fprintf('\n Quota minima del flyby su Giove = %g (km)', r_p_flyby_Jupiter)
    fprintf('\n Durata flyby Giove = %g (ore).',t_flyby_tot_hours_Jupiter)    
    fprintf('\n--------------------------------------------------------\n')

%% Flight totale
    
    Solar_System_animation;

%% Fase Giove-Urano

    ingresso_SOI_Urano = ingresso_SOI_Giove + seconds(t_JU) + seconds(t_flyby_tot_Jupiter);
    str_ingresso_SOI_Urano = datestr(ingresso_SOI_Urano);
    
    fprintf("\n Fase Giove-Urano:")
    fprintf('\n Tempo di volo trascorso da Giove a Urano %g (giorni)\n',t_JU_days);
    fprintf('\n Data di ingresso nella sfera di influenza di Urano = %s \n', str_ingresso_SOI_Urano);
    fprintf('\n-----------------------------------------------------\n')

    % Cattura su Urano
    Uranus_capture;
    
    % Cambio piano da Eclittica a Equatoriale
    Uranus_orbital_plane_shift;

    arrivo = ingresso_SOI_Urano + ...
        seconds(t_tot_capture_Uranus) + seconds(deltaT_min);
    str_arrivo = datestr(arrivo);
    fprintf("\n Data di fine missione = %s \n", str_arrivo)
    
%% Cacolo Delta Velocita' totale

    DeltaV;
