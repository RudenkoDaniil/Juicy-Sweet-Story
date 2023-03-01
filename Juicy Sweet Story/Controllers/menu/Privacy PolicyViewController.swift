//
//  Privacy PolicyViewController.swift
//  Juicy Sweet Story
//
//  Created by Даниил on 26.02.2023.
//

import UIKit

class Privacy_PolicyViewController: UIViewController {
    // MARK: - properties
    private let ImageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "rulesBackGround")
        return iv
    }()
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
    private var privacyPolicyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Knewave-Regular", size: 16)
        textView.textAlignment = .center
        textView.textColor = .white
        textView.isEditable = false
        textView.backgroundColor = nil
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = """
                Privacy Policy for Puzzle iOS Game
                
                At Juicy Sweet Story, we are committed to protecting the privacy of our users. This privacy policy outlines how we collect, use, and protect the personal information that you provide to us.
                
                Information We Collect
                
                We do not collect any personal information from users who play our puzzle game. However, we may collect non-personal information such as the number of puzzles completed, the time taken to complete each puzzle. This information is stored locally on your device using Swift User Defaults.
                
                How We Use Your Information
                
                We do not share any of your information with third parties. The non-personal information that we collect is solely used to improve the game and enhance the user experience.
                
                Data Security
                
                We take data security seriously and have implemented appropriate technical and organizational measures to protect against unauthorized access, loss, misuse, or alteration of the information that we collect.
                
                Children's Privacy
                
                Our game is intended for general audiences and does not knowingly collect any personal information from children under the age of 13. If you are a parent or guardian and believe that your child has provided us with personal information, please contact us immediately.
                
                Changes to this Privacy Policy
                
                We reserve the right to update this privacy policy from time to time. We encourage you to review this page periodically for any changes. Your continued use of the game after any modifications to the policy will constitute your acceptance of the new policy.
                
                Contact Us
                
                If you have any questions or concerns about this privacy policy, please contact us at [Email Address].
            """
        return textView
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
        view.addSubview(privacyPolicyTextView)
        view.addSubview(backButton)
    }
    private func viewsAutoLayout(){
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 70, height: 70)
        privacyPolicyTextView.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 15, paddingBottom: 80, paddingRight: 20, width: 0, height: 0)
    }
}
