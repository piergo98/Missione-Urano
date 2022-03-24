%Calcolo il tempo t di flyby giove usando l'equazione di keplero

%conosco a,e,r dallo script Flyby_jupiter
GM_jupiter = 126686534; %[km^3/s^2] 
v_inf_down = v2_l_j - v2_j ;  
v_inf_down_norm = norm(v_inf_down); 
% %v_inf_up_norm = norm(v_inf_up); 
a= - GM_jupiter/((v_inf_down_norm)^2);%semiaxis major 
r_p= 1e5;  %hp  
e= 1-(r_p/a); 
delta= 2*asind(1/e); %angolo tra gli asintoti 

%ricavo l'anomalia vera f

%conosco a,e,r dallo script Flyby_jupiter 
 
%ricavo l'anomalia vera f 
 
f = acosd((a*(1-e^2)-r_p) / (e*r_p)) 
%cosf = (a*(1-e^2)-R_SOI_jupiter) / (e*R_SOI_jupiter) 
%trovo l'anomalia eccentrica E 
 
%tan(E/2)=(((1-e)/(1+e))^(1/2))*(tan(f/2)); 
 
%trovo p semilato retto [km] 
p= r_p*(1+e*cosd(f)) 
 
%calcolo f1 su sfera più stretta r=10000 
r=1e4; 
%calcolo anomalia vera per r 
f1= acosd((1/e)-(r/p)) 
%E = 2*atanhd((((1-e)/(1+e))^(1/2))*(tan(f/2))) 
E=atanh(sqrt((e-1)/(e+1))*tand(f1/2))   
E_deg= rad2deg(E) 
%trovo anomalia media M 
 
M = e*sinh(E)-E 
M_deg=rad2deg(M) 
 
%trovo il tempo 
 
t_flyby = M_deg*sqrt(-a^3/GM_jupiter) %in secondi 
t_flyby_tot=2*t_flyby  
t_flyby_tot_hours= t_flyby_tot/3600 
 
 
