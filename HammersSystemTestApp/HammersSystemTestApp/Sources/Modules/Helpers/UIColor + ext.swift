//
//  UIColor + ext.swift
//  HammersSystemTestApp
//
//  Created by Намик on 10/19/22.
//

import UIKit

extension UIColor {
    static func color(red: CGFloat,
                    green: CGFloat,
                      blue: CGFloat,
                      alpha: CGFloat) -> UIColor {
        
        return UIColor(red: red,
                       green: green,
                       blue: blue,
                       alpha: alpha)
    }

    static let standardPink = UIColor.color(red: 0.99,
                                            green: 0.23,
                                            blue: 0.41,
                                            alpha: 1)
    
    static let lightPink = UIColor.color(red: 0.99,
                                         green: 0.23,
                                         blue: 0.41,
                                         alpha: 0.4)
    
    static let categoryBackgroundColor = UIColor.color(red: 0.99,
                                                       green: 0.23,
                                                       blue: 0.41,
                                                       alpha: 0.2)
    static let borderColor = UIColor.color(red: 0.992,
                                           green: 0.227,
                                           blue: 0.412,
                                           alpha: 1).cgColor
}
