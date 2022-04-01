//
//  AlertControllerView.swift
//  Notes
//
//  Created by Alessia Andrisani on 31/03/22.
//

import SwiftUI

struct AlertControllerView: UIViewControllerRepresentable {
	
	@ObservedObject var noteStore: NotesStore
	
	@Binding var text: String
	
	
	@Binding var textfieldText: String
	@Binding var showingAlert: Bool
	
	@Binding var showingModal: Bool
	
	var alertTitle: String
	var alertMessage: String
	
	
	func makeCoordinator() -> AlertControllerView.Coordinator {
		Coordinator(self)
	}
	
	class Coordinator: NSObject, UITextFieldDelegate {
		var alert: UIAlertController?
		
		var control: AlertControllerView
		init(_ control: AlertControllerView) {
			self.control = control
		}
		

		func textFieldDidChangeSelection(_ textField: UITextField) {
			control.textfieldText = textField.text ?? ""
		}
	}
	
	func makeUIViewController(context: Context) -> UIViewController {
		return UIViewController()
	}
	
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
		
		if self.showingAlert {
			let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
			context.coordinator.alert = alert
			
			
			alert.addTextField { textField in
				textField.placeholder = "Enter some text"
				textField.text = self.textfieldText
				textField.delegate = context.coordinator
				
			}
			
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
			
			DispatchQueue.main.async {
				uiViewController.present(alert, animated: true, completion: {
					self.showingAlert = false
				})
			}
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
	
	
	
}

//struct AlertControllerView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlertControllerView()
//    }
//}
