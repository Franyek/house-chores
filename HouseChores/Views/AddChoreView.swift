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
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Chore name", text: $choreName)
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
                        store.addChore(name: choreName, frequencyInDays: frequencyInDays)
                        dismiss()
                    }
                    .disabled(choreName.isEmpty)
                }
            }
        }
    }
}
