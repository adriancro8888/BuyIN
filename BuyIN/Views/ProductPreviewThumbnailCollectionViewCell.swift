//
//  ProductPreviewThumbnailCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 16/03/2022.
//

import UIKit

class ProductPreviewThumbnailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = className
    
    private let previewImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(previewImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previewImageView.frame = contentView.bounds
    }
    
    func configure(with url: URL) {
        previewImageView.setImageFrom(url)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
