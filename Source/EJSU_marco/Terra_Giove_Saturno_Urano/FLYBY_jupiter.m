% plot_flyby(coe_flyby_Jupiter, -f_deg_Jupiter, f_deg_Jupiter, r2_j, 69911, 'b')

% function plot_flyby(coe, TA_i, TA_f, planet_position, radius_planet, color)
    
%     h = coe(1);         % Momento angolare
      e = e_flyby_Jupiter;         % Eccentricità
%     RA = coe(3);        % Ascensione retta
%     incl = coe(4);      % Inclinazione orbita di trasferimento
%     w = coe(5);         % Argomento del periasse
%     a = coe(7);         % Semiasse maggiore
    color = 'b';
    radius = 600;
    mu = 1.26686534e8;   % mu jupiter (km^2/s^3)

%     p = h^2 / mu;       % Semilato retto
    p = p_Jupiter;

    f = -f1_Jupiter_deg:0.1:f1_Jupiter_deg;
    pos = [];
    
%     figure(1)
    hold on;
%     circle_plot(0, 0, R_SOI_Jupiter);
    circle_plot(0, 0, 69911);
    for i = 1:length(f)
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
        r = p / (1 + e*cosd(f(i))); 
%       Converto in coordinate cartesiane
        x = r*cosd(f(i));
        y = r*sind(f(i));
        z = 0;
%       Cambio di coordinate il vettore posizione per plottarlo
%         pos = Q_pX * [x y z]';
        pos = [x y z] + [r_p_flyby_Jupiter 0 0];
    
        if i == 1 
            c = circle_plot(pos(1), pos(2), radius);
            ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',1);
        end
        addpoints(ra, pos(1), pos(2), pos(3));
        drawnow;
        c.Position(1) = pos(1) - radius;
        c.Position(2) = pos(2) - radius;
        drawnow;
    end
    axis equal
  
    xlim([-1e8 1e8])
    ylim([-1e8 1e8])
    zlim([-1e8 1e8])
    xlabel('x (km)')
    ylabel('y (km)')
    zlabel('z (km)')
    view([0, 0, 1])
% end
