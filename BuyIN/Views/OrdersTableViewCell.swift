//
//  OrdersTableViewCell.swift
//  BuyIN
//
//  Created by apple on 3/10/22.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet var itemImage: UIImageView!
    
    @IBOutlet var orderId: UILabel!
    
    @IBOutlet var orderType: UILabel!
    
    @IBOutlet var orderTime: UILabel!
    
    @IBOutlet var orderPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
