//
//  ShoppingBagCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 21/03/2022.
//

import UIKit
import SwipeCellKit


protocol ShoppingBagCollectionViewCellDelegate: AnyObject {
    func shoppingBagCollectionViewCellDidTapMinus(_ forItem: CartItemViewModel)
    func shoppingBagCollectionViewCellDidTapPlus(_ forItem: CartItemViewModel)

}

class ShoppingBagCollectionViewCell: SwipeCollectionViewCell ,ViewModelConfigurable {
    
    static let identifier = className
    
    var viewModel: CartItemViewModel?

    weak var _delegate: ShoppingBagCollectionViewCellDelegate?
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(
            systemName: "minus",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 16,
                weight: .bold))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.backgroundColor = .black
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(
            systemName: "plus",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 16,
                weight: .bold))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.backgroundColor = .black
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()

    private let colorTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let sizeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let productTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.35)
        return view
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let productPricelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(productImageView)
        contentView.addSubview(productTitle)
        contentView.addSubview(colorTitle)
        contentView.addSubview(sizeTitle)
        contentView.addSubview(productPricelabel)
        contentView.addSubview(separator)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(minusButton)
        contentView.addSubview(plusButton)
        configureConstraints()
        minusButton.addTarget(self, action: #selector(didTapMinus), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
    }
    
    @objc private func didTapMinus() {
        _delegate?.shoppingBagCollectionViewCellDidTapMinus(viewModel!)
        
    }
    
    @objc private func didTapPlus() {
        _delegate?.shoppingBagCollectionViewCellDidTapPlus(viewModel!)
    }
    
    func configureFrom(_ viewModel: CartItemViewModel) {
        productImageView.setImageFrom(viewModel.imageURL!)
        productTitle.text = viewModel.title
        let variant = viewModel.subtitle.split(separator: Character("/"))
        let size = variant[0].trimmingCharacters(in: CharacterSet(charactersIn: " "))
        let color = variant[1].trimmingCharacters(in: CharacterSet(charactersIn: " "))
        sizeTitle.text = "Size: \(size)"
        colorTitle.text = "Color: \(color)"
        productPricelabel.text = viewModel.price
        quantityLabel.text = viewModel.quantityDescription
        self.viewModel = viewModel
        configureButtons()
    }
    
    private func configureButtons() {
        if viewModel!.quantity < 2 {
            configureAsDisabled()
        } else {
            configureAsEnabled()
        }
    }
    
    private func configureAsEnabled() {
        minusButton.isEnabled = true
        minusButton.backgroundColor = .black
    }
    
    private func configureAsDisabled() {
        minusButton.backgroundColor = .gray
        minusButton.isEnabled = false
    }
    
    typealias ViewModelType = CartItemViewModel

    
    private func configureConstraints() {
        
        let productImageViewConstraints = [
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            productImageView.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        let productTitleConstraints = [
            productTitle.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
            productTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            productTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ]
        
        let colorTitleConstraints = [
            colorTitle.leadingAnchor.constraint(equalTo: productTitle.leadingAnchor),
            colorTitle.topAnchor.constraint(equalTo: productTitle.bottomAnchor, constant: 10)
        ]
        
        let sizeTitleConstraints = [
            sizeTitle.leadingAnchor.constraint(equalTo: productTitle.leadingAnchor),
            sizeTitle.topAnchor.constraint(equalTo: colorTitle.bottomAnchor, constant: 10)
        ]

        let productPricelabelConstraints = [
            productPricelabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            productPricelabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ]
        
        let separatorConstraints = [
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        let quantityLabelConstraints = [
            quantityLabel.leadingAnchor.constraint(equalTo: productTitle.leadingAnchor),
            quantityLabel.topAnchor.constraint(equalTo: sizeTitle.bottomAnchor, constant: 10)
        ]
        
        let minusButtonConstraints = [
            minusButton.leadingAnchor.constraint(equalTo: quantityLabel.leadingAnchor),
            minusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            minusButton.heightAnchor.constraint(equalToConstant: 40),
            minusButton.widthAnchor.constraint(equalToConstant: 40)
        ]
        
        let plusButtonConstraints = [
            plusButton.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 20),
            plusButton.topAnchor.constraint(equalTo: minusButton.topAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: 40),
            plusButton.widthAnchor.constraint(equalToConstant: 40)
            
        ]
        
        NSLayoutConstraint.activate(productImageViewConstraints)
        NSLayoutConstraint.activate(productTitleConstraints)
        NSLayoutConstraint.activate(colorTitleConstraints)
        NSLayoutConstraint.activate(sizeTitleConstraints)
        NSLayoutConstraint.activate(productPricelabelConstraints)
        NSLayoutConstraint.activate(separatorConstraints)
        NSLayoutConstraint.activate(quantityLabelConstraints)
        NSLayoutConstraint.activate(minusButtonConstraints)
        NSLayoutConstraint.activate(plusButtonConstraints)
    }

    
    required init?(coder: NSCoder) {
        fatalError()
    }
}


