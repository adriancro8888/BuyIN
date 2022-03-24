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

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerImageView)
        configureConstraints()

    }
    
    private func configureConstraints() {
        

        let bannerImageViewConstraints = [
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(bannerImageViewConstraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
