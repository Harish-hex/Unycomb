# Unycomb (Nexus) — Implementation Plan

> **College-only collaboration platform** — Flutter/Dart, Bumblebee design system, clean architecture.

## Architecture Summary

From `arch` (SVG diagram):

```
┌──────────────────────────────────────────┐
│  Platform:  Android  ·  iOS              │  ← one codebase
├──────────────────────────────────────────┤
│  UI:  Widgets · Bloc/Cubit · Nav · DI    │  ← Flutter + get_it
├──────────────────────────────────────────┤
│  Domain:  Models · Use cases · Repos     │  ← pure Dart
├──────────────────────────────────────────┤
│  Data:  Dio · WebSocket · Drift · Secure │  ← persistence + network
├──────────────────────────────────────────┤
│  Backend:  REST API · Firebase Auth      │
│            FCM push  · Scraper           │
├──────────────────────────────────────────┤
│  Infra:  PostgreSQL · Redis · Obj Store  │
└──────────────────────────────────────────┘
```

---

## User Review Required

> [!IMPORTANT]
> **Backend scope**: This plan covers the Flutter mobile app in full. The backend (REST API, scraper, PostgreSQL, Redis, Object storage) is outlined but assumed to be developed in parallel by a backend team or in a later phase. Confirm if backend implementation should be included in detail.

> [!IMPORTANT]
> **State management**: The architecture diagram specifies **Bloc/Cubit**. The plan follows this. Confirm if you want to use `flutter_bloc` or a different state management approach.

> [!WARNING]
> **Firebase dependency**: Auth uses Firebase Auth with university email OTP. FCM is used for push notifications. This requires a Firebase project, Google Services config files (google-services.json / GoogleService-Info.plist), and Apple/Google developer accounts.

> [!IMPORTANT]
> **Chat feature**: The bottom nav includes a Chat tab, but no Chat screen is detailed in PLAN.md. This plan includes a basic real-time chat scaffold. Confirm if chat is in scope for MVP.

---

## Proposed Changes

### Sprint 1 — Foundation (Weeks 1–2)

Everything below is under `lib/`. This sprint produces a runnable app with the design system, core components, onboarding flow, and the home grid screen — all with static/mock data.

---

#### 1.1 Project Scaffolding & Configuration

##### [NEW] Flutter project initialization
- `flutter create --org com.unycomb --project-name nexus .`
- Set minimum SDK: Android 24 / iOS 15
- Configure `analysis_options.yaml` with strict linting (`flutter_lints`)

##### [NEW] [pubspec.yaml](file:///Users/harishharish/Unycomb/pubspec.yaml)
Dependencies to declare upfront:

| Category | Packages |
|---|---|
| State management | `flutter_bloc`, `bloc` |
| DI | `get_it`, `injectable`, `injectable_generator` |
| Navigation | `go_router` |
| Networking | `dio`, `retrofit`, `retrofit_generator` |
| Local DB | `drift`, `drift_dev`, `sqlite3_flutter_libs` |
| Secure storage | `flutter_secure_storage` |
| Firebase | `firebase_core`, `firebase_auth`, `firebase_messaging` |
| WebSocket | `web_socket_channel` |
| Fonts | `google_fonts` (Syne, DM Sans, JetBrains Mono) |
| Utils | `equatable`, `json_annotation`, `json_serializable`, `freezed`, `freezed_annotation`, `build_runner` |
| UI | `flutter_svg`, `cached_network_image`, `shimmer` |
| Testing | `bloc_test`, `mocktail`, `golden_toolkit` |

---

#### 1.2 Theme & Design Tokens

##### [NEW] [lib/core/theme/colors.dart](file:///Users/harishharish/Unycomb/lib/core/theme/colors.dart)
- `NexusColors` class with all 11 color constants from PLAN.md palette
- Bumblebee Yellow `#F5C518`, Amber Gold `#E6A800`, Pitch Black `#0D0D0D`, Carbon `#1A1A1A`, Graphite `#252525`, Ash `#2E2E2E`, Off White `#F0F0F0`, Warm Grey `#9A9A9A`, Dim `#555555`, Lime `#84CC16`, Vermillion `#EF4444`

