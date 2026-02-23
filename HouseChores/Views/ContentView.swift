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
    @State var choreToDelete: Chore?
    @State var showingDeleteConfirmation = false
    @GestureState private var isPressed = false
    
    var body: some View {
        NavigationStack {
            Group {
                if store.chores.isEmpty {
                    ContentUnavailableView(
                        "No Chores Yet",
                        systemImage: "checkmark.circle",
                        description: Text("Tap + to add your first chore.")
                    )
                } else {
                    List(store.sortedChores) { chore in
                        Button(action: {
                            if isEditMode {
                                // In edit mode, tap opens edit sheet
                                choreToEdit = chore
                            } else {
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()
                                
                                // In normal mode, tap marks as done
                                store.markAsDone(id: chore.id)
                            }
                        }) {
                            ChoreRow(chore: chore, store: store, isEditMode: isEditMode)
                        }
                        .buttonStyle(.plain)
                        .scaleEffect(isPressed ? 0.95 : 1.0)
                        .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .updating($isPressed) { _, state, _ in
                                            state = true
                                        }
                                )
                        .scrollContentBackground(isEditMode ? .hidden : .visible)
                        .background(isEditMode ? Color.orange.opacity(0.1) : Color.clear)
                        .animation(.easeInOut(duration: 0.3), value: isEditMode)
                        .swipeActions(edge: .trailing){
                            Button(role: .destructive){
                                choreToDelete = chore
                                showingDeleteConfirmation = true
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
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        isEditMode.toggle()
                    }) {
                        Image(systemName: isEditMode ? "checkmark" : "pencil")
                    }
                }
                ToolbarItem(placement: .principal){
                    Text(isEditMode ? "Edit Chores" : "Chores")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        showingAddChore = true
                    }){
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddChore) {
                AddChoreView(store: store)
            }
            .sheet(item: $choreToEdit) { chore in
                EditChoreView(store: store, chore: chore)
            }
            .alert("Delete Chore?", isPresented: $showingDeleteConfirmation, presenting: choreToDelete) { chore in
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.warning)
                    
                    store.deleteChore(id: chore.id)
                }
            } message: { chore in
                Text("Are you sure you want to delete '\(chore.name)'?")
            }
        }
    }
}



#Preview {
    ContentView()
}

