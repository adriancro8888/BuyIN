//
//  HotProductsCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 11/03/2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = className
    
//    private let productTitleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 18, weight: .medium)
//        label.text = "Casual blouse"
//        return label
//    }()
    
//    private let vendorLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 12, weight: .medium)
//        label.text = "Pull&Bear"
//        label.textColor = .lightGray
//        return label
//    }()
//
//
//    private let priceLabel: UILabel = {
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 20, weight: .medium)
//        label.text = "$35.34"
//        return label
//    }()
    
//    private let productImageView: UIImageView = {
//
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        guard let url = URL(string: "https://images.unsplash.com/photo-1581338834647-b0fb40704e21?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80") else {
//            return UIImageView()
//        }
//        imageView.setImageFrom(url)
//        imageView.clipsToBounds = true
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = 10
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
//
//    private let likeButton: UIButton = {
//        let button = UIButton(type: .system)
//        let image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
//        button.setImage(image, for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.tintColor = .lightGray
//        return button
//    }()
//    private lazy var blurredVisualEffect: UIVisualEffectView = {
//        let blurEffect = UIBlurEffect(style: .regular)
//        let view = UIVisualEffectView(effect: blurEffect)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.clipsToBounds = true
//        view.layer.masksToBounds = true
//        return view
//    }()
//
    
    private let bannerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 38, weight: .bold)
        
        label.textColor = .white
        return label
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.35
        return view
    }()
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.addSubview(productImageView)
//        contentView.addSubview(priceLabel)
//        contentView.addSubview(productTitleLabel)
//        contentView.addSubview(vendorLabel)
//        contentView.addSubview(likeButton)
//        contentView.backgroundColor = .tertiarySystemFill
//        configureConstraints()
//        contentView.clipsToBounds = true
//        contentView.layer.masksToBounds = true
//        contentView.layer.cornerRadius = 10
        contentView.addSubview(bannerImageView)
        contentView.addSubview(overlayView)
        contentView.addSubview(bannerLabel)


        configureConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        overlayView.frame = contentView.bounds
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with model: String, thumbnail: String) {
        bannerLabel.text = model
        bannerImageView.image = UIImage(named: thumbnail)
//        bannerImageView.loadGif(name: "bannerGif")
//        priceLabel.text = model.price
//        let url = model.images.items[1].url
//        productImageView.setImageFrom(url, placeholder: nil, completion: nil)
//        productTitleLabel.text = model.title
        
    }
    
    private func configureConstraints() {
        
        let bannerImageViewConstraints = [
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let bannerLabelConstraints = [
            bannerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bannerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(bannerImageViewConstraints)
        NSLayoutConstraint.activate(bannerLabelConstraints)

//
//
//        let productImageViewConstraints = [
//            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            productImageView.heightAnchor.constraint(equalToConstant: 190)
//        ]
//
//        let priceLabelConstraints = [
//            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            priceLabel.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 5)
//        ]
//
//        let productTitleLabelConstraints = [
//            productTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            productTitleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10)
//        ]
//
//        let vendorLabelConstraints = [
//            vendorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            vendorLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5)
//        ]
//
//        let likeButtonConstraints = [
//            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
//            likeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//        ]
//
//        NSLayoutConstraint.activate(productImageViewConstraints)
//        NSLayoutConstraint.activate(priceLabelConstraints)
//        NSLayoutConstraint.activate(vendorLabelConstraints)
//        NSLayoutConstraint.activate(productTitleLabelConstraints)
//        NSLayoutConstraint.activate(likeButtonConstraints)
    }
}