##### [NEW] [lib/core/theme/typography.dart](file:///Users/harishharish/Unycomb/lib/core/theme/typography.dart)
- `NexusTextStyles` class with named styles:
  - `display` — Syne 800, 28–36px
  - `heading` — Syne 700, 20–24px
  - `subheading` — Syne 600, 16–18px
  - `body` — DM Sans 400, 14–15px
  - `caption` — DM Sans 500, 11–12px
  - `code` — JetBrains Mono 400, 13px

##### [NEW] [lib/core/theme/theme.dart](file:///Users/harishharish/Unycomb/lib/core/theme/theme.dart)
- `NexusTheme.dark` — ThemeData with `scaffoldBackgroundColor: #0D0D0D`, custom `colorScheme`, `textTheme`, `appBarTheme`, `bottomNavigationBarTheme`, `cardTheme`, `inputDecorationTheme`
- No light theme (bumblebee is dark-only as per design direction)

---

#### 1.3 Core Component Library

##### [NEW] [lib/core/components/nexus_button.dart](file:///Users/harishharish/Unycomb/lib/core/components/nexus_button.dart)
Three factory constructors:
- `NexusButton.primary()` — yellow bg `#F5C518`, black text, Syne 600, 15px, 48px h, 12px radius
- `NexusButton.outlined()` — yellow border, yellow text, transparent bg
- `NexusButton.ghost()` — warm grey text only
- All include `onTap` callback, loading state, disabled state
- Press animation: scale 0.96, 120ms ease-out

##### [NEW] [lib/core/components/nexus_card.dart](file:///Users/harishharish/Unycomb/lib/core/components/nexus_card.dart)
- Carbon background `#1A1A1A`, 16px radius, 1px Ash border `#2E2E2E`, 16px padding
- Accepts `child` widget, optional `onTap`, `elevation` variant
- Card entrance animation: translate y+16→0, 60ms stagger delay

##### [NEW] [lib/core/components/nexus_tag.dart](file:///Users/harishharish/Unycomb/lib/core/components/nexus_tag.dart)
Two styles:
- `TagStyle.accent` — yellow bg at 15% opacity, yellow text, yellow border at 30%
- `TagStyle.neutral` — graphite bg `#252525`, warm grey text
- Tap-to-select animation: scale 1.05 briefly, border animates yellow

##### [NEW] [lib/core/components/nexus_bottom_nav.dart](file:///Users/harishharish/Unycomb/lib/core/components/nexus_bottom_nav.dart)
- 5 items: Home, Match, Feed, Chat, Profile
- Active: yellow icon fill + yellow dot indicator + label visible
- Inactive: warm grey icon, no label
- Carbon background `#1A1A1A`
- Tab transition: fade + 8px upward translate, 200ms

##### [NEW] [lib/core/components/nexus_avatar.dart](file:///Users/harishharish/Unycomb/lib/core/components/nexus_avatar.dart)
- Circular avatar with configurable size (default 52px)
- Fallback initials on empty image
- Stacked variant for project member groups

##### [NEW] [lib/core/components/nexus_filter_chip.dart](file:///Users/harishharish/Unycomb/lib/core/components/nexus_filter_chip.dart)
- Active: yellow fill + black text
- Inactive: graphite fill + warm grey text
- Horizontally scrollable chip row container

##### [NEW] [lib/core/components/nexus_badge.dart](file:///Users/harishharish/Unycomb/lib/core/components/nexus_badge.dart)
- Yellow pill badge for counts
- Red pill for urgent deadlines
- Positioned top-right of parent

---

#### 1.4 Navigation

##### [NEW] [lib/core/navigation/app_router.dart](file:///Users/harishharish/Unycomb/lib/core/navigation/app_router.dart)
Using `go_router`:
- `/onboarding` → OnboardingFlow (welcome → verify → profile-setup)
- `/home` → HomeScreen (grid launchpad)
- `/shell` → ShellRoute with NexusBottomNav wrapping:
  - `/shell/home` → HomeScreen (compact, within nav)
  - `/shell/matching` → MatchingScreen
  - `/shell/feed` → FeedScreen
  - `/shell/chat` → ChatScreen
  - `/shell/profile` → ProfileScreen
