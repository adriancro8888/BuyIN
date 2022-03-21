//
//  CategoryTabCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 21/03/2022.
//

import UIKit

class CategoryTabCollectionViewCell: UICollectionViewCell {
    
    static let identifier = className
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let overlay: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45)
        return view
    }()
    
    private let categoryTitle: UILabel = {
       
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryImageView)
        contentView.addSubview(overlay)
        contentView.addSubview(categoryTitle)
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 10
        configureConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryImageView.frame = contentView.bounds
        overlay.frame = contentView.bounds
    }
    
    func configure(with model: CollectionViewModel) {
        categoryTitle.text = model.title
        categoryImageView.setImageFrom(model.imageURL!)
    }
    
    private func configureConstraints() {
        
        let categoryTitleConstraints = [
            categoryTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            categoryTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            categoryTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(categoryTitleConstraints)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
