//
//  RecentlyAddedCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 11/03/2022.
//

import UIKit

class RecentlyAddedCollectionViewCell: UICollectionViewCell {
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        guard let url = URL(string: "https://images.unsplash.com/photo-1581338834647-b0fb40704e21?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80") else {
            return UIImageView()
        }
        imageView.setImageFrom(url)
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "Casual blouse"
        return label
    }()
    
    private let vendorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = "Pull&Bear"
        label.textColor = .lightGray
        return label
    }()
    
    
    private let priceLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "$35.34"
        return label
    }()
    
    static let identifier = "RecentlyAddedCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(productImageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(productTitleLabel)
        contentView.addSubview(vendorLabel)
        configureConstraints()
        contentView.backgroundColor = .tertiarySystemFill
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private func configureConstraints() {
        let productImageViewConstraints = [
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
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