- `/projects` → ProjectsScreen
- `/projects/:id` → ProjectDetailScreen (Kanban)
- `/mentorship` → MentorshipScreen
- Redirect logic: if not authenticated → `/onboarding`

---

#### 1.5 Dependency Injection

##### [NEW] [lib/core/di/injection.dart](file:///Users/harishharish/Unycomb/lib/core/di/injection.dart)
- `get_it` + `injectable` setup
- Register singletons: `Dio` instance, `AppRouter`, `AuthRepository`, `SecureStorage`
- Register factories: all Cubits/Blocs

---

#### 1.6 App Entry Points

##### [NEW] [lib/main.dart](file:///Users/harishharish/Unycomb/lib/main.dart)
- `WidgetsFlutterBinding.ensureInitialized()`
- `Firebase.initializeApp()`
- `configureDependencies()` (get_it)
- `runApp(const NexusApp())`

##### [NEW] [lib/app.dart](file:///Users/harishharish/Unycomb/lib/app.dart)
- `MaterialApp.router` with `NexusTheme.dark`, `GoRouter` instance
- No debug banner

---

#### 1.7 Onboarding Flow

##### [NEW] [lib/features/onboarding/presentation/screens/welcome_screen.dart](file:///Users/harishharish/Unycomb/lib/features/onboarding/presentation/screens/welcome_screen.dart)
- Full black screen
- Nexus wordmark: stagger-in animation (letters 40ms delay each, opacity 0→1, 600ms)
- Tagline: "Build with the best minds on campus"
- Continue button (NexusButton.primary)

##### [NEW] [lib/features/onboarding/presentation/screens/verify_screen.dart](file:///Users/harishharish/Unycomb/lib/features/onboarding/presentation/screens/verify_screen.dart)
- University email input field
- OTP entry (6-digit pin input)
- Verified checkmark animation (yellow tick, scale-in)

##### [NEW] [lib/features/onboarding/presentation/screens/profile_setup_screen.dart](file:///Users/harishharish/Unycomb/lib/features/onboarding/presentation/screens/profile_setup_screen.dart)
- Name text field
- Year selector (dropdown or segmented control)
- Skills tag grid (tap to select, selected = yellow accent style)
- Profile photo upload (camera/gallery picker)

##### [NEW] [lib/features/onboarding/presentation/cubit/onboarding_cubit.dart](file:///Users/harishharish/Unycomb/lib/features/onboarding/presentation/cubit/onboarding_cubit.dart)
- States: `OnboardingInitial`, `OtpSending`, `OtpSent`, `OtpVerifying`, `OtpVerified`, `ProfileSaving`, `OnboardingComplete`, `OnboardingError`
- Methods: `sendOtp(email)`, `verifyOtp(code)`, `saveProfile(data)`

---

#### 1.8 Home Screen

##### [NEW] [lib/features/home/presentation/screens/home_screen.dart](file:///Users/harishharish/Unycomb/lib/features/home/presentation/screens/home_screen.dart)
- **Hero zone** (top 1/3):
  - Top-left: Nexus wordmark (Syne 800, yellow)
  - Top-right: notification bell + avatar
  - Centre: greeting "Good morning, [name]" (Syne 600)
  - Stat pill strip: horizontal scroll — `3 active projects · 2 new matches · 5 hackathons`
  - Background: carbon with hexagonal dot pattern (4% opacity yellow)
- **Navigation grid** (bottom 2/3):
  - 2×3 grid, 12px gap, 16px edge padding
  - Each tile: graphite bg `#252525`, 12px radius, 1px ash border
  - Tile layout: icon (24px, yellow) top-left, label (Syne 600, 15px) bottom-left, badge top-right
  - Featured tile: yellow left border (3px), lighter bg
  - Press: scale 0.96, 120ms ease-out spring

##### [NEW] [lib/features/home/presentation/cubit/home_cubit.dart](file:///Users/harishharish/Unycomb/lib/features/home/presentation/cubit/home_cubit.dart)
- Loads: user greeting, stat counts (active projects, matches, hackathons)
- States: `HomeLoading`, `HomeLoaded(stats, userName)`, `HomeError`

