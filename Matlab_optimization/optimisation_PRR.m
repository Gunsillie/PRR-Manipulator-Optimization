%__________Optimisation d'un manipulateur plan PRR__________
% 
%			  Romain PESSIA, Maxime HOLSTEIN
% 		   ROPAH 2017, enseignant : Stéphane CARO
%
%
% Ce programme a pour but d'optimiser les valeurs des 
% caractéristiques du manipulateur plan PRR de façon à 
% minimiser sa surface occupée.Il utilise la fonction fmincon 
% d'optimisation non-linéaire pour résoudre ce problème.
%
% - fun.m décrit simplement la fonction à minimiser ici
% - genjac.m calcule la matrice jacobienne d'une configuration
%   donnée du manipulateur
% - MGI.m calcule le modèle géométrique indirect du manipulateur
%   pour une configuration donnée
% - nlincond.m exprime les conditions non-linéaires que doit
%   remplir le manipulateur (ici, seulement des inégalités)
%___________________________________________________________


% Inégalités linéaires entre les données du problème
A=[ -2   sqrt(3)/2  -sqrt(3);
     1  -1   0;
     0  -1   1];
b=[0; 0; 0];

% Egalités linéaires entre les données du problème
Aeq=[];
beq=[];

%x = [Lb, R, r]
% Valeurs initiales
x0=[0.4; 0.7; 0.2];
% Valeurs minimales
lb=[0; 0; 0];
% Valeurs maximales
ub=[0.7.; 1.; 0.5];

[x,fval] = fmincon(@fun,x0,A,b,Aeq,beq,lb,ub,@nlincond)