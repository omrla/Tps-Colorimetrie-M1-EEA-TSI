# Travaux Pratiques Colorimétrie - M1 EEA/TSI

**Auteurs :** Omar Lamari & Az-eddine MAZID  
**Établissement :** Université de Bourgogne Europe  
**Filière :** M1 EEA/TSI - 2025/2026  
**Enseignant responsable :** Lyes AKSAS  
**Logiciel :** MATLAB (pour TP1 et TP6)  

---

## Rapport et énoncé

- [Télécharger le rapport complet (PDF)](rapport/Rapport_TPs_Colorimetrie_LAMARI_MAZID.pdf)
- [Télécharger le fascicule officiel (PDF)](rapport/Enonce_Colorimetrie_2024.pdf)

---

## Contenu du projet

| TP | Thème | Type | Fichiers |
|----|-------|------|---------|
| **TP 1** | Mesure colorimétrique de surface par photométrie | Lab + MATLAB | `TP1_Colorimetrie_LAMARI_MAZID.m` |
| **TP 3** | Test de colorimétrie visuelle et cognitive | Lab (pas de code) | - |
| **TP 4** | Espace et manipulation des images couleur | Lab (pas de code) | - |
| **TP 5** | Mesure de brillance des objets | Lab (pas de code) | - |
| **TP 6** | Conception d'un capteur couleur par dématricage | MATLAB | dossier `TP6_demosaicing_Bayer/` |

> TP 2 (Métamérie) et TP 7 (Acquisition image couleur) non réalisés.

---

## Détail des TPs

### TP 1 - Mesure colorimétrique de surface par photométrie

**Matériel utilisé :**
- Spectrophotomètre sans contact **MINOLTA CS-1000**
- Source lumineuse **Gammin plafonnier D65** (lumière du jour)
- Lampe à incandescence (illuminant A)
- Mire **Macbeth ColorChecker**
- Blanc Lambertien (référence de calibration)

**Manipulations :**
- Calibration du spectrophotomètre sur le blanc Lambertien
- Mesure des coordonnées **XYZ** et **L\*a\*b\*** de plusieurs pastilles du ColorChecker sous D65 puis sous illuminant A
- Calcul des valeurs RGB avec correction gamma (gamma = 2.2)
- Évaluation des écarts de couleur entre les deux sources selon la norme **CIE 1994**

**Script MATLAB fourni (`TP1_Colorimetrie_LAMARI_MAZID.m`) :**
- Saisie des valeurs X, Y, Z par l'utilisateur
- Conversion XYZ vers RGB via la matrice de passage sRGB
- Application de la correction gamma (puissance 1/2.2)

```matlab
m = [0.488718 0.176204 0; 0.310680 0.812985 0.0102048; 0.200602 0.0108109 0.989795];
n = inv(m);
rgb = XYZ * n;
R = rgb(1)^(1/2.2);
G = rgb(2)^(1/2.2);
B = rgb(3)^(1/2.2);
```

---

### TP 3 - Test de colorimétrie visuelle et cognitive

Travaux pratiques en salle sans code informatique.

**Manipulations :**
- Classement visuel de couleurs sous différents éclairages (incandescence, blanc économique)
- Observation du métamérisme avec couleur rouge standard et grise standard
- Classement avec variation du contraste
- Analyse cognitive des perceptions colorées

---

### TP 4 - Espace et manipulation des images couleur

Travaux pratiques en salle (MATLAB utilisé en séance, code non fourni dans ce dépôt).

**Thèmes abordés :**
- Influence de la correction gamma sur les images numériques
- Conversion vers l'espace **CMY** (Cyan, Magenta, Yellow)
- Conversion vers l'espace **LHS** (Luminance, Hue, Saturation)
- Calcul et analyse de l'histogramme
- Fonctions de décorrélation
- Fonctions d'illuminants et couleurs primaires

---

### TP 5 - Mesure de brillance des objets

Travaux pratiques en salle sans code informatique.