##### [NEW] [lib/features/home/presentation/widgets/hero_zone.dart](file:///Users/harishharish/Unycomb/lib/features/home/presentation/widgets/hero_zone.dart)
##### [NEW] [lib/features/home/presentation/widgets/nav_grid.dart](file:///Users/harishharish/Unycomb/lib/features/home/presentation/widgets/nav_grid.dart)
##### [NEW] [lib/features/home/presentation/widgets/grid_tile.dart](file:///Users/harishharish/Unycomb/lib/features/home/presentation/widgets/grid_tile.dart)

---

### Sprint 2 — Core Features (Weeks 3–4)

Profile, Matching, Feed screens and the bottom nav wired across all inner screens.

---

#### 2.1 Domain Layer — Models & Repo Interfaces

##### [NEW] [lib/shared/models/user_model.dart](file:///Users/harishharish/Unycomb/lib/shared/models/user_model.dart)
```dart
// Fields: id, name, email, university, year, avatarUrl, 
//         skills: List<String>, reputationScore: double,
//         reviewCount: int, profileCompletionPercent: int
```

##### [NEW] [lib/shared/models/match_model.dart](file:///Users/harishharish/Unycomb/lib/shared/models/match_model.dart)
```dart
// Fields: id, user: UserModel, bio: String, matchStatus: MatchStatus
```

##### [NEW] [lib/shared/models/opportunity_model.dart](file:///Users/harishharish/Unycomb/lib/shared/models/opportunity_model.dart)
```dart
// Fields: id, title, source, sourceLogoUrl, deadline: DateTime,
//         tags: List<String>, description, type: OpportunityType
```

##### [NEW] [lib/shared/models/project_model.dart](file:///Users/harishharish/Unycomb/lib/shared/models/project_model.dart)
```dart
// Fields: id, name, members: List<UserModel>, progress: double,
//         openTaskCount: int, status: ProjectStatus, tasks: List<TaskModel>
```

##### [NEW] [lib/shared/models/task_model.dart](file:///Users/harishharish/Unycomb/lib/shared/models/task_model.dart)
```dart
// Fields: id, title, assignee: UserModel, dueDate: DateTime,
//         status: TaskStatus (todo/inProgress/done)
```

##### [NEW] [lib/shared/models/review_model.dart](file:///Users/harishharish/Unycomb/lib/shared/models/review_model.dart)
```dart
// Fields: id, fromUser: UserModel, rating: double, text: String, createdAt
```

All models use `freezed` + `json_serializable` for immutability and serialization.

##### [NEW] [lib/domain/repositories/auth_repository.dart](file:///Users/harishharish/Unycomb/lib/domain/repositories/auth_repository.dart)
##### [NEW] [lib/domain/repositories/user_repository.dart](file:///Users/harishharish/Unycomb/lib/domain/repositories/user_repository.dart)
##### [NEW] [lib/domain/repositories/matching_repository.dart](file:///Users/harishharish/Unycomb/lib/domain/repositories/matching_repository.dart)
##### [NEW] [lib/domain/repositories/feed_repository.dart](file:///Users/harishharish/Unycomb/lib/domain/repositories/feed_repository.dart)
##### [NEW] [lib/domain/repositories/project_repository.dart](file:///Users/harishharish/Unycomb/lib/domain/repositories/project_repository.dart)

All are **abstract** interfaces (pure Dart). Implementations live in the data layer.

---

#### 2.2 Profile Screen

##### [NEW] [lib/features/profile/presentation/screens/profile_screen.dart](file:///Users/harishharish/Unycomb/lib/features/profile/presentation/screens/profile_screen.dart)
- Large avatar (80px), name (Syne 700, 22px), university + year, verified badge (yellow ✓)
- Reputation score: large yellow number + star row + review count
- Skills: wrapping row of `NexusTag.accent`
- Portfolio: 2-column grid of project cards (name, role, tech stack chips)
- Reviews: scrollable list of feedback cards

##### [NEW] [lib/features/profile/presentation/cubit/profile_cubit.dart](file:///Users/harishharish/Unycomb/lib/features/profile/presentation/cubit/profile_cubit.dart)
- States: `ProfileLoading`, `ProfileLoaded(user, portfolio, reviews)`, `ProfileError`

