//
//  Extensions.swift
//  myMufti
//
//  Created by Qazi on 28/03/2022.
//

import Foundation


// MARK: - Date Extensions
extension Date {
    func timeAgoDisplay() -> String {
            let calendar = Calendar.current
            let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
            let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
            let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
            let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!

            if minuteAgo < self {
                let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
                print(minuteAgo)
                return "\(diff) sec ago"
            } else if hourAgo < self {
                let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
                print(hourAgo)
                return "\(diff) min ago"
            } else if dayAgo < self {
                let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
                print(dayAgo)
                return "\(diff) hrs ago"
            } else if weekAgo < self {
                let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
                print(weekAgo)
                return "\(diff) days ago"
            }
            let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
        print(diff)
            return "\(diff) weeks ago"
        }
}
