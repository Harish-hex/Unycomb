# UNYCOMB — App Design Plan

## Overview

Nexus is a college-only collaboration platform built in Flutter/Dart. The design language is bold, energetic, and distinctly student-facing — not corporate, not generic. The aesthetic direction is **bumblebee**: high-contrast black and yellow, with a sharp editorial grid layout that communicates seriousness and ambition.

---

## Colour Palette — Bumblebee

| Role | Name | Hex |
|---|---|---|
| Primary accent | Bumblebee Yellow | `#F5C518` |
| Deep accent | Amber Gold | `#E6A800` |
| Background | Pitch Black | `#0D0D0D` |
| Surface | Carbon | `#1A1A1A` |
| Surface elevated | Graphite | `#252525` |
| Border | Ash | `#2E2E2E` |
| Text primary | Off White | `#F0F0F0` |
| Text secondary | Warm Grey | `#9A9A9A` |
| Text muted | Dim | `#555555` |
| Success | Lime | `#84CC16` |
| Error | Vermillion | `#EF4444` |

### Dart token definitions

```dart
class NexusColors {
  static const yellow      = Color(0xFFF5C518);
  static const amberGold   = Color(0xFFE6A800);
  static const black       = Color(0xFF0D0D0D);
  static const carbon      = Color(0xFF1A1A1A);
  static const graphite    = Color(0xFF252525);
  static const ash         = Color(0xFF2E2E2E);
  static const offWhite    = Color(0xFFF0F0F0);
  static const warmGrey    = Color(0xFF9A9A9A);
  static const dim         = Color(0xFF555555);
  static const lime        = Color(0xFF84CC16);
  static const vermillion  = Color(0xFFEF4444);
}
```

---

## Typography

| Role | Font | Weight | Size |
|---|---|---|---|
| Display / Wordmark | Syne | 800 | 28–36px |
| Headings | Syne | 700 | 20–24px |
| Subheadings | Syne | 600 | 16–18px |
| Body | DM Sans | 400 | 14–15px |
| Caption / Label | DM Sans | 500 | 11–12px |
| Code / Monospace | JetBrains Mono | 400 | 13px |

Syne's geometric boldness pairs with DM Sans's warmth — neither too technical nor too casual. The display font carries the bumblebee energy; the body font keeps readability.

---

## Navigation System

Nexus uses a **two-tier navigation** model, inspired by Instagram's pattern but adapted for a productivity-first context.

### Tier 1 — Home screen grid (primary entry)

The home screen is NOT a feed. It is a **full-bleed navigation grid** that occupies the bottom two-thirds of the screen. The top third is the hero zone — wordmark, user greeting, and a live stat strip (active projects, open matches, new opportunities).

The grid is 2×3, giving six large tappable tiles. Each tile is a destination with a label, an icon glyph, and a live badge count where relevant.

```
┌─────────────────────────────┐
│                             │
│   HERO ZONE  (top 1/3)      │
│   Wordmark + greeting       │
│   Live stat strip           │
│                             │
├──────────────┬──────────────┤
│              │              │
│   Matching   │    Feed      │
│              │              │
├──────────────┼──────────────┤
│              │              │
│   Projects   │  Mentorship  │
│              │              │
├──────────────┼──────────────┤
│              │              │
│   Profile    │    More      │
│              │              │
└──────────────┴──────────────┘
```

This grid acts as a visual launchpad. It removes the need to memorise tab positions and communicates every core feature at a glance. The yellow accent colour is used on active/highlighted tiles.

### Tier 2 — Bottom navigation bar (all inner screens)

Once inside any section, the home grid disappears and a standard bottom navigation bar appears. Five items. Mirrors Instagram's bottom bar pattern — persistent, always accessible, never intrusive.

```
┌─────────────────────────────────────────┐
│                                         │
│           Screen content                │
│                                         │
│                                         │
├──────┬──────┬──────┬──────┬─────────────┤
│  🏠  │  🔍  │  ⚡  │  💬  │     👤      │
│ Home │Match │ Feed │ Chat │   Profile   │
└──────┴──────┴──────┴──────┴─────────────┘
```

