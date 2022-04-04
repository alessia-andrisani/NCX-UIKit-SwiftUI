//
//  ContentView.swift
//  Notes
//
//  Created by Alessia Andrisani on 31/03/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var notesStore = NotesStore()
    
    @State private var showModal = false
    var body: some View {
        NavigationView {
            
            List {
                
                Section {
                    ForEach(notesStore.notes) { note in
                        
                        ZStack{
                            NavigationLink { NoteDetailView(noteStore: notesStore, note: note) } label: {
                                EmptyView()
                            }.opacity(0)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(note.title)
                                        .font(.title3)
                                        .bold()
                                        .lineLimit(1)
                                    Spacer()
                                    Text(note.date.formattedDateInString)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    
                                }.padding(.bottom, 0.5)
                                Text(note.text)
                                    .font(.subheadline)
                                    .lineLimit(2)
                                    .frame(maxHeight: .infinity)
                                
                            }.padding(.vertical, 4)
                            
                        }
                        
                    }
                    .onDelete(perform: deleteNote)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showModal = true
                        
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
            }
            .navigationTitle("Notes")
        }
        
        .sheet(isPresented: $showModal) {
            AddNoteView(noteStore: notesStore, showingModal: $showModal)
        }
    }
    func deleteNote( at offsets: IndexSet) {
        notesStore.notes.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
