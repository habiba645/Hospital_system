# MediDesk – Hospital Reception System

Flutter web application for hospital front-desk management.

## Architecture

**Feature-based + Clean Architecture layers**

```
lib/
├── core/                     # Shared infrastructure
│   ├── constants/            # API endpoints, app constants
│   ├── network/              # Dio client + interceptors
│   ├── routes/               # go_router configuration
│   ├── theme/                # Colors + ThemeData
│   ├── utils/
│   └── widgets/              # AppShell, Sidebar, TopBar
├── features/
│   ├── auth/                 # Full clean-arch (data/domain/presentation)
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── dashboard/
│   ├── doctors/
│   ├── departments/
│   ├── receptionists/
│   ├── patients/
│   ├── appointments/
│   └── schedule/
└── main.dart
```

### State management
- **Cubit** (flutter_bloc) for all feature state
- AuthCubit is provided at the root and drives navigation after login

### Networking
- **Dio** with `AuthInterceptor` that injects Bearer token from secure storage
- Ready to point `ApiConstants.baseUrl` at your backend

### Navigation
- **go_router** with two `ShellRoute`s (Admin / Reception)
- Shared `AppShell` + `AppSidebar` + `AppTopBar`
- Role-based menu items already wired

## Getting started

```bash
flutter pub get
flutter run -d chrome
```

## Adding a new screen / feature

1. Create folder under `lib/features/<feature>/presentation/{cubit,screens,widgets}`
2. Add a route inside the appropriate `ShellRoute` in `app_router.dart`
3. Add a nav item in `AppSidebar`
4. Implement Cubit + repository when you connect the API

## Theming

All colors live in `core/theme/app_colors.dart` and match the provided design system (teal primary, soft mint background, status chips, etc.).

## Auth flow (ready for API)

1. LoginScreen → AuthCubit.login()
2. AuthRepositoryImpl → Remote + Local datasources
3. On success → navigate to `/admin` or `/reception` based on role
4. Token stored via flutter_secure_storage and attached by AuthInterceptor

Point `ApiConstants` and expand the login response model to include the real token.
