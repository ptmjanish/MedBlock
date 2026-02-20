# MedBlock – Medical Content Block Renderer (SwiftUI)

Native SwiftUI renderer for polymorphic medical study content blocks loaded from a bundled JSON file.  
Target: **Xcode 16+**, **iOS 17+**, supports **iPhone + iPad**, Dark Mode, responsive comparison layout, and persistent text highlights.

## Features
- Polymorphic JSON decoding via plugin registry (extensible architecture)
- Block types:
  - heading
  - paragraph (rich spans with bold)
  - comparison (responsive columns: side-by-side on wide, stacked on narrow)
  - mnemonic
  - callout (warning/tip/info)
  - list (ordered + unordered)
- Long-press paragraph highlighting with persistence (UserDefaults)
- Adaptive highlight picker:
  - iPhone: sheet
  - iPad: popover sized to content
- Dark Mode + clean typography
- Accessibility improvements (VoiceOver labels, contrast handling)

## How to Build & Run
1. Open `MedBlock.xcodeproj` in **Xcode 16+**
2. Select an iPhone or iPad simulator/device (iOS 17+)
3. Run (⌘R)

The app loads `StudyContent.json` from the app bundle.

## Architecture Decisions
### 1) Plugin-based block decoding/rendering (extensible)
Block decoding + rendering is handled via a **registry of plugins**.
- Adding a new block type requires adding one new file/plugin and registering it.
- Avoids a giant switch statement spread across the app.

### 2) Separation of concerns
- Models: pure Decodable types for each block
- Rendering: SwiftUI views per block
- Services: JSON loading + document decoding
- Highlighting: store + picker UI isolated in its own module/folder

### 3) Responsive layout
Comparison block uses size class / available width rules:
- Wide screens: two columns
- Narrow: stacked vertically

## Unit Tests
Includes tests for:
- JSON decoding (document title, block count, block types)
- Plugin registry mapping (type string -> correct decoded model)

Run:
- Xcode → Product → Test (⌘U)

## What I Would Improve With More Time
- Snapshot tests for block views (light/dark + dynamic type)
- More robust highlight system (range-based highlighting, not full paragraph)
- Better theming (custom palette and reduced “system default” feel)
- Expand accessibility (more explicit traits, rotor navigation for headings)
- Add subtle appear animations for blocks (respect Reduce Motion)
