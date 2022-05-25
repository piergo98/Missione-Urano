%% MISSIONE COMPLETA: Terra-Venere-Saturno-Urano

    close all; clear; clc;

    % Inizializzo la missione
    init_Terra_Venere_Saturno_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Venus_Saturn_Uranus;

%% Fase Terra-Venere

    fprintf("\n Partenza dall'orbita di parcheggio sulla Terra il 2022/01/01 ore 12:00:00 \n");

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;

    fprintf('\n Ingresso nella sfera di influenza di Venere il 2022/04/01 ore 12:00:00 \n');

    % Fly-by su Venere
  
    plot_flyby(r_Venus, R_SOI_Venus, e_flyby_Venus, p_Venus, f_in_Venus_deg, r_p_flyby_Venus, 'V');

    fprintf('\n Posizione iniziale [%g, %g, %g] (km).',...
                                                     r2_v(1), r2_v(2), r2_v(3))
    fprintf('\n Velocità iniziale [%g, %g, %g] (km/s).',...
                                                         v2_l_v(1), v2_l_v(2), v2_l_v(3))
    fprintf('\n Altezza minima passaggio su Venere %g km', r_p_flyby_Venus)
    fprintf('\n Posizione finale [%g, %g, %g] (km).', r2_fin_v(1), r2_fin_v(2), r2_fin_v(3))
    fprintf('\n Velocità finale [%g, %g, %g] (km/s).', v_fin_Venus(1), v_fin_Venus(2), v_fin_Venus(3))
    fprintf('\n Tempo di volo nella sfera di influenza di Venere [%g Y, %g M, %g D, %g h, %g m, %g s] (km/s).' ...
        ,years_V, months_V, days_V, hours_V, minutes_V, seconds_V)
    fprintf('\n--------------------------------------------------------\n\n')

%% Fase Venere-Saturno

    fprintf('\n Ingresso nella sfera di influenza di Saturno il 2028/01/01 ore 12:00:00 \n');

    % Fly-by su Saturno
    
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


%% Flight totale

    Solar_System_animation;

%% Fase Saturno-Urano

    fprintf('\n Ingresso nella sfera di influenza di Urano il 2033/12/25 ore 12:00:00');

    % Cattura su Urano
    Uranus_capture;
    
    % Cambio piano da Eclittica a Equatoriale
    Uranus_orbital_plane_shift;

    arrivo = datetime(2033, 12, 25, 12, 00, 00) + ...
        seconds(t_tot_capture_Uranus) + seconds(deltaT_min);
    str_arrivo = datestr(arrivo);
    fprintf("\n Data di fine missione = %s \n", str_arrivo)
    
%% Cacolo Delta Velocita' totale

    DeltaV;
