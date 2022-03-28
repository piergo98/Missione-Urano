h = coe(1);         % Momento angolare
e = coe(2);         % Eccentricità
RA = coe(3);        % Ascensione retta
incl = coe(4);
w = coe(5);

radius = 6e3;


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

% hold on
f = 1:0.1:360;
pos = [];

figure(1)
hold on;

for i = 1:length(f)
    r = p / (1 + e*cosd(f(i)));
    
    x = r*cosd(f(i));
    y = r*sind(f(i));
    z = 0;
    pos = Q_pX * [x y z]';

    if i == 1 
        plot(x,y, 'bo-', 'LineWidth', 2, 'MarkerSize', 18);
        c = circle_plot(x, y, radius);
        ra = animatedline(x, y,"Color",'r','LineWidth',3);
    end
    addpoints(ra, x, y);
    drawnow;
    c.Position(1) = x - radius;
    c.Position(2) = y - radius;
    drawnow;
%     plot3(pos(1), pos(2), pos(3),'ko')
%     line(pos(1), pos(2), pos(3))
    xlim([-2e9 2e9])
    ylim([-2e9 2e9])
    zlim([-2e9 2e9])
end

xlabel('km')
ylabel('km')
zlabel('km')
view([1, 1, 0])
