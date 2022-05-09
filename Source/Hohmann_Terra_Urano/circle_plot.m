% Definisco la funzione che disegna un cerchio nella posizione desiderata
function h = circle_plot(x,y,r,color)
    d = r*2;
    px = x-r;
    py = y-r;
    h = rectangle('Position',[px py d d],'Curvature',[1,1], 'EdgeColor', color);
    %daspect([1,1,1]
end