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
                    ChoreRow(chore: chore, store: store)
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



#Preview {
    ContentView()
}

