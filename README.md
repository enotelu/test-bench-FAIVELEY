# test-bench-FAIVELEY


Programmes d'automatisation pour banc de test faiveley. (adressage IP et formatage disque)

Le but de ce projet est d'automatiser le banc de test Videoprotection FAIVELEY afin de gagner en productivité. Les modification hardware du banc effectué les programmes suivant permettent d'automatiser la partie software (réglage et visualisation des XEBRA et le formatage des disques HDD).


**Programme _Banc de test Videoprotection FAIVELEY.bat_ :**

Le fichier _Banc de test Videoprotection FAIVELEY.bat_ permet d'automatiser l'adressage IP selon le système ainsi que l'ouverture de la page de configuration.
Avant de lancer le programmes, vérifier les points suivants:
- l'enregistreur XEBRA est allumé
- l'enregistreur XEBRA est connecté par cable Ethernet à votre ordinateur
- votre ordinateur possède JAVA

Il suffit ensuite d'exécuter le fichier sur un ordinateur Windows et le programme fonctionnera (ne pas touché au clavier ou à la souris lors de l'exécution du programme).

***Programme tester sur :***
- Windows XP
- XEBRA1
- XEBRA3

***Attention prérequis :***
- logciel XTrack de Faiveley pour un contrôle complet des systèmes


**Programme _HDD TEST.bat_ :**

Le fichier _HDD TEST.bat_ permet d'automatiser le formatage des disques dur pour les enregistreurs XEBRA. Il vient formater les disques à l'aide du logiciel HDDLLF, attention ce logiciel permet de formater le disque principal du PC (faire ATTENTION). Le programme permet de vérifier le nombre de disque dur connecté et de stopper le processus avant le formatage si il n'y a que le disque principal de connecté.
Avant de lancer le programmes, vérifier les points suivants:
- ne pas lancer le programme si il n'y a pas de disque dur externe connecté (risque de formatage du disque principal du PC)
- les disques dur sont bien connecté et reconnu par l'ordinateur
- 

Il suffit ensuite d'exécuter le fichier sur un ordinateur Windows et le programme fonctionnera (ne pas touché au clavier ou à la souris lors de l'exécution du programme).

***Programme tester sur :***
- Windows XP
- version de HDDLLF : 4.25

***Attention prérequis :***
- logiciel HDDLLF.4.25 pour le formatage
