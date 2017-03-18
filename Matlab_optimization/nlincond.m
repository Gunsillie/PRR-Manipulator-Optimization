function [ c,ceq ] = nlincond( x )

Lb = x(1);
R = x(2);
r = x(3);
syms x;

%condition sur la raideur; détermination de a
E = 200*10^9; %acier

% Ligne optionnelle pour calculer la section des barres intermédiaires
%a = vpasolve(x^8+16*Lb^4*x^4==16*Lb^6*10^10/(9*E^2), x, [0 1]);

C2 = 10;
C3 = 10; 
c = [];
ceq = [];
n = 5;    % Nombre de points pour l'échantillonage
Rw = 0.05; % Rayon souhaité de l'espace de travail
phi = [2*pi/3; 2*pi/3-pi/12; 2*pi/3+pi/12];


maxCond = 1;
for i=0:n-1             % test de n points sur le cercle délimitant l'e.d.t
    for j=1:size(phi)   % Test des différents angles phi pour 
                        % x et y donnés
        pos = [R*sqrt(3)/2+ Rw*cos(pi*i/n); R/2+ Rw*sin(pi*i/n); phi(j)];

        % Test du MGI sur la position en cours
        [error, a1, a2, a3, b1, b2, b3, e1, e2, e3]= MGI(pos,Lb, R, r);
        if(error == 1)
            c = [10;10]
            return
        else
            %Test du conditionnement de J*J'
            J = genjac(r, a1, a2, a3, b1, b2, b3, e1, e2, e3);
            lambda = eig(J*J');
            cond = max(abs(lambda))/min(abs(lambda));

            if cond > maxCond
                maxCond = cond;
                C3 = double(maxCond)-250;
				% Malgré la normalisation de J, le conditionnement reste 
				% toujours  bien supérieur à 10 ; nous choisissons à
				% la place 250 comme valeur acceptable
            end
        end    
    end
end
C2 = 0;
if(C3>10)
    C3=10;
end
c = [C2; C3]
end