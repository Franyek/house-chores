//
//  Edit-MODE-IDEAS.md
//  HouseChores
//
//  Created by Franciska Sára on 2026. 02. 07..
//

# Edit Mode Visual Design Ideas

Ideas for making edit mode more visually distinct from normal mode.

## Current Implementation
- Edit/Done icon button in navigation bar (pencil/checkmark)
- Title changes from "Chores" to "Edit Chores"
- Tap behavior changes (mark done → open edit sheet)

## Enhancement Ideas

### Option 1: Banner at Top
**What:** Blue banner appears at top of list when in edit mode

```swift
VStack(spacing: 0) {
    // Edit mode banner
    if isEditMode {
        HStack {
            Image(systemName: "pencil.circle.fill")
            Text("Tap a chore to edit")
                .font(.subheadline)
                .fontWeight(.medium)
            Spacer()
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
    
    List(store.sortedChores) { chore in
        // ... list content
    }
}
.animation(.easeInOut(duration: 0.3), value: isEditMode)
```

**Effect:** Clear message telling user they're in edit mode

---

### Option 2: Change List Background Color
**What:** Entire list gets subtle tinted background

```swift
List(store.sortedChores) { chore in
    // ... your content
}
.scrollContentBackground(isEditMode ? .hidden : .visible)
.background(isEditMode ? Color.orange.opacity(0.1) : Color.clear)
.animation(.easeInOut(duration: 0.3), value: isEditMode)
```

**Effect:** Whole screen feels different in edit mode

---

### Option 3: Colored Bar on Left Side
**What:** Blue vertical bar appears on left edge of each row

In `ChoreRow.swift`:
```swift
HStack(spacing: 0) {
    // Colored bar on left
    if isEditMode {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 4)
            .padding(.trailing, 8)
    }
    
    VStack(alignment: .leading) {
        // ... existing content
    }
}
.animation(.spring(response: 0.3, dampingFraction: 0.7), value: isEditMode)
```

**Effect:** Clean visual indicator per row

---

### Option 4: Icons + Fade + Chevron (Comprehensive)
**What:** Multiple visual changes combined

In `ChoreRow.swift`:
```swift
HStack {
    // Left pencil icon
    if isEditMode {
        Image(systemName: "pencil.circle.fill")
            .foregroundColor(.blue)
            .font(.title3)
            .transition(.scale.combined(with: .opacity))
    }
    
    VStack(alignment: .leading) {
        Text(chore.name)
            .font(.headline)
        
        HStack {
            if let lastDone = chore.lastDone {
                let days = store.daysAgo(from: lastDone)
                let daysOverdue = days - chore.frequencyInDays
                
                Text("\(days) days ago")
                    .font(.subheadline)
                    // Fade urgency colors in edit mode
                    .foregroundColor(isEditMode ? .secondary : store.colorForOverdue(daysOverdue))
            } else {
                Text("Never done")
                    .font(.subheadline)
                    .foregroundColor(isEditMode ? .secondary : .orange)
            }
            
            Spacer()
            
            Text("Every \(chore.frequencyInDays) days")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
    .opacity(isEditMode ? 0.7 : 1.0)  // Fade content slightly
    
    // Right chevron
    if isEditMode {
        Image(systemName: "chevron.right")
            .foregroundColor(.blue)
            .transition(.scale.combined(with: .opacity))
    }
}
.animation(.spring(response: 0.3), value: isEditMode)
```

**Effect:**
- Pencil icons appear on left
- Chevrons appear on right
- Urgency colors turn gray
- Content slightly faded
- Smooth spring animation

---

### Option 5: Row Background Tint
**What:** Each row gets subtle background color

In `ContentView.swift`, add to Button:
```swift
.listRowBackground(isEditMode ? Color.blue.opacity(0.08) : Color.clear)
```

**Effect:** Subtle blue tint on each row

---

### Option 6: Scale Effect
**What:** Rows slightly shrink in edit mode

```swift
.scaleEffect(isEditMode ? 0.98 : 1.0)
.animation(.spring(response: 0.3), value: isEditMode)
```

**Effect:** Subtle visual "pull back" suggesting different mode

---

## Recommended Combination

**For maximum clarity:**
- Option 1 (Banner) + Option 4 (Icons + Fade + Chevron)

This provides:
✅ Clear message at top
✅ Per-row visual indicators
✅ Color changes to show "not in action mode"
✅ Smooth animations
✅ Standard iOS patterns (chevrons)

---

## Animation Tips

**Smooth transitions:**
```swift
.animation(.easeInOut(duration: 0.3), value: isEditMode)
```

**Spring animation (more natural):**
```swift
.animation(.spring(response: 0.3, dampingFraction: 0.7), value: isEditMode)
```

**Slide in from top:**
```swift
.transition(.move(edge: .top).combined(with: .opacity))
```

**Scale and fade:**
```swift
.transition(.scale.combined(with: .opacity))
```

---

## Notes

- All options can be combined
- Start with subtle changes, add more if needed
- Test on actual device for best feel
- Consider accessibility - don't rely only on color
- Animations should be quick (0.2-0.4 seconds)
