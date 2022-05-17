    
% Argomenti di ingresso: coe --> elementi orbitali dell'orbita di
% trasferimento
%                        TA_i --> anomalia vera iniziale
%                        TA_f --> anomalia vera finale
%                        color --> stringa con il colore dell'orbita ('r',
%                        'g', 'b', 'k')

function plot_traiettoria_spacecraft(coe, TA_i, TA_f, color)
    h = coe(1);         % Momento angolare
    e = coe(2);         % Eccentricità
    RA = coe(3);        % Ascensione retta
    incl = coe(4);      % Inclinazione orbita di trasferimento
    w = coe(5);         % Argomento del periasse
    a = coe(7);
    
    radius = 6e3;
    mu = 1.327*10^11;   % mu sun (km^2/s^3)
    
    p = a*(1 - e^2);    % Semilato retto   
    
    % Rotazione rispetto a Z dell'ascensione retta
    R3_W = [ cos(RA)  sin(RA)  0
            -sin(RA)  cos(RA)  0
                0        0     1];
    
    % Rotazione rispetto a X dell'inclinazione dell'orbita
    R1_i = [1       0          0
            0   cos(incl)  sin(incl)
            0  -sin(incl)  cos(incl)];
    
    % Rotazione attorno a Z dell'argomento del periasse
    R3_w = [ cos(w)  sin(w)  0 
            -sin(w)  cos(w)  0
               0       0     1];
    
    % Passaggio da perifocale a eliocentrico per rappresentare l'orbita in 3D
    % il centro è sempre il sole
    Q_pX = (R3_w*R1_i*R3_W)';        
    
    % hold on
    f = TA_i:0.5:TA_f;
    pos = [];
    
    figure(1)
    hold on;

    for i = 1:length(f)
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
        r = p / (1 + e*cosd(f(i)));
%       Converto in coordinate cartesiane
        x = r*cosd(f(i));
        y = r*sind(f(i));
        z = 0;
%       Cambio di coordinate il vettore posizione per plottarlo
        pos = Q_pX * [x y z]';
    
        if i == 1 
            c = circle_plot(pos(1), pos(2), radius, 'g');
            ra = animatedline(pos(1), pos(2), pos(3), "Color", color,'LineWidth',1);
        end
        addpoints(ra, pos(1), pos(2), pos(3));
        drawnow;
        c.Position(1) = pos(1) - radius;
        c.Position(2) = pos(2) - radius;
        drawnow;
        axis equal
  
%         xlim([-1e9 1e9])
%         ylim([-1e9 1e9])
%         zlim([-8e8 8e8])
    end
    
    xlabel('x (km)')
    ylabel('y (km)')
    zlabel('z (km)')
    view([0, 0, 1])
end