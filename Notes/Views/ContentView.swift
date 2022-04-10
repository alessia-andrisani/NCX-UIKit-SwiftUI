//
//  ContentView.swift
//  Notes
//
//  Created by Alessia Andrisani on 31/03/22.
//

import SwiftUI

//This is the main View of the App

struct ContentView: View {
    
	//Creates an instance of NotesStore with the array of notes inside
    @StateObject var notesStore = NotesStore()
    
	// Tracks whether we're showing AddNoteView or not
    @State private var showModal = false
    var body: some View {
        NavigationView {
            
			//Create the list from the array in notesStore
            List {
                
                Section {
                    ForEach(notesStore.notes) { note in
                        
                        ZStack{
                            NavigationLink { NoteDetailView(noteStore: notesStore, note: note) } label: {
                                EmptyView()
                            }.opacity(0)   //To hide the > symbol of Navigation Link
                            
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
                                    .lineLimit(1)
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
        //Shows AddNoteView
        .sheet(isPresented: $showModal) {
            AddNoteView(noteStore: notesStore, showingModal: $showModal)
        }
    }
	//Function to delete the notes from the list
    func deleteNote( at offsets: IndexSet) {
        notesStore.notes.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
