%% Constants
global mu
mu = 1.327565122000000e+11; %[km^3/s^2]

%Masses
Sun_mass = 1.989*10^30;		%[kg]

%SOI: (m_planet/m_Sun)^(2/5) * distance_from_Sun
Earth_SOI   = 9.24*10^5;	%[km]
Mars_SOI    = 5.74*10^5;	%[km]
Jupiter_SOI = 4.82*10^7;    %[km]
Saturn_SOI  = 5.45*10^7;    %[km]
Uranus_SOI  = 5.19*10^7;    %[km]

%Parking orbits (not considering body radius)
Epark_radius = 200;		%[km]
Epark_inclination = 0;	%[rad]

% time_vector, a row for each day of the mission
time_vector = ymd_gen([2022, 07, 01],[2035, 12, 25]);
n_days = size(time_vector,1);

%% Mission info
%{
    The mission is subdivided in three parts:
    - Earth to Jupiter;
    - Jupiter to Saturn;
    - Saturn tu Uranus;
    Variables for each part have the same name but different suffix.
    
    Da definire ancora:
    %%Planet configurations have the following numerical indications:
    %%- 0: at Earth departure (to Mars) -> 27/9/07
    %%- 1: at Mars arrival/departure (from Earth, to Vesta) -> 17/2/09
    %%- 2: at Vesta arrival (from Mars) -> 16/7/11
    %%- 3: at Vesta departure (to Ceres) -> 5/9/12
    %%- 4: at Ceres arrival (from Vesta) -> 5/3/15
%}

%% Qui è ancora tutto da definire
%Earth
% [Earth_coe0, Earth_r0, Earth_v0, ~] = planet_elements_and_sv(3,2022,9,27,0,0,0);
% [Earth_coe1, Earth_r1, Earth_v1, ~] = planet_elements_and_sv(3,2024,2,17,0,0,0);

%%Mars
%[Mars_coe0, Mars_r0, Mars_v0, ~] = planet_elements_and_sv(4,2024,9,27,0,0,0);
%[Mars_coe1, Mars_r1, Mars_v1, ~] = planet_elements_and_sv(4,2028,2,17,0,0,0);
%[Mars_coe2, Mars_r2, Mars_v2, ~] = planet_elements_and_sv(4,2029,7,16,0,0,0);


%% Plots Parameters

% init of status msg
status_msg = ['Nothing'];

% axis lim in plots
xy_lim = 3e9;		%lim in xy plane
z_lim = 1e9;		%lim in z coord

% colours of objects, rgb
% nice link to get rbg colour:
% https://www.rapidtables.com/web/color/RGB_Color.html
col = [	"g"		     %green
		"m"          %magenta
		"b"          %blue
		"r"          %red
		"#A2142F"    %darker red
		"#7E2F8E"    %purple
		"#4DBEEE"    %darker cyan
		"c"          %(bright) cyan
		"#D95319"    %orange
		"#77AC30"    %darker green
		"#EDB120"    %ochre
		"#D95319"];  %orange, not visible due to Sun orbit dimensions

col_bkgnd	= [0,	0,	0];		% Background
col_grid	= [255,	255, 255]	/255;	% Grid
col_sun		= [255, 204, 0]		/255;	% Sun
col_earth	= col(3);	%[0,	102, 204]	/255;	% Earth
col_mars	= col(4);	%[255,	102, 0]		/255;	% Mars
col_jupiter = col(5);   % Jupiter
col_saturn  = col(6);   % Saturn
col_uran    = col(7);   % Uranus
col_spcr	= [0,	196, 255]	/255;	% spacecraft

% dimension of objects
dim_sun		= 24;
dim_earth	= 8;
dim_mars	= 8;
dim_jupiter = 14;
dim_saturn  = 12;
dim_uran    = 10;
dim_spcr	= 2;

% width of lines
planet_linewidth = 0.1;
width_spcr  = 1;

%% Movie parameters

% init of frame counter
k = 1;
movie_fps = 20;