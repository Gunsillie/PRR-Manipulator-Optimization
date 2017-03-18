function [error, a1, a2, a3, b1, b2, b3, e1, e2, e3] = MGI(X,Lb, R, r)
% Rappel : X = [x; y; phi] 

error = 0;
a1 = 0;
a2 = 0;
a3 = 0;
b1 = 0;
b2 = 0;
b3 = 0;
e1 = 0;
e2 = 0;
e3 = 0;

%Calcul de rho1
xc1 = X(1) + r*cos(X(3)+7*pi/6);
yc1 = X(2) + r*sin(X(3)+7*pi/6); 
beta1 = asin(yc1/Lb);
rho1 = xc1 - Lb*cos(beta1);
%On teste la validité de rho1
if (isreal(rho1) == 0 || rho1<=0 || rho1 >= sqrt(3)*R)
    error = 1;
    return
end

%Calcul de rho2
syms x;
xc2 = X(1) + r*cos(X(3)-pi/6);
yc2 = X(2) + r*sin(X(3)-pi/6); 
b = xc2-sqrt(3)*R-sqrt(3)*yc2;
c = (xc2-sqrt(3)*R)^2+yc2^2-Lb^2; 
rho2 = 0.5*(-b+sqrt(b^2-4*c));
%On teste la validité de rho2
if (isreal(rho2) == 0 || rho2<=0 || rho2 >= sqrt(3)*R)
    error = 1;
    return
end

%Calcul de rho3
xc3 = X(1) + r*cos(X(3)+pi/2);
yc3 = X(2) + r*sin(X(3)+pi/2);
b = xc3-sqrt(3)*R/2+sqrt(3)*(yc3-3*R/2);
c = (xc3-sqrt(3)*R/2)^2+(yc3-3*R/2)^2-Lb^2; 
rho3 = 0.5*(-b+sqrt(b^2-4*c));
%On teste la validité de rho3
if (isreal(rho3) == 0 || rho3<=0 || rho3 >= sqrt(3)*R)
    error = 1;
    return
end

%Si aucune erreur, vecteurs ai, bi, ei (pour le calcul de la jacobienne)
beta2 = pi/3 - asin((yc2-rho2*sqrt(3)/2)/Lb);
beta3 = 2*pi/3 + asin((yc3-3*R/2+rho3*sqrt(3)/2)/Lb);
a1 = [rho1; 0];
a2 = [-rho2/2; rho2*sqrt(3)/2];
a3 = [-rho2/2; -rho2*sqrt(3)/2];

b1 = [Lb*cos(beta1); Lb*sin(beta1)];
b2 = [Lb*cos(beta2+2*pi/3); Lb*sin(beta2+2*pi/3)];
b3 = [Lb*cos(beta3+4*pi/3); Lb*sin(beta3+4*pi/3)];

e1 = [r*cos(X(3)+7*pi/6); r*sin(X(3)+7*pi/6)];
e2 = [r*cos(X(3)-pi/6);   r*sin(X(3)-pi/6)];
e3 = [r*cos(X(3)+pi/2);   r*sin(X(3)+pi/2)];

end