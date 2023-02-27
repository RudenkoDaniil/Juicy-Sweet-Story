//
//  EndLVLViewController.swift
//  Juicy Sweet Story
//
//  Created by Даниил on 25.02.2023.
//

import UIKit

class EndLVLViewController: UIViewController {
    //MARK: - properties
    public var result: Bool = false
    public var completion: ((Int) -> (Void))?
    public var timerLabel = SystemLabbel()
    private var bestTimeLabel = SystemLabbel()
    public var progress: Int = 1
    //MARK: - UIViews
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    lazy var menuButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "house").withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .purple1
        button.imageView?.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
        button.backgroundColor = .white
        button.layer.cornerRadius = 50/2
        button.layer.borderColor = UIColor.purple1.cgColor
        button.layer.borderWidth = 3
        button.tag = 0
        button.addTarget(self, action: #selector(handlerButton), for: .touchUpInside)
        return button
    }()
    lazy var replayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "reload").withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .purple1
        button.imageView?.layer.transform = CATransform3DMakeScale(0.6, 0.6, 0.6)
        button.backgroundColor = .white
        button.layer.cornerRadius = 60/2
        button.layer.borderColor = UIColor.purple1.cgColor
        button.layer.borderWidth = 3
        button.tag = 1
        button.addTarget(self, action: #selector(handlerButton), for: .touchUpInside)
        return button
    }()
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "forvard").withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
        button.backgroundColor = .white
        button.layer.cornerRadius = 50/2
        button.layer.borderColor = UIColor.purple1.cgColor
        button.layer.borderWidth = 3
        button.tag = 2
        button.addTarget(self, action: #selector(handlerButton), for: .touchUpInside)
        return button
    }()
    
    private let lablelMain: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    private let lablelSecond: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    //MARK: - handlers
    private func configureView(){
        view.addSubview(menuButton)
        view.addSubview(replayButton)
        view.addSubview(nextButton)
        view.addSubview(timerLabel)
        view.addSubview(logoImageView)
        view.addSubview(lablelMain)
        view.addSubview(lablelSecond)
        viewsAutoLayout()
        if result == false {
            nextButton.isEnabled = false
            nextButton.layer.borderColor = UIColor.systemGray.cgColor
            let image = #imageLiteral(resourceName: "disabledForvard").withRenderingMode(.alwaysOriginal)
            nextButton.setImage(image, for: .normal)
            timerLabel.textToSet = " 0:00 "
            timerLabel.anchor(top: nil, left: view.leftAnchor, bottom: replayButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 30, paddingRight: 30, width: 0, height: 60)
            
            let customFont = UIFont(name: "Knewave-Regular", size: 65) ?? UIFont.systemFont(ofSize: 65)
            let text = " LEVEL \n FAILED  "
            lablelMain.font = customFont
            lablelMain.textAlignment = .center
            lablelMain.numberOfLines = 2
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(.strokeColor, value: UIColor.pink, range: NSRange(location: 0, length: text.count))
            attributedText.addAttribute(.strokeWidth, value: -20, range: NSRange(location: 0, length: text.count))
            attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: text.count))
            lablelMain.attributedText = attributedText
            lablelSecond.text = text
            logoImageView.image = #imageLiteral(resourceName: "failed")
            lablelSecond.text = text
            lablelSecond.font = customFont
            lablelSecond.textColor = .white
        }
        else {
            let bestTime = UserDefaults.standard.value(forKey: "lvlResult\(progress)") as? Int ?? 1
            let (minutes, remainingSeconds) = convertSecondsToMinutesAndSeconds(seconds: bestTime)
            let timeString = String(format: "%02d:%02d", minutes, remainingSeconds)
            bestTimeLabel.textToSet = timeString
            view.addSubview(bestTimeLabel)
            bestTimeLabel.anchor(top: nil, left: view.leftAnchor, bottom: replayButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 15, paddingRight: 30, width: 0, height: 60)
            timerLabel.anchor(top: nil, left: view.leftAnchor, bottom: bestTimeLabel.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 15, paddingRight: 30, width: 0, height: 60)
            
            let customFont = UIFont(name: "Knewave-Regular", size: 65) ?? UIFont.systemFont(ofSize: 65)
            let text = " LEVEL \n COMPLETED "
            lablelMain.font = customFont
            lablelMain.textAlignment = .center
            lablelMain.numberOfLines = 2
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(.strokeColor, value: UIColor.pink, range: NSRange(location: 0, length: text.count))
            attributedText.addAttribute(.strokeWidth, value: -20, range: NSRange(location: 0, length: text.count))
            attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: text.count))
            lablelMain.attributedText = attributedText
            lablelSecond.text = text
            logoImageView.image = #imageLiteral(resourceName: "completed")
            lablelSecond.text = text
            lablelSecond.font = customFont
            lablelSecond.textColor = .white
            
        }
    }
    private func viewsAutoLayout(){
        replayButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 100, paddingRight: 0, width: 60, height: 60)
        replayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuButton.anchor(top: replayButton.topAnchor, left: nil, bottom: nil, right: replayButton.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 50, height: 50)
        nextButton.anchor(top: replayButton.topAnchor, left: replayButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        lablelMain.anchor(top: nil, left: nil, bottom: timerLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 15, paddingRight: 0, width: 0, height: 0)
        lablelMain.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.anchor(top: nil, left: nil, bottom: lablelMain.firstBaselineAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 385, height: 0)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lablelSecond.anchor(top: nil, left: nil, bottom: timerLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 15, paddingRight: 0, width: 0, height: 0)
        lablelSecond.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    //MARK: - @objc
    @objc func handlerButton(_ sender: UIButton){
        dismiss(animated: true, completion: { [weak self] in
            self?.completion?(sender.tag)
        })
    }
}
