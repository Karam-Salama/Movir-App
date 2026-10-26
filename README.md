<div align="center">

# 🎬 Movir

**Movie Tickets Booking Mobile App**

</div>

## 📖 Overview

**Movir** is a modern and lightweight movie ticket reservation mobile app built with Flutter, offering a clean architecture and a smooth user experience. It features real-time seat availability, secure payment integrations, and a robust feature set for a real-world booking workflow.

<br>


<img width="1376" height="768" alt="thump" src="https://github.com/user-attachments/assets/83309c92-d755-4f84-8c3a-ed714f91012d" />




</div>








## ✨ Core Features

| # | Screen / Feature | Description |
|---|------------------|-------------|
| 1 | Splash & Onboarding | Introduction screens introducing movie discovery and booking |
| 2 | Authentication | Secure sign-in and sign-up using Email/Password, Google, or Facebook |
| 3 | Home / Discover | Browse popular, top-rated, trending, and now-playing movies powered by TMDb API |
| 4 | Movie Details & Categories | View movie categories, search, comprehensive info, cast, and timings |
| 5 | Seat Selection | Interactive real-time seat availability and reservation system using Firebase |
| 6 | Checkout & Payment | Secure online payment integration supporting PayPal, Visa, and Wallets via Paymob |
| 7 | Booking History | View active bookings and reservation history |
| 8 | Favorites | Add and manage favorite movies using Firebase |

## 🧱 Tech Stack & Architecture

- **Framework:** Flutter & Dart[cite: 15]
- **Architecture:** Clean Architecture (Data → Domain → Presentation) following SOLID principles[cite: 15]
- **State Management:** BLoC / Cubit[cite: 15]
- **Networking:**
 Dio for REST API integration (TMDb API)[cite: 15]
- **Backend & Database:** Firebase Auth & Firestore for authentication, favorites, and real-time bookings[cite: 15]
- **Payment Gateways:** PayPal and Paymob integration[cite: 15]

## 📁 Project Structure

```
movir
├── assets/
│   ├── fonts/              # Custom font files
│   ├── images/             # Raster images (logos, illustrations, avatars)
│   └── svgs/               # Vector icons and illustrations
└── lib/
├── core/
│   ├── constants/      # App-wide constants (strings, durations, keys)
│   ├── theme/          # Colors, text styles, spacing — design tokens
│   ├── routing/        # App routes / navigation setup
│   ├── widgets/        # Shared reusable widgets (cards, buttons, inputs)
│   ├── utils/          # Helpers, extensions, formatters, validators
│   └── errors/         # Failure/exception classes, error handling
│
└── features/
├── splash_onboarding/
│   ├── data/
│   ├── domain/
│   └── presentation/
│       ├── screens/
│       └── widgets/
│
├── auth/
│   ├── data/           # Auth repository implementation, Firebase data sources
│   ├── domain/         # Entities, repository interface, login/signup use cases
│   └── presentation/   # Screens (Login, Register), widgets, and Cubit/Bloc
│
├── home/
│   ├── data/           # Movie models, TMDb remote data sources, local caching
│   ├── domain/         # Movie entities, repository interface, get movies use cases
│   └── presentation/   # Discover screen, category lists, search UI, and Bloc
│
├── movie_details/
│   ├── data/
│   ├── domain/
│   └── presentation/   # Movie details, cast view, timings selection
│
├── booking/
│   ├── data/           # Seat reservation and checkout/payment implementation
│   ├── domain/         # Booking entities, use cases for seat locking and payment
│   └── presentation/   # Seat selection layout, cinema lists, checkout & payment UI
│
├── favorites/
│   ├── data/           # Firebase sync for favorite movies
│   ├── domain/         # Manage favorites use cases
│   └── presentation/   # Favorite movies list screens and widgets
│
└── profile/
├── data/
├── domain/
└── presentation/   # User profile, booking history, and settings
```

Each feature follows the same three-layer split:

- **data/** — models, repository implementations, remote/local data sources
- **domain/** — entities, repository interfaces, use cases (pure business logic, no Flutter imports)
- **presentation/** — screens, widgets, state management (Bloc/Cubit/Provider) for that feature

`core/` holds everything shared across features — theme, routing, common widgets, and utilities — so no feature depends on another feature directly.
