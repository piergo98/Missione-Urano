%% Options 
alpha   = 1; % globe transparency level, 1 = opaque, through 0 = invisible 
% image. 
image_file = './Animation/img/Mars.png'; 
%% Create figure 
space_color = 'k'; 
figure('Color', space_color); 
hold on; 
% Turn off the normal axes 
set(gca, 'NextPlot','add', 'Visible','off'); 
xlim([-inf inf])
ylim([-inf inf])
zlim([-inf inf])
% Set initial view 
view(0,30); 
axis vis3d; 
%% Create wireframe globe 
% Create a 3D meshgrid of the sphere points using the ellipsoid function 
 
[x, y, z] = sphere(1000); 
globe = surf(r_Mars*x, r_Mars*y, r_Mars*(-z)); 
 
%% Texturemap the globe 
% Load Earth image for texture map 
cdata = imread(image_file); 
% Set image as color data (cdata) property, and set face color to indicate 
% a texturemap, which Matlab expects to be in cdata. Turn off the mesh edges. 
set(globe, 'FaceColor', 'texturemap', 'CData', cdata, 'FaceAlpha', alpha, 'EdgeColor', 'none'); 
