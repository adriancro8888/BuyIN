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
    
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerImageView)
        contentView.addSubview(overlayView)
        guard let url = URL(string: "https://images.unsplash.com/photo-1568196004494-b1ee34f3b436?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80") else {return}
        bannerImageView.setImageFrom(url)
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
