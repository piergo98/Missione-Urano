%% Plot SOI 
% Compute the ray of SOI
m_Uranus = 8.681e+25;    %Earth mass in kg
m_Sun = 1.989e+30;      %Sun mass in kg
d_Uranus2Sun = 2857319330;    %distance Earth-Sun in km
R_SOI_Uranus = d_Uranus2Sun*(m_Uranus/m_Sun)^(2/5); % ray SOI of Earth


%define a Sphere in the space with ray R_SOI
[X,Y,Z] = sphere;

%compute the state vector of the Earth at the departure from the planet
[coe_d_Uranus, r_d_Uranus, v_d_Uranus, jd] = planet_elements_and_sv...
                                            (7, 2024, 07, 3, 12, 00 , 00);

% Plot the SOI
figure(4)
surface(r_d_Uranus(1)+R_SOI_Uranus*X,r_d_Uranus(2)+R_SOI_Uranus*Y,...
    r_d_Uranus(3)+R_SOI_Uranus*Z,'EdgeColor','red','FaceColor','red',...
    'FaceAlpha','0');
