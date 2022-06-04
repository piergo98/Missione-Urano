%% Script description
% This script executes the animation of the Uran Mission
% The animation works by plotting each day the position of planets, Sun,
% and the spacecraft.

%In this first version it will plot only planets and Sun.

%% intro

movie_mode = 2;	% 1 for movie writing, 2 for HD movie, 0 for only matlab animation

% Init all par, constants and plot parameters
solar_system_animation_init

% Computes the position of the spacecraft for each day of the mission
Spacecraft_position_for_EJSU

%% Editable animation parameters

% Animation rates
time_pause = 0;		% time [s] after each drawing. Set to zero to avoid pausing
fr_skip = 6;		% frame skip between each drawing

% View angles
View = [90 90];				% initial view
spinlon = -45;				% how much view angle change long [grad]
spinlat = -29;				% how much view angle change lat [grad]

%% Solar System Plot and Animation
figh = figure();
clf 
set(gcf, 'Renderer', 'zbuffer');
set(gca, 'color', col_bkgnd)
ax = gca;
ax.GridColor = col_grid;
% Colore della traiettoria dello spacecraft
color = 'g';

if movie_mode == 2
% 	warning('Note that a 1080p resolution is needed for movie_mode = 2')
	figh.WindowState = 'maximize';
end

hold on

% Orbits (Not accurate, should be computed each year) 
plot_orbit2(3,	time_vector(1,1), planet_linewidth)		%Earth
plot_orbit2(4,	time_vector(1,1), planet_linewidth)		%Mars
plot_orbit2(5,  time_vector(1,1), planet_linewidth)	    %Jupiter
plot_orbit2(6,  time_vector(1,1), planet_linewidth)	    %Saturn
plot_orbit2(7,  time_vector(1,1), planet_linewidth)     %Uran
 
	
for d = 1:fr_skip:n_days			% speed
	% Reset figure
	if d ~= 1
		delete(p_Sun)
		delete(p_Earth)
		delete(p_Mars)
		delete(p_Jupiter)
		delete(p_Saturn)
        delete(p_Uran)
	end
	
	% Now
	year_now	= time_vector(d,1);
	month_now	= time_vector(d,2);
	day_now		= time_vector(d,3);
	
	% Sun (id = 12)
	[~, Sun_now, ~, ~]     = planet_elements_and_sv(10, year_now, month_now, day_now, 0, 0, 0);
							
	% Earth (id = 3)
	[~, Earth_now, ~, ~]   = planet_elements_and_sv(3, year_now, month_now, day_now, 0, 0, 0);
	% Mars (id = 4)
	[~, Mars_now, ~, ~]    = planet_elements_and_sv(4, year_now, month_now, day_now, 0, 0, 0);
	% Jupiter (id = 5)
	[~, Jupiter_now, ~, ~] = planet_elements_and_sv(5, year_now, month_now, day_now, 0, 0, 0);
    % Saturn (id = 6)
	[~, Saturn_now, ~, ~]  = planet_elements_and_sv(6, year_now, month_now, day_now, 0, 0, 0);
    % Uran (id = 7)
	[~, Uran_now, ~, ~]    = planet_elements_and_sv(7, year_now, month_now, day_now, 0, 0, 0);
    % Spacecraft
    spcr_now = pos_spcr(:,d);
	
	
	p_Sun		= plot3(Sun_now(1),Sun_now(2),Sun_now(3),'o','Color',col_sun, 'MarkerSize', dim_sun,'MarkerFaceColor',col_sun);
	
    p_Earth		= plot3(Earth_now(1),Earth_now(2),Earth_now(3),'o','Color',col_earth, 'MarkerSize', dim_earth,'MarkerFaceColor',col_earth);				

    p_Mars		= plot3(Mars_now(1),Mars_now(2),Mars_now(3),'o','Color',col_mars, 'MarkerSize', dim_mars,'MarkerFaceColor',col_mars);

    p_Jupiter   = plot3(Jupiter_now(1),Jupiter_now(2),Jupiter_now(3),'o','Color',col_jupiter, 'MarkerSize', dim_jupiter,'MarkerFaceColor',col_jupiter);				

    p_Saturn	= plot3(Saturn_now(1),Saturn_now(2),Saturn_now(3),'o','Color',col_saturn, 'MarkerSize', dim_saturn,'MarkerFaceColor',col_saturn);

    p_Uran      = plot3(Uran_now(1),Uran_now(2),Uran_now(3),'o','Color',col_uran, 'MarkerSize', dim_uran,'MarkerFaceColor',col_uran);

    % SPACECRAFT
    
    if d == 1 
        c = circle_plot(spcr_now(1), spcr_now(2), radius);
        ra = animatedline(spcr_now(1), spcr_now(2), spcr_now(3), "Color", color,'LineWidth', dim_spcr);
    end
    addpoints(ra, spcr_now(1), spcr_now(2), spcr_now(3));
    drawnow;
    c.Position(1) = spcr_now(1) - radius;
    c.Position(2) = spcr_now(2) - radius;
    drawnow;

	% Figure parameters update				
	axis equal;
    grid on;
	hold on
	
	xlim([-xy_lim, xy_lim]);
	ylim([-xy_lim, xy_lim]);
	zlim([-z_lim, z_lim]);

	if spinlon == 0 && spinlat == 0
		if d == 1
			view(View(1, 1), View(1, 2));
		end
	else
		view(View(1, 1) + spinlon * d/n_days, View(1, 2) + spinlat* d/n_days);
	end
	xlabel('X [km]');
	ylabel('Y [km]');
	zlabel('Z [km]');
	date = datetime(time_vector(d,:));
	
	%% update title
    status_msg = 'Solar System';
	
	Title = [status_msg '   '  datestr(date), ' (day ', num2str(d), ' of ', num2str(n_days), ').'];
    title(Title)
	
	drawnow;
	
	% Pause
	if time_pause ~= 0
		pause(time_pause)
	end
	
    % Write video
	if movie_mode ~= 0
		movieVector(k) = getframe(figh);
		k = k+1;
	end
end

%% Video stuff
% if movie_mode
% 	movie = VideoWriter('Missione Completa', 'MPEG-4');
% 	movie.FrameRate = movie_fps;
% 
% 	open(movie);
% 	writeVideo(movie, movieVector);
% 	close(movie);
% end