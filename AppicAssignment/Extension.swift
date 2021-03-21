//
//  Extension.swift
//  AppicAssignment
//
//  Created by Dinesh Tanwar on 20/03/21.
//

import Foundation
import UIKit

extension UIButton {
     func addLeftPadding(_ padding: CGFloat) {
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: padding, bottom: 0.0, right: -padding)
        contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: padding)
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let blueLight = UIColor.rgb(red: 29, green: 161, blue: 242)
}
