# House Chores - Pre-Release Todo List

## 1. Core Missing Features

- [ ] **Edit last done date** - Allow editing the lastDone date manually (for when you forgot to record it)
- [X] **Haptic feedback** - Add subtle vibration when marking a chore as done
- [X] **Confirm before delete** - Show confirmation dialog before deleting a chore (prevent accidental deletes)

## 2. Build & Distribution

### TestFlight (Shareable without App Store)
- [ ] Enroll in Apple Developer Program ($99/year) - required for TestFlight
- [ ] Create App ID in Apple Developer portal
- [ ] Create app in App Store Connect
- [ ] Archive the app in Xcode (Product → Archive)
- [ ] Upload to TestFlight via Xcode
- [ ] Add testers by email
- [ ] Testers install via TestFlight app (free on App Store)

### GitHub Actions CI/CD
- [ ] Create `.github/workflows/build.yml`
- [ ] Automated build on push to main
- [ ] Run tests automatically on pull requests
- [ ] Auto archive and upload to TestFlight on new version tag

## 3. UI/UX Polish

- [ ] **Edit mode visual distinction** - Implement one of the discussed options (banner, icons, fade)
- [ ] **Dark mode testing** - Test and fix any dark mode issues
- [ ] **App icon** - Add proper app icon
- [ ] **Empty state** - Already done ✅
- [ ] **Improve spacing** - Fine tune padding in ChoreRow

## 4. App Store Preparation

- [ ] Choose final app name
- [ ] Write app description
- [ ] Create keywords list
- [ ] Privacy policy (required by Apple)
- [ ] Screenshots (iPhone 6.7" and 6.5" required)
- [ ] Set version number to 1.0.0
- [ ] Submit for App Store review

## 5. Ideas for Future Versions (Post v1.0)

### Nice to have before release:
- [ ] **Sort options** - Let user choose between urgency/alphabetical/manual order
- [ ] **Search/filter** - Find chores quickly when list grows
- [ ] **Chore categories** - Group chores (Kitchen, Garden, Bathroom etc.)

### Post release:
- [ ] **Push notifications** - Remind when chores are overdue
- [ ] **Home screen widget** - See most urgent chores without opening app
- [ ] **Statistics** - How many chores done this week/month
- [ ] **iCloud sync** - Sync across multiple devices
- [ ] **Share with family** - Assign chores to family members
- [ ] **Recurring templates** - Common chore presets (water plants every 3 days etc.)
- [ ] **Undo mark as done** - In case of accidental tap
- [ ] **Streaks** - Track how consistently chores are done on time

## Notes

- Use the app daily and note any friction points
- TestFlight is the fastest way to share with others without App Store
- Apple review takes 1-3 days typically
- Focus on stability and core features for v1.0 - fancy features can come later
