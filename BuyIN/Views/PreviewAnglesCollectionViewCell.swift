//
//  PreviewAnglesCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 12/03/2022.
//

import UIKit

class PreviewAnglesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = className
    
    var isCellSelected: Bool = false {
        didSet {
            isCellSelected ? configureAsSelected() : configureAsNotSelected()
        }
    }
    private let overlayView: UIView = {
        let view = UIView()
        return view
    }()
    
    func configure(with model: ImageViewModel) {
        collectionImageView.setImageFrom(model.url)
    }
    
    private func configureAsSelected() {
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    private func configureAsNotSelected() {
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    }
    
    private let collectionImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        guard let url = URL(string: "https://images.unsplash.com/photo-1581338834647-b0fb40704e21?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80") else {
            return UIImageView()
        }
        imageView.contentMode = .scaleAspectFill
        imageView.setImageFrom(url)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        contentView.addSubview(collectionImageView)
        configureConstraints()
        contentView.addSubview(overlayView)
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        overlayView.frame = contentView.bounds
    }
    
    private func configureConstraints() {
        
        let collectionImageViewConstraints = [
            collectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        
        
        NSLayoutConstraint.activate(collectionImageViewConstraints)
    }
    
    private func configureCell(){
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
