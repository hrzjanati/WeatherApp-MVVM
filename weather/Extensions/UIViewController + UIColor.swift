//
//  UIViewController + UIColor.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/24/22.
//

import Foundation
import UIKit

extension UIViewController {
    func setColor(status : String)-> UIColor {
        var colors : UIColor = .black
        if status == "MaxTemp" {
            colors = .red
        }
        else if status == "MinTemp" {
            colors = .blue
        }
        else if status == "Sunrise" {
            colors = .systemYellow
        }
        else if status == "Sunset" {
            colors = .orange
        }
        else if status == "Moonrise" {
            colors = .gray
        }
        else if status == "Moonset" {
            colors = .lightGray
        }
       return colors
    }
    
}
