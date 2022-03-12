//
//  PreviewCollectionHeaderCollectionReusableView.swift
//  BuyIN
//
//  Created by Amr Hossam on 12/03/2022.
//

import UIKit

class PreviewCollectionHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "PreviewCollectionHeaderCollectionReusableView"
    
    
    
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        guard let url = URL(string: "https://images.unsplash.com/photo-1581338834647-b0fb40704e21?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80") else {
            return UIImageView()
        }
        imageView.clipsToBounds = true
        imageView.setImageFrom(url)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(previewImageView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        let previewImageViewConstraints = [
            previewImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewImageView.topAnchor.constraint(equalTo: topAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            previewImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(previewImageViewConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previewImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
