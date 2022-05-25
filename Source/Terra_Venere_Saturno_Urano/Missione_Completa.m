%% MISSIONE COMPLETA: Terra-Venere-Saturno-Urano

    close all; clear; clc

    % Inizializzo la missione
    init_Terra_Venere_Saturno_Urano;

    % Calcolo le Traiettorie di Lambert
    Earth_Venus_Saturn_Uranus;

    fprintf("\n MISSIONE TERRA-TERRA-SATURNO-URANO \n");
    fprintf('\n-----------------------------------------------------\n')

%% Fase Terra-Venere

    fprintf("\n Partenza dall'orbita di parcheggio sulla Terra il 2022/01/01 ore 12:00:00 \n");

    % Cambio Piano da Equatoriale ad Eclittica
    Earth_plane_shift;

    % Fuga dalla SOI della Terra
    Escape_from_Earth;

    fprintf('\n Ingresso nella sfera di influenza di Venere il 2022/04/01 ore 12:00:00 \n');

    % Fly-by su Venere
    flyby_Venus_time;

%% Fase Venere-Saturno

    fprintf('\n Ingresso nella sfera di influenza di Saturno il 2028/01/01 ore 12:00:00 \n');

    % Fly-by su Saturno
    flyby_Saturn_time;

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
