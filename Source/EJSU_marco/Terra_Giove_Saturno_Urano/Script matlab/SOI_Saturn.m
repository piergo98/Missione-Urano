%% Plot SOI 
% Compute the ray of SOI
m_Saturn = 5.683e+26;    %Saturn mass in kg
m_Sun = 1.989e+30;      %Sun mass in kg
d_Saturn2Sun =  1427014089;    %distance Saturn-Sun in km
R_SOI_Saturn = d_Saturn2Sun*(m_Saturn/m_Sun)^(2/5); % ray SOI of Saturn


%define a Sphere in the space with ray R_SOI
[X,Y,Z] = sphere;

%compute the state vector of Saturn at the departure from the planet
[coe_d_Saturn, r_d_Saturn, v_d_Saturn, jd] = planet_elements_and_sv...
                                            (6, 2025, 07, 01, 18, 00, 00);

% Plot the SOI
figure(1)
surf(r_d_Saturn(1)+R_SOI_Saturn*X,r_d_Saturn(2)+R_SOI_Saturn*Y,...
    r_d_Saturn(3)+R_SOI_Saturn*Z,'EdgeColor','red','FaceColor','red', 'FaceAlpha','0');
% xlim([-1e8 1e8])
% ylim([-1e 1e8])
% zlim([-1e8 1e8])

