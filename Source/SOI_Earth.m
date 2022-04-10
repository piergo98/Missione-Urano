%% Plot SOI 
% Compute the ray of SOI
m_Earth = 5.972e+24;    %Earth mass in kg
m_Sun = 1.989e+30;      %Sun mass in kg
d_Earth2Sun = 152104285;    %distance Earth-Sun in km
R_SOI_Earth = d_Earth2Sun*(m_Earth/m_Sun)^(2/5); % SOI of Earth radius


%define a Sphere in the space with radius R_SOI
[X,Y,Z] = sphere;

%compute the state vector of the Earth at the departure from the planet
[coe_d_Earth, r_d_Earth, v_d_Earth, jd] = planet_elements_and_sv...
                                            (3, 2024, 07, 3, 12, 00 , 00);

% Plot the SOI
figure(1)
surface(r_d_Earth(1)+R_SOI_Earth*X,r_d_Earth(2)+R_SOI_Earth*Y,...
    r_d_Earth(3)+R_SOI_Earth*Z,'EdgeColor','red','FaceColor','red',...
    'FaceAlpha','0');



