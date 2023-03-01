//
//  GameViewController.swift
//  Juicy Sweet Story
//
//  Created by Даниил on 24.02.2023.
//

import UIKit

class GameViewController: UIViewController {
    // MARK: - properties
    private let ImageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "background")
        return iv
    }()
    lazy var playButton: ActualGradientButton2 = {
        let button = ActualGradientButton2(type: .system)
        button.addTarget(self, action: #selector(PuzzleHandler), for: .touchUpInside)
        button.setTitle("Play", for: .normal)
        return button
    }()
    lazy var rulesButton: ActualGradientButton2 = {
        let button = ActualGradientButton2(type: .system)
        button.setTitle("Game Rules", for: .normal)
        button.addTarget(self, action: #selector(pressentRulles), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    lazy var settingsButton: ActualGradientButton2 = {
        let button = ActualGradientButton2(type: .system)
        button.setTitle("Settings", for: .normal)
        button.addTarget(self, action: #selector(pressentSettings), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    lazy var privacyPolicyButton: UIButton = {
        let button = ActualGradientButton2(type: .system)
        button.setTitle("Privacy Policy", for: .normal)
        button.addTarget(self, action: #selector(pressentPrivacy), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
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
        view.addSubview(playButton)
        view.addSubview(rulesButton)
        view.addSubview(settingsButton)
        view.addSubview(privacyPolicyButton)
    }
    private func viewsAutoLayout(){
        rulesButton.translatesAutoresizingMaskIntoConstraints = false
        rulesButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        rulesButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        rulesButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        rulesButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        playButton.anchor(top: nil, left: view.leftAnchor, bottom: rulesButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, width: 0, height: 70)
        settingsButton.anchor(top: rulesButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 70)
        privacyPolicyButton.anchor(top: settingsButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 70)
    }
    // MARK: - @objc
    @objc func pressentRulles(){
        let vc = RulesViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    @objc func PuzzleHandler(){
        let vc = ChooseLVLViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    @objc func pressentPrivacy(){
        let vc = Privacy_PolicyViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    @objc func pressentSettings(){
        let vc = SettingsViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
}
