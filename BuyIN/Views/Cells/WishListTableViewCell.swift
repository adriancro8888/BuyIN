//
//  WishListTableViewCell.swift
//  BuyIN
//
//  Created by apple on 3/13/22.
//

import UIKit

class WishListTableViewCell: UITableViewCell {

    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var mediumSizeBtn: UIButton!
    
    @IBOutlet weak var smallSize: UIButton!
    
    @IBOutlet weak var largeSize: UIButton!
    
    @IBOutlet weak var xLSize: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
