%% Calcolo il delta V totale della missione

DeltaV_tot = 0;

%% Delta V necessario per il cambio di piano sulla terra

DeltaV_tot = DeltaV_tot + deltaV_orbit_e;

%% Delta V del primo impulso (pericentro)

DeltaV_tot = DeltaV_tot + deltaV_escape_Earth;

%% Delta V del secondo impulso (apocentro)

%DeltaV_tot = DeltaV_tot + deltaV_a;

%% Delta V necessario per la cattura su Urano

DeltaV_tot = DeltaV_tot + deltaV_uranus_capture;

%% Delta V necessario per il cambio di piano su Urano

DeltaV_tot = DeltaV_tot + deltaV_ottimo;


fprintf("\n DeltaV totale missione = %g \n",DeltaV_tot);
fprintf("\n DeltaV cambio piano Terra = %g",deltaV_orbit_e);
fprintf("\n DeltaV primo impulso (pericentro) per Hohmann = %g",deltaV_escape_Earth);
fprintf("\n DeltaV del secondo impulso (apocentro) per Hohmann = %g",deltaV_uranus_capture);
%fprintf("\n DeltaV cattura su Urano = %g",deltaV_uranus_capture);
fprintf("\n DeltaV cambio piano Urano = %g \n",deltaV_ottimo);
