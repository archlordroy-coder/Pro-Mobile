# Pro Informatique - Application Mobile

## Description

Application mobile Flutter pour Pro Informatique, permettant aux utilisateurs de découvrir les services, produits et promotions de l'entreprise.

## Technologies

- **Flutter** - Framework cross-platform
- **Dart** - Langage de programmation
- **Provider** - Gestion d'état
- **HTTP** - Requêtes API

## Fonctionnalités

### Mode Invité
- Accès complet à l'application sans création de compte
- Navigation entre les différentes sections
- Visualisation des services, produits et promotions

### Authentification
- Inscription utilisateur avec email et mot de passe
- Connexion sécurisée
- Option "Continuer sans compte" pour accès invité
- Déconnexion

### Navigation

#### Écran d'accueil (Splash Screen)
- Animation de chargement
- Redirection vers l'écran d'authentification

#### Écran d'authentification
- Formulaire de connexion (email, mot de passe)
- Formulaire d'inscription (nom, email, mot de passe, confirmation)
- Toggle entre connexion et inscription
- Bouton "Continuer sans compte"

#### Écran principal (Main Screen)
- Navigation par onglets :
  - **Accueil** : Vue d'ensemble avec promotions
  - **Services** : Liste des services disponibles
  - **Produits** : Catalogue de produits
  - **Panier** : Gestion du panier d'achat
  - **Profil** : Informations utilisateur et paramètres

#### Services
- Liste des services avec icônes et descriptions
- Détails des services avec fonctionnalités
- Catégorisation des services
- Prix affichés

#### Produits
- Grille de produits avec images
- Filtrage par catégorie
- Détails des produits
- Ajout au panier
- Prix affichés

#### Panier
- Liste des produits ajoutés
- Modification des quantités
- Suppression d'articles
- Calcul du total

#### Profil
- Informations utilisateur (si connecté)
- Paramètres de l'application
- Déconnexion

#### Cyber Café
- Interface pour la gestion des tickets cyber café
- Réservation de postes

#### Recherche
- Recherche de produits et services
- Filtres de recherche

## Structure du Projet

```
lib/
├── main.dart                 # Point d'entrée
├── constants.dart            # Constantes de l'application
├── models/
│   ├── product.dart         # Modèle Produit
│   └── service.dart         # Modèle Service
├── providers/
│   └── app_provider.dart    # Gestion d'état global
├── services/
│   ├── api_service.dart     # Appels API
│   ├── data_repository.dart # Repository de données
│   └── local_cache_service.dart # Cache local
├── screens/
│   ├── splash_screen.dart   # Écran de chargement
│   ├── auth_screen.dart     # Écran d'authentification
│   ├── main_screen.dart     # Écran principal
│   ├── home_screen.dart     # Accueil
│   ├── services_screen.dart # Services
│   ├── products_screen.dart # Produits
│   ├── cart_screen.dart     # Panier
│   ├── profile_screen.dart  # Profil
│   ├── search_screen.dart   # Recherche
│   └── cyber_cafe_screen.dart # Cyber Café
```

## Configuration

### API URL

L'URL de l'API est configurée dans `lib/services/api_service.dart` :

```dart
const String baseUrl = 'https://api.proinformatique.dev';
```

### Couleurs

Les couleurs de l'application sont définies dans `lib/constants.dart` :

```dart
class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF2A2D3E);
  static const Color background = Color(0xFFF5F7FA);
  // ...
}
```

## Installation

```bash
flutter pub get
```

## Exécution

### Sur un device physique
```bash
flutter devices
flutter run -d <device-id>
```

### Sur un émulateur
```bash
flutter emulators
flutter emulator launch <emulator-id>
flutter run
```

### Sur le web
```bash
flutter run -d chrome
```

## Build

### APK Android
```bash
flutter build apk
```

### iOS
```bash
flutter build ios
```

### Web
```bash
flutter build web
```

## Développement

### Ajouter un nouvel écran

1. Créer le fichier dans `lib/screens/`
2. Ajouter la route dans `lib/main.dart`
3. Naviguer vers l'écran :
```dart
Navigator.pushNamed(context, '/screen_name');
```

### Ajouter un nouvel appel API

1. Ajouter la méthode dans `lib/services/api_service.dart`
2. Ajouter la méthode dans `lib/services/data_repository.dart`
3. Appeler depuis le provider ou l'écran

### Gestion d'état

L'application utilise Provider pour la gestion d'état :

```dart
final appProvider = Provider.of<AppProvider>(context);
await appProvider.fetchData();
```

## Sécurité

- Les mots de passe sont envoyés en clair (à améliorer avec HTTPS et hashage)
- Pas de stockage sécurisé des tokens (à améliorer avec secure storage)
- Validation basique des entrées

## Améliorations Futures

- [ ] Hashage des mots de passe
- [ ] Stockage sécurisé des tokens
- [ ] Notifications push
- [ ] Mode hors ligne
- [ ] Paiements intégrés
- [ ] Localisation multi-langue
- [ ] Tests unitaires
- [ ] Intégration CI/CD

## Déploiement

### Android

1. Configurer `android/app/build.gradle`
2. Générer la clé de signature
3. Builder l'APK ou AAB

### iOS

1. Configurer `ios/Runner.xcodeproj`
2. Configurer les certificats et profils
3. Builder l'IPA

## Support

Pour toute question ou problème, contactez l'équipe de développement.
