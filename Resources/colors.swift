//
//  File.swift
//  Juicy Sweet Story
//
//  Created by Даниил on 24.02.2023.
//

import Foundation
import UIKit

extension UIColor {
    static let pink = UIColorFromRGB(0xFF32D0)
    static let purple1 = UIColorFromRGB(0xAD1B8D)
    static let purple2 = UIColorFromRGB(0xA50081)

    static func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
    }
}
