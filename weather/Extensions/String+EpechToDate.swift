//
//  String+EpechToDate.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/14/22.
//

import Foundation

extension String {
    func convertEpechTimeToDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "EEEE"
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: Double(self)!))
        let replce = dateString.replacingOccurrences(of: "Saturday", with: "Sat").replacingOccurrences(of: "Monday", with: "Mon").replacingOccurrences(of: "Tuesday", with: "Tue").replacingOccurrences(of: "Wednesday", with: "Wed").replacingOccurrences(of: "Thursday", with: "Thu").replacingOccurrences(of: "Friday", with: "Fri").replacingOccurrences(of: "Sunday", with: "Sun")
        return replce
    }
}

