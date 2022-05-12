%%calcolo propellente da usare
%DeltaV;
m0=1e4;
I= 3000;  %impulso specifico
g0= 9.81 %[m/s^2]
m_start_orbit_earth=m0*exp(D_v_escape_Earth/I*g0)
m_exp=m_start_orbit_earth-m0