%%script per calcolo carburante
DeltaV;

%dati
m0=1e4 %massa spacecraft
I=3000 %impulso specifico carburante
g0= 9.81 %acc.gravitazionale [ms^-2]
m1_escape_earth=m0*exp(deltaV_escape_Earth/(I*g0))
m_out=m1_escape_earth-m0;

%% calcolo carburante giove saturno
g_sun=274; %[ms^-2]
m1_J_S=m1_escape_earth*exp(d_V_JS_norm/(I*g_sun));
m_out_J_S=m1_J_S-m1_escape_earth;
