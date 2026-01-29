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
    
    init(name: String, lastDone: Date? = nil, frequencyInDays: Int) {
        self.id = UUID()
        self.name = name
        self.lastDone = lastDone
        self.frequencyInDays = frequencyInDays
    }
}