**Manipulations :**
- Photo de nuit à Dijon - homogénéité de surface
- Échantillons bois - même matériau, couleurs différentes
- Échantillons du catalogue GrettaMacbeth
- Patchs gris (3C) - même matériau, brillance variable

---

### TP 6 - Conception d'un capteur couleur par dématricage (dossier Gouton)

Simulation du pipeline d'acquisition d'un capteur d'image avec filtre de Bayer sous MATLAB.

**Pipeline traité :**
```
Image RGB originale -> Application du filtre Bayer (CFA) -> Démosaicing -> Reconstruction RGB
```

**Algorithmes de démosaicing testés :**
- GBRG, GRBG, BGGR, RGGB via la fonction MATLAB `demosaic`
- Algorithme de Alleysson (`Random_demosai.m`)
- Démosaicing manuel par interpolation bilinéaire (`Dematricage.m`)

**Métriques de qualité :**
- Distance colorimétrique euclidienne (espace RGB)
- Delta E76 (espace CIE Lab) - meilleure corrélation perceptuelle

**Images de test utilisées :**
- `Ima_phare.tif` - Image phare (référence principale)
- `Maison.tif` - Image maison
- `peppers.png` - Image poivrons (image de référence standard)
- `TestImage.jpg` - Image de test pour l'algorithme Alleysson

**Interface graphique MATLAB :**
- `GUI_Dematricage.m` / `GUI_Dematricage.fig` - GUI MATLAB GUIDE permettant de comparer visuellement les différentes méthodes de démosaicing

---

## Structure du dépôt

```
Tps-Colorimetrie-M1-EEA-TSI/
|
|-- README.md
|-- .gitignore
|
|-- rapport/
|   |-- Rapport_TPs_Colorimetrie_LAMARI_MAZID.pdf   <- Rapport complet (34 pages)
|   |-- Enonce_Colorimetrie_2024.pdf                 <- Fascicule officiel
|
|-- TP1_mesure_colorimetrique/
|   |-- TP1_Colorimetrie_LAMARI_MAZID.m              <- Conversion XYZ vers RGB avec gamma
|
|-- TP6_demosaicing_Bayer/
|   |-- src/
|   |   |-- TP6_colorimetrie.m      <- Script principal TP6
|   |   |-- bayer.m                 <- Génération du filtre de Bayer
|   |   |-- Dematricage.m           <- Démosaicing par interpolation bilinéaire
|   |   |-- CFAphare.m              <- Analyse CFA sur image phare
|   |   |-- CFAphare_Modifier.m     <- Version modifiée de CFAphare
|   |   |-- Ima_originale.m         <- Affichage image originale
|   |   |-- Image_CFA.m             <- Fonction image CFA
|   |   |-- la_A.m                  <- Fonction utilitaire
|   |   |-- plot_vars.m             <- Interface de visualisation
|   |   |-- GUI_Dematricage.m       <- Code de l'interface graphique
|   |
|   |-- gui/
|   |   |-- GUI_Dematricage.fig     <- Fichier GUI MATLAB GUIDE
|   |
|   |-- alleysson/
|   |   |-- Random_demosai.m        <- Algorithme de démosaicing Alleysson
|   |
|   |-- images/
|       |-- Ima_phare.tif           <- Image phare (référence)
|       |-- Maison.tif              <- Image maison
|       |-- peppers.png             <- Image poivrons
|       |-- TestImage.jpg           <- Image test Alleysson
```

---

## Utilisation

**Toolboxes MATLAB requises :**
- Image Processing Toolbox (`imread`, `imshow`, `demosaic`, `rgb2lab`, `bwlabel`)

**Pour TP1 :**
```matlab
cd TP1_mesure_colorimetrique
run TP1_Colorimetrie_LAMARI_MAZID.m
% Le script demande les valeurs X, Y, Z et retourne R, G, B
```

**Pour TP6 :**
```matlab
cd TP6_demosaicing_Bayer/src
addpath('../images')
run TP6_colorimetrie.m
% Pour l'interface graphique :
GUI_Dematricage
```
