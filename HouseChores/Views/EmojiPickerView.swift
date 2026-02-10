//
//  EmojiPickerView.swift
//  HouseChores
//
//  Created by Franciska Sára on 2026. 02. 08..
//

import SwiftUI

struct EmojiPickerView: View {
    @Binding var selectedEmoji: String
    @Environment(\.dismiss) var dismiss
    
    let emojis = [
        // Home & Cleaning
        "🏠", "🧹", "🧼", "🧽", "🪣", "🧴",
        "🚿", "🛁", "🚽", "🗑️", "♻️", "🧺",
        
        // Plants & Garden
        "🌱", "🪴", "🌿", "🌸", "🌻", "🌷",
        "💧", "🚿", "🌾", "🍃", "🌵", "🌴",
        
        // Kitchen & Food
        "🍽️", "🥘", "🍳", "🧊", "🥤", "☕",
        "🍴", "🥄", "🔪", "🧂", "🧈", "🥛",
        
        // Laundry & Clothes
        "👕", "👔", "👗", "🧥", "🧦", "👖",
        "🎽", "🩱", "🧤", "👒", "🧢", "👞",
        
        // Tools & Maintenance
        "🔧", "🔨", "🪛", "🪚", "🔩", "⚙️",
        "🧰", "🪜", "🖌️", "🪣", "✂️", "📏",
        
        // Vehicles
        "🚗", "🚙", "🚕", "🏍️", "🚲", "🛴",
        
        // Pets
        "🐕", "🐈", "🐠", "🐦", "🐹", "🐰",
        
        // Other
        "📦", "📋", "✉️", "💼", "🎒", "🛒",
        "🔑", "💡", "🕯️", "🧯", "🪫", "🔋"
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 16) {
                    ForEach(emojis, id: \.self) { emoji in
                        Button(action: {
                            selectedEmoji = emoji
                            dismiss()
                        }) {
                            Text(emoji)
                                .font(.system(size: 44))
                                .frame(width: 60, height: 60)
                                .background(
                                    selectedEmoji == emoji
                                        ? Color.blue.opacity(0.2)
                                        : Color.gray.opacity(0.1)
                                )
                                .cornerRadius(12)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Choose Icon")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !selectedEmoji.isEmpty {
                        Button("Clear") {
                            selectedEmoji = ""
                            dismiss()
                        }
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}

#Preview {
    EmojiPickerView(selectedEmoji: .constant("🏠"))
}
