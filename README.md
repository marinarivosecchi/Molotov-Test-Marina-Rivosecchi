# Test Molotov - Marina Rivosecchi

## Introduction
Ce README décrit les documents relatifs au test technique réalisé pour Molotov pour le poste de Senior Analytics Engineer.
* Document Google Slides pour afficher les résultats: [Lien 🔗](https://docs.google.com/presentation/d/139Hr6Of78znmkjz6vTSzOfMOfIuzLdnqI37BCE_Zlag/edit?usp=sharing)
* Lien Google Colab pour exécuter le code Python: [Lien 🔗](https://colab.research.google.com/drive/1i22166VXYfs53aE4oJJ2xYmPbWFvc3UE?usp=sharing)

## Objectifs du test

* Effectuer une analyse exploratoire en Python.
* Rédiger une requête SQL.
* Faire des suggestions de KPI pour l'équipe marketing.

## Structure du repository

* Data : Contient les données nécessaires pour le test - [Lien 🔗](https://github.com/marinarivosecchi/Molotov-Test-Marina-Rivosecchi/tree/main/Data)
* Resolution pour le Question 1 - Analyse exploratoire avec Python - [Lien 🔗](https://github.com/marinarivosecchi/Molotov-Test-Marina-Rivosecchi/blob/main/Question%201%20-%20Analyse%20exploratoire%20avec%20Python.ipynb)
* Resolution pour le Question 2 - Requête SQL - [Lien 🔗](https://github.com/marinarivosecchi/Molotov-Test-Marina-Rivosecchi/blob/main/Question%202%20-%20Reque%CC%82te%20SQL.sql)

## Données

- User: Cette table recense l’ensemble des utilisateurs ayant créé un compte Molotov. 
- Subscription: Cette table recense les souscriptions (=options payantes) détenues pour chaque utilisateur, ainsi que les dates de début et de fin de l’abonnement.
Ainsi, si un user a plusieurs options, il apparaîtra plusieurs fois dans la table avec des id de souscription différentes. 
- Watch: L’event de ‘watch_stopped’ est envoyé lors de l'arrêt du visionnage d’un programme et recense les différentes dimensions associées au watch (device, type de contenu visionné...).
- Channel: Cette table regroupe l’ensemble des chaînes sur Molotov.
