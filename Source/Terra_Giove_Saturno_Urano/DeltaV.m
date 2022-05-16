%% Calcolo il delta V totale della missione

DeltaV_tot = 0;
%% Delta V necessario per il cambio di piano sulla terra

%% Delta V necessario per Escape dalla Terra

Escape_from_Earth;
DeltaV_tot = DeltaV_tot + D_v_escape_Earth;

%% Delta V necessario per entrare in orbita di Lambert dalla Giove a Saturno

DeltaV_tot = DeltaV_tot + d_V_JS_norm;

%% Delta V necessario per entrare in orbita di Lambert da Saturno a Urano

DeltaV_tot = DeltaV_tot + d_V_SU_norm;

%% Delta V necessario per entrare in orbita di Lambert da Saturno a Urano
Uranus_orbital_plane_shift;
DeltaV_tot = DeltaV_tot + deltaV_ottimo;

fprintf("\n DeltaV totale missione = %d",DeltaV_tot);
fprintf("\n DeltaV escape = %g",D_v_escape_Earth);
fprintf("\n DeltaV Giove-Saturno = %g",d_V_JS_norm);
fprintf("\n DeltaV Saturno-Urano = %g",d_V_SU_norm);
fprintf("\n DeltaV cambio piano Urano = %g \n",deltaV_ottimo);
