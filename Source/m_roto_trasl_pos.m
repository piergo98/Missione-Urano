%% ROTO-TRASLATION MATRIX FROM ORBIT TO PLANET FOR POSITION VECTOR
function [Vect_trasl] = m_roto_trasl_pos(Vect,planet_id, year, month,...
                      day, hour, minute, second)
%Compute the orbital elements and the state vector of a planet in a certain
%data
addpath './Script matlab'
[coe, r, v, jd] = planet_elements_and_sv ...
                (planet_id, year, month, day, hour, minute, second);
% [coe, r, v, jd] = planet_elements_and_sv(8, 2030, 12,25, 00, 00, 00);
                

theta = coe(6);
r_planet = r;
%v_planet = v;

C = [cos(theta), -sin(theta), 0, r_planet(1);...
    sin(theta), cos(theta), 0, r_planet(2);...
    0, 0, 1, r_planet(3);...
    0, 0, 0, 1];
Vect_om = [Vect,1];
Vect_trasl_tr = C^-1 * Vect_om';
Vect_trasl = (Vect_trasl_tr(1:3))';
end
