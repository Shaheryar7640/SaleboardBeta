//
//  DesignableImage.swift
//  FlairPit
//
//  Created by Haseeb Saad on 09/03/2017.
//  Copyright © 2017 Haseeb Saad. All rights reserved.
//

import UIKit

@IBDesignable class DesignableImage: UIImageView {
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.size.width / 2
                self.clipsToBounds = true
            } else {
                self.clipsToBounds = false
            }
        }
    }
}


