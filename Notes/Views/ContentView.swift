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
						
						NavigationLink { NoteDetailView(noteStore: notesStore, note: note) } label: {
							
						
						
						VStack(alignment: .leading) {
							HStack {
								Text(note.title)
								Spacer()
								Text(note.date.formattedDateInString)
								
							}
							Text(note.text)
								.lineLimit(2)
								.foregroundColor(.secondary)
								
						}
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
