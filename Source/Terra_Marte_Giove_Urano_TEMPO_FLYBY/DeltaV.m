%% Calcolo il delta V totale della missione

DeltaV_tot = 0;

%% Delta V necessario per il cambio di piano sulla terra

DeltaV_tot = DeltaV_tot + deltaV_orbit_e;

%% Delta V necessario per Escape dalla Terra

DeltaV_tot = DeltaV_tot + deltaV_escape_Earth;

%% Delta V necessario per entrare in orbita di Lambert dalla Marte a Giove

DeltaV_tot = DeltaV_tot + d_V_MJ_norm;

%% Delta V necessario per entrare in orbita di Lambert da Giove a Urano

DeltaV_tot = DeltaV_tot + d_V_JU_norm;

%% Delta V necessario per la cattura su Urano

DeltaV_tot = DeltaV_tot + deltaV_uranus_capture;

%% Delta V necessario per il cambio di piano su Urano

DeltaV_tot = DeltaV_tot + deltaV_ottimo;

fprintf('\n-----------------------------------------------------\n')
fprintf("\n DeltaV cambio piano Terra = %g (km/s)",deltaV_orbit_e);
fprintf("\n DeltaV Terra-Marte = %g (km/s)",deltaV_escape_Earth);
fprintf("\n DeltaV Marte-Giove = %g (km/s)",d_V_MJ_norm);
fprintf("\n DeltaV Giove-Urano = %g (km/s)",d_V_JU_norm);
fprintf("\n DeltaV cattura su Urano = %g (km/s)",deltaV_uranus_capture);
fprintf("\n DeltaV cambio piano Urano = %g (km/s)\n",deltaV_ottimo);
fprintf("\n DeltaV totale missione = %g (km/s)\n",DeltaV_tot);
