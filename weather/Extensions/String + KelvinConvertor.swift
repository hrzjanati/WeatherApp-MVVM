//
//  String + KelvinConvertor.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/14/22.
//

import Foundation

extension String {
    func KelvinToC() -> String {
        let rtString = Double(self)! - 273.15
        return "\(Int(rtString))"
    }
    
}
