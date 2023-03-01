//
//  ChooseLVLViewController.swift
//  Juicy Sweet Story
//
//  Created by Даниил on 24.02.2023.
//

import UIKit

class ChooseLVLViewController: UIViewController {
    // MARK: - Properties
    let array = [#imageLiteral(resourceName: "lvl1"), #imageLiteral(resourceName: "lvl7"), #imageLiteral(resourceName: "lvl6"), #imageLiteral(resourceName: "lvl3"), #imageLiteral(resourceName: "lvl5"), #imageLiteral(resourceName: "lvl11"), #imageLiteral(resourceName: "lvl12"), #imageLiteral(resourceName: "lvl4"), #imageLiteral(resourceName: "lvl8"), #imageLiteral(resourceName: "lvl2"), #imageLiteral(resourceName: "lvl10"), #imageLiteral(resourceName: "lvl5"), ]
    private var progress = UserDefaults.standard.value(forKey: "userProgress") as? Int ?? 1
    // MARK: - UIViews
    private let ImageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "background")
        return iv
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
    private let lablelMain: UILabel = {
        let label = UILabel()
        let customFont = UIFont(name: "Knewave-Regular", size: 45) ?? UIFont.systemFont(ofSize: 45)
        let attributedText = NSMutableAttributedString(string: label.text ?? " LEVEVS ")
        attributedText.addAttribute(.strokeColor, value: UIColor.purple1, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.strokeWidth, value: -10, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.font, value: customFont, range: NSRange(location: 0, length: attributedText.length))
        label.attributedText = attributedText
        return label
    }()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(LVLViewCell.self, forCellWithReuseIdentifier: LVLViewCell.identifier)
        collectionView.backgroundColor = nil
        return collectionView
    }()
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewsAutoLayout()
    }
    // MARK: - configureViews
    private func configureView(){
        view.addSubview(ImageView)
        view.sendSubviewToBack(ImageView)
        view.addSubview(collectionView)
        view.addSubview(backButton)
        view.addSubview(lablelMain)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func viewsAutoLayout(){
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 70, height: 70)
        collectionView.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
        lablelMain.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        lablelMain.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
// MARK: - extencion UICollectionView
extension ChooseLVLViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: LVLViewCell.identifier, for: indexPath) as? LVLViewCell else{
        fatalError()
        }
        cell.label.number = indexPath.row+1
        cell.image.image = array[indexPath.row]
        
        let progress = UserDefaults.standard.value(forKey: "userProgress") as? Int ?? 1
        if indexPath.row+1 > progress {
            cell.contentView.addSubview(cell.darkView)
            cell.darkView.frame = cell.contentView.bounds
            cell.contentView.addSubview(cell.imageCandle)
            cell.imageCandle.contentMode = .scaleAspectFit
            cell.imageCandle.translatesAutoresizingMaskIntoConstraints = false
            cell.imageCandle.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
            cell.imageCandle.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor).isActive = true
            cell.imageCandle.isHidden = false
            cell.darkView.isHidden = false
        } else {
            cell.imageCandle.isHidden = true
            cell.darkView.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
      }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let progress = UserDefaults.standard.value(forKey: "userProgress") as? Int ?? 1
        if progress >= indexPath.row+1 {
            let vc = PuzzleViewController()
            vc.progress = indexPath.row+1
            vc.gameImage = array[indexPath.row]
            vc.completion = {collectionView.reloadData()}
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
        }
    }
}


