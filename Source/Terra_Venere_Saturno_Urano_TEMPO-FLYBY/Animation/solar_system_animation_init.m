%% Constants

% time_vector, a row for each day of the mission
time_vector = ymd_gen([2022, 01, 02],[2033, 12, 25]);
n_days = size(time_vector,1);

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
col_venus	= col(11);	
col_earth	= col(3);	%[0,	102, 204]	/255;	% Earth
col_mars	= col(4);	%[255,	102, 0]		/255;	% Mars
col_jupiter = col(5);   % Jupiter
col_saturn  = col(6);   % Saturn
col_uran    = col(7);   % Uranus
col_spcr	= [0,	196, 255]	/255;	% spacecraft

% dimension of objects
dim_sun		= 18;
dim_venus   = 6;
dim_earth	= 8;
dim_mars	= 8;
dim_jupiter = 13;
dim_saturn  = 11;
dim_uran    = 9;
dim_spcr	= 2;

% width of lines
planet_linewidth = 0.1;
width_spcr  = 1;

%% Movie parameters

% init of frame counter
k = 1;
movie_fps = 60;

