////////////////////////////////////////////////////////////
///////// Projet de Calcul Scientifique
////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////
///////// Le Carré [0,1]*[0,1]
////////////////////////////////////////////////////////////


// VERSOIN MODIFIÉE PAR FABIEN DELHOMME -- PRISE DE NOTE


// IDÉE DE BASE

// On fait une grille plus grande que le domaine. Le nombre de case est detérminé par la précision

// On considère que les points qui sont juste avant la fin du domaine représente la frontière.
// (discètisation)


// Pb: comment savoir rapidement si on est dehors, sur la frontière, ou dedans ?
// Solution: On fait deux matrices, l'une qui va contenir l'évaluation de la fonction f, et l'autre
// qui va être une matrice booléenne indiquant si on est au bord, à la frontière ou à l'extérieure.


// PLAN D'ATTAQUE -- Commun

// Décider d'une nouveaux domaine
// Etablir une discrétisation correcte du domaine (plus on augmente le nombre de points, plus on se
// rapproche du vrai domaine )
// Coder la construction de la grille (les deux matrices). 
// Lancer l'algorithme.

//Plan d'attaque perso

// Coder la dernière partie de l'algorithme (facile)
// Faire l'exemple du cercle unité (moyen)


function Test = D(x,y)
    // Renvoie :
    // 1 si le point de coordonnées (x,y) est dans le domaine D
    // 0 sinon
    Test = 1d0*(x>=0 & x<=1 & y>=0 & y<=1)
endfunction


function Test = dD(x,y)
    // Renvoie :
    // 1 si le point de coordonnées (x,y) est sur le bords de D
    // 0 sinon
    Test = 1d0*((x==0 & y>=0 & y<=1) | (y==0 & x>=0 & x<=1) | (x==1 & y>=0 & y<=1) | (y==1 & x>=0 & x<=1))
endfunction  

// On représente le domaine par un tableau: 


function [X,Y]= crea_D(L)
    // Crée le domaine, réprésenté par :
    // X : liste des abscisses, associée à
    // Y : liste des ordonnées
    X = []
    Y = []
    for i = 0:(1/L):1
        for j = 0:(1/L):1
            X = [X,i]
            Y = [Y,j]
        end
    end
endfunction


function [X,Y]= marche_alea(x,y,L)
    // Une marche aléatoire :
    // à partir d'un point de coordonnées (x,y), et vers un de ses quatre voisins numérotés de 1 à 4 :
    //        3
    //      2 + 4
    //        1
    test = grand(1,1,'uin',1,4) // entier aléatoire dans [1,4]
    X = x + (1/L)*(test==4) - (1/L)*(test==2) // ? solution au problème d'arrondis : x = int(L*x)/L ?
    Y = y + (1/L)*(test==3) - (1/L)*(test==1)
endfunction

function tempsArrivee = marcheAle(grilleDomaine)
    test = grand(1,1,'uin',1,4) // entier aléatoire dans [1,4]

    
endfunction

function v = Monte_Carlo_point(x,y,L,K,f)
    // méthode de Monte-Carlo appliquée à un point de coordonnées (x,y) où :
    // 1/L est la taille du maillage
    // K est le nombre de marches aléatoires à réaliser
    // F est la condition sur le bords du domaine
    V = [] // V : tableau qui va contenir les K valeurs de F obtenues à la fin des K marches aléatoires
    x0 = x
    y0 = y // (x0,y0) : coordonnées du point d'origine, que l'on ne modifiera pas.
    for i = 1:K
        while ~(dD(x,y))
            [x,y] = marche_alea(x,y,L)
            disp(x)
            disp(y)
        end
        V(i) = f(x,y)
        x=x0
        y=y0
    end
    v = sum(V)/length(V)
endfunction


function [X,Y,Z] = Monte_Carlo_domaine(L,K,f,affichage)
    // X,Y,Z : listes des abscisses, ordonnées, valeurs en ces points.
    // affichage : entrer 1 si l'on veut afficher le résultat, 0 sinon.
    [X,Y] = crea_D(L)
    for i = 1:L**2
        Z(i) = Monte_Carlo_point(X(i),Y(i),L,K,f)
    end
    if affichage then
        plot3d3(X,Y,Z)
    end
endfunction


////////////////////////////////////////////////////////////
///////// Essai pour une certaine condition F
////////////////////////////////////////////////////////////


function Y = F1(x,y)
    // on choisit la condition prenant pour valeur :
    // 1 sur deux côtés opposés du carré
    // 0 sur les deux autres côtés
    Y = 1*(x==1) + 1*(x==0)
endfunction


