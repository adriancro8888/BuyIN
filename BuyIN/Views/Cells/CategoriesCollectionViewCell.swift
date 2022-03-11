//
//  CategoriesCollectionViewCell.swift
//  BuyIN
//
//  Created by Akram Elhayani on 10/03/2022.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell,ViewModelConfigurable {
    typealias ViewModelType = CollectionViewModel
    
    @IBOutlet private weak var titleImageView: UIImageView!
    @IBOutlet private weak var titleLable: UILabel!
    private(set) var viewModel: CollectionViewModel?
    func configureFrom(_ viewModel: CollectionViewModel) {
        self.viewModel = viewModel
        self.titleImageView.setImageFrom(viewModel.imageURL)
        self.titleLable.text = viewModel.title
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
