//
//  Note.swift
//  Notes
//
//  Created by Alessia Andrisani on 31/03/22.
//

import Foundation

struct Note: Identifiable {
	let id = UUID()
	var title: String
	var text: String
	var date: Date
	
}
