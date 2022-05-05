addpath(genpath("Script matlab"));
addpath(genpath("Animation"));

%% Inizializzo dati utili

global mu;
global m_Sun;
global G;

mu = 1.327*10^11;   % mu sun (km^3/s^2)
m_Sun = 1.989e+30;  % Sun mass in kg
G = 6.6742e-20; % Costante gravitazionale

deg = pi/180;

%Masses
Sun_mass = 1.989*10^30;		%[kg]

%Parking orbits (not considering body radius)
Epark_radius = 200;		%[km]
Epark_inclination = 0;	%[rad]
Upark_radius = 1000;        %[km]
Upark_inclination = 97.7;    %[deg]  

%% Compute the ray of SOI_Earth
mu_Earth = 3986004418; %[km^3/s^2] 
m_Earth = 5.972e+24;    %Earth mass in kg
r_Earth = 6.371e+3;
d_Earth2Sun = 152104285;    %distance Earth-Sun in km
R_SOI_Earth = d_Earth2Sun*(m_Earth/m_Sun)^(2/5);   


%% Compute the ray of SOI_Saturn
mu_Saturn = 37931187; %[km^3/s^2] 
m_Saturn = 5.683e+26;    %Saturn mass in kg
r_Saturn = 5.8232e+4;
d_Saturn2Sun =  1427014089;    %distance Saturn-Sun in km
R_SOI_Saturn = d_Saturn2Sun*(m_Saturn/m_Sun)^(2/5);

%% Compute the ray of SOI_Jpiter
mu_Jupiter =  1.26686534e8; %[km^3/s^2]
m_Jupiter = 1.898e27;    %Jupiter mass in kg
r_Jupiter = 6.9911e+4;
d_Jupiter2Sun = 778412020;    %distance Earth-Sun in km
R_SOI_Jupiter = d_Jupiter2Sun*(m_Jupiter/m_Sun)^(2/5);

%% Compute the ray of SOI_Uranus
mu_Uranus = 5793939; %[km^3/s^2]
m_Uranus = 8.681e+25;    %Earth mass in kg
d_Uranus2Sun = 2857319330;    %distance Earth-Sun in km
r_Uranus = 2.5362e+4;
R_SOI_Uranus = d_Uranus2Sun*(m_Uranus/m_Sun)^(2/5);

