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

N = 100 // précision
K = 10 // nombres de marches aléatoires que l'on effectue par points


// On se donne la grille, le but est de faire la marche aléatoire

// La grille, c'est deux matrices

//La fonction MatLocal représente le domaine
function y=creerMatLocal()
    //  1 si c'est dedans, 0 dehors, 2 sur la frontière (la valeur de la case i,j de la matrice)
end


function y=creerMatVal(matLocal, fonctionBord)

    //On parcours la matrice matLocal, et si on tombe sur une frontière, on évalue fonctionBord

    for i = 1:N
        for j = 1:N
            if matLocal(i,j)==2
                matVal(i,j)= fonctionBord(i,j)
            end
        end
    end

end

function y=valeurTrouveeAuBord(matLocal, fonctionBord)
//on se balade dans la grille jusqu'a en sortir ( == toucher une frontière),la valeur de la fonction bord atteint
end

// constructionSolLaplacien: Construit la solution du laplacien point par point
// entrée: les deux matrices qui représente le domaine
// sortie: la matrice Valeur, matValeur, qui est modifiée

function y=constructionSolLaplacien(matValeur, matLocal)

    // On parcours toutes les cases de la grille, jusqu'a être à l'intérieure du domaine

    i = 0
    j = 0 //On commence en haut à droite
    for i = 1:N
        for j = 1:N
            if matLocal(i,j) == 1
                for k = 1:K
                    matValeur(i,j) = matValeur(i,j) + nbPasAleaSortir(i,j)
                end
                matValeur(i,j) = matValeur(i,j)/K
            end
        end
    end
end


//Avantage: on peut facilement paralléliser, puisque il on construit la solution point par point
