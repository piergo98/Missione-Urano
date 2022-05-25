%% MISSIONE COMPLETA: Terra-Marte-Saturno-Urano
    
    close all; clear; clc

    % Inizializzo la missione
    init_Terra_Marte_Saturno_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Mars_Saturn_Uranus;

    fprintf("\n MISSIONE TERRA-MARTE-SaturnO-URANO \n");
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
    
    fprintf("\n Fase Terra-Marte:")
    fprintf('\n Tempo di volo trascorso da Terra a Marte %g (giorni)\n', t_EM_days);
    fprintf('\n Data di ingresso nella sfera di influenza di Marte = %s \n', str_ingresso_SOI_Marte);

    plot_flyby(r_Mars, R_SOI_Mars, e_flyby_Mars, p_Mars, f_in_Mars_deg, r_p_flyby_Mars, 'M'); 

    fprintf('\n Posizione iniziale [%g, %g, %g] (km).',...
                                                     r2_m(1), r2_m(2), r2_m(3))
    fprintf('\n Velocità iniziale [%g, %g, %g] (km/s).',...
                                                         v2_l_m(1), v2_l_m(2), v2_l_m(3))
    fprintf('\n Altezza minima passaggio su Marte %g km', r_p_flyby_Mars)
    fprintf('\n Posizione finale [%g, %g, %g] (km).',...
        r2_fin_m(1), r2_fin_m(2), r2_fin_m(3))
    fprintf('\n Velocità finale [%g, %g, %g] (km/s).',...
        v_fin_Mars(1), v_fin_Mars(2), v_fin_Mars(3))
    fprintf('\n Tempo di volo nella sfera di influenza di Marte [%g Y, %g M, %g D, %g h, %g m, %g s] (km/s).',...
        years_M, months_M, days_M, hours_M, minutes_M, seconds_M)
    fprintf('\n--------------------------------------------------------\n\n')
     
%     fprintf('\n Quota minima del flyby su Marte = %g (km)', r_p_flyby_Mars)
%     fprintf('\n Durata flyby Marte = %g (ore).',t_flyby_tot_hours_Mars)    
%     fprintf('\n--------------------------------------------------------\n')


%% Fase Marte-Saturno
    
    ingresso_SOI_Saturno = ingresso_SOI_Marte + seconds(t_MS) + seconds(t_flyby_tot_Mars);
    str_ingresso_SOI_Saturno = datestr(ingresso_SOI_Saturno);
    
    % Fly-by su Saturno

    fprintf("\n Fase Marte-Saturno:")
    fprintf('\n Tempo di volo trascorso da Terra a Saturno %g (giorni)\n', t_MS_days);
    fprintf('\n Data di ingresso nella sfera di influenza di Saturno = %s \n', str_ingresso_SOI_Saturno);

    plot_flyby(r_Saturn, R_SOI_Saturn, e_flyby_Saturn, p_Saturn, f_in_Saturn_deg, r_p_flyby_Saturn, 'S');

    fprintf('\n Posizione iniziale [%g, %g, %g] (km).',...
                                                     r2_s(1), r2_s(2), r2_s(3))
    fprintf('\n Velocità iniziale [%g, %g, %g] (km/s).',...
                                                         V2_l_s(1), V2_l_s(2), V2_l_s(3))
    fprintf('\n Altezza minima passaggio su Saturno %g km', r_p_flyby_Saturn)
    fprintf('\n Posizione finale [%g, %g, %g] (km).',...
        r2_fin_s(1), r2_fin_s(2), r2_fin_s(3))
    fprintf('\n Velocità finale [%g, %g, %g] (km/s).',...
        v_fin_Saturn(1), v_fin_Saturn(2), v_fin_Saturn(3))
    fprintf('\n Tempo di volo nella sfera di influenza di Saturno [%g Y, %g M, %g D, %g h, %g m, %g s] (km/s).',...
        years_S, months_S, days_S, hours_S, minutes_S, seconds_S)
    fprintf('\n--------------------------------------------------------\n\n')

%     fprintf('\n Quota minima del flyby su Saturno = %g (km)', r_p_flyby_Saturn)
%     fprintf('\n Durata flyby Saturno = %g (ore).',t_flyby_tot_hours_Saturn)    
%     fprintf('\n--------------------------------------------------------\n')

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
