//
//  String + UpperBound.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/24/22.
//

import Foundation

extension String {
   
    func upperBoundString(_ of : String) -> String {
        var finaly : String?
        if let range = self.range(of: of) {
            let finly = self[range.upperBound...]
            finaly = "\(finly)"
        }
        return finaly!
    }
}
