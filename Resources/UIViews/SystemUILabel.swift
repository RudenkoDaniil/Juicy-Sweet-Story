//
//  SystemUILabel.swift
//  Juicy Sweet Story
//
//  Created by Даниил on 27.02.2023.
//

import Foundation
import UIKit

class SystemLabbel: UIView {
    let numberLabel = UILabel()
    var textToSet: String = "" { didSet {
        let customFont = UIFont(name: "Knewave-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)
        let attributedText = NSMutableAttributedString(string: textToSet)
        attributedText.addAttribute(.strokeColor, value: UIColor.purple1, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.strokeWidth, value: -7.0, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.font, value: customFont, range: NSRange(location: 0, length: attributedText.length))
        numberLabel.attributedText = attributedText
        
    }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    private func setupUI() {
        backgroundColor = .clear
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.textAlignment = .center
        addSubview(numberLabel)
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: layer.cornerRadius)
        UIColor.white.setFill()
        path.fill()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 25
        layer.borderWidth = 3
        layer.borderColor = UIColor.purple1.cgColor
    }
}
