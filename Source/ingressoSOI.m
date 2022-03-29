
function [ingresso_SOI] = ingressoSOI(coe, TA_i, TA_f, r2, r_SOI)
    h = coe(1);         % Momento angolare
    e = coe(2);         % Eccentricità
    RA = coe(3);        % Ascensione retta
    incl = coe(4);
    w = coe(5);
    a = coe(7);
    
    radius = 6e3;
    mu = 1.327*10^11;   % mu sun (km^2/s^3)
    
    p = h^2 / mu;       % Semilato retto    
    
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

    f = TA_i:1e-8:TA_f;
    pos = [];
        
    for i = 1:length(f)
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
        r = p / (1 + e*cosd(f(i)));
%       Converto in coordinate cartesiane
        x = r*cosd(f(i));
        y = r*sind(f(i));
        z = 0;

        %distanza spacecraft_sun in modulo
        pos_spacecraft = Q_pX * [x y z]';
        
        %distanza spacecraft pianeta
        dist_space2planet = r2 - pos_spacecraft;  
        norm_dist_space2planet = norm(dist_space2planet);

        if(norm_dist_space2planet <= r_SOI)
            ingresso_SOI = [x y z];
            break
        else
            ingresso_SOI = 'no';
        end    
    end

end    