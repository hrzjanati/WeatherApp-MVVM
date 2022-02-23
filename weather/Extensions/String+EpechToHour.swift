//
//  String+EpechToHour.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/23/22.
//

import Foundation

extension String {
    func convertEpechToHour() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: Double(self)!))
        return dateString
    }
}

