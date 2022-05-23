function plot_flyby(r_planet, r_SOI, e_flyby, p_flyby, f_deg, r_p_flyby, who_plot) 
     
    color = 'b'; 
    radius = 6000; 
 
    f = -f_deg:0.1:f_deg; 
    pos = []; 
   
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
            switch who_plot 
                case 'E' 
                    r_Earth = r_planet; 
                    plot_Earth; 
                case 'J' 
                    r_Jupiter = r_planet; 
                    plot_Jupiter; 
                    r_limit = r_p_flyby+1000000; 
                case 'S' 
                    r_Saturn = r_planet; 
                    plot_Saturn; 
                    r_limit = r_p_flyby+10000000; 
                case 'V' 
                    r_Venus = r_planet; 
                    plot_Venus; 
                    r_limit = r_p_flyby+100000; 
                case 'M' 
                    r_Mars = r_planet; 
                    plot_Mars; 
                    r_limit = r_p_flyby+100000; 
                otherwise 
                    r_Uranus = r_planet; 
                    plot_Uranus; 
            end 
            c = circle_plot(pos(1), pos(2), radius);            
            ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',2); 
        end 
        addpoints(ra, pos(1), pos(2), pos(3)); 
        drawnow; 
        c.Position(1) = pos(1) - radius; 
        c.Position(2) = pos(2) - radius; 
        drawnow; 
         
    end 
%    axis equal 
   
%     xlim([-r_SOI r_SOI]) 
%     ylim([-r_SOI r_SOI]) 
%     zlim([-r_SOI r_SOI]) 
 
    xlim([-r_limit r_limit]) 
    ylim([-r_limit r_limit]) 
    zlim([-r_limit r_limit]) 
 
    xlabel('x (km)') 
    ylabel('y (km)') 
    zlabel('z (km)') 
    view([0, 0, 1]) 
    
end