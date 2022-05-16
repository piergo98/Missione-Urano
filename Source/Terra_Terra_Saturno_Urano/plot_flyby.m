function plot_flyby(r_planet, r_SOI, e_flyby, p_flyby, f_deg, r_p_flyby)
    
    hold on
    figure();
    color = 'b';
    radius = 600;

    f = -f_deg:0.1:f_deg;
    pos = [];
    
    circle_plot(0, 0, r_planet);
    for i = 1:length(f)
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
        r = p_flyby / (1 + e_flyby*cosd(f(i)));
%       Converto in coordinate cartesiane
        x = r*cosd(f(i));
        y = r*sind(f(i));
        z = 0;
%       Cambio di coordinate il vettore posizione per plottarlo
        pos = [x y z] + [r_p_flyby 0 0];
    
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
  
    xlim([-r_SOI r_SOI])
    ylim([-r_SOI r_SOI])
    zlim([-r_SOI r_SOI])
%     
%     xlim([-1e6 1e6])
%     ylim([-1e6 1e6])
%     zlim([-1e6 1e6])
%     
    xlabel('x (km)')
    ylabel('y (km)')
    zlabel('z (km)')
    view([0, 0, 1])
    
end