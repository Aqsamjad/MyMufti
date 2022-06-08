//
//  DateManager.swift
//  myMufti
//
//  Created by Qazi on 28/03/2022.
//

import Foundation

class DateManager {
    static let standard = DateManager()
    
    func getDateFrom(stringDate: String) -> Date {
        let created_at = stringDate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: created_at) ?? Date()
    }
}