##### [NEW] [lib/features/profile/presentation/widgets/reputation_badge.dart](file:///Users/harishharish/Unycomb/lib/features/profile/presentation/widgets/reputation_badge.dart)
##### [NEW] [lib/features/profile/presentation/widgets/portfolio_grid.dart](file:///Users/harishharish/Unycomb/lib/features/profile/presentation/widgets/portfolio_grid.dart)
##### [NEW] [lib/features/profile/presentation/widgets/review_card.dart](file:///Users/harishharish/Unycomb/lib/features/profile/presentation/widgets/review_card.dart)

---

#### 2.3 Matching Screen

##### [NEW] [lib/features/matching/presentation/screens/matching_screen.dart](file:///Users/harishharish/Unycomb/lib/features/matching/presentation/screens/matching_screen.dart)
- Header: "Find partners" (Syne 700) + back arrow + filter icon
- Filter chips row: All · Design · Backend · ML · Mobile (using `NexusFilterChip`)
- Partner cards: full-width `NexusCard` with avatar (52px), name + university, skill tags, 2-line bio, "Request collab" CTA (NexusButton.primary)
- Yellow ripple on "Request collab" tap
- Empty state: bumblebee illustration + improvement prompt
- Cards stagger in: 60ms delay per card, y+16→0

##### [NEW] [lib/features/matching/presentation/cubit/matching_cubit.dart](file:///Users/harishharish/Unycomb/lib/features/matching/presentation/cubit/matching_cubit.dart)
- States: `MatchingLoading`, `MatchingLoaded(matches, activeFilter)`, `MatchRequestSent`, `MatchingError`
- Methods: `loadMatches()`, `filterBySkill(skill)`, `requestCollab(userId)`

##### [NEW] [lib/features/matching/presentation/widgets/partner_card.dart](file:///Users/harishharish/Unycomb/lib/features/matching/presentation/widgets/partner_card.dart)

---

#### 2.4 Feed Screen

##### [NEW] [lib/features/feed/presentation/screens/feed_screen.dart](file:///Users/harishharish/Unycomb/lib/features/feed/presentation/screens/feed_screen.dart)
- Header: "Opportunities" (Syne 700)
- Toggle pills: Hackathons · Collabs · Competitions
- Pinned strip: "Closing soon" — 2–3 cards horizontal scroll, yellow left border
- Feed cards: source logo, title (Syne 600), deadline badge (red if <7d, yellow otherwise), tag chips, one-line description, "View" (NexusButton.outlined)

##### [NEW] [lib/features/feed/presentation/cubit/feed_cubit.dart](file:///Users/harishharish/Unycomb/lib/features/feed/presentation/cubit/feed_cubit.dart)
- States: `FeedLoading`, `FeedLoaded(opportunities, closingSoon, activeCategory)`, `FeedError`
- Methods: `loadFeed()`, `filterByCategory(category)`

##### [NEW] [lib/features/feed/presentation/widgets/opportunity_card.dart](file:///Users/harishharish/Unycomb/lib/features/feed/presentation/widgets/opportunity_card.dart)
##### [NEW] [lib/features/feed/presentation/widgets/closing_soon_strip.dart](file:///Users/harishharish/Unycomb/lib/features/feed/presentation/widgets/closing_soon_strip.dart)

---

#### 2.5 Chat Screen (Scaffold)

##### [NEW] [lib/features/chat/presentation/screens/chat_list_screen.dart](file:///Users/harishharish/Unycomb/lib/features/chat/presentation/screens/chat_list_screen.dart)
- List of conversation tiles: avatar, name, last message preview, timestamp
- Tap to navigate to chat detail

##### [NEW] [lib/features/chat/presentation/screens/chat_detail_screen.dart](file:///Users/harishharish/Unycomb/lib/features/chat/presentation/screens/chat_detail_screen.dart)
- Message bubbles (yellow for sent, graphite for received)
- Text input bar with send button

##### [NEW] [lib/features/chat/presentation/cubit/chat_cubit.dart](file:///Users/harishharish/Unycomb/lib/features/chat/presentation/cubit/chat_cubit.dart)

---

### Sprint 3 — Backend Integration (Weeks 5–6)

Wire Firebase Auth, REST API, WebSocket, and local persistence.

