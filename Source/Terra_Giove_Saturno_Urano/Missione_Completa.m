%% MISSIONE COMPLETA: Terra-Giove-Saturno-Urano
    
    close all; clear; clc

    % Inizializzo la missione
    init_Terra_Giove_Saturno_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Jupiter_Saturn_Uranus;

    fprintf("\n MISSIONE TERRA-GIOVE-SATURNO-URANO \n");
    fprintf('\n-----------------------------------------------------\n')

%% Fase Sfera di influenza Terra
    
    partenza = datetime(2022, 7, 01, 12, 00, 00);
    str_partenza = datestr(partenza);
    fprintf("\n Data di partenza dall'orbita di parcheggio sulla Terra = %s \n", str_partenza);
    fprintf('\n-----------------------------------------------------\n')

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;

%% Fase Terra-Giove

    ingresso_SOI_Giove = partenza + seconds(t_EJ) + seconds(t_tot_escape_Earth);
    str_ingresso_SOI_Giove = datestr(ingresso_SOI_Giove);
    
    % Fly-by su Giove
    flyby_Jupiter_time;
    fprintf("\n Fase Terra-Giove:")
    fprintf('\n Tempo di volo trascorso da Terra a Giove %g (giorni)\n', t_EJ_days);
    fprintf('\n Data di ingresso nella sfera di influenza di Giove = %s \n', str_ingresso_SOI_Giove);
    
    fprintf('\n Quota minima del flyby su Giove = %g (km)', r_p_flyby_Jupiter)
    fprintf('\n Durata flyby Giove = %g (ore).',t_flyby_tot_hours_Jupiter)    
    fprintf('\n--------------------------------------------------------\n')
%% Fase Giove-Saturno
    
    ingresso_SOI_Saturno = ingresso_SOI_Giove + seconds(t_JS)+ seconds(t_flyby_tot_Jupiter);
    str_ingresso_SOI_Saturno = datestr(ingresso_SOI_Saturno);

    % Fly-by su Saturno
    flyby_Saturn_time;
    fprintf("\n Fase Giove-Saturno:")
    fprintf('\n Tempo di volo trascorso da Giove a Saturno = %g (giorni)\n', t_JS_days)
    fprintf('\n Data di ingresso nella sfera di influenza di Saturno = %s \n', str_ingresso_SOI_Saturno)
    
    fprintf('\n Quota minima del flyby su Giove = %g (km)', r_p_flyby_Saturn)
    fprintf('\n Durata flyby Giove = %g (ore).',t_flyby_tot_hours_Saturn)    
    fprintf('\n--------------------------------------------------------\n')

%% Flight totale

    % volo totale
    Solar_System_animation


%% Fase Saturno-Urano
    
    ingresso_SOI_Urano = ingresso_SOI_Saturno + seconds(t_SU) + seconds(t_flyby_tot_Saturn);
    str_ingresso_SOI_Urano = datestr(ingresso_SOI_Urano);
    
    fprintf("\n Fase Saturno-Urano:")
    fprintf('\n Tempo di volo trascorso da Saturno a Urano %g (giorni)\n',t_SU_days);
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