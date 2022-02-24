//
//  UIViewcontroller+SuffixString.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/24/22.
//

import Foundation
import UIKit

extension UIViewController {
    func suffixString(status : String)-> String {
        var Str : String?
        if status == "MaxTemp" {
            Str = "°▲"
        }
        else if status == "MinTemp" {
            Str = "°▼"
        }
        else if status == "Sunrise" {
            Str = " H"
        }
        else if status == "Sunset" {
            Str = " H"
        }
        else if status == "Moonrise" {
            Str = " H"
        }
        else if status == "Moonset" {
            Str = " H"
        }
        return Str!
    }
    
}
