//
//  FeedCollectionCell.swift
//  SocketIoRealmSample
//
//  Created by Abdelhak Jemaii on 30/03/2017.
//  Copyright © 2017 Abdelhak Jemaii. All rights reserved.
//

import UIKit

class FeedCollectionCell: UICollectionViewCell {
    
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)

        
        self.addSubview(title)
        title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        title.widthAnchor.constraint(equalTo: self.widthAnchor , multiplier : 0.9).isActive = true
        title.heightAnchor.constraint(equalTo: self.heightAnchor , multiplier : 0.5).isActive = true
        //
        self.addSubview(label)
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier : 0.9).isActive = true
        
        self.layer.cornerRadius = 10

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIView {
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
    }

}