The active tab uses bumblebee yellow as the icon fill and a small yellow dot indicator underneath. Inactive tabs are warm grey. No labels on inactive tabs — icon-only until selected, then the label appears (Instagram-style).

---

## Screen Designs

### 1. Home screen

**Purpose:** Orientation and navigation launchpad.

**Layout:**
- Top 1/3: Hero zone
  - Top-left: Nexus wordmark in Syne 800, yellow
  - Top-right: notification bell + avatar
  - Centre: "Good morning, [name]" in Syne 600
  - Below greeting: horizontal stat pill strip — `3 active projects · 2 new matches · 5 hackathons`
  - Background: carbon (`#1A1A1A`) with a subtle hexagonal dot pattern at 4% opacity in yellow

- Bottom 2/3: Navigation grid
  - 2 columns × 3 rows
  - Each cell: `#252525` background, 12px rounded corners, 1px `#2E2E2E` border
  - Cell layout: icon glyph (24px, yellow) top-left, label (Syne 600, 15px, off-white) bottom-left, badge (yellow pill) top-right if count > 0
  - Active/featured tile gets a yellow left border accent (3px) and slightly lighter background
  - Grid has 12px gap between cells, 16px padding from screen edges

**Grid tiles:**

| Tile | Icon | Badge source |
|---|---|---|
| Matching | person-search | Pending match requests |
| Feed | lightning-bolt | Unread opportunities |
| Projects | folder-open | Active task count |
| Mentorship | academic-cap | Session requests |
| Profile | user-circle | Profile completion % |
| More | grid-dots | — |

---

### 2. Matching screen

**Purpose:** Discover and request project partners.

**Layout:**
- Header: "Find partners" in Syne 700, back arrow left, filter icon right
- Filter chips row: All · Design · Backend · ML · Mobile — horizontally scrollable, active chip = yellow fill + black text, inactive = graphite fill + warm grey text
- Card stack: full-width cards, `#1A1A1A` background, 16px radius
  - Each card: avatar (52px circle), name + university, skill tags (yellow pill tags), short bio (2 lines max), "Request collab" CTA button (yellow, full-width, rounded)
  - Cards are vertically scrollable — professional, not swipeable
- Empty state: bumblebee illustration, "No matches yet — update your skills to improve suggestions"

---

### 3. Feed screen

**Purpose:** Curated opportunities — hackathons, competitions, open collabs.

**Layout:**
- Header: "Opportunities" in Syne 700
- Toggle pills: Hackathons · Collabs · Competitions
- Feed cards: stacked list
  - Card: source logo (Devpost/MLH), event title (Syne 600), deadline badge (red if < 7 days, yellow otherwise), tag chips (Remote · Prize · 48hr), one-line description, "View" button (outlined yellow)
- Pinned strip at top: "Closing soon" — 2–3 cards in horizontal scroll with yellow left border accent

---

### 4. Projects screen

**Purpose:** Manage active project collaborations.

**Layout:**
- Header: "My projects" + "New project" button (yellow, Syne 600)
- Project cards: project name, member avatars (stacked circles), progress bar (yellow fill on graphite track), open task count, status badge (Active / Paused / Completed)
- Project detail view: Kanban task board — three columns (To do · In progress · Done), cards draggable between columns
- Task cards: assignee avatar, task title, due date pill

---

### 5. Profile screen

**Purpose:** Personal portfolio and reputation showcase.

**Layout:**
- Top section: large avatar (80px), name (Syne 700, 22px), university + year, verified badge (yellow checkmark)
- Reputation score: large yellow number (e.g. `4.8`) with star row, total reviews count
- Skill tags: wrapping row of yellow pill tags
- Portfolio section: 2-column grid of project cards with project name, role, and tech stack chips
- Reviews: scrollable list of short feedback cards from past collaborators

---

### 6. Onboarding flow

Three screens, minimal:

1. **Welcome** — full black screen, Nexus wordmark animates in yellow, tagline "Build with the best minds on campus", Continue button
2. **Verify** — university email input, OTP entry, verified tick animation in yellow
3. **Profile setup** — name, year, skills selection (tag grid, tap to select, selected = yellow), profile photo upload

