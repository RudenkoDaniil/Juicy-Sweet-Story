//
//  SettingsViewController.swift
//  Juicy Sweet Story
//
//  Created by Даниил on 26.02.2023.
//

import UIKit
import StoreKit
class SettingsViewController: UIViewController {
    // MARK: - Properties
    private var soundState = UserDefaults.standard.value(forKey: "soundButton") as? Int ?? 1
    private var vibroState = UserDefaults.standard.value(forKey: "vibroButton") as? Int ?? 1
    // MARK: - UIViews
    private let ImageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "rulesBackGround")
        return iv
    }()
    private var SoundLabel: ActualGradientButton2 = {
        let button = ActualGradientButton2(type: .system)
        button.setTitle("SOUND", for: .normal)
        button.isEnabled = false
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    private var VibroLabel: ActualGradientButton2 = {
        let button = ActualGradientButton2(type: .system)
        button.setTitle("VIBRO", for: .normal)
        button.isEnabled = false
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    lazy var rateLabel: ActualGradientButton2 = {
        let button = ActualGradientButton2(type: .system)
        button.setTitle("RATE US", for: .normal)
        button.addTarget(self, action: #selector(pressentRate), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "Vector (1)").withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
        button.backgroundColor = .white
        button.layer.cornerRadius = 70/2
        button.layer.borderColor = UIColor.purple1.cgColor
        button.layer.borderWidth = 5
        button.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        return button
    }()
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfigure()
    }
    // MARK: - Handlers
    private func viewConfigure(){
        view.addSubview(ImageView)
        view.sendSubviewToBack(ImageView)
        view.addSubview(backButton)
        view.addSubview(SoundLabel)
        view.addSubview(VibroLabel)
        view.addSubview(rateLabel)
        var soundImage1: UIImage; var soundImage2: UIImage;
        var vibroImage1: UIImage; var vibroImage2: UIImage;
        if vibroState == 1 { vibroImage1 = #imageLiteral(resourceName: "checked=yes"); vibroImage2 = #imageLiteral(resourceName: "checked=no"); }
        else { vibroImage2 = #imageLiteral(resourceName: "checked=yes"); vibroImage1 = #imageLiteral(resourceName: "checked=no"); }
        
        if soundState == 1 { soundImage1 = #imageLiteral(resourceName: "checked=yes"); soundImage2 = #imageLiteral(resourceName: "checked=no"); }
        else { soundImage2 = #imageLiteral(resourceName: "checked=yes"); soundImage1 = #imageLiteral(resourceName: "checked=no"); }
        let soundButton = stateButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50), image1: soundImage1, image2: soundImage2)
        let vibroButton = stateButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50), image1: vibroImage1, image2: vibroImage2)
        view.addSubview(soundButton)
        view.addSubview(vibroButton)
        vibroButton.onClick = {
            if self.vibroState == 1 {
                self.vibroState = 2
                UserDefaults.standard.set(2, forKey: "vibroButton")
            }
            else {
                self.vibroState = 1
                UserDefaults.standard.set(1, forKey: "vibroButton")
            }
        }
        soundButton.onClick = {
            if self.soundState == 1 {
                self.soundState = 2
                UserDefaults.standard.set(2, forKey: "soundButton")
            }
            else {
                self.soundState = 1
                soundButton.onClick = { UserDefaults.standard.set(1, forKey: "soundButton")
                }
            }
        }
        // MARK: - AutoLayout
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 70, height: 70)
        soundButton.anchor(top: backButton.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 70, height: 70)
        vibroButton.anchor(top: soundButton.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 70, height: 70)
        SoundLabel.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: soundButton.leftAnchor, paddingTop: 40, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 70)
        VibroLabel.anchor(top: SoundLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: vibroButton.leftAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 70)
        rateLabel.anchor(top: VibroLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 70)
    }
    // MARK: - @objc
    @objc func pressentRate(){
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            // Show own review prompt if needed
        }
    }
}