---

#### 3.1 Data Layer — Repository Implementations

##### [NEW] [lib/data/repositories/auth_repository_impl.dart](file:///Users/harishharish/Unycomb/lib/data/repositories/auth_repository_impl.dart)
- Firebase Auth: `sendOtp(email)`, `verifyOtp(code)`, `signOut()`
- Token stored in `flutter_secure_storage`

##### [NEW] [lib/data/repositories/user_repository_impl.dart](file:///Users/harishharish/Unycomb/lib/data/repositories/user_repository_impl.dart)
- GET/PUT user profile via Dio (REST API)
- Local cache via Drift

##### [NEW] [lib/data/repositories/matching_repository_impl.dart](file:///Users/harishharish/Unycomb/lib/data/repositories/matching_repository_impl.dart)
- GET matches, POST collab request via Dio

##### [NEW] [lib/data/repositories/feed_repository_impl.dart](file:///Users/harishharish/Unycomb/lib/data/repositories/feed_repository_impl.dart)
- GET opportunities from REST API (backed by scraper data)

##### [NEW] [lib/data/repositories/project_repository_impl.dart](file:///Users/harishharish/Unycomb/lib/data/repositories/project_repository_impl.dart)
- CRUD projects and tasks via REST API
- Offline task cache via Drift

---

#### 3.2 Networking Configuration

##### [NEW] [lib/data/network/dio_client.dart](file:///Users/harishharish/Unycomb/lib/data/network/dio_client.dart)
- Base URL configuration
- Auth interceptor (attach Bearer token from secure storage)
- Error interceptor (map DioExceptions to domain errors)
- Logging interceptor (debug mode only)

##### [NEW] [lib/data/network/api_endpoints.dart](file:///Users/harishharish/Unycomb/lib/data/network/api_endpoints.dart)
- All REST endpoint constants

##### [NEW] [lib/data/network/websocket_client.dart](file:///Users/harishharish/Unycomb/lib/data/network/websocket_client.dart)
- `web_socket_channel` wrapper
- Used for real-time collab requests and chat

---

#### 3.3 Local Persistence

##### [NEW] [lib/data/local/nexus_database.dart](file:///Users/harishharish/Unycomb/lib/data/local/nexus_database.dart)
- Drift database definition
- Tables: `users`, `projects`, `tasks`, `opportunities`

##### [NEW] [lib/data/local/daos/](file:///Users/harishharish/Unycomb/lib/data/local/daos/)
- `UserDao`, `ProjectDao`, `TaskDao`, `OpportunityDao`

---

#### 3.4 Projects Screen with Kanban

##### [NEW] [lib/features/projects/presentation/screens/projects_screen.dart](file:///Users/harishharish/Unycomb/lib/features/projects/presentation/screens/projects_screen.dart)
- Header: "My projects" + "New project" button (yellow)
- Project cards: name, member avatars (stacked), progress bar (yellow on graphite), task count, status badge

##### [NEW] [lib/features/projects/presentation/screens/project_detail_screen.dart](file:///Users/harishharish/Unycomb/lib/features/projects/presentation/screens/project_detail_screen.dart)
- Kanban board: 3 columns (To do · In progress · Done)
- Drag-and-drop task cards between columns
- Task card: assignee avatar, title, due date pill

##### [NEW] [lib/features/projects/presentation/cubit/projects_cubit.dart](file:///Users/harishharish/Unycomb/lib/features/projects/presentation/cubit/projects_cubit.dart)
##### [NEW] [lib/features/projects/presentation/cubit/kanban_cubit.dart](file:///Users/harishharish/Unycomb/lib/features/projects/presentation/cubit/kanban_cubit.dart)
##### [NEW] [lib/features/projects/presentation/widgets/project_card.dart](file:///Users/harishharish/Unycomb/lib/features/projects/presentation/widgets/project_card.dart)
##### [NEW] [lib/features/projects/presentation/widgets/kanban_board.dart](file:///Users/harishharish/Unycomb/lib/features/projects/presentation/widgets/kanban_board.dart)
##### [NEW] [lib/features/projects/presentation/widgets/task_card.dart](file:///Users/harishharish/Unycomb/lib/features/projects/presentation/widgets/task_card.dart)

