//
//  RecentlyAddedCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 11/03/2022.
//

import UIKit
import CoreML

class RecentlyAddedCollectionViewCell: UICollectionViewCell {
    
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let vendorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    
    private let priceLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    static let identifier = "RecentlyAddedCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .yellow

    }
  
    required init?(coder: NSCoder) {
        fatalError()
    }
    

    func configure(with model: ProductViewModel) {

        priceLabel.text = model.price
        let url = model.images.items[0].url
        productImageView.setImageFrom(url)
        
        
        productTitleLabel.text = model.title
        
    }
    
    private func configureConstraints() {
        let productImageViewConstraints = [
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            productImageView.heightAnchor.constraint(equalToConstant: 265)
        ]
        
        let priceLabelConstraints = [
            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 5)
        ]
        
        let productTitleLabelConstraints = [
            productTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            productTitleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10)
        ]
        
        let vendorLabelConstraints = [
            vendorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vendorLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5)
        ]
        
        NSLayoutConstraint.activate(productImageViewConstraints)
        NSLayoutConstraint.activate(productTitleLabelConstraints)
        NSLayoutConstraint.activate(priceLabelConstraints)
        NSLayoutConstraint.activate(vendorLabelConstraints)
    }
}
