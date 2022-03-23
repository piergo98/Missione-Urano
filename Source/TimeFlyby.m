%Calcolo il tempo t dio flyby(CI SI PROVA) usando l'equazione di keplero

%test
%  a = 10000;
%  e = 0.5;
%  r_in = 14147;
%  r_p = a*(1-e);
r_SOI_Jupiter = 48.2e6;
%conosco a,e,r_p dallo script Flyby_jupiter

%r_in = p/(1+e*cos(f))
%p = r_in*(1+e*cos(f))
%ricavo l'anomalia vera f (di ingresso SOI?)

r_in = r_SOI_Jupiter;

%%versione in gradi che non torna
%cosf = (a*(1-e^2)-r_in) / (e*r_in)
%f = acosd((a*(1-e^2)-r_in) / (e*r_in))

%p = r_in*(1+e*cosd(f))
%p2 = r_in*(1+e*cosf)

%%versione in radianti di p (NON DOVREBBE FUNZIONARE MA INVECE SEMBRA
%%ANDARE PER SBAGLIO
f = acosd((a*(1-e^2)-r_in) / (e*r_in))
p = r_in*(1+e*cos(f))

f1 = acosd((1/e)-(r_in/p))
f2 = -f1
%f1 = acosd((1/e)-(r_in/p))
%trovo l'anomalia eccentrica E2

E2 = atanh(((e-1)/(e+1))^(1/2) * tan(f2/2))

%E = 2*atand((((1-e)/(1+e))^(1/2))*(tand(f/2)))

%trovo anomalia media M

%M = E - e*sin(E)

M2 = e * sinh(E2) - E2

%trovo mean motion n

%n = (mu/a^3)^(1/2)
%n = (GM_jupiter/a^3)^(1/2)

%trovo il tempo

%t_flyby = M/n

t2 = M2 * (((-a^3)/(GM_jupiter))^(1/2))

delta_t = 2 * t2