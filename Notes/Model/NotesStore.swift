//
//  NotesStore.swift
//  Notes
//
//  Created by Alessia Andrisani on 31/03/22.
//

import Foundation

// Class where we create an empty array of Notes. It needs to be ObservableObject in order to share it in the other views as a StateObject. The array needs to be Published in order to update the views when changes occur

class NotesStore: ObservableObject {
	@Published var notes: [Note] = []
}
