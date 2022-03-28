%Calcolo il tempo t di flyby giove usando l'equazione di keplero

%conosco a,e,r dallo script Flyby_jupiter
GM_jupiter = 126686534; %[km^3/s^2] 
v_inf_down = v2_l_j - v2_j ;  
v_inf_down_norm = norm(v_inf_down); 
% %v_inf_up_norm = norm(v_inf_up); 
a= - GM_jupiter/((v_inf_down_norm)^2);%semiaxis major 
r_p= 1e6;  %hp  
e= 1-(r_p/a); 
%e= 2*GM_jupiter/(a*(v_inf_down_norm)^2)-1
delta= 2*asind(1/e); %angolo tra gli asintoti 

%ricavo l'anomalia vera f

%conosco a,e,r dallo script Flyby_jupiter 
 
%ricavo l'anomalia vera f 
 
f = acos((a*(1-e^2)-r_p) / (e*r_p)) 
f_deg =rad2deg(f)
%cosf = (a*(1-e^2)-R_SOI_jupiter) / (e*R_SOI_jupiter) 
%trovo l'anomalia eccentrica E 
 
%tan(E/2)=(((1-e)/(1+e))^(1/2))*(tan(f/2)); 
 
%trovo p semilato retto [km] 
p= r_p*(1+e*cos(f)) 
 
%calcolo f1 su sfera più stretta r=10000 
r=R_SOI_Jupiter; 
%calcolo anomalia vera per r 
f1= acos((1/e)*((p/r)-1)) 

%E = 2*atanhd((((1-e)/(1+e))^(1/2))*(tan(f/2))) 
E_2=atanh(sqrt((e-1)/(e+1))*tan(f1/2)); 
E = E_2/2;
E_deg= rad2deg(E) 
%trovo anomalia media M 
 
M = e*sinh(E)-E 
M_deg=rad2deg(M) 
 
%trovo il tempo 
 
t_flyby = M*sqrt(-a^3/GM_jupiter) %in secondi 
t_flyby_tot=2*t_flyby  
t_flyby_tot_hours= t_flyby_tot/3600 
 
[y m d h min sec] = sec2date(t_flyby_tot) 
