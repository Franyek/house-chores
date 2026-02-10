//
//  EditChoreView.swift
//  HouseChores
//
//  Created by Franciska Sára on 2026. 02. 02..
//

import SwiftUI

struct EditChoreView: View {
    @ObservedObject var store: ChoreStore
    let chore: Chore
    @Environment(\.dismiss) var dismiss
    @State private var choreName: String
    @State private var frequencyInDays: Int
    @State private var selectedEmoji: String
    @State private var showingEmojiPicker = false
    
    init(store: ChoreStore, chore: Chore) {
        self.store = store
        self.chore = chore
        self._choreName = State(initialValue: chore.name)
        self._frequencyInDays = State(initialValue: chore.frequencyInDays)
        self._selectedEmoji = State(initialValue: chore.emoji ?? "")
    }
    
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
            .navigationTitle("Edit Chore")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        store.updateChore(id: chore.id, name: choreName, frequencyInDays: frequencyInDays, emoji: selectedEmoji)
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
