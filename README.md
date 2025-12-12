# Tic-Tac-Toe - Flutter Monorepo

Un projet Flutter monorepo structuré pour un jeu Tic-Tac-Toe (2 joueurs locaux)
utilisant Clean Architecture, Melos, et Riverpod V2.

## 🚀 Installation

### Prérequis

1. Installer Flutter (3.27.0 ou supérieur):
   - Suivre les instructions sur
     [flutter.dev](https://flutter.dev/docs/get-started/install)

2. Installer [Melos](https://melos.invertase.dev/):

```bash
dart pub global activate melos
```

### Setup du projet

1. Cloner le repository (si applicable)

2. Installer les dépendances avec Melos:

```bash
melos bootstrap
```

Cette commande va:

- Exécuter `flutter pub get` dans tous les packages et apps

## 🧪 Scripts Melos

```bash
# Bootstrap tous les packages
melos bootstrap

# Obtenir les dépendances
melos get

# Nettoyer tous les packages
melos clean

# Lancer les tests
melos test

# Analyser le code
melos analyze

# Formater le code
melos format

# Builder l'application
melos build
```

## 🧪 Tests

Les tests unitaires sont organisés dans chaque package:

```bash
# Tous les tests
melos test

# Tests d'un package spécifique
cd packages/game
flutter test
```
