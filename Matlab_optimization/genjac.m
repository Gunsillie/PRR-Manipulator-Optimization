function J = genjac(r, a1, a2, a3, b1, b2, b3, e1, e2, e3)
% Prend en argument les différents vecteurs permettant
% le calcul de la jacobienne, et renvoie celle-ci

E = [0 -1; 1 0];

% Notons que le calcul de A est fait avec une normalisation,
% comme expliqué dans le rapport
A = [b1' b1'*E*e1;
     b2' b2'*E*e2;
     b3' b3'*E*e3];

B = eye(3);
B(1,1) = b1'*a1;
B(2,2) = b2'*a2;
B(3,3) = b3'*a3;

J = B\A; %inv(B)*A