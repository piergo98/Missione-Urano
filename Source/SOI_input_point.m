% Argomenti di ingresso: coe --> elementi orbitali dell'orbita di
% trasferimento
%                        TA_i --> anomalia vera iniziale
%                        TA_f --> anomalia vera finale
%                        color --> stringa con il colore dell'orbita ('r',
%                        'g', 'b', 'k')

function [spcr_SOI_input_point] = SOI_input_point(coe,TA_pianeta, pos_pianeta)

    h = coe(1);         % Momento angolare
    e = coe(2);         % Eccentricità
    RA = coe(3);        % Ascensione retta
    incl = coe(4);
    w = coe(5);
    a = coe(7);
   
           
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
    
    % Effettuo il controllo su un intorno della TA_Finale (+-20 deg)
    f = (TA_pianeta - 20) : 0.5 : (TA_pianeta + 20);
    pos = [];
    
    SOI_JUPITER;            %lo uso per trovare la soi di giove
    SOI_Earth;
    for i = 1:length(f)
%       Legge oraria dello spacecraft in funzione dell'anomalia vera
        r = p / (1 + e*cosd(f(i)));
%       Converto in coordinate cartesiane
        x = r*cosd(f(i));
        y = r*sind(f(i));
        z = 0;
%       Cambio di coordinate il vettore posizione per plottarlo
        pos = Q_pX * [x y z]';
        pos_p_heliocentric = Q_pX * pos_pianeta';   %non sono sicuro serva

        %salvo posizione spacecraft se entro nella soi del pianeta di
        %arrivo
        r_spcr_pianeta = pos - pos_p_heliocentric;
        if norm(r_spcr_pianeta) <= R_SOI_Jupiter
           spcr_SOI_input_point = [r_spcr_pianeta(1) r_spcr_pianeta(2) r_spcr_pianeta(3)];
        else
           spcr_SOI_input_point = [0 0 0];
        end    
    
    end
    
end