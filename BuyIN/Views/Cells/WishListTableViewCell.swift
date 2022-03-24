//
//  WishListTableViewCell.swift
//  BuyIN
//
//  Created by apple on 3/13/22.
//

import UIKit

class WishListTableViewCell: UITableViewCell {

    var items:[CartItem] = []
    var indexPathRow : IndexPath = IndexPath(row: 0, section: 0)

    @IBOutlet weak var wishItemImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var itemPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func removeButton(_ sender: Any) {
        WishlistController.shared.removeAllQuantities(at: indexPathRow.row)
        self.postItemsDeletedNotification()
    }
    
    private func postItemsDeletedNotification() {
        let indexPathDict : [String: IndexPath] = ["indexPath": indexPathRow]
        let notification = Notification(name: Notification.Name("DeletedWishList"), userInfo: indexPathDict)
        NotificationQueue.default.enqueue(notification, postingStyle: .asap)
    }
    
    @IBAction func addToCart(_ sender: Any) {
        WishlistController.shared.moveToCart(at: indexPathRow.row)
        self.postItemsDeletedNotification()
    }
}
