// Test de convergence dans le cas d'une fonction au bord simple (x+y)
// on fixe le domaine. On va faire varieir le nombre de marche aléatoire.

//Pour optimiser les calculs, l'idée est de faire une moyenne de série de 10 ésultats. POur suivre l'évolution de la construcion de
//la moyenne de la solution.

clear;
// Constantes

N = 20
K = 3; // nombres de marches aléatoires que l'on effectue par points par série.
S = 30; // Nombre série que l'on va faire.

ChoixDomaine = 0; // On fixe le domaine
iterateur = 1:S //pour afficher le graphique

if ChoixDomaine == 0
    estDedans = zeros(N,N);
    matValeur = zeros(N,N);
    // C'est un cercle centré 0, de rayon 1
    for i = 1:N
        for j = 1:N
            if i**2 + j**2<=N*N // Ceci est un quart de cercle...
                estDedans(i,j)=1;
            end
        end
    end
end

function z=fonctionBord(x, y)
//    if x<y
//        z =1
//    else
//        z = 0
//    end
    x = x/N //Pour pas avoir des valeurs trop grandes aux bords
    y = y/N
    z = x + y
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


//Vecteur qui contient tout les erreurs en fonction du nombre de marche aléatoire
vecErreur = zeros(1, S)
// On parcours toutes les cases de la grille, jusqu'a être à l'intérieure du domaine

// On initialise la grille.
for i = 1:N
    for j = 1:N
        if estDedans(i,j)
            matValeur(i,j) = valeurTrouveeAuBord(i,j)
        end
    end
end
    
for k = 2:S
    erreurMax = 0
    for i = 1:N
        for j = 1:N
            if estDedans(i,j)
                somme = 0
                for l = 1:K
                    somme = somme + valeurTrouveeAuBord(i,j);
                end
                matValeur(i,j) = ( somme + k*K*matValeur(i,j) )/ ((k+1)*K); //Vive le hacking
                
                e = abs(matValeur(i, j) - fonctionBord(i,j))
                if e > erreurMax
                    erreurMax = e
                end
            end
        end
    end
    vecErreur(k)= erreurMax
    scf(1)
    subplot(221)
    clf()
    plot3d1(0:1/N:1-1/N, 0:1/N:1-1/N, matValeur)
    // Fin du calcul de la k-ieme série.
    
    // Calcul de la différence avec la solution. Ici, puisque la fonction au bord est linéaire, la solution attendue est cette même fonction
    
    // On prend la norme max.
   
    // On vient de calculer la "distance" entre la solution est l'approximation pour K = 10*k
    // On met cette donnée dans vecErreur(k)

    scf(2)
    subplot(222)
    clf()
    xtitle('Calcul de la distance entre la soolution approchée et la solution exacte', 'Nombre de marche aléatoire', 'Norme infinie entre la solution exacte et approchée')
    plot(K*iterateur, vecErreur)
end
