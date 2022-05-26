%% MISSIONE COMPLETA: Terra-Marte-Giove-Urano
    
    close all; clear; clc

    % Inizializzo la missione
    init_Terra_Marte_Giove_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Mars_Jupiter_Uranus;

    fprintf("\n MISSIONE TERRA-MARTE-GIOvE-URANO \n");
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
    fprintf("\n Fase Terra-Marte:")
    fprintf('\n Tempo di volo trascorso da Terra a Marte %g (giorni)\n', t_EM_days);
    fprintf('\n Data di ingresso nella sfera di influenza di Marte = %s \n', str_ingresso_SOI_Marte);

    plot_flyby(r_Mars, R_SOI_Mars, e_flyby_Mars, p_Mars, f_in_Mars_deg, r_p_flyby_Mars, 'M'); 
    
    fprintf('\n Posizione iniziale [%g, %g, %g] (km).',...
                                                         r2_m(1), r2_m(2), r2_m(3))
    fprintf('\n velocità iniziale [%g, %g, %g] (km/s).',...
                                                         v2_l_m(1), v2_l_m(2), v2_l_m(3))
    fprintf('\n Altezza minima passaggio su Marte %g km', r_p_flyby_Mars)
    fprintf('\n Posizione finale [%g, %g, %g] (km).',...
        r2_fin_m(1), r2_fin_m(2), r2_fin_m(3))
    fprintf('\n velocità finale [%g, %g, %g] (km/s).',...
        v_fin_Mars(1), v_fin_Mars(2), v_fin_Mars(3))
    fprintf('\n Tempo di volo nella sfera di influenza di Marte [%g Y, %g M, %g D, %g h, %g m, %g s] (km/s).',...
        years_M, months_M, days_M, hours_M, minutes_M, seconds_M)
    fprintf('\n--------------------------------------------------------\n\n')
    
%     fprintf('\n Quota minima del flyby su Marte = %g (km)', r_p_flyby_Mars)
%     fprintf('\n Durata flyby Marte = %g (ore).',t_flyby_tot_hours_Mars)    
%     fprintf('\n--------------------------------------------------------\n')
    
%% Fase Marte-Giove

    ingresso_SOI_Giove = ingresso_SOI_Marte + seconds(t_MJ) + seconds(t_flyby_tot_Mars);
    str_ingresso_SOI_Giove = datestr(ingresso_SOI_Giove);
    
    % Fly-by su Giove
    fprintf("\n Fase Marte-Giove:")
    fprintf('\n Tempo di volo trascorso da Terra a Giove %g (giorni)\n', t_MJ_days);
    fprintf('\n Data di ingresso nella sfera di influenza di Giove = %s \n', str_ingresso_SOI_Giove);

    plot_flyby(r_Jupiter, R_SOI_Jupiter, e_flyby_Jupiter, p_Jupiter, f_in_Jupiter_deg, r_p_flyby_Jupiter, 'J'); 

    fprintf('\n Posizione iniziale [%g, %g, %g] (km).',...
                                                     r2_j(1), r2_j(2), r2_j(3))
    fprintf('\n velocità iniziale [%g, %g, %g] (km/s).',...
                                                         v2_l_j(1), v2_l_j(2), v2_l_j(3))
    fprintf('\n Altezza minima passaggio su Giove %g km', r_p_flyby_Jupiter)
    fprintf('\n Posizione finale [%g, %g, %g] (km).',...
        r2_fin_j(1), r2_fin_j(2), r2_fin_j(3))
    fprintf('\n velocità finale [%g, %g, %g] (km/s).',...
        v_fin_Jupiter(1), v_fin_Jupiter(2), v_fin_Jupiter(3))
    fprintf('\n Tempo di volo nella sfera di influenza di Giove [%g Y, %g M, %g D, %g h, %g m, %g s] (km/s).',...
        years_J, months_J, days_J, hours_J, minutes_J, seconds_J)
    fprintf('\n--------------------------------------------------------\n\n')

%     fprintf('\n Quota minima del flyby su Giove = %g (km)', r_p_flyby_Jupiter)
%     fprintf('\n Durata flyby Giove = %g (ore).',t_flyby_tot_hours_Jupiter)    
%     fprintf('\n--------------------------------------------------------\n')

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
    
%% Cacolo Delta velocita' totale

    DeltaV;
