//
//  String+Ext.swift
//  GHBook
//
//  Created by Basem Elkady on 4/7/25.
//

import Foundation

extension String {
    
    // MARK: - Date Formatting
    
    /// Converts an ISO8601 date string (e.g. "2021-04-07T12:34:56Z") to a formatted string like "Apr 2021"
    func formatToGFDate() -> String? {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime]
        
        // Parse the ISO date string to a Date object
        guard let date = isoDateFormatter.date(from: self) else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"  // Format to display Month and Year
        
        return dateFormatter.string(from: date)
    }
}
