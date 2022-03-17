//
//  ThumbnailCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 16/03/2022.
//

import UIKit

class ThumbnailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = className
    
    let overlay: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        return view
    }()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(overlay)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        thumbnailImageView.frame = contentView.bounds
    }
    
    func configure(with url: URL) {
        thumbnailImageView.setImageFrom(url)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
