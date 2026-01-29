//
//  ContentView.swift
//  HouseChores
//
//  Created by Franciska Sára on 2026. 01. 11..
//

import SwiftUI

struct ContentView: View {
    @State private var chores: [Chore] = [
        Chore(name: "Watering plants", lastDone: Date(), frequencyInDays: 7),
        Chore(name: "Hoovering the living room", lastDone: nil, frequencyInDays: 5),
        Chore(name: "Clean the downstairs toilet", lastDone: Date(), frequencyInDays: 7)
    ]
    
    var sortedChores: [Chore] {
        chores.sorted { (chore1, chore2) -> Bool in
            let lastDone1 = urgencyScore(for: chore1)
            let lastDone2 = urgencyScore(for: chore2)
            return lastDone1 > lastDone2
        }
    }
    
    @State var showingAddChore = false
    @State var choreToEdit: Chore?
    
    var body: some View {
        NavigationStack {
            List(sortedChores) { chore in
                Button(action: {
                    if let index = chores.firstIndex(where: { $0.id == chore.id }) {
                        chores[index].lastDone = Date()
                    }
                }){
                    VStack(alignment: .leading) {
                        Text(chore.name).font(.headline)
                        HStack {
                            if let lastDone = chore.lastDone {
                                let days = daysAgo(from: lastDone)
                                let daysOverdue = days - chore.frequencyInDays
                                Text("\(days) days ago")
                                    .font(.subheadline)
                                    .foregroundColor(colorForOverdue(daysOverdue))
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
                        if let index = chores.firstIndex(where: { $0.id == chore.id }) {
                            chores.remove(at: index)
                        }
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
                AddChoreView(chores: $chores)
            }
            .sheet(item: $choreToEdit) { chore in
                EditChoreView(chores: $chores, chore: chore)
            }
            .onAppear {
                loadChores()
            }
            .onChange(of: chores) {
                saveChores()
            }
        }
    }
    
    func saveChores() {
        if let encoded = try? JSONEncoder().encode(chores) {
            UserDefaults.standard.set(encoded, forKey: "chores")
        }
    }
    
    func loadChores() {
        if let savedChores = UserDefaults.standard.data(forKey: "chores"),
           let loadedChores = try? JSONDecoder().decode([Chore].self, from: savedChores) {
            chores = loadedChores
        }
    }
    
    func daysAgo(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date, to: Date())
        return components.day ?? 0
    }
    
    func urgencyScore(for chore: Chore) -> Int {
        guard let lastDone = chore.lastDone else { return 1000 }
        
        let daysSinceLastDone = daysAgo(from: lastDone)
        let daysOverdue = daysSinceLastDone - chore.frequencyInDays
        return daysOverdue
    }
    
    func colorForOverdue(_ daysOverdue: Int) -> Color {
        if daysOverdue <= 0 {
            return .gray  // On time or early
        } else if daysOverdue == 1 {
            return .yellow  // 1 day overdue - warning
        } else if daysOverdue <= 3 {
            return .orange  // 2-3 days overdue - getting urgent
        } else {
            return .red  // 4+ days overdue - very urgent
        }
    }
}

struct AddChoreView: View {
    @Binding var chores: [Chore]
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
                        let newChore = Chore(name: choreName, lastDone: nil, frequencyInDays: frequencyInDays)
                        chores.append(newChore)
                        dismiss()
                    }
                    .disabled(choreName.isEmpty)
                }
            }
        }
    }
}

struct EditChoreView: View {
    @Binding var chores: [Chore]
    let chore: Chore
    @Environment(\.dismiss) var dismiss
    @State private var choreName: String
    @State private var frequencyInDays: Int
    
    init(chores: Binding<[Chore]>, chore: Chore) {
        self._chores = chores
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
                        if let index = chores.firstIndex(where: { $0.id == chore.id }) {
                            chores[index].name = choreName
                            chores[index].frequencyInDays = frequencyInDays
                        }
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

