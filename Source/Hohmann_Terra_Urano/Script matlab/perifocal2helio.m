% Restituisce la matrice di rotazione per passare da un'orbita perifocale a
% una eliocentrica 

function Q = perifocal2helio(RA, incl, w)
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
    Q = (R3_w*R1_i*R3_W)';
    
end