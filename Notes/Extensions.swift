//
//  Extensions.swift
//  Notes
//
//  Created by Alessia Andrisani on 31/03/22.
//

import Foundation

extension Date {
	var formattedDateInString: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		return dateFormatter.string(from: self as Date)
	}
}
