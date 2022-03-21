//
//  HotProductsCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 11/03/2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = className

    func configer(with collection  : CollectionViewModel)  {
    
        bannerLabel.text = collection.title;
        bannerImageView.setImageFrom(collection.imageURL);
    }
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
    
    func configure(with model: CollectionViewModel) {
        bannerLabel.text = model.title
        guard let url = model.imageURL else {return}
        bannerImageView.setImageFrom(url)
    }
    
    func configure(with model: String, thumbnail: String) {
        bannerLabel.text = model
        bannerImageView.image = UIImage(named: thumbnail)
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
    }
}
