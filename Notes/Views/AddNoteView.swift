//
//  AddNoteView.swift
//  Notes
//
//  Created by Alessia Andrisani on 31/03/22.
//

import SwiftUI

struct AddNoteView: View {
	
	@ObservedObject var noteStore: NotesStore
	
	//TextEditor
	@State private var text = ""
	@FocusState private var isFocused: Bool
	
	@Binding var showingModal: Bool
	
	//	@Environment (\.dismiss) var dismiss
	
	//Alert
	@State private var showingAlert = false
	@State private var textString = ""
	
	var body: some View {
		NavigationView {
			
			ZStack {
				
				AlertControllerView(noteStore: noteStore, text: $text, textString: $textString, showAlert: $showingAlert, showingModal: $showingModal, title: "New Note", message: "Write a title for this note.")
				
				VStack {
				
				TextEditor(text: $text)
					.focused($isFocused)
					.frame(maxWidth: UIScreen.main.bounds.width/1.10, maxHeight: .infinity)
					.padding(4)
					

				}
				
				.frame(maxWidth: UIScreen.main.bounds.width / 1.07 ,maxHeight: UIScreen.main.bounds.height/1.15)
					.background(.white)
					.cornerRadius(15)
	
			}
			
			.navigationTitle("New Note")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button("Done") {
						
						showingAlert = true

						
					}
				}
				ToolbarItem(placement: .navigationBarLeading) {
				Button("Cancel", role: .destructive) {
					showingModal = false
				}
				}
			}
			.background(Color(uiColor: .systemGroupedBackground))
			
		}
		
	}
}

struct AddNoteView_Previews: PreviewProvider {
	static var previews: some View {
		AddNoteView(noteStore: NotesStore(), showingModal: .constant(false))
	}
}
