//
//  HomeWeatherCellTableViewCell.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/14/22.
//

import UIKit

class HomeWeatherCellTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLb: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var minTempLb: UILabel!
    @IBOutlet weak var macTempLb: UILabel!
    
    public func configuration(day: String , main : String, min : String , max : String) {
        dayLb.text = day
        mainImg.image = UIImage(named: main)
        minTempLb.text = min
        macTempLb.text = max
    }
   
}
