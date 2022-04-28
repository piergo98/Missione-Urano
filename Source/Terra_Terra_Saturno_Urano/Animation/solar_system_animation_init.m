%% Constants

% time_vector, a row for each day of the mission
%time_vector = ymd_gen([2022, 10, 01],[2036, 4, 3]);
time_vector = ymd_gen([2023, 03, 01],[2036, 08, 01]);

n_days = size(time_vector,1);

%% Mission info
%{
    The mission is subdivided in three parts:
    - Earth to Earth;
    - Earth to Saturn;
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
%% Plots Parameters

% init of status msg
status_msg = ['Nothing'];

% axis lim in plots
xy_lim = 3e9;		%lim in xy plane
z_lim = 1e9;		%lim in z coord

% colours of objects, rgb
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