% Kepler equation for hyperbolic equation

% Velocità in uscita dalla Terra
v_inf_down_Earth = v2_l_e2 - v2_e2;  
v_inf_down_norm_Earth = norm(v_inf_down_Earth); 

% Semimajor axis
a_flyby_Earth = - mu_Earth / (v_inf_down_norm_Earth^2); 

r_p_flyby_Earth_true = 0;

for i=1:1:360
    % Rp
    r_p_flyby_Earth = r_Earth + i*10^2;    
    
    % Eccentricity
    e_flyby_Earth = 1-(r_p_flyby_Earth/a_flyby_Earth); 
    
    % Angolo tra gli asintoti 
    delta_Earth = 2*asin(1/e_flyby_Earth);  
    delta_deg_Earth = rad2deg(delta_Earth);
    fprintf('delta = %g\n', delta_deg_Earth)
%     if delta_deg_Earth > 180
%         r_p_flyby_Earth_true = r_p_flyby_Earth;
%     end
end
% Semiasse minore
b_flyby_Earth = a_flyby_Earth * sqrt(1-e_flyby_Earth^2);
% Semilato retto
p_flyby_Earth = a_flyby_Earth * (1-e_flyby_Earth^2);


% y_ke=sqrt(((a_flyby_Jupiter^2*b_flyby_Jupiter^2)-(b_flyby_Jupiter^2*R_SOI_Jupiter^2))/(-a_flyby_Jupiter^2-b_flyby_Jupiter^2))
% x_ke=sqrt((R_SOI_Jupiter^2)-y_ke^2)

% Ricavo l'anomalia vera f
f_Earth = acos((p_flyby_Earth-R_SOI_Jupiter) / (e_flyby_Earth*R_SOI_Jupiter));
f_deg_Earth = rad2deg(f_Earth);

% Ricavo anomalia eccentrica F
cosh_F = ((e_flyby_Earth+cos(f_Earth))/(e_flyby_Earth*cos(f_Earth)+1));
F = log(cosh_F+sqrt(cosh_F^2-1));
F_deg_Earth = rad2deg(F);

% Calcolo il tempo di volo del flyby
t_ke = sqrt((-a_flyby_Earth^3)/mu_Earth)*(e_flyby_Earth*sinh(F)-F); % (s)

%t_hours_ke =t_ke/3600 
%t_day_ke = t_hours_ke/24 
% eq2grado1(a_flyby_Jupiter,b_flyby_Jupiter,R_SOI_Jupiter,r_p_flyby_Jupiter) 
% function [x1_int,x2_int,y1_int,y2_int]= eq2grado1(a_flyby_Jupiter,b_flyby_Jupiter,R_SOI_Jupiter,r_p_flyby_Jupiter)

% Risolvo un'equazione di secondo grado per trovare le intersezioni tra la
% SOI e l'iperbole
A = a_flyby_Earth^2+b_flyby_Earth^2; 
B = -2*(b_flyby_Earth)^2*r_p_flyby_Earth; 
C = (b_flyby_Earth)^2*(r_p_flyby_Earth)^2-(a_flyby_Earth)^2*R_SOI_Earth^2-(a_flyby_Earth^2)*(b_flyby_Earth^2); 
D = B^2-4*A*C; 

% Prima intersezione iperbole-SOI
x1_int = (-B+sqrt(D))/(2*A); 
y1_int = sqrt(R_SOI_Earth^2-x1_int^2);
r1 = [x1_int y1_int r2_e2(3)];
% Seconda intersezione iperbole-SOI
x2_int = (-B-sqrt(D))/(2*A);
y2_int = sqrt(R_SOI_Earth^2-x2_int^2);
r2 = [x2_int y2_int r2_e2(3)];

% Calcolo coe iperbole
coe_Earth = coe_from_sv(r2, v2_l_e2, mu_Earth);