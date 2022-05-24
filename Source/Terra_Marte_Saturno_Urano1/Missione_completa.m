%% MISSIONE COMPLETA: Terra-Marte-Saturno-Urano
    
    close all; clear; clc

    % Inizializzo la missione
    init_Terra_Marte_Saturno_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Mars_Saturn_Uranus;

    fprintf("\n MISSIONE TERRA-MARTE-SATURNO-URANO \n");
    fprintf('\n-----------------------------------------------------\n')

%% Fase Fase Sfera di influenza Terra

    partenza = datetime(2022, 9, 01, 18, 00, 00);
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


%% Fase Marte-Saturno
    
    ingresso_SOI_Saturno = ingresso_SOI_Marte + seconds(t_MS) + seconds(t_flyby_tot_Mars);
    str_ingresso_SOI_Saturno = datestr(ingresso_SOI_Saturno);
    
    % Fly-by su Saturno
    flyby_Saturn_time;
    fprintf("\n Fase Marte-Saturno:")
    fprintf('\n Tempo di volo trascorso da Terra a Saturno %g (giorni)\n', t_MS_days);
    fprintf('\n Data di ingresso nella sfera di influenza di Saturno = %s \n', str_ingresso_SOI_Saturno);
    
    fprintf('\n Quota minima del flyby su Saturno = %g (km)', r_p_flyby_Saturn)
    fprintf('\n Durata flyby Saturno = %g (ore).',t_flyby_tot_hours_Saturn)    
    fprintf('\n--------------------------------------------------------\n')

%% Flight totale
    
    Solar_System_animation;
%% Fase Saturno-Urano

    ingresso_SOI_Urano = ingresso_SOI_Saturno + seconds(t_SU) + seconds(t_flyby_tot_Saturn);
    str_ingresso_SOI_Urano = datestr(ingresso_SOI_Urano);
    
    fprintf("\n Fase Saturno-Urano:")
    fprintf('\n Tempo di volo trascorso da Saturno a Urano %g (giorni)\n', t_SU_days);
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
