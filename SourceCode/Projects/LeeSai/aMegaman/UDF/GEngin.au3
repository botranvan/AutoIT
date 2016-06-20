#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:
	G-Engin:
		G-Engin (GEng) est un UDF qui permet de gérer un affichage 2D
		avec AutoIt simplement.
		Il est basé sur GDI+.
		
	Version 1.2.1: (02/07/2011)
	- +: Documentation complète
	- *: Le calcule de l'innertie de mouvement est plus précis
	- *: Il n'y plus qu'un seul paramètre Innertie (et pas 2)
	- *: La taille d'une police est exprimé en pixels (_GEng_Font_Create)
		
	Version 1.2: (10/06/2011)
	- +: Paramètre $iDynamique pour _GEng_Sprite_Collision et _GEng_Sprite_CollisionScrBorders qui permet d'activer le calcule
			de collisions dynamiques (collision élastique), assez rudimentaire (lent, bugé...) mais exploitable
	- +: _GEng_Sprite_MasseSet et _GEng_Sprite_MasseGet, masse d'un sprite pour les collisions dynamiques
	- +: _GEng_Sprite_CollisionScrBorders
	- +: _GEng_ImageLoadStream: charge la chaine de caractères représentant un fichier image (Résultat de: FileToBinaryString)
	- +: _GEng_Sprite_ColorMatrixTranslate, _GEng_Sprite_ColorMatrixReset
	- *: Calcules de collision simplifiés (le point n'est plus concidéré comme un rectanlge)
	- *: Mode debug amélioré: possibilité de selectionner certaines fonctions seulement (voir _GEng_SetDebug)
	- -: _GEng_FPS_Start et _GEng_FPS_End devient: _GEng_FPS_Get
		
	Version 1.1: (03/06/2011)
	- +: Volume, pan, pitch for hSound Object (_GEng_Sound_AttribSet, _GEng_Sound_AttribGet)
	- +: Possibilité de modifier la couleur d'un objet Text sans devoir créer un nouvel objet Font (voir _GEng_Text_Create)
	- +: Ajout de _GEng_Sprite_PointGet: Retourne la position d'un point dans un sprite
	- *: Ajout du paramètre $iDelay à _GEng_FPS_End (ne retourne le FPS que toutes les $iDelay ms)
	- *: _GEng_Sprite_Del Renommé en _GEng_Sprite_Delete
	- !: Bug _GEng_ImageLoad (Issue 1)
	- !: Bug _GEng_SpriteToPoint_AngleDiff (Issue 3)
	- !: Bug _GEng_Sprite_AngleSet (Issue 4)

	Version 1.0: (29/05/2011)
	- Lance une fenètre de rendu
	- Chargement de fichiers images (BMP, ICON, GIF, JPEG, Exif, PNG, TIFF, WMF, EMF)
		avec gestion de la transparence (PNG, ICO ...)
	- Création d'objets Sprites, qui sont le coeur du moteur:
		+ Un objet sprite doit contenir une image, ou une portion d'image
		+ Il possède différent attributs:
			Position (x, y)
			Taille (x, y)
			Point d'origin (x, y)
			Vitesse (x, y) et vitesse max (pixels/s)
			Accelération (x, y) (pixels/s²)
			Innertie (x, y) (pixels/s²)
			Angle (Degres)
			Vitesse de rotation (Deg/s)
			Accélération de rotation (Deg/s²)
			Innertie de rotation (Deg/s²)
		+ Il possède une zone de collision, qui peut être soir un point, un cercle, 
			ou un rectangle
		+ Enfin, il peut être animé grâce à un objer Animation
		+ PS: On peut attacher des variables à un sprite (voir GEng_Sprite_Append.au3)
	- Fonctions de calcules géométriques
		+ Distance, Angle, Vecteur entre: point-point, sprite-point, sprite-sprite
		+ Convertion Vecteur->Angle, Angle->Vecteur (en spécifiant la grandeur du vecteur)
	- Gestion des collisions entre sprites, et avec les bords de l'écran
	- Affichage de texte (couleur, police, taille, format ...)
	- Gestion rudimentaire des sons (bass.dll)
	
	Remarques:
	- L'unité de distance est le pixel => vitesse = pixels/s, accélération = pixels/s²
	- L'unité d'angle est le degré => vitesse de rotation = Deg/s, accélération de rotation = Deg/s²
	- Le point 0, 0 est situé au coin supérieur gauche de l'écran
	- En ce qui concerne les angles:
		+ 0 correspond à la direction droite
		+ un angle (+) signifie 'sens horaire', et inversement.
		+ l'angle d'un sprite sera toujours stocké sous la forme d'une valeur entre 0 et 359
			jamais un _GEng_Sprite_AngleGet ne retournera un nombre supérieur à 359 ou inférieur à 0
			Par contre, vous pouvez spécifier n'IMPORTE quel valeur pour un angle et elle sera toujours
			réduite à la valeur correspondante entre 0 et 359
		+ Concernant la vitesse et accélération de rotation: une valeur (+) signifie 'sens horaire'
			et inversement
	- L'innertie: est définie dans cet UDF comme 'une accélération qui fait tendre la vitesse vers 0'
		vous pouvez spécifier n'importe quelle valeur qu'elle soit + ou -, elle sera prise comme valeur
		absolue
	- Un objet Sprite tourne autour de sont point d'origine, et est positionné pas rapport à ce point
	
	To do:
	- Effets sonors (bass_fx.dll)
	- Permêtre la transmission de forces lors des collisions!
	- Meilleur gestion des erreurs

#ce ----------------------------------------------------------------------------

#include <GDIPlus.au3>
#include <Array.au3>
#include <WinApi.au3>
#include "GEngin\Bass\bass.au3"

; ##############################################################

Global $__GEng_hGui = -1
Global $__GEng_WinW = -1, $__GEng_WinH = -1
Global $__GEng_hBitmap = -1
Global $__GEng_hGraphic = -1
Global $__GEng_hBuffer = -1
Global $__GEng_hDC = -1
Global $__GEng_hCompatibleDC = -1
Global $__GEng_FPSTimer = 0
Global $__GEng_FPSDisplayTimer = 0
; ---
Global Const $__GEng_PI = 4 * ATan(1)


; ##############################################################

Global $__GEng_Debug = 0
Global $_Arrow, _
	$_dbg_Arrow0 = 0, $_dbg_Arrow1, $_dbg_Arrow2, $_dbg_Arrow3, $_dbg_Arrow4, _
	$_dbg_pen0 = 0, $_dbg_pen1, $_dbg_pen2, $_dbg_pen3, $_dbg_pen4

; ##############################################################

#include "GEngin\GEng_System.au3"
#include "GEngin\GEng_Image.au3"
#include "GEngin\GEng_Sprite.au3"
#include "GEngin\GEng_Sprite_Collision.au3"
#include "GEngin\GEng_Sprite_Animation.au3"
#include "GEngin\GEng_Sprite_Dynamics.au3"
#include "GEngin\GEng_Sprite_Get.au3"
#include "GEngin\GEng_Sprite_Set.au3"
#include "GEngin\GEng_Sprite_Append.au3"
#include "GEngin\GEng_Animation.au3"
#include "GEngin\GEng_Draw.au3"
#include "GEngin\GEng_Geometry.au3"
#include "GEngin\GEng_Text.au3"
#include "GEngin\GEng_Sound.au3"
; ---
#include "GEngin\GEng_Debug.au3"
