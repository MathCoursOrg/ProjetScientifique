# Projet Scientifique
_Solving Laplace Equation by the method of Monte Carlo._


Le but de ce projet est de résoudre l'équation de Poisson avec la méthode de
Monte Carlo.

Ce projet est constitué des fichiers suivants:
    - __monteCarlo.sce__: code _Scilab_ qui résout l'équation de poisson à l'aide
      d'un algorithme randonisé.
    - __premierCode.sce__: code _Scilab_ illustrant un problème d'arrondi.
    - __presentation.tex__: code _LaTeX_ qui présente la méthode de Monte Carlo, et
      les principaux résultats qui assurent la convergence (en cours)


Ce qu'il reste à faire: (par ordre décroissant d'urgence)
    - Faire un graphe log/log pour trouver l'ordre de convergence du schéma (
        presque surement ?? ). Il faut plusieurs graphes puisque la méthode est
        paramétrée par K (nombre de marches aléatoires) et par N (précision de
        la grille, c'est-à-dire précision de la discrétisation du domaine).
    - Compléter le fichier presentation.tex
    - Ajouter de nouveaux domaines
    - Conclure quant à d'éventuelle corrélation entre la vitesse de convergence
      du schéma et la « bizarrie » du domaine.
    - Peut on jouer sur la symétrie d'un domaine pour mettre en évidence la
      convergence de la solution ?

## Avantages de la méthode de Monte Carlo

    - Plutôt facile à mettre en œuvre.
    - Le schéma permet de construire la solution point par point: on peut donc
      paralléliser le processus, soit en divisant le domaine, soit en divisant
      le nombre de marche aléatoire par point, puis faire la moyenne des
      résultats trouvés.


## Désavantage (à priori?)

    - Convergence non certaine en théorie (??). Quant est-il en pratique ?
    - Temps d'exécution  «aléatoire ».

Il est donc possible d'obtenir n'importe quoi au bout d'un temps très long.
(Vraiment ?)
