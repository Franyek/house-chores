//
//  ChoreStore.swift
//  HouseChores
//
//  Created by Franciska Sára on 2026. 01. 29..
//

import Foundation
import Combine
import SwiftUI

class ChoreStore: ObservableObject {
    @Published var chores: [Chore] = [] {
        didSet {
            saveChores()
        }
    }
    
    init() {
        loadChores()
    }
    
    // CRUD Operations
    func addChore(name: String, frequencyInDays: Int) {
        let newChore = Chore(name: name, lastDone: nil, frequencyInDays: frequencyInDays)
        chores.append(newChore)
    }
    func deleteChore(id: UUID) {
        if let index = chores.firstIndex(where: { $0.id == id }) {
            chores.remove(at: index)
        }
    }
    func updateChore(id: UUID, name: String, frequencyInDays: Int) {
        if let index = chores.firstIndex(where: { $0.id == id }) {
            chores[index].name = name
            chores[index].frequencyInDays = frequencyInDays
        }
    }
    func markAsDone(id: UUID) {
        if let index = chores.firstIndex(where: { $0.id == id }) {
            chores[index].lastDone = Date()
        }
    }
    
    // Business Logic
    var sortedChores: [Chore] {
        chores.sorted { (chore1, chore2) -> Bool in
            let lastDone1 = urgencyScore(for: chore1)
            let lastDone2 = urgencyScore(for: chore2)
            return lastDone1 > lastDone2
        }
    }
    func urgencyScore(for chore: Chore) -> Int {
        guard let lastDone = chore.lastDone else { return 1000 }
        
        let daysSinceLastDone = daysAgo(from: lastDone)
        let daysOverdue = daysSinceLastDone - chore.frequencyInDays
        return daysOverdue
    }
    func daysAgo(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date, to: Date())
        return components.day ?? 0
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
    
    // Persistence
    private func saveChores() {
        if let encoded = try? JSONEncoder().encode(chores) {
            UserDefaults.standard.set(encoded, forKey: "chores")
        }
    }
    private func loadChores() {
        if let savedChores = UserDefaults.standard.data(forKey: "chores"),
           let loadedChores = try? JSONDecoder().decode([Chore].self, from: savedChores) {
            chores = loadedChores
        }
    }
}

