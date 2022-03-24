//
//  ProductPreviewDescriptionCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 12/03/2022.
//

import UIKit

class ProductPreviewDescriptionCollectionViewCell: UICollectionViewCell {
    
    static let identifier = className
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(descriptionTitleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.backgroundColor = .secondarySystemFill
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 20
        configureConstraints()
    }
    
    
    func configure(with model: ProductViewModel) {
        descriptionLabel.text = model.summary.replacingOccurrences(of: "/<a.*>.*?</a>/ig", with: "")
    }
    
    private func configureConstraints() {
        
        let descriptionTitleLabelConstraints = [
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            descriptionTitleLabel.heightAnchor.constraint(equalToConstant: 20),
        ]
        
        let descriptionLabelConstraints = [
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(descriptionTitleLabelConstraints)
        NSLayoutConstraint.activate(descriptionLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
