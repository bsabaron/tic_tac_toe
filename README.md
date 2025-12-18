# Tic-Tac-Toe - Flutter Monorepo

Un projet Flutter monorepo structuré pour un jeu Tic-Tac-Toe (2 joueurs locaux)
utilisant Clean Architecture, Melos, et Riverpod V2.

## 🚀 Installation

### Prérequis

- Flutter 3.27.0 ou supérieur
  ([flutter.dev](https://flutter.dev/docs/get-started/install))
- [Melos](https://melos.invertase.dev/) : `dart pub global activate melos`

### Setup

```bash
# 1. Installer les dépendances
melos bootstrap

# 2. Générer les classes avec build_runner
melos generate
```

## 📦 Structure

```
tic_tac_toe/
├── packages/
│   ├── core/      # Utilitaires partagés
│   └── game/      # Logique métier et UI du jeu
└── lib/           # Application principale
```

## 🛠️ Commandes Melos

```bash
# Dépendances
melos get          # Récupérer les dépendances

# Génération
melos generate     # Générer le code avec build_runner

# Qualité de code
melos format       # Formater le code
melos analyze      # Analyser le code

# Tests
melos test         # Lancer tous les tests
melos coverage     # Générer le rapport de couverture

# Nettoyage
melos clean        # Nettoyer les builds
```

## 🧪 Tests

```bash
# Tous les tests
melos test

# Tests d'un package spécifique
cd packages/game
flutter test
```
