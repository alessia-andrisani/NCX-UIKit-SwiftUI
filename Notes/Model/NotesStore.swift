//
//  NotesStore.swift
//  Notes
//
//  Created by Alessia Andrisani on 31/03/22.
//

import Foundation

class NotesStore: ObservableObject {
	@Published var notes: [Note] = []
}
