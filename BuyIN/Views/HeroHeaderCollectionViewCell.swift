//
//  HeroHeaderCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 11/03/2022.
//

import UIKit

class HeroHeaderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HeroHeaderCollectionViewCell"
    
    
    private let heroTextLabel: UILabel = {
      
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New Arrivals"
        label.numberOfLines = 0
        label.textColor = .white
        label.font =  .systemFont(ofSize: 74, weight: .heavy)
        return label
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()
    
    private let heroImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(heroImageView)
        contentView.addSubview(overlayView)
        contentView.addSubview(heroTextLabel)
        configureConstraints()
        guard let url = URL(string: "https://images.unsplash.com/photo-1568196004494-b1ee34f3b436?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80") else {return}
        heroImageView.setImageFrom(url, placeholder: UIImage(systemName: "house"))
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = contentView.bounds
        overlayView.frame = contentView.bounds
    }
    
    private func configureConstraints() {
        let heroTextLabelConstraints = [
            heroTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            heroTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            heroTextLabel.widthAnchor.constraint(equalToConstant: 280)
        ]
        
        NSLayoutConstraint.activate(heroTextLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
