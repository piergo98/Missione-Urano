%this function calculate de delta-v for each planet
function [delta_v_earth_jupiter]= V_inf_earth_jupiter
mu_sun=1.327e11; %[km^3/s^2]
mu_earth=398600;
%define orbital radii
R_earth=149.6e6; %[km]
R_jupiter=740e6;
%define V_inf_earth_jupiter
V_inf_eart_jupiter= sqrt(mu_sun/R_earth)*(sqrt(2*R_jupiter/(R_jupiter+R_earth))-1);
%define speed of the spacecraft at 200km
V_c= sqrt(mu_earth/(R_earth+200));
%calculated delta-v
delta_v_earth_jupiter= V_c*(sqrt(2+(V_inf_eart_jupiter/V_c)^2)-1);
