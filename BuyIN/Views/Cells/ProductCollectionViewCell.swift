//
//  ProductCollectionViewCell.swift
//  BuyIN
//
//  Created by Akram Elhayani on 10/03/2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell ,ViewModelConfigurable {
    
    typealias ViewModelType = ProductViewModel
    

    @IBOutlet weak var favoritButton: UIButton!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var producImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    private(set) var viewModel: ProductViewModel?
    
    func configureFrom(_ viewModel: ProductViewModel) {
        self.viewModel = viewModel
        
        self.productTitle.text = viewModel.title
        self.productPrice.text = viewModel.price
        self.producImage.setImageFrom(viewModel.images.items.first?.url)
    }
    @IBAction func favoritButtonClicked(_ sender: Any) {
    }
}
