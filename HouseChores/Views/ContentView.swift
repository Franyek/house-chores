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
    @State var isEditMode = false
    
    var body: some View {
        NavigationStack {
            List(store.sortedChores) { chore in
                Button(action: {
                        if isEditMode {
                            // In edit mode, tap opens edit sheet
                            choreToEdit = chore
                        } else {
                            // In normal mode, tap marks as done
                            store.markAsDone(id: chore.id)
                        }
                    }) {
                        ChoreRow(chore: chore, store: store, isEditMode: isEditMode)
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
            .navigationTitle(isEditMode ? "Edit Chores" : "Chores")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button(isEditMode ? "Done" : "Edit") {
                        isEditMode.toggle()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Add Chore") {
                        showingAddChore = true
                    }
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

