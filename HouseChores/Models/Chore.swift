//
//  Chore.swift
//  HouseChores
//
//  Created by Franciska Sára on 2026. 01. 28..
//

import Foundation

struct Chore: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var lastDone: Date?
    var frequencyInDays: Int
    var emoji: String?
    
    init(name: String, lastDone: Date? = nil, frequencyInDays: Int, emoji: String? = nil) {
        self.id = UUID()
        self.name = name
        self.lastDone = lastDone
        self.frequencyInDays = frequencyInDays
        self.emoji = emoji
    }
}
