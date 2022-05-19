%% Calcolo il delta V totale della missione

DeltaV_tot = 0;

%% Delta V necessario per il cambio di piano sulla terra

DeltaV_tot = DeltaV_tot + deltaV_orbit_e;

%% Delta V necessario per Escape dalla Terra

DeltaV_tot = DeltaV_tot + deltaV_escape_Earth;

%% Delta V necessario per entrare in orbita di Lambert dalla Marte a Giove

DeltaV_tot = DeltaV_tot + d_V_fS_norm;

%% Delta V necessario per entrare in orbita di Lambert da Giove a Urano

DeltaV_tot = DeltaV_tot + d_V_JU_norm;

%% Delta V necessario per la cattura su Urano

DeltaV_tot = DeltaV_tot + deltaV_uranus_capture;

%% Delta V necessario per il cambio di piano su Urano

DeltaV_tot = DeltaV_tot + deltaV_ottimo;

fprintf("\n DeltaV totale missione = %d \n",DeltaV_tot);
fprintf("\n DeltaV cambio piano Terra = %g",deltaV_orbit_e);
fprintf("\n DeltaV Terra-Marte = %g",deltaV_escape_Earth);
fprintf("\n DeltaV Marte-Giove = %g",d_V_fS_norm);
fprintf("\n DeltaV Giove-Urano = %g",d_V_JU_norm);
fprintf("\n DeltaV cattura su Urano = %g",deltaV_uranus_capture);
fprintf("\n DeltaV cambio piano Urano = %g \n",deltaV_ottimo);
