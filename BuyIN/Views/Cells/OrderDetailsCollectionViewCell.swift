//
//  OrderDetailsCollectionViewCell.swift
//  BuyIN
//
//  Created by apple on 3/15/22.
//

import UIKit

class OrderDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shippingAdress: UITextView!
    
    @IBOutlet weak var phoneNumbers: UILabel!
    
    @IBOutlet weak var stateOfOrder: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        
    }

}
