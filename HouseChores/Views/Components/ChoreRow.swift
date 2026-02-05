//
//  ChoreRow.swift
//  HouseChores
//
//  Created by Franciska Sára on 2026. 02. 02..
//

import SwiftUI

struct ChoreRow: View {
    let chore: Chore
    let store: ChoreStore
    let isEditMode: Bool
    
    var body: some View {
        HStack {
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
            
            if isEditMode {
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
    }
}
