%% Plot SOI 
% Compute the ray of SOI
% m_Earth = 5.972e+24;    %Earth mass in kg
% m_Sun = 1.989e+30;      %Sun mass in kg
% d_Earth2Sun = 152104285;    %distance Earth-Sun in km
% R_SOI_Earth = d_Earth2Sun*(m_Earth/m_Sun)^(2/5); % SOI of Earth radius

%define a Sphere in the space with radius R_SOI
[X,Y,Z] = sphere;

%compute the state vector of the Earth at the departure from the planet
[coe_d_Venus, r_d_Venus, v_d_Venus, jd] = planet_elements_and_sv...
                                            (2, 2022, 04, 01, 12, 00 , 00);

% Plot the SOI
hold on
figure(1)
surface(r_d_Venus(1)+R_SOI_Venus*X,r_d_Venus(2)+R_SOI_Venus*Y,...
    r_d_Venus(3)+R_SOI_Venus*Z,'EdgeColor','magenta','FaceColor','magenta',...
    'FaceAlpha','0');