---

### Sprint 4 — Polish & Advanced Features (Weeks 7–8)

Real-time features, push notifications, mentorship, reputation, and performance tuning.

---

#### 4.1 Real-time Collab Requests

##### [MODIFY] [lib/data/network/websocket_client.dart](file:///Users/harishharish/Unycomb/lib/data/network/websocket_client.dart)
- Subscribe to collab request events
- Emit match request/accept/decline events

##### [NEW] [lib/features/matching/presentation/cubit/realtime_match_cubit.dart](file:///Users/harishharish/Unycomb/lib/features/matching/presentation/cubit/realtime_match_cubit.dart)
- Stream-based updates for incoming match requests

---

#### 4.2 Push Notifications (FCM)

##### [NEW] [lib/data/services/notification_service.dart](file:///Users/harishharish/Unycomb/lib/data/services/notification_service.dart)
- FCM token registration
- Foreground/background message handling
- Local notification display (`flutter_local_notifications`)
- Deep linking from notification tap to relevant screen

---

#### 4.3 Mentorship Screen

##### [NEW] [lib/features/mentorship/presentation/screens/mentorship_screen.dart](file:///Users/harishharish/Unycomb/lib/features/mentorship/presentation/screens/mentorship_screen.dart)
- Mentor cards: avatar, name, expertise tags, availability status
- "Request session" CTA
- Session requests list (pending/accepted)

##### [NEW] [lib/features/mentorship/presentation/cubit/mentorship_cubit.dart](file:///Users/harishharish/Unycomb/lib/features/mentorship/presentation/cubit/mentorship_cubit.dart)

---

#### 4.4 Reputation & Reviews

##### [MODIFY] [lib/features/profile/presentation/screens/profile_screen.dart](file:///Users/harishharish/Unycomb/lib/features/profile/presentation/screens/profile_screen.dart)
- Wire real reviews from API
- Add "Leave review" flow for past collaborators

##### [NEW] [lib/features/profile/presentation/screens/reviews_screen.dart](file:///Users/harishharish/Unycomb/lib/features/profile/presentation/screens/reviews_screen.dart)
- Full review list with pagination

---

#### 4.5 Performance & Animation Tuning

- Profile all animations with Flutter DevTools
- Ensure all list views use `ListView.builder` (not `Column` with children)
- Image caching via `cached_network_image`
- Shimmer loading placeholders on all data-loading screens
- Verify 60fps on both Android and iOS release builds
- Run `flutter analyze` and `dart fix --apply`

---

## Complete File Tree (65+ files)

