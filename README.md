# Travaux Pratiques Colorimetrie - M1 EEA/TSI

**Auteurs :** Omar Lamari & MAZID
**Etablissement :** Universite de Bourgogne Europe
**Filiere :** M1 EEA/TSI - 2025/2026
**Logiciel :** MATLAB / Simulink (R2023a)

---

## Rapport et enonce

- [Telecharger le rapport complet (PDF)](rapport/Rapport_TPs_Colorimetrie_LAMARI_MAZID.pdf)
- [Telecharger le fascicule officiel (PDF)](rapport/Enonce_Colorimetrie_2024.pdf)

---

## Contenu du projet

| Seance | Theme | Fichier principal |
|--------|-------|------------------|
| TP1 / TP2 | Fonctions colorimetriques CIE, tristimulus XYZ | `TP1_Colorimetrie_LAMARI_MAZID.m` |
| TP3 | Conversion XYZ vers sRGB et Adobe RGB | `TP1_Colorimetrie_LAMARI_MAZID.m` |
| TP5 | Mesure de brillance, coordonnees chromatiques | `TP1_Colorimetrie_LAMARI_MAZID.m` |
| TP6 | Demosaicing Bayer CFA, distance colorimetrique, Delta E | `TP6_colorimetrie.m` |

---

## Detail des TPs

### TP1 / TP2 - Fonctions colorimetriques CIE et tristimulus XYZ

Introduction aux bases de la colorimetrie :
- Calcul des valeurs tristimulus X, Y, Z a partir des fonctions colorimetriques CIE
- Coordonnees chromatiques x, y dans le diagramme CIE 1931
- Representation des couleurs spectrales

### TP3 - Conversion XYZ vers RGB

Conversion des valeurs tristimulus en espaces coloriels RGB :
- Matrice de passage XYZ vers **sRGB** (standard IEC 61966-2-1)
- Matrice de passage XYZ vers **Adobe RGB (1998)**
- Application de la correction gamma (gamma = 2.2)
- Saisie utilisateur des valeurs X, Y, Z et calcul des composantes R, G, B

Extrait du code :
```matlab
m = [0.488718 0.176204 0; 0.310680 0.812985 0.0102048; 0.200602 0.0108109 0.989795];
n = inv(m);
rgb = XYZ * n;
R = rgb(1)^(1/2.2);
G = rgb(2)^(1/2.2);
B = rgb(3)^(1/2.2);
```

### TP5 - Mesure de brillance et chromaticite

- Calcul de la brillance relative Y
- Coordonnees chromatiques dans le plan CIE xy
- Comparaison des gamuts sRGB et Adobe RGB

### TP6 - Demosaicing Bayer CFA (dossier Gouton)

Simulation du pipeline d'acquisition d'un capteur d'image avec filtre de Bayer.

**Pipeline traite :**
```
Image RGB originale -> Application du filtre Bayer (CFA) -> Demosaicing -> Reconstruction RGB
```

**Algorithmes de demosaicing testes :**
- GBRG, GRBG, BGGR, RGGB (fonction MATLAB `demosaic`)
- Algorithme de Alleysson (`Random_demosai.m`)
- Demosaicing manuel implementation (`Dematricage.m`)

**Metriques de qualite :**
- Distance colorimetrique euclidienne (espace RGB)
- Delta E76 (espace CIE Lab) - meilleure correlation perceptuelle

**Images de test :**
- `Ima_phare.tif` - Image phare (reference principale)
- `Maison.tif` - Image maison
- `peppers.png` - Image poivrons (reference standard)
- `TestImage.jpg` - Image de test Alleysson

**Interface graphique :**
- `GUI_Dematricage.m` / `GUI_Dematricage.fig` - GUI MATLAB GUIDE pour comparer les methodes de demosaicing

---

## Structure du depot

```
Tps-Colorimetrie-M1-EEA-TSI/
|
|-- README.md
|-- .gitignore
|
|-- rapport/
|   |-- Rapport_TPs_Colorimetrie_LAMARI_MAZID.pdf   <- Rapport complet
|   |-- Enonce_Colorimetrie_2024.pdf                 <- Fascicule officiel
|
|-- TP1_TP2_TP3_TP5_conversions_couleur/
|   |-- TP1_Colorimetrie_LAMARI_MAZID.m              <- Script principal (TP1, TP2, TP3, TP5)
|
|-- TP6_demosaicing_Bayer/
|   |-- src/
|   |   |-- TP6_colorimetrie.m      <- Script principal TP6
|   |   |-- bayer.m                 <- Generation du filtre de Bayer
|   |   |-- Dematricage.m           <- Fonction de demosaicing manuel
|   |   |-- CFAphare.m              <- Analyse CFA image phare
|   |   |-- CFAphare_Modifier.m     <- Version modifiee
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
|   |   |-- Random_demosai.m        <- Algorithme de demosaicing Alleysson
|   |
|   |-- images/
|       |-- Ima_phare.tif           <- Image phare (reference)
|       |-- Maison.tif              <- Image maison
|       |-- peppers.png             <- Image poivrons
|       |-- TestImage.jpg           <- Image test Alleysson
```

---

## Utilisation

1. Ouvrir **MATLAB R2023a** (ou version compatible)
2. Ajouter le dossier du TP au path MATLAB : `addpath(genpath('chemin/vers/dossier'))`

**Pour TP1/TP2/TP3/TP5 :**
```matlab
cd TP1_TP2_TP3_TP5_conversions_couleur
run TP1_Colorimetrie_LAMARI_MAZID.m
```

**Pour TP6 :**
```matlab
cd TP6_demosaicing_Bayer/src
run TP6_colorimetrie.m
% Pour l'interface graphique :
GUI_Dematricage
```

**Toolboxes MATLAB requises :**
- Image Processing Toolbox (`imread`, `imshow`, `demosaic`, `rgb2lab`)
- Statistics and Machine Learning Toolbox (optionnel)
