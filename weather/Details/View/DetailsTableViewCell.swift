//
//  DetailsTableViewCell.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/23/22.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!

    public func configuration(title : String , imageName : String , color : UIColor) {
        titleLabel.textColor = color
        titleLabel.text = title
        iconImage.image = UIImage(named: imageName)
    }
}