---

## Component Library

### Buttons

```dart
// Primary — filled yellow
NexusButton.primary(label: "Request collab", onTap: ...)
// background: #F5C518, text: #0D0D0D, Syne 600, 15px, 48px height, 12px radius

// Secondary — outlined
NexusButton.outlined(label: "View", onTap: ...)
// border: #F5C518, text: #F5C518, transparent background

// Ghost — text only
NexusButton.ghost(label: "Skip", onTap: ...)
// text: #9A9A9A
```

### Skill tags

```dart
// Accent pill
NexusTag(label: "Flutter", style: TagStyle.accent)
// background: #F5C518 at 15% opacity, text: #F5C518, border: #F5C518 at 30% opacity

// Neutral pill
NexusTag(label: "Backend", style: TagStyle.neutral)
// background: #252525, text: #9A9A9A
```

### Cards

```dart
NexusCard(
  background: NexusColors.carbon,   // #1A1A1A
  borderRadius: 16,
  border: NexusColors.ash,          // #2E2E2E at 1px
  padding: EdgeInsets.all(16),
)
```

### Bottom nav bar

```dart
NexusBottomNav(
  activeColor: NexusColors.yellow,
  inactiveColor: NexusColors.warmGrey,
  backgroundColor: NexusColors.carbon,
  indicatorStyle: IndicatorStyle.dot,  // small yellow dot under active icon
  items: [Home, Match, Feed, Chat, Profile],
)
```

---

## Motion & Micro-interactions

- **Home grid tiles:** scale down to 0.96 on press, 120ms ease-out spring — satisfying tap feedback
- **Bottom nav transitions:** fade + slight upward translate (8px, 200ms) when switching tabs
- **Skill tag selection:** tag scales up to 1.05 briefly when selected, border animates in yellow
- **Match request sent:** yellow ripple emanates from the "Request collab" button
- **Onboarding wordmark:** letters stagger in with 40ms delay each, opacity 0→1 over 600ms
- **Card entrance:** cards stagger in with 60ms delay per card, translate from y+16 to y+0

All animations use Flutter's `AnimationController` with `CurvedAnimation(curve: Curves.easeOutCubic)`. Every motion has a functional reason — no decoration for its own sake.

---

## Flutter Project Structure

```
lib/
├── main.dart
├── app.dart                      # MaterialApp, theme, routes
│
├── core/
│   ├── theme/
│   │   ├── colors.dart           # NexusColors
│   │   ├── typography.dart       # NexusTextStyles
│   │   └── theme.dart            # ThemeData
│   ├── components/
│   │   ├── nexus_button.dart
│   │   ├── nexus_card.dart
│   │   ├── nexus_tag.dart
│   │   └── nexus_bottom_nav.dart
│   └── navigation/
│       └── app_router.dart
│
├── features/
│   ├── home/
│   │   ├── home_screen.dart      # Grid launchpad
│   │   └── home_cubit.dart
│   ├── matching/
│   ├── feed/
│   ├── projects/
│   ├── mentorship/
│   └── profile/
│
└── shared/
    ├── models/                   # Domain models
    └── widgets/                  # Shared UI components
```

---

## Build Sequence

### Sprint 1 — Foundation
- Flutter project setup, theme tokens, typography, colour system
- Core component library: buttons, cards, tags, bottom nav
- Onboarding flow: welcome → verify → profile setup
- Home screen with static grid

### Sprint 2 — Core features
- Profile screen with skills and portfolio
- Matching screen with filter chips and partner cards
- Feed screen with opportunity cards
- Bottom nav bar wired across all screens

### Sprint 3 — Backend integration
- Auth API wired to onboarding (Firebase + university email OTP)
- Partner matching API → matching screen
- Hackathon scraper data → feed screen
- Projects screen with Kanban task board

### Sprint 4 — Polish
- Real-time collab requests via WebSocket
- FCM push notifications
- Reputation and reviews on profile
- Mentorship pairing screen
- Performance profiling and animation tuning