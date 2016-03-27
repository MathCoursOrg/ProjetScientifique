clear;
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

//=============================================================



// Constantes

N = 20; // précision, inutile si on prend le domaine à partir d'une image
K = 10; // nombres de marches aléatoires que l'on effectue par points

ChoixDomaine = 0;

// Création de la matrice estDedans


// On se donne la grille, le but est de faire la marche aléatoire


//La fonction MatLocal représente le domaine

// Par exemple :
//0 0 0 0 0 0 0 0 0 0 0  |
//0 0 0 0 1 1 0 0 0 0 0  |
//0 0 0 1 1 1 1 0 0 0 0  |
//0 0 1 1 1 1 1 1 0 0 0  |
//0 0 1 1 1 1 1 1 1 0 0  N
//0 0 1 1 1 1 1 1 1 0 0  |
//0 0 0 1 1 1 1 1 0 0 0  |
//0 0 0 0 1 1 1 0 0 0 0  |
//0 0 0 0 0 0 0 0 0 0 0  |



if ChoixDomaine == 0
    estDedans = zeros(N,N);
    matValeur = zeros(N,N);
    // C'est un cercle centré 0, de rayon 1
    for i = 1:N
        for j = 1:N
            if (i/N)**2 + (j/N)**2<=1 // Ceci est un quart de cercle...
                estDedans(i,j)=1;
            end
        end
    end
end

if ChoixDomaine == 1
    estDedans = zeros(N,N);
    matValeur = zeros(N,N);
 // On fait un carré
  for i = 1:N
    for j = 1:N
      if max(i/N - 1/2)
      end
    end
  end
end

if ChoixDomaine == 3
    //On prend le domaine parmi les dessins du dossiers domaine
    estDedans = fscanfMat("domaines/essaiImage.png.txt")
    taille = size(estDedans)
    N = taille(1)
    matValeur = zeros(N,N)
end

function z=fonctionBord(x, y)
//    if x<y
//        z =1
//    else
//        z = 0
//    end
    z = abs(sin(x+y))
endfunction

function y=valeurTrouveeAuBord(i,j)
//on se balade dans la grille jusqu'a en sortir ( == toucher une frontière),la valeur de la fonction bord atteint
    while (i <= N & j<= N & i > 0 & j > 0 & estDedans(i,j))
        pasAlea = grand(1,1, 'uin', 1, 4)
        i = i + (pasAlea==4) - (pasAlea==2);
        j = j + (pasAlea==3) - (pasAlea==1);
    end

    // Une fois que l'on est sorti de la boucle, on est à la frontière (ou sur la grille).
    y = fonctionBord(i,j)
endfunction

// constructionSolLaplacien: Construit la solution du laplacien point par point
// entrée: les deux matrices qui représente le domaine
// sortie: la matrice Valeur, matValeur, qui est modifiée


// On parcours toutes les cases de la grille, jusqu'a être à l'intérieure du domaine

drawlater()
clf()
for i = 1:N
    for j = 1:N
        if estDedans(i,j)
            for k = 1:K
                matValeur(i,j) = matValeur(i,j) + valeurTrouveeAuBord(i,j);
            end
            matValeur(i,j) = matValeur(i,j)/K;
        end
    end
end
plot3d1(0:1/N:1-1/N, 0:1/N:1-1/N, matValeur)
drawnow()
