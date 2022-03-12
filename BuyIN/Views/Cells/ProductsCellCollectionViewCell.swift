//
//  ProductsCellCollectionViewCell.swift
//  BuyIN
//
//  Created by apple on 3/12/22.
//

import UIKit

class ProductsCellCollectionViewCell: UICollectionViewCell, ViewModelConfigurable {
    typealias ViewModelType = ProductViewModel

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemName.text = "test"
    }
    private(set) var viewModel: ProductViewModel?
    
    func configureFrom(_ viewModel: ProductViewModel) {
        self.viewModel = viewModel
        
        self.itemName.text = viewModel.title
        self.itemPrice.text = viewModel.price
        print(viewModel.title)
        self.itemImage.setImageFrom(viewModel.images.items.first?.url)
    }

}
