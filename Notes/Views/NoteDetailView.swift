//
//  NoteDetailView.swift
//  Notes
//
//  Created by Alessia Andrisani on 31/03/22.
//

import SwiftUI

// In this view we show the details of a note and we can modify it
struct NoteDetailView: View {
    
    @ObservedObject var noteStore: NotesStore
    
    var note: Note
    
	// We find the index of the note we're passing in the array
    var noteIndex: Int {
        let index = noteStore.notes.firstIndex(where: { $0.id == note.id})!
        
        return index
    }
    
    //TextEditor
    @State private var text = ""
    @FocusState private var isFocused: Bool
    
	// Tracks if we are editing the note or not
    @State private var isEditing = false
    
    var body: some View {
        
        VStack {
            // If we are in Edit Mode we show the TextEditor otherwise we'll show a text
            if isEditing {
                TextEditor(text: $text)
                    .focused($isFocused)
                    .frame(maxWidth: UIScreen.main.bounds.width/1.10, maxHeight: .infinity)
                    .padding(4)
            } else {
                Text(note.text)
                    .frame(maxWidth: UIScreen.main.bounds.width/1.10, maxHeight: .infinity, alignment: .topLeading)
                    .padding(4)
                
            }
        } //We set the value of the State var to the content of the note we are passing
        .onAppear(perform: {
            text = note.text
        })
        .navigationTitle(note.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                if !isEditing{
                    Button("Edit") {
                        isEditing.toggle()
                    }
                } else {
                    Button("Done") {
                        isEditing.toggle()
						// We update the note with the modified text
                        noteStore.notes[noteIndex].text = text
                    }
                }
            }
        }
    }
}

struct NoteDetailView_Previews: PreviewProvider {
	static var previews: some View {
		NoteDetailView(noteStore: NotesStore(), note: .exampleNote)
	}
}
