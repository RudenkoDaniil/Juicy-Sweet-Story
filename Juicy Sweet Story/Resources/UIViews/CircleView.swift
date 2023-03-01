//
//  CircleView.swift
//  Juicy Sweet Story
//
//  Created by Даниил on 27.02.2023.
//

import Foundation
import UIKit

class CircleView: UIView {
    let numberLabel = UILabel()
    
    var number: Int = 0 {
        didSet {
            numberLabel.text = "\(number)"
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
        // Configure circle view
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.borderColor = UIColor.purple1.cgColor
        
        // Configure number label
        let customFont = UIFont(name: "Knewave-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
        let attributedText = NSMutableAttributedString(string: numberLabel.text ?? "\(number)")
        attributedText.addAttribute(.strokeColor, value: UIColor.purple1, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.strokeWidth, value: -5.0, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.font, value: customFont, range: NSRange(location: 0, length: attributedText.length))
        numberLabel.attributedText = attributedText
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.textAlignment = .center
        addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.white.setFill()
        path.fill()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
}

