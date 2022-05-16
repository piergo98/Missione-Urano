%% Calcolo il delta V totale della missione

DeltaV_tot = 0;

%% Delta V necessario per il cambio di piano sulla terra

DeltaV_tot = DeltaV_tot + deltaV_orbit_e;

%% Delta V necessario per Escape dalla Terra

DeltaV_tot = DeltaV_tot + deltaV_escape_Earth;

%% Delta V necessario per entrare in orbita di Lambert da Venere a Saturno

DeltaV_tot = DeltaV_tot + d_V_VS_norm;

%% Delta V necessario per entrare in orbita di Lambert da Saturno a Urano

DeltaV_tot = DeltaV_tot + d_V_SU_norm;

%% Delta V necessario per la cattura su Urano

DeltaV_tot = DeltaV_tot + deltaV_uranus_capture;

%% Delta V necessario per il cambio di piano su Urano

DeltaV_tot = DeltaV_tot + deltaV_ottimo;


fprintf("\n DeltaV totale missione = %d \n",DeltaV_tot);
fprintf("\n DeltaV cambio piano Terra = %g",deltaV_orbit_e);
fprintf("\n DeltaV Terra-Venere = %g",deltaV_escape_Earth);
fprintf("\n DeltaV Venere-Saturno = %g",d_V_VS_norm);
fprintf("\n DeltaV Saturno-Urano = %g",d_V_SU_norm);
fprintf("\n DeltaV cattura su Urano = %g",deltaV_uranus_capture);
fprintf("\n DeltaV cambio piano Urano = %g \n",deltaV_ottimo);
