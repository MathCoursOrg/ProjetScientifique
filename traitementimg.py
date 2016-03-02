from PIL import Image
import sys

#récupère l'argument passer après le nom du programme en ligne de commande qui sera le nom du fichier
nom_image = sys.argv[1]

img = Image.open(nom_image)


largeur = img.width
hauteur = img.height
N=0

#on veut une image carrée
if largeur==hauteur:
    N = largeur
else:
    sys.exit("image pas carrée")

#on ouvre un fichier dans lequel écrire
nom_fichier = nom_image+".txt"
fichier=open(nom_fichier,'a')
fichier.write("N = "+str(N)+"\n"+"matrice = [\n")

#pour avoir l'image en noir et blanc
img=img.convert('L')

#on parcourt l'image pour analyser la couleur de chaque pixel et la reporter dans le fichier
for y in range(0,N):
    for x in range (0,N):
        if x!= N-1:
            #on est pas à la fin de la ligne donc séparation par virgule
            if img.getpixel((x,y))=255:
                #on a un carré noir
                fichier.write("1,")
            else:
                #on a un carré blanc
                fichier.write("0,")
        else:
            #on est à la fin de la ligne donc séparation par point-virgule
            if img.getpixel((x,y))=255:
                #on a un carré noir
                fichier.write("1;\n")
            else:
                #on a un carré blanc
                fichier.write("0;\n")   
            
            
            
            
fichier.write("];")
fichier.close()

































