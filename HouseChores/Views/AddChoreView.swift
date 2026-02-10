//
//  AddChoreView.swift
//  HouseChores
//
//  Created by Franciska Sára on 2026. 02. 02..
//

import SwiftUI

struct AddChoreView: View {
    @ObservedObject var store: ChoreStore
    @Environment(\.dismiss) var dismiss
    @State private var choreName = ""
    @State private var frequencyInDays: Int = 7
    @State private var selectedEmoji = ""
    @State private var showingEmojiPicker = false  // Add this
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Chore name", text: $choreName)
                
                HStack {
                    Text("Icon")
                    Spacer()
                    Button(action: {
                        showingEmojiPicker = true
                    }) {
                        if selectedEmoji.isEmpty {
                            Text("Choose...")
                                .foregroundColor(.secondary)
                        } else {
                            Text(selectedEmoji)
                                .font(.largeTitle)
                        }
                    }
                }
                
                Stepper("Every \(frequencyInDays) days", value: $frequencyInDays, in: 1...365)
            }
            .navigationTitle("New Chore")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        store.addChore(name: choreName,
                                       frequencyInDays: frequencyInDays,
                                       emoji: selectedEmoji.isEmpty ? nil : selectedEmoji
                        )
                        dismiss()
                    }
                    .disabled(choreName.isEmpty)
                }
            }
            .sheet(isPresented: $showingEmojiPicker) {
                EmojiPickerView(selectedEmoji: $selectedEmoji)
            }
        }
    }
}
