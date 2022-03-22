//
//  OrderDetailsSummaryCollectionViewCell.swift
//  BuyIN
//
//  Created by apple on 3/19/22.
//

import UIKit

class OrderDetailsSummaryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var TotalOrderBefore: UILabel!
    
    @IBOutlet weak var shipping: UILabel!
    
    @IBOutlet weak var taxes: UILabel!
    
    @IBOutlet weak var totalBeforeDiscount: UILabel!
    @IBOutlet weak var discountCode: UILabel!
    
    @IBOutlet weak var orderTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
