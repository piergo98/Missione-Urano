%Calcolo il tempo t di flyby(CI SI PROVA) usando l'equazione di keplero

%conosco a,e,r dallo script Flyby_jupiter

%ricavo l'anomalia vera f

f = acosd((a*(1-e^2)-rp) / (e*rp));

%trovo l'anomalia eccentrica E

%tan(E/2)=(((1-e)/(1+e))^(1/2))*(tan(f/2));

E = 2*atand(((1-e)/(1+e))^(1/2))*(tan(f/2));

%trovo anomalia media M

M = E - e*sin(E);

%trovo mean motion n

n = (mu/a^3)^(1/2);

%trovo il tempo

t_flyby = M/n

