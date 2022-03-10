//
//  WishListCollectionViewCell.swift
//  BuyIN
//
//  Created by apple on 3/10/22.
//

import UIKit

class WishListCollectionViewCell: UICollectionViewCell {

    @IBOutlet var itemImage: UIImageView!
    
    @IBOutlet var itemName: UILabel!
    
    @IBOutlet var sellerName: UILabel!
    
    @IBOutlet var discription: UILabel!
    
    @IBOutlet var itemPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
