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
    
    init(store: ChoreStore, chore: Chore) {
        self.store = store
        self.chore = chore
        self._choreName = State(initialValue: chore.name)
        self._frequencyInDays = State(initialValue: chore.frequencyInDays)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Chore name", text: $choreName)
                
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
                        store.updateChore(id: chore.id, name: choreName, frequencyInDays: frequencyInDays)
                        dismiss()
                    }
                    .disabled(choreName.isEmpty)
                }
            }
        }
    }
}
