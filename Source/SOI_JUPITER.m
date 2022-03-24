%% Plot SOI 
% Compute the ray of SOI
m_Jupiter = 1.898e27;    %Jupiter mass in kg
m_Sun = 1.989e+30;      %Sun mass in kg
d_Jupiter2Sun = 778412020;    %distance Earth-Sun in km
R_SOI_Jupiter = d_Jupiter2Sun*(m_Jupiter/m_Sun)^(2/5); % ray SOI of Earth


%define a Sphere in the space with ray R_SOI
[X,Y,Z] = sphere;

%compute the state vector of the Earth at the departure from the planet
[coe_d_Jupiter, r_d_Jupiter, v_d_Jupiter, jd] = planet_elements_and_sv...
                                            (5, 2025, 07, 01, 18, 00, 00);

% Plot the SOI

surface(r_d_Jupiter(1)+R_SOI_Jupiter*X,r_d_Jupiter(2)+R_SOI_Jupiter*Y,...
    r_d_Jupiter(3)+R_SOI_Jupiter*Z,'EdgeColor','interp');



