//
//  Structchingi.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/15/22.
//

import Foundation
import UIKit

class StretchyTableHeaderView: UIView {
    
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    private var containerView: UIView!
    
    public var locationLabel: UILabel!
    public var tempLabel : UILabel!
    public var descrebtionLabel : UILabel!
    
    public var imageView : UIImageView!
    
    private var containerViewHeight = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setViewConstraints()
        locationLabel =  setupLabel(cgrect: CGRect(x: 0,
                                                           y: 0,
                                                           width: self.frame.size.width,
                                                   height: self.frame.size.height / 5) , font: UIFont(name: "HelveticaNeue", size: 30)!)
        tempLabel = setupLabel(cgrect: CGRect(x: 0,
                                                      y: 20 + locationLabel.frame.size.height,
                                                      width: self.frame.size.width,
                                                      height: self.frame.size.height / 3), font: UIFont(name: "HelveticaNeue-Bold", size: 60)!)
        
      descrebtionLabel = setupLabel(cgrect: CGRect(x: 0,
                                                   y: 20 + tempLabel.frame.size.height + locationLabel.frame.size.height,
                                                   width: self.frame.size.width,
                                                   height: self.frame.size.height / 5), font: UIFont(name: "HelveticaNeue", size: 28)!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func setupLabel(cgrect : CGRect , font : UIFont)-> UILabel {
        let label = UILabel(frame: cgrect )
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = font
        label.textColor = .blue
        label.clipsToBounds = true
        label.backgroundColor = .clear
        label.contentMode = .scaleAspectFill
        containerView.addSubview(label)
        return label
    }
    
    private func createViews() {
        // Container View
        containerView = UIView()
        self.addSubview(containerView)
        // ImageView for background
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        containerView.addSubview(imageView)
    }
    
    private func setViewConstraints() {
        // UIView Constraints
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            self.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        // Container View Constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        // ImageView Constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
