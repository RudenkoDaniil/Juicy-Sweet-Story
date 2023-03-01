//
//  stateButton.swift
//  Juicy Sweet Story
//
//  Created by Даниил on 27.02.2023.
//

import Foundation
import UIKit

class stateButton: UIButton {
    // Properties for button images
    private var image1: UIImage?
    private var image2: UIImage?
    
    // Property to track which image is currently displayed
    private var isImage1Shown = true {
        didSet {
            setBackgroundImage(isImage1Shown ? image1 : image2, for: .normal)
        }
    }
    
    // Closure handler for button click event
    var onClick: (() -> Void)?
    
    init(frame: CGRect, image1: UIImage?, image2: UIImage?) {
        super.init(frame: frame)
        self.image1 = image1
        self.image2 = image2
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        // Set initial button image
        setBackgroundImage(image1, for: .normal)
        
        // Remove default button styling
        adjustsImageWhenHighlighted = false
        adjustsImageWhenDisabled = false
        tintColor = .clear
        
        // Add click event
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    @objc private func buttonClicked() {
        isImage1Shown = !isImage1Shown
        onClick?()
    }
}
