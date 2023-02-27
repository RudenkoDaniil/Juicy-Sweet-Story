//
//  ActualGradientButton2.swift
//  Juicy Sweet Story
//
//  Created by Даниил on 27.02.2023.
//

import Foundation
import UIKit

class ActualGradientButton2: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        self.titleLabel?.font = UIFont(name: "Knewave-Regular", size: 35)
        self.setTitleColor(UIColor.white, for: .normal)
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [UIColor.UIColorFromRGB(0xFF32D0).cgColor,
                    UIColor.UIColorFromRGB(0xAD1B8D).cgColor,
                    UIColor.UIColorFromRGB(0xA50081).cgColor]
        l.startPoint = CGPoint(x: 0, y: 0)
        l.endPoint = CGPoint(x: 1, y: 1)
        l.cornerRadius = 25
        layer.insertSublayer(l, at: 0)
        layer.cornerRadius = 25
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 5
        return l
    }()
}
