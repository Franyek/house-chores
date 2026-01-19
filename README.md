# iOS Chore Tracker App - Development Plan

A step-by-step plan for building a chore tracking iOS app. Each task is designed to take 15-30 minutes of focused work.

## Phase 1: Setup & Environment

- [x] **Install Xcode** - Download from Mac App Store (runs in background, no focus needed)
- [x] **Create your first project** - Open Xcode → New Project → iOS App → SwiftUI
- [x] **Run the default app** - Press play button, see "Hello World" in simulator

## Phase 2: Learn Basic SwiftUI

- [x] **Modify text** - Change "Hello World" to something else, see it update
- [x] **Add a button** - Add one button that prints to console when clicked
- [x] **Create a list** - Display 3 hardcoded chore names in a list
- [x] **Add a simple model** - Create a Chore struct with name and date properties

## Phase 3: Core Functionality

- [ ] **Add timestamp** - Make button store current date/time for one chore
- [ ] **Display the date** - Show "Last done: X days ago" under chore name
- [ ] **Add multiple chores** - Make the list work with 3-5 different chores
- [ ] **Add new chore UI** - Create a simple form to add a chore name
- [ ] **Make "mark as done" work** - Button updates the timestamp for that chore
- [ ] **Persist data** - Save chores so they survive app restart (UserDefaults first, then CoreData later)

## Phase 4: Polish

- [ ] **Add icons** - Visual indicators for each chore type
- [ ] **Color coding** - Show overdue items in red/yellow
- [ ] **Sort by urgency** - Most overdue items at top
- [ ] **Edit/delete** - Manage your chore list

## Notes

- Each checkbox can be ticked off in GitHub as you complete tasks
- You can add notes or dates completed under each item
- Feel free to adjust the order or break tasks down further if needed
- Remember: progress over perfection!

## Project Info

- **Tech Stack**: SwiftUI, Swift
- **Target**: iOS (iPhone)
- **Purpose**: Track household chores with timestamps
- **Developer Background**: Python backend developer, learning iOS development
