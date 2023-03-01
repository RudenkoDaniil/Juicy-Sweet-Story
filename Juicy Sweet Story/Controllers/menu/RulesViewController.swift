//
//  RulesViewController.swift
//  Juicy Sweet Story
//
//  Created by Даниил on 24.02.2023.
//

import UIKit

class RulesViewController: UIViewController {
    // MARK: - properties
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "Vector (1)").withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
        button.backgroundColor = .white
        button.layer.cornerRadius = 70/2
        button.layer.borderColor = UIColor.pink.cgColor
        button.layer.borderWidth = 5
        button.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        return button
    }()
    private let ImageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "rulesBackGround")
        return iv
    }()
    private let lablelMain: UILabel = {
        let label = UILabel()
        let customFont = UIFont(name: "Knewave-Regular", size: 45) ?? UIFont.systemFont(ofSize: 45)
        let attributedText = NSMutableAttributedString(string: label.text ?? " GAME RULES ")
        attributedText.addAttribute(.strokeColor, value: UIColor.pink, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.strokeWidth, value: -7, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.font, value: customFont, range: NSRange(location: 0, length: attributedText.length))
        label.attributedText = attributedText
        return label
    }()
    private let WelcomeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let customFont = UIFont(name: "Knewave-Regular", size: 35) ?? UIFont.systemFont(ofSize: 35)
        let attributedText = NSMutableAttributedString(string: label.text ?? "Welcome to Juicy Sweet Story!")
        attributedText.addAttribute(.strokeColor, value: UIColor.pink, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.strokeWidth, value: -7, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.font, value: customFont, range: NSRange(location: 0, length: attributedText.length))
        label.attributedText = attributedText
        return label
    }()
    private let descriptionLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let customFont = UIFont(name: "Knewave-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)
        let attributedText = NSMutableAttributedString(string: label.text ??
        """
                                                       Explore every of 12 levels, move puzzles to create the same picture as in example.
                                                       Each level have time limitation on pass it, and it's time will decrease in each level.
                                                       If you loose - you can try to pass level again.
                                                       If you win - you can pass the next level.
        """)
        attributedText.addAttribute(.strokeColor, value: UIColor.white, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.font, value: customFont, range: NSRange(location: 0, length: attributedText.length))
        label.attributedText = attributedText
        label.textAlignment = .center
        return label
    }()
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewsAutoLayout()
    }
    // MARK: - Handlers
    private func configureView(){
        view.addSubview(ImageView)
        view.sendSubviewToBack(ImageView)
        view.addSubview(backButton)
        view.addSubview(lablelMain)
        view.addSubview(WelcomeLabel)
        view.addSubview(descriptionLable)
    }
    private func viewsAutoLayout(){
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 70, height: 70)
        lablelMain.anchor(top: view.topAnchor, left: backButton.rightAnchor, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        WelcomeLabel.anchor(top: lablelMain.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 0)
        descriptionLable.anchor(top: WelcomeLabel.bottomAnchor, left: WelcomeLabel.leftAnchor, bottom: nil, right: WelcomeLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
