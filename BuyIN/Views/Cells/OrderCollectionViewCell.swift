//
//  OrderCollectionViewCell.swift
//  BuyIN
//
//  Created by apple on 3/13/22.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var orderImage: UIImageView!
    
    @IBOutlet weak var NameOfItem: UILabel!
    
    @IBOutlet weak var dateOfOrder: UILabel!
    
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var firstItemInOrderImage: UIImageView!
    
    @IBOutlet weak var secondItemInOrderImage: UIImageView!
    
    @IBOutlet weak var moreButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
