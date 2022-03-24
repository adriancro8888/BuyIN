//
//  ProductHeaderCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 12/03/2022.
//

import UIKit

class ProductHeaderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = className
    
    private let addToCartButton: UIButton = {
       
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Add To Cart", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setImage(UIImage(systemName: "cart.fill"), for: .normal)
//        button.backgroundColor = UIColor(red: 232/255, green: 88/255, blue: 56/255, alpha: 1)
        button.backgroundColor = .black
        button.tintColor = .white
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.text = "Cash on delivery"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.text = "Fast Shipping"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let firstLabelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "shippingbox")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let secondLabelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "airplane")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textColor = .red
        return label
    }()
    
    
    private let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(productTitleLabel)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(separator)
        contentView.addSubview(containerView)
        contentView.addSubview(addToCartButton)
        containerView.addSubview(firstLabel)
        containerView.addSubview(secondLabel)
        containerView.addSubview(firstLabelImageView)
        containerView.addSubview(secondLabelImageView)
        configureConstraints()
    }
    
    
    private func configureConstraints() {
        
        let productTitleLabelConstraints = [
            productTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ]
        let productPriceLabelConstraints = [
            productPriceLabel.leadingAnchor.constraint(equalTo: productTitleLabel.leadingAnchor),
            productPriceLabel.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 10)
        ]
        
 
        
        let separatorConstraints = [
            separator.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 20),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        let containerViewConstraints = [
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            containerView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10),
            containerView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let firstLabelImageViewConstraints = [
            firstLabelImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            firstLabelImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -10),
            firstLabelImageView.widthAnchor.constraint(equalToConstant: 30),
            firstLabelImageView.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        let firstLabelConstraints = [
            firstLabel.leadingAnchor.constraint(equalTo: firstLabelImageView.leadingAnchor),
            firstLabel.topAnchor.constraint(equalTo: firstLabelImageView.bottomAnchor, constant: 5)
        ]
        
        let secondLabelConstraints = [
            secondLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            secondLabel.centerYAnchor.constraint(equalTo: firstLabel.centerYAnchor)
        ]
        
        let secondLabelImageViewConstraints = [
            secondLabelImageView.leadingAnchor.constraint(equalTo: secondLabel.leadingAnchor),
            secondLabelImageView.centerYAnchor.constraint(equalTo: firstLabelImageView.centerYAnchor),
            secondLabelImageView.widthAnchor.constraint(equalToConstant: 30),
            secondLabelImageView.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        
        let addToCartButtonConstraints = [
            addToCartButton.bottomAnchor.constraint(equalTo: productPriceLabel.bottomAnchor),
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            addToCartButton.widthAnchor.constraint(equalToConstant: 160),
            addToCartButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        NSLayoutConstraint.activate(productTitleLabelConstraints)
        NSLayoutConstraint.activate(productPriceLabelConstraints)
        NSLayoutConstraint.activate(separatorConstraints)
        NSLayoutConstraint.activate(containerViewConstraints)
        NSLayoutConstraint.activate(firstLabelImageViewConstraints)
        NSLayoutConstraint.activate(firstLabelConstraints)
        NSLayoutConstraint.activate(secondLabelConstraints)
        NSLayoutConstraint.activate(secondLabelImageViewConstraints)
        NSLayoutConstraint.activate(addToCartButtonConstraints)
    }
    
    func configure(with model: ProductViewModel) {
        productTitleLabel.text = model.title
        productPriceLabel.text = "E£\(model.price.dropFirst())"

        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
