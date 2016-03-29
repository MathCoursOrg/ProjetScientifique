clear;
// Constantes

K = 5;
S = 10;

for N = 10:5:20 //On regarde pour les différentes valeurs de N
    estDedans = zeros(N,N);
    matValeur = zeros(N,N);

    // On prend ici un cercle centré au milieu du domaine de rayon N/2
    for i = 1:N
        for j = 1:N
            if (i - N/2)**2 + (j - N/2)**2<=(N/2)**2
                estDedans(i,j)=1;
            end
        end
    end

    function z=fonctionBord(x, y)
        z = (-x - y)/N + 2 // On prend ce plan pour des raisons purement esthétique
    endfunction

    function y=valeurTrouveeAuBord(i,j)
        while (i <= N & j<= N & i > 0 & j > 0 & estDedans(i,j))
            pasAlea = grand(1,1, 'uin', 1, 4)
            i = i + (pasAlea==4) - (pasAlea==2);
            j = j + (pasAlea==3) - (pasAlea==1);
        end
        y = fonctionBord(i,j);
    endfunction

    //Vecteur qui contient tout les erreurs en fonction du nombre de marche aléatoire
    vecErreur = zeros(1, S);

    // On initialise la grille, et on trouve la première erreur commise.
    erreurMax = 0;
    for i = 1:N
        for j = 1:N
            if estDedans(i,j) //une fois que l'on est dedans
                matValeur(i,j) = valeurTrouveeAuBord(i,j);
                e = abs(matValeur(i, j) - fonctionBord(i,j)); //on calcule l'erreur commise par l'approximation
                if e > erreurMax
                    erreurMax = e;
                end
            end
        end
    end
    vecErreur(1)=erreurMax;

    // Ensuite, on calcule toutes les erreurs en fonctions de k qui varie entre 2 et S
    for k = 2:S
        erreurMax = 0;
        for i = 1:N
            for j = 1:N
                if estDedans(i,j)
                    somme = 0;
                    for l = 1:K
                        somme = somme + valeurTrouveeAuBord(i,j);
                    end
                    matValeur(i,j) = ( somme + k*K*matValeur(i,j) ) / ( ( k + 1 )*K ); // Moyenne pondérée
                    // Calcul de la différence avec la solution:
                    //Ici, puisque la fonction au bord est linéaire, la solution attendue est cette même fonction
                    e = abs(matValeur(i, j) - fonctionBord(i,j));// Calcul de l'erreur pour le point (i,j)
                    if e > erreurMax
                        erreurMax = e;
                        // On prend la norme max.
                    end
                end
            end
        // Fin du calcul de la k-ieme série.
        end
        // On vient de calculer la "distance" entre la solution est l'approximation pour K = 10*k
        // On met cette donnée dans vecErreur(k)
        vecErreur(k)= erreurMax;
    end

    // On affiche le tout, et on sauvegarde dans les fichiers qui vont bien

    iterateur = 1:S; //pour afficher le graphique
    //D'abord la solution en elle même (pour voir si elle ressemble à un plan)
    scf(1);
    clf();
    xtitle("Représentation de la solution approchée", "axe des absicces", "axe des ordonnées", "");
    plot3d1(0:1/N:1-1/N, 0:1/N:1-1/N, matValeur, theta = 30);
    xs2png(1,'ResultatsConvergences/ImageK' + string(K) + 'S'+ string(S) + 'N'+string(N)+'.png')

    //Ensuite le graphe log/log pour contrôler la convergence
    scf(2);
    clf();
    xtitle('Calcul de la distance entre la solution approchée et la solution exacte en échelle logarithmique', 'Nombre de marche aléatoire', 'Norme infinie entre la solution exacte et approchée');

    //On termine en rajoutant une regression pour connaitre la puissance alpha telle que | solutionApproche - solutionExacte| = O(1/K^alpha)

    [a,b]=reglin(log(K*iterateur), log(vecErreur))
    plot2d(K*iterateur, vecErreur, logflag="ll");
    plot2d(K*iterateur, ((K*iterateur).^a), leg=string(a) + "*x", style = -1);

    xs2png(2,'ResultatsConvergences/Convergence_K' + string(K) + '_S'+ string(S) + '_N'+string(N)+'.png')
end
