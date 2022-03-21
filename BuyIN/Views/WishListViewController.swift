//
//  WishListViewController.swift
//  BuyIN
//
//  Created by apple on 3/12/22.
//

import UIKit

class WishListViewController: UIViewController {
    
    var wishlistItems : [CartItem] = []

    @IBOutlet weak var wishListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib1 = UINib(nibName: "WishListTableViewCell", bundle: nil)
        wishListTableView.register(nib1, forCellReuseIdentifier: "WishListTableViewCell")
        wishListTableView.rowHeight = 229
        wishListTableView.separatorStyle = .none
        self.registerNotifications()
    }
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(WishlistControllerItemsDeleted(_:)), name: Notification.Name("DeletedWishList"), object: nil)
    }
    
    @objc private func WishlistControllerItemsDeleted(_ notification: Notification) {
        if let indexPath = notification.userInfo?["indexPath"] as? IndexPath {
            self.wishlistItems.remove(at: indexPath.row)
            self.wishListTableView.deleteRows(at: [indexPath], with: .fade)
            self.wishListTableView.reloadData()
        }
    }
    

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension WishListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlistItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let wishListCell = tableView.dequeueReusableCell(withIdentifier: "WishListTableViewCell") as! WishListTableViewCell
        wishListCell.items = wishlistItems
        wishListCell.indexPathRow = indexPath
        wishListCell.productName.text = wishlistItems[indexPath.row].product.title
        wishListCell.itemPrice.text  = wishlistItems[indexPath.row].product.price
        let imgURL = wishlistItems[indexPath.row].product.images.items[0].url
        wishListCell.wishItemImage.setImageFrom(imgURL)
        return wishListCell
    }
}
    
    
    extension WishListViewController : UITableViewDelegate {
        
//        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//            if (editingStyle == .delete) {
//            WishlistController.shared.removeAllQuantities(at: indexPath.row)
//        }
//        }
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
                -> UISwipeActionsConfiguration? {
                let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                    WishlistController.shared.removeAllQuantities(at: indexPath.row)
                    self.wishlistItems.remove(at: indexPath.row)
                    self.wishListTableView.deleteRows(at: [indexPath], with: .fade)
                    self.wishListTableView.reloadData()

                    completionHandler(true)
                }
                deleteAction.image = UIImage(systemName: "trash")
                deleteAction.backgroundColor = .systemRed
                let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
                return configuration
        }
        
    }