```
lib/
├── main.dart
├── app.dart
│
├── core/
│   ├── theme/
│   │   ├── colors.dart
│   │   ├── typography.dart
│   │   └── theme.dart
│   ├── components/
│   │   ├── nexus_button.dart
│   │   ├── nexus_card.dart
│   │   ├── nexus_tag.dart
│   │   ├── nexus_bottom_nav.dart
│   │   ├── nexus_avatar.dart
│   │   ├── nexus_filter_chip.dart
│   │   └── nexus_badge.dart
│   ├── navigation/
│   │   └── app_router.dart
│   └── di/
│       └── injection.dart
│
├── domain/
│   └── repositories/
│       ├── auth_repository.dart
│       ├── user_repository.dart
│       ├── matching_repository.dart
│       ├── feed_repository.dart
│       └── project_repository.dart
│
├── data/
│   ├── repositories/
│   │   ├── auth_repository_impl.dart
│   │   ├── user_repository_impl.dart
│   │   ├── matching_repository_impl.dart
│   │   ├── feed_repository_impl.dart
│   │   └── project_repository_impl.dart
│   ├── network/
│   │   ├── dio_client.dart
│   │   ├── api_endpoints.dart
│   │   └── websocket_client.dart
│   ├── local/
│   │   ├── nexus_database.dart
│   │   └── daos/
│   │       ├── user_dao.dart
│   │       ├── project_dao.dart
│   │       ├── task_dao.dart
│   │       └── opportunity_dao.dart
│   └── services/
│       └── notification_service.dart
│
├── features/
│   ├── onboarding/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── welcome_screen.dart
│   │       │   ├── verify_screen.dart
│   │       │   └── profile_setup_screen.dart
│   │       └── cubit/
│   │           └── onboarding_cubit.dart
│   ├── home/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── home_screen.dart
│   │       ├── cubit/
│   │       │   └── home_cubit.dart
│   │       └── widgets/
│   │           ├── hero_zone.dart
│   │           ├── nav_grid.dart
│   │           └── grid_tile.dart
│   ├── matching/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── matching_screen.dart
│   │       ├── cubit/
│   │       │   ├── matching_cubit.dart
│   │       │   └── realtime_match_cubit.dart
│   │       └── widgets/
│   │           └── partner_card.dart
│   ├── feed/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── feed_screen.dart
│   │       ├── cubit/
│   │       │   └── feed_cubit.dart
│   │       └── widgets/
│   │           ├── opportunity_card.dart
│   │           └── closing_soon_strip.dart
│   ├── projects/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── projects_screen.dart
│   │       │   └── project_detail_screen.dart
│   │       ├── cubit/
│   │       │   ├── projects_cubit.dart
│   │       │   └── kanban_cubit.dart
│   │       └── widgets/
│   │           ├── project_card.dart
│   │           ├── kanban_board.dart
│   │           └── task_card.dart
│   ├── chat/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── chat_list_screen.dart
│   │       │   └── chat_detail_screen.dart
│   │       └── cubit/
│   │           └── chat_cubit.dart
│   ├── mentorship/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── mentorship_screen.dart
│   │       └── cubit/
│   │           └── mentorship_cubit.dart
│   └── profile/
│       └── presentation/
│           ├── screens/
│           │   ├── profile_screen.dart
│           │   └── reviews_screen.dart
│           ├── cubit/
│           │   └── profile_cubit.dart
│           └── widgets/
│               ├── reputation_badge.dart
│               ├── portfolio_grid.dart
│               └── review_card.dart
│
└── shared/
    ├── models/
    │   ├── user_model.dart
    │   ├── match_model.dart
    │   ├── opportunity_model.dart
    │   ├── project_model.dart
    │   ├── task_model.dart
    │   └── review_model.dart
    └── widgets/
        └── (shared reusable widgets)
```

---

## Open Questions

> [!IMPORTANT]
> 1. **Backend stack**: The arch diagram shows REST API + PostgreSQL + Redis + Object storage. What language/framework for the backend? (Node.js/Express, Python/FastAPI, Go, etc.)

> [!IMPORTANT]
> 2. **Chat scope**: Chat is in the bottom nav but not detailed in PLAN.md. Should Sprint 2 include a full chat feature or a placeholder screen?

> [!IMPORTANT]
> 3. **Mentorship detail**: The mentorship tile exists on the home grid but the screen design is minimal. Should mentorship be a full matching + scheduling system, or a lightweight "request a session" flow?

> [!NOTE]
> 4. **"More" tile**: The home grid has a "More" tile. What goes there? Settings? Notifications? Help? Community?

> [!NOTE]
> 5. **University list**: Is there a fixed list of supported universities, or should any `.edu` email be accepted?

---

## Verification Plan

### Automated Tests

| Type | What | Command |
|---|---|---|
| Unit tests | All Cubits (every state transition) | `flutter test test/unit/` |
| Unit tests | All repository impls (mocked Dio/Drift) | `flutter test test/unit/` |
| Widget tests | Core components (button, card, tag, nav) | `flutter test test/widgets/` |
| Widget tests | Each screen (golden tests for visual regression) | `flutter test test/golden/` |
| Integration | Onboarding flow end-to-end | `flutter test integration_test/` |
| Integration | Navigation: home grid → all destinations | `flutter test integration_test/` |
| Lint | Static analysis | `flutter analyze` |

### Manual Verification
- Run on **physical Android device** and **iOS Simulator** to verify:
  - All animations hit 60fps
  - Bottom nav transitions feel smooth
  - Home grid tap feedback is satisfying
  - Onboarding wordmark stagger animation works
  - Card entrance animations stagger correctly
- Dark mode display on OLED (true black `#0D0D0D`)
- Test on small screen (iPhone SE) and large screen (iPad) for responsive layout
