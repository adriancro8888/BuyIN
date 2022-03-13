//
//  ProfileViewController.swift
//  BuyIN
//
//  Created by apple on 3/10/22.
//

import UIKit

class ProfileViewController: UIViewController {

    //@IBOutlet var itemsTableView: UITableView!
    
    @IBOutlet weak var ordersCollectionViews: UICollectionView!
    @IBOutlet var wishList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        let nib1 = UINib(nibName: "OrdersTableViewCell", bundle: nil)
//        itemsTableView.register(nib1, forCellReuseIdentifier: "OrdersTableViewCell")
//        itemsTableView.separatorStyle = .none
        
//        let nib2 = UINib(nibName: "WishListCollectionViewCell", bundle: nil)
//        self.wishList.register(nib2, forCellWithReuseIdentifier: "WishListCollectionViewCell")
        
        let wishListNib = UINib(nibName: "UpdatedWishListCollectionViewCell", bundle: nil)
        self.wishList.register(wishListNib, forCellWithReuseIdentifier: "UpdatedWishListCollectionViewCell")
        
        let orderNib = UINib(nibName: "OrderCollectionViewCell", bundle: nil)
        self.ordersCollectionViews.register(orderNib, forCellWithReuseIdentifier: "OrderCollectionViewCell")
        
        
        
        
    }
    

    @IBAction func settingButton(_ sender: Any) {
        let newViewController = ProductsViewController(nibName: "ProductsViewController", bundle: nil)

        // Present View "Modally"
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func moreButton(_ sender: Any) {
        
        let orderController : OrdersViewController = OrdersViewController.instantiateFromNib()
        orderController.modalPresentationStyle = .fullScreen
        self.present(orderController, animated: true, completion: nil)
        
        
       // let navigationController = UINavigationController(rootViewController: orderController)
       
        //self.navigationController?.pushViewController(orderController, animated: true)
    }
    
    @IBAction func moreButtonForWishList(_ sender: Any) {
        let wishController : WishListViewController = WishListViewController.instantiateFromNib()
        wishController.modalPresentationStyle = .fullScreen
        self.present(wishController, animated: true, completion: nil)
    }
}
//extension ProfileViewController : UITableViewDataSource {
////    func numberOfSections(in tableView: UITableView) -> Int {
////        return 0
////    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        itemsTableView.rowHeight = 239
//
//        let itemCell = tableView.dequeueReusableCell(withIdentifier: "OrdersTableViewCell") as! OrdersTableViewCell
//        itemCell.itemImage.layer.cornerRadius = 20
//        itemCell.layer.cornerRadius = 20
//       // itemCell.layer.borderWidth = 350
//        if indexPath.row == 1 {
//            itemCell.itemImage.image = UIImage(named: "lipstick")
//            itemCell.orderId.text = "Order #124"
//            itemCell.orderType.text = "Lipstick by charlotte tilbury"
//            itemCell.orderTime.text = "created: 28/2/2022"
//            itemCell.orderPrice.text = "$30"
//        }
//        return itemCell
//    }
//
//    }

extension ProfileViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 320, height: 208) //for the wishListCell nib2
       
    
        if collectionView == ordersCollectionViews {
            return CGSize(width: 302, height: 236)
        }else {
            
            return CGSize(width: 152, height: 202)
        }
        
        
    }
}
extension ProfileViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ordersCollectionViews {
            return 2
            
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           // for the wishListCell second nib
//        let wishListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishListCollectionViewCell", for: indexPath) as! WishListCollectionViewCell
//        if indexPath.row == 1 {
//            wishListCell.itemImage.image = UIImage(named: "brush")
//            wishListCell.itemName.text = "volum brush"
//            wishListCell.itemPrice.text = "$80"
//            wishListCell.discription.text = "Brush for dry hair"
//            wishListCell.sellerName.text = "Revelon"
//        }
//        return wishListCell
        
       
//        updatedWishListCell.wishListItemImage.image = UIImage(named: "b2")
//        updatedWishListCell.wishListItemImage.contentMode = .scaleAspectFit
       
        
        if collectionView == ordersCollectionViews {
            let orderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCollectionViewCell", for: indexPath) as! OrderCollectionViewCell
            return orderCell
            
        }else {
            let updatedWishListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpdatedWishListCollectionViewCell", for: indexPath) as! UpdatedWishListCollectionViewCell
            return updatedWishListCell
        }
    }
    
    
    
    
}
