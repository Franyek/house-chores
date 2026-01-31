//
//  ContentView.swift
//  HouseChores
//
//  Created by Franciska Sára on 2026. 01. 11..
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var store = ChoreStore()
    @State var showingAddChore = false
    @State var choreToEdit: Chore?
    
    var body: some View {
        NavigationStack {
            List(store.sortedChores) { chore in
                Button(action: {
                    store.markAsDone(id: chore.id)
                }){
                    VStack(alignment: .leading) {
                        Text(chore.name).font(.headline)
                        HStack {
                            if let lastDone = chore.lastDone {
                                let days = store.daysAgo(from: lastDone)
                                let daysOverdue = days - chore.frequencyInDays
                                Text("\(days) days ago")
                                    .font(.subheadline)
                                    .foregroundColor(store.colorForOverdue(daysOverdue))
                            } else {
                                Text("Never done")
                                    .font(.subheadline)
                                    .foregroundColor(.orange)
                            }
                            
                            Spacer()
                            
                            Text("Every \(chore.frequencyInDays) days")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .swipeActions(edge: .trailing){
                    Button(role: .destructive){
                        store.deleteChore(id: chore.id)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .swipeActions(edge: .leading){
                    Button{
                        choreToEdit = chore
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    .tint(.blue)
                }
            }
            .padding()
            .navigationTitle("Chores")
            .toolbar {
                Button("Add Chore") {
                    showingAddChore = true
                }
            }
            .sheet(isPresented: $showingAddChore) {
                AddChoreView(store: store)
            }
            .sheet(item: $choreToEdit) { chore in
                EditChoreView(store: store, chore: chore)
            }
        }
    }
}

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

#Preview {
    ContentView()
}

