%% MISSIONE COMPLETA: Terra-Terra-Saturno-Urano
    
    close all; clear; clc;
    
    % Inizializzo la missione
    init_Terra_Terra_Saturno_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Earth_Saturn_Uranus;

    fprintf("\n MISSIONE TERRA-TERRA-SATURNO-URANO \n");
    fprintf('\n-----------------------------------------------------\n')

%% Fase Fase Sfera di influenza Terra    

%     fprintf("\n Partenza dall'orbita di parcheggio sulla Terra il 2023/03/01 ore 18:00:00 \n");
%     fprintf('\n-----------------------------------------------------\n')
    partenza = datetime(2023, 03, 01, 18, 00, 00);
    str_partenza = datestr(partenza);
    fprintf("\n Data di partenza dall'orbita di parcheggio sulla Terra = %s \n", str_partenza);
    fprintf('\n-----------------------------------------------------\n')

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;

%% Fase Terra-Terra
    
    ingresso_SOI_Terra = partenza + seconds(t_EE) + seconds(t_tot_escape_Earth);
    str_ingresso_SOI_Terra = datestr(ingresso_SOI_Terra);

%    fprintf('\n Tempo di volo da Terra a Terra %g (giorni)\n',t_EE_days);
%    fprintf('\n Ingresso nella sfera di influenza della Terra il 2024/03/01 ore 18:00:00 \n');

    fprintf("\n Fase Terra-Terra:")
    fprintf('\n Tempo di volo trascorso da Terra a Terra %g (giorni)\n', t_EE_days);
    fprintf('\n Data di ingresso nella sfera di influenza della Terra = %s \n', str_ingresso_SOI_Terra);

    % Fly-by sulla Terra
    plot_flyby(r_Earth, R_SOI_Earth, e_flyby_Earth, p_Earth, f_in_Earth_deg, r_p_flyby_Earth, 'E');
  
    fprintf('\n Posizione iniziale [%g, %g, %g] (km).',...
                                                         r2_e2(1), r2_e2(2), r2_e2(3))
    fprintf('\n Velocità iniziale [%g, %g, %g] (km/s).',...
                                                         v2_l_e2(1), v2_l_e2(2), v2_l_e2(3))
    fprintf('\n Altezza minima passaggio su Terra %g km', r_p_flyby_Earth)
    fprintf('\n Posizione finale [%g, %g, %g] (km).', r2_fin_e(1), r2_fin_e(2), r2_fin_e(3))
    fprintf('\n Velocità finale [%g, %g, %g] (km/s).', v_fin_Earth(1), v_fin_Earth(2), v_fin_Earth(3))
    fprintf('\n Tempo di volo nella sfera di influenza della Terra [%g Y, %g M, %g D, %g h, %g m, %g s].' ...
        ,years_E, months_E, days_E, hours_E, minutes_E, seconds_E)
    fprintf('\n--------------------------------------------------------\n\n')

%% Fase Terra-Saturno

%     fprintf('\n Tempo di volo da Terra a Saturno %g (giorni)\n',t_fS_days);
%     fprintf('\n Ingresso nella sfera di influenza di Saturno il 2030/08/01 ore 00:00:00 \n');
%     fprintf('\n-----------------------------------------------------\n')
%    fprintf('\n Flyby su Saturno\n')

    ingresso_SOI_Saturno = ingresso_SOI_Terra + seconds(t_ES)+ seconds(t_flyby_tot_Earth);
    str_ingresso_SOI_Saturno = datestr(ingresso_SOI_Saturno);

    % Fly-by su Saturno
    fprintf("\n Fase Terra-Saturno:")
    fprintf('\n Tempo di volo trascorso da Terra a Saturno = %g (giorni)\n', t_ES_days)
    fprintf('\n Data di ingresso nella sfera di influenza di Saturno = %s \n', str_ingresso_SOI_Saturno)

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
    fprintf('\n Tempo di volo nella sfera di influenza di Saturno [%g Y, %g M, %g D, %g h, %g m, %g s].',...
        years_S, months_S, days_S, hours_S, minutes_S, seconds_S)
    fprintf('\n--------------------------------------------------------\n\n')

%% Flight totale
    
    Solar_System_animation;

%% Fase Saturno-Urano

    ingresso_SOI_Urano = ingresso_SOI_Saturno + seconds(t_SU) + seconds(t_flyby_tot_Saturn);
    str_ingresso_SOI_Urano = datestr(ingresso_SOI_Urano);

%     fprintf('\n Tempo di volo da Saturno a Urano %g (giorni)\n',t_SU_days);
%     fprintf('\n Ingresso nella sfera di influenza di Urano il 2036/08/01 ore 00:00:00');
%     fprintf('\n-----------------------------------------------------\n')
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
