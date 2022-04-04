//
//  NoteDetailView.swift
//  Notes
//
//  Created by Alessia Andrisani on 31/03/22.
//

import SwiftUI

struct NoteDetailView: View {
    
    @ObservedObject var noteStore: NotesStore
    
    var note: Note
    
    var noteIndex: Int {
        let index = noteStore.notes.firstIndex(where: { $0.id == note.id})!
        
        return index
        
    }
    
    //TextEditor
    @State private var text = ""
    @FocusState private var isFocused: Bool
    
    @State private var isEditing = false
    
    var body: some View {
        
        VStack {
            
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
        }
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
