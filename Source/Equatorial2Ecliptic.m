function r_ec = Equatorial2Ecliptic(r_eq)

% Defining the inclination angle between equatorial and ecliptical plane
fi = 23.4;      % (deg)

% Rotation matrix
R_eq2ec = [1     0           0;
           0   cosd(fi)    sind(fi);
           0   -sind(fi)    cosd(fi)];

r_ec = R_eq2ec * r_eq';
end