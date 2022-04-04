//
//  AlertControllerView.swift
//  Notes
//
//  Created by Alessia Andrisani on 31/03/22.
//

import SwiftUI

struct AlertControllerView: UIViewControllerRepresentable {
	
	@ObservedObject var noteStore: NotesStore
	
	//Binding to TextEditor in ContentView
	@Binding var text: String
	
	//Binding to AddNoteView
	@Binding var showingModal: Bool
	
	
	//Alert
	@Binding var textfieldText: String
	@Binding var showingAlert: Bool
	
	var alertTitle: String
	var alertMessage: String
	//
	
	// A Coordinator class will coordinate our View Controller to the SwiftUI view giving us the ability to respond to changes
	func makeCoordinator() -> AlertControllerView.Coordinator {
		Coordinator(self)
	}
	
	class Coordinator: NSObject, UITextFieldDelegate {
		var alert: UIAlertController?
		
		var control: AlertControllerView
		init(_ control: AlertControllerView) {
			self.control = control
		}
		
		// This function links the TextField to the binding variable textFieldText
		func textFieldDidChangeSelection(_ textField: UITextField) {
			control.textfieldText = textField.text ?? ""
		}
	}
	
	//Creates the UIViewController
	func makeUIViewController(context: Context) -> UIViewController {
		return UIViewController()
	}
	
	// Sends data from SwiftUI to UIKit
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
		
		//Logic implementation for the alert
		if self.showingAlert {
			let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
			context.coordinator.alert = alert
			
			//Adding the textField to the alert
			alert.addTextField { textField in
				textField.placeholder = "Enter some text"
				textField.text = self.textfieldText
				textField.delegate = context.coordinator
				
			}
			
			//Adding actions for the buttons
			alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { _ in
				
				self.textfieldText = ""
			})
			
			alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { _ in
				if let textField = alert.textFields?.first, let text = textField.text {
					self.textfieldText = text
				}
				showingModal = false
				
				let newNote = Note(title: textfieldText, text: text, date: Date.now)
				
				noteStore.notes.append(newNote)
			})
			//
			
			// Presents the Alert and dismisses it on completion
			DispatchQueue.main.async {
				uiViewController.present(alert, animated: true, completion: {
					self.showingAlert = false
				})
			}
		}
	}
}

