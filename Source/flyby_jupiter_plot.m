
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%{
  This function computes the orbit of a spacecraft by using rkf45 to 
  numerically integrate Equation 2.22.

  It also plots the orbit and computes the times at which the maximum
  and minimum radii occur and the speeds at those times.

  hours     - converts hours to seconds
  G         - universal gravitational constant (km^3/kg/s^2)
  m1        - planet mass (kg)
  m2        - spacecraft mass (kg)
  mu        - gravitational parameter (km^3/s^2)
  R         - planet radius (km)
  r0        - initial position vector (km)
  v0        - initial velocity vector (km/s)
  t0,tf     - initial and final times (s)
  y0        - column vector containing r0 and v0
  t         - column vector of the times at which the solution is found
  y         - a matrix whose columns are:
                 columns 1, 2 and 3:
                    The solution for the x, y and z components of the 
                    position vector r at the times in t
                 columns 4, 5 and 6:
                    The solution for the x, y and z components of the 
                    velocity vector v at the times in t
  r         - magnitude of the position vector at the times in t
  imax      - component of r with the largest value
  rmax      - largest value of r
  imin      - component of r with the smallest value
  rmin      - smallest value of r
  v_at_rmax - speed where r = rmax
  v_at_rmin - speed where r = rmin
  
  User M-function required:   rkf45
  User subfunctions required: rates, output
%}
% -------------------------------------------------------------------
% Define global variables state vector (r,v)
flyby_jupiter1(r2_j,v_inf_down_Jupiter,f1_Jupiter,p_Jupiter,t_flyby_tot_Jupiter)
function [y]= flyby_jupiter1(r2_j, v_inf_down_Jupiter, f1_Jupiter, p_Jupiter, t_flyby_tot_Jupiter)

GM_jupiter = 126686534; %[km^3/s^2]

%clc; close all; clear all
addpath './Script matlab'


hours = 3600;
G     = 6.6742e-20;

%...Input data:
%   Earth:
m1 = 1.89819e27;    %massa di giove
R  = 69911;  %raggio giove
m2 = 10000;   %massa Spacecraft

t0 = 0;
tf = t_flyby_tot_Jupiter; %dt in Lambert
%...End input data


%...Numerical integration:
mu    = G*(m1 + m2);
r1= [p_Jupiter*sin(f1_Jupiter),p_Jupiter*cos(f1_Jupiter),0];
y0    = [r1 v_inf_down_Jupiter]';
[t,y] = rkf45(@rates, [t0 tf], y0);

%...Output the results:
output

return

% ~~~~~~~~~~~~~~~~~~~~~~~~
function dydt = rates(t,f)
% ~~~~~~~~~~~~~~~~~~~~~~~~
%{
  This function calculates the acceleration vector using Equation 2.22
  
  t          - time
  f          - column vector containing the position vector and the
               velocity vector at time t
  x, y, z    - components of the position vector r
  r_m          - the magnitude of the the position vector
  vx, vy, vz - components of the velocity vector v
  ax, ay, az - components of the acceleration vector a
  dydt       - column vector containing the velocity and acceleration
               components
%}
% ------------------------
x    = f(1);
y    = f(2);
z    = f(3);
vx   = f(4);
vy   = f(5);
vz   = f(6);

r_m    = norm([x y z]);

ax   = -mu*x/r_m^3;
ay   = -mu*y/r_m^3;
az   = -mu*z/r_m^3;
    
dydt = [vx vy vz ax ay az]';    
end %rates


% ~~~~~~~~~~~~~
function output
% ~~~~~~~~~~~~~
%{
  This function computes the maximum and minimum radii, the times they
  occur and and the speed at those times. It prints those results to
  the command window and plots the orbit.

  r_m         - magnitude of the position vector at the times in t
  imax      - the component of r with the largest value
  rmax      - the largest value of r
  imin      - the component of r with the smallest value
  rmin      - the smallest value of r
  v_at_rmax - the speed where r = rmax
  v_at_rmin - the speed where r = rmin

  User subfunction required: light_gray
%}
% -------------
for i = 1:length(t)
    r_m(i) = norm([y(i,1) y(i,2) y(i,3)]);
end

[rmax imax] = max(r_m);
[rmin imin] = min(r_m);

v_at_rmax   = norm([y(imax,4) y(imax,5) y(imax,6)]);
v_at_rmin   = norm([y(imin,4) y(imin,5) y(imin,6)]);

%...Output to the command window:
fprintf('\n\n--------------------------------------------------------\n')
fprintf('\n fly-by orbit jupiter\n')
fprintf(' %s\n', datestr(now))
fprintf('\n The initial position is [%g, %g, %g] (km).',...
                                                     r1(1), r1(2), r1(3))
fprintf('\n   Magnitude = %g km\n', norm(r1))
fprintf('\n The initial velocity is [%g, %g, %g] (km/s).',...
                                                     v_inf_down_Jupiter(1), v_inf_down_Jupiter(2), v_inf_down_Jupiter(3))
fprintf('\n   Magnitude = %g km/s\n', norm(v_inf_down_Jupiter))
fprintf('\n Initial time = %g h.\n Final time   = %g h.\n',0,tf/hours) 
fprintf('\n The minimum altitude is %g km at time = %g h.',...
            rmin-R, t(imin)/hours)
fprintf('\n The speed at that point is %g km/s.\n', v_at_rmin)
fprintf('\n The maximum altitude is %g km at time = %g h.',...
            rmax-R, t(imax)/hours)
fprintf('\n The speed at that point is %g km/s\n', v_at_rmax)
fprintf('\n--------------------------------------------------------\n\n')

%...Plot the results:
%   Draw the planet
[xx, yy, zz] = sphere(100);
surf(R*xx, R*yy, R*zz)
colormap(light_gray)
caxis([-R/100 R/100])
shading interp

%   Draw and label the X, Y and Z axes
line([0 2*R],   [0 0],   [0 0]); text(2*R,   0,   0, 'X')
line(  [0 0], [0 2*R],   [0 0]); text(  0, 2*R,   0, 'Y')
line(  [0 0],   [0 0], [0 2*R]); text(  0,   0, 2*R, 'Z')

%   Plot the orbit, draw a radial to the starting point
%   and label the starting point (o) and the final point (f)
hold on
plot3(  y(:,1),    y(:,2),    y(:,3),'k')
comet3(  y(:,1),    y(:,2),    y(:,3))
line([0 r1(1)], [0 r1(2)], [0 r1(3)])
text(   y(1,1),    y(1,2),    y(1,3), 'in_flyby', 'Color','r')
text( y(end,1),  y(end,2),  y(end,3), 'out_flyby', 'Color', 'g')

%   Select a view direction (a vector directed outward from the origin) 
view([37.5,30])

%   Specify some properties of the graph
grid on
axis equal
xlabel('km')
ylabel('km')
zlabel('km')
title ('Trajectory flyby around jupiter')
xlim([-2e5 2e5])
ylim([-2e5 2e5])
zlim([-2e5 2e5])
% ~~~~~~~~~~~~~~~~~~~~~~~
function map = light_gray
% ~~~~~~~~~~~~~~~~~~~~~~~
%{
  This function creates a color map for displaying the planet as light
  gray with a black equator.
  
  r - fraction of red
  g - fraction of green
  b - fraction of blue

%}
% -----------------------
r_m = 0.8; g = r_m; b = r_m;
map = [r_m g b
       0 0 0
       r_m g b];
end %light_gray

end %output
end %flyby_jupiter




