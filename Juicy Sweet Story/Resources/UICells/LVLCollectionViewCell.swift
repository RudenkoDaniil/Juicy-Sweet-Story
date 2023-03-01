//
//  LVLCollectionViewCell.swift
//  Juicy Sweet Story
//
//  Created by Даниил on 27.02.2023.
//

import UIKit

class LVLViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "LVLViewCell"
    public let image = UIImageView()
    public let imageCandle = UIImageView(image: #imageLiteral(resourceName: "candy"))
    public let label = CircleView()
    public var cell: Int = 1
    public let darkView: UIView = {
        let view = UIView()
        view.alpha = 0.6
        view.layer.cornerRadius = 20
        view.backgroundColor = .black
        view.isHidden = true
        return view
    }()
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - handlers
    private func configureViews(){
        contentView.layer.cornerRadius = 20
        contentView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        contentView.addSubview(image)
        image.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 2, paddingLeft: 2, paddingBottom: 2, paddingRight: 2, width: 0, height: 0)
        let corner = UIImageView(image: #imageLiteral(resourceName: "candy frame"))
        contentView.addSubview(corner)
        corner.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        contentView.addSubview(label)
        label.anchor(top: nil, left: nil, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
    }
}
