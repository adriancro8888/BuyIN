//
//  BannerCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 16/03/2022.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = className
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()
    
    private let heroTitle: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 52, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerImageView)
        contentView.addSubview(overlayView)
        contentView.addSubview(heroTitle)
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        let heroTitleConstraints = [
            heroTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            heroTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60),
            heroTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(heroTitleConstraints)
    }
    
    func configure(with model: CollectionViewModel) {
        guard let url = model.imageURL else {return}
        bannerImageView.setImageFrom(url)
        heroTitle.text = model.title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bannerImageView.frame = contentView.bounds
        overlayView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
