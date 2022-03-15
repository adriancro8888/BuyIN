//
//  HeroCategoriesCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 11/03/2022.
//

import UIKit

class HeroCategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = className
    
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "promotionBanner")
        imageView.clipsToBounds = true
        return imageView
    }()
    
//    private let containerView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .label
//        view.clipsToBounds = true
//        view.layer.masksToBounds = true
//        view.layer.cornerRadius = 20
//        view.backgroundColor = .black
//
//        return view
//    }()
    
//    var categoryTitle: String {
//        get {
//            titleLabel.text!
//        }
//
//        set {
//            titleLabel.text = newValue
//        }
//    }
//
//    private let titleLabel: UILabel = {
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 20, weight: .regular)
//        label.textAlignment = .center
//        label.textColor = .white
//        label.numberOfLines = 1
//        return label
//    }()
//
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.addSubview(containerView)
//        contentView.addSubview(titleLabel)
        contentView.addSubview(bannerImageView)
        configureConstraints()
        backgroundColor = .red
    }
    
    private func configureConstraints() {
        
//
//        let titleLabelConstraints = [
//            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
//            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
//            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
//            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
//        ]
//
//        let containerViewConstraints = [
//            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            containerView.widthAnchor.constraint(equalToConstant: 90)
//
//        ]
        
        let bannerImageViewConstraints = [
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(bannerImageViewConstraints)
//        NSLayoutConstraint.activate(containerViewConstraints)
//        NSLayoutConstraint.activate(titleLabelConstraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
