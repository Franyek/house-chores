# Phase 4: App Store Release & Production Readiness

Plan to take your chore tracker from working prototype to App Store release.

## 4.1: Code Refactoring & Architecture (3-5 sessions)

### Session 1: Separate Model & Data Layer
- [X] Create `Models/Chore.swift` - Move Chore struct to its own file
- [X] Create `Services/ChoreStore.swift` - Move persistence logic out of view
- [X] Update ContentView to use ChoreStore

### Session 2: Separate Views
- [X] Create `Views/ContentView.swift` - Main list view
- [X] Create `Views/AddChoreView.swift` - Add chore form
- [X] Create `Views/EditChoreView.swift` - Edit chore form
- [X] Create `Views/Components/ChoreRow.swift` - Individual list item

### ~~Session 3: Helpers & Extensions~~
~~- [ ] Create `Helpers/DateHelper.swift` - Date calculation functions~~
~~ - [ ] Create `Helpers/ColorHelper.swift` - Color coding logic~~
~~- [ ] Create `Extensions/Color+Theme.swift` - Custom color definitions~~

### File Structure Goal:
```
ChoreTracker/
├── Models/
│   └── Chore.swift
├── Views/
│   ├── ContentView.swift
│   ├── AddChoreView.swift
│   ├── EditChoreView.swift
│   └── Components/
│       └── ChoreRow.swift
├── Services/
│   └── ChoreStore.swift
├── Helpers/
│   ├── DateHelper.swift
│   └── ColorHelper.swift
└── ChoreTrackerApp.swift
```

## 4.2: Testing (2-3 sessions)

### Session 1: Setup & Model Tests
- [X] Enable testing target in Xcode
- [X] Create `ChoreTests.swift` - Test Chore model creation, Codable encoding/decoding
- [ ] Create `DateHelperTests.swift` - Test date calculations

### Session 2: Business Logic Tests
- [X] Create `ChoreStoreTests.swift` - add/edit/delete operations
- [ ] Create `ChoreStoreTests.swift` - Test save/load, 
- [ ] Test sorting logic
- [ ] Test urgency calculations

### Session 3: Optional - UI Tests
- [ ] Basic UI test for adding a chore
- [ ] Basic UI test for marking as done

## 4.3: UI/UX Polish (2-3 sessions)

### Session 1: Edit Mode (Prevent Accidental Mark as Done)
- [X] Add edit mode toggle button in toolbar
- [X] In edit mode: tap opens edit sheet instead of marking done
- [X] Add visual indicator when in edit mode (chevron or title change)
- [ ] Keep swipe actions available in both modes

### Session 2: Visual Improvements
- [X] Add app icon (use SF Symbols or design simple icon)
- [X] Add chore icons/emojis (optional)
- [ ] Improve spacing and padding
- [ ] Add subtle animations (button press, list updates)

### Session 3: Better Empty States & Accessibility
- [X] Add "no chores" empty state with helpful message
- [ ] Add onboarding hints for first-time users
- [ ] Test with Dynamic Type (larger text sizes)
- [ ] Test in Dark Mode
- [ ] Add haptic feedback on mark as done

## 4.4: App Store Preparation (2-3 sessions)

### Session 1: App Metadata
- [ ] Choose app name (check availability on App Store)
- [ ] Write app description (focus on benefits)
- [ ] Create keywords for search
- [ ] Decide on pricing (free recommended for v1)

### Session 2: Required Assets
- [ ] App icon (1024x1024px) - use Canva or similar
- [ ] Screenshots (iPhone 6.7" and 6.5" required)
  - Main list view
  - Adding a chore
  - Color-coded urgency
  - Mark as done in action
- [ ] Optional: Preview video (15-30 seconds)

### Session 3: App Store Connect Setup
- [ ] Create Apple Developer account ($99/year)
- [ ] Create App Store Connect app listing
- [ ] Upload metadata, screenshots, description
- [ ] Set up privacy policy (required - can use simple template)

## 4.5: CI/CD with GitHub Actions (2 sessions)

### Session 1: Basic Build Pipeline
- [ ] Create `.github/workflows/build.yml`
- [ ] Set up automated build on push to main
- [ ] Run tests automatically
- [ ] Archive on tags/releases

### Session 2: TestFlight Deployment
- [ ] Set up automatic TestFlight uploads
- [ ] Add version bumping automation
- [ ] Create release notes template

### Sample Workflow:
```yaml
# .github/workflows/build.yml
name: Build and Test

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build
        run: xcodebuild build -scheme ChoreTracker
      - name: Test
        run: xcodebuild test -scheme ChoreTracker
```

## 4.6: Final Pre-Release Checklist

### Technical
- [ ] All features working on real device
- [ ] No crashes or major bugs
- [ ] Data persists correctly
- [ ] App works offline
- [ ] Memory leaks checked
- [ ] Battery usage reasonable

### Legal/Admin
- [ ] Privacy policy created and linked
- [ ] App Store guidelines reviewed
- [ ] Age rating set appropriately
- [ ] Support email/website set up

### Release
- [ ] Version number set (1.0.0)
- [ ] Build number incremented
- [ ] Archive and upload to App Store Connect
- [ ] Submit for review
- [ ] Wait 1-3 days for approval

## Timeline Estimate

Assuming 15-30 min focused sessions:
- **Refactoring**: 5-7 sessions (2-3 weeks)
- **Testing**: 3-5 sessions (1-2 weeks)
- **UI Polish**: 3-4 sessions (1-2 weeks)
- **App Store Prep**: 3-4 sessions (1-2 weeks)
- **CI/CD Setup**: 2-3 sessions (1 week)
- **Final testing & submission**: 2-3 sessions (1 week)

**Total: 6-10 weeks to App Store submission**

## Success Criteria

✅ Clean, maintainable code structure
✅ Core functionality tested
✅ Professional-looking UI
✅ Automated build pipeline
✅ App approved on App Store
✅ Can iterate and add features easily

## Notes

- Start with refactoring - it makes everything else easier
- Testing can be added gradually - don't need 100% coverage for v1
- UI polish has diminishing returns - don't perfectionism trap
- Apple review takes 1-3 days typically, plan accordingly
- Can release with minimal features - better to ship and iterate

## Post-Launch Ideas (Phase 5)

- Push notifications for overdue chores
- Categories/tags for chores
- Statistics and insights
- Widgets for home screen
- iCloud sync across devices
- Share chores with family members
- Recurring chore templates
- Check Edit mode visualisation ideas
