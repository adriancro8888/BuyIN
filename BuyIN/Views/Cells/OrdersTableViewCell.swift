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
        //layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 15, right: 0)
        
    }
    override func layoutSubviews() {
         super.layoutSubviews()
         let bottomSpace: CGFloat = 10.0 // Let's assume the space you want is 10
         self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: bottomSpace, right: 0))
    }
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
