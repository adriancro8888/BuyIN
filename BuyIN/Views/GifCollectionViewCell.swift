//
//  GifCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 15/03/2022.
//

import UIKit

class GifCollectionViewCell: UICollectionViewCell {
    
    private let label: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Boost your Style Sense."
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 38, weight: .bold)
        return label
    }()
    
    static let identifier = className
    
    private let gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(gifImageView)
        contentView.addSubview(label)
        contentView.backgroundColor = .red
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        let labelConstraints = [
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gifImageView.frame = contentView.bounds
        gifImageView.loadGif(name: "bannerGif")
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
