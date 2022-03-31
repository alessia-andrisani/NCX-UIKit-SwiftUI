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
	
	
	@Binding var textString: String
	@Binding var showAlert: Bool
	
	@Binding var showingModal: Bool
	
	var title: String
	var message: String
	
	
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
			control.textString = textField.text ?? ""
		}
	}
	
	func makeUIViewController(context: Context) -> UIViewController {
		return UIViewController()
	}
	
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
		
		
		guard context.coordinator.alert == nil else { return }
		
		if self.showAlert {
			let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
			context.coordinator.alert = alert
			
			
			alert.addTextField { textField in
				textField.placeholder = "Enter some text"
				textField.text = self.textString
				textField.delegate = context.coordinator
				
			}
			
			alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { _ in
				

				alert.dismiss(animated: true) {
					self.showAlert = false
					
					
					//L'ho aggiunta io
					self.textString = ""
					
				}
			})
			
			alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { _ in
				if let textField = alert.textFields?.first, let text = textField.text {
					self.textString = text
					
					
				}
				
				alert.dismiss(animated: true) {
					self.showAlert = false
					showingModal = false
					
					let newNote = Note(title: textString, text: text, date: Date.now)
					
					noteStore.notes.append(newNote)
					
				}
				
			})
			
			DispatchQueue.main.async {
				uiViewController.present(alert, animated: true, completion: {
					self.showAlert = false
					context.coordinator.alert = nil
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
