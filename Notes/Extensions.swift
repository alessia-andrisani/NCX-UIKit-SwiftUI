//
//  Extensions.swift
//  Notes
//
//  Created by Alessia Andrisani on 31/03/22.
//

import Foundation


// Formats a date in String in order to display it in ContentView

extension Date {
	var formattedDateInString: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		return dateFormatter.string(from: self as Date)
	}
}
