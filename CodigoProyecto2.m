%Método del Simpson 1/3
clc;
clear;
syms x1 f(x) y g(x)
disp("***********Calculo de la concentración de oxigeno disuelto\n en un cuerpo de agua estático************");
%%Método de simpson 1/3 múltiple con n=100 + operaciones extra
o=input("Ingresa la Tasa de disminución de concentración de oxígeno por metro por litro (mgO2/L*m): "); 
T=o*1000;
A=input("Ingresa el área superficial promedio en m^2: ");

f(x)=T*A*x;

a=0;
b=input("Ingresa la profundidad promedio del cuerpo de agua en metros: ");
n=3;

h=(b-a)/n;

DBO=input("Ingresa el DBO (La demanda biologica) Unidades mgO2/L: ");
Q=input("Ingresa el caudal del efluente en m^3/s: ");

fact=input("Introduce el porcentaje de reduccion del DBO: ");
dec=1-(fact/100); %%Calculo del decimal

t=24*3600; %%Se esta asumiendo el tiempo de exposición por día (En segundos) 

ValX= zeros(1,n+1);
ValY= zeros(1,n+1);
for i=1:n+1
    r=a+h*(i-1);
    ValX(1,i)=r;
end

for i=1:n+1
    s=eval(f(ValX(1,i)));
    ValY(1,i)=s;
end



MOL=(b-a)*(ValY(1,1)+3*ValY(1,2)+3*ValY(1,3)+ValY(1,n+1))/8; %Masa de oxígeno disuelto en la laguna

Vdbo=Q*t*1000; %Volumen caudal DBO en L
Mdbo=Vdbo*DBO; %Masa del DBO en mg

MTot=MOL-Mdbo; %Masa total de oxigeno disuelto

VLag=b*A*1000; %Volumen de laguna
CF=MTot/(VLag+Vdbo); %Concentracion de oxigeno disuelto en laguna despues de 24h

fprintf("\n*******Concentracion de oxigeno disuelto en la laguna despues de 24 horas: %f********\n",CF);

%%Aqui se calcula considerando el cambio del DBO
Mdbo2=Vdbo*DBO*dec;
MTot2=MOL-Mdbo2;
CF2=MTot2/(VLag+Vdbo); %Concentracion de oxigeno disuelto en laguna despues de 24h


%%Valores que se han detectado en laguna: 0.3 a 3.52   Oxigeno disuelto mg/L

if 4<CF2 && CF2<7
    fprintf("\n*****Con esta reduccion de DBO, el valor %f se encuentra dentro de los límites establecidos para desarollar vida*****\n",CF2);
else 
    fprintf("\n*****Con esta reduccion de DBO, el valor %f no tiene los requesitos para desarrollar vida*****\n",CF2);
end