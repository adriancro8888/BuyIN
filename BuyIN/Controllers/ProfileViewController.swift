//
//  ProfileViewController.swift
//  BuyIN
//
//  Created by apple on 3/10/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var itemsTableView: UITableView!
    
    @IBOutlet var wishList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib1 = UINib(nibName: "OrdersTableViewCell", bundle: nil)
        itemsTableView.register(nib1, forCellReuseIdentifier: "OrdersTableViewCell")
        itemsTableView.separatorStyle = .none
        
        let nib2 = UINib(nibName: "WishListCollectionViewCell", bundle: nil)
        wishList.register(nib2, forCellWithReuseIdentifier: "WishListCollectionViewCell")
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ProfileViewController : UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 0
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        itemsTableView.rowHeight = 229
        
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "OrdersTableViewCell") as! OrdersTableViewCell
        itemCell.itemImage.layer.cornerRadius = 20
        itemCell.layer.cornerRadius = 20
       // itemCell.layer.borderWidth = 350
        if indexPath.row == 1 {
            itemCell.itemImage.image = UIImage(named: "lipstick")
            itemCell.orderId.text = "Order #124"
            itemCell.orderType.text = "Lipstick by charlotte tilbury"
            itemCell.orderTime.text = "created: 28/2/2022"
            itemCell.orderPrice.text = "$30"
        }
        return itemCell
    }
    
    
}
extension ProfileViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 208)
    }
}
extension ProfileViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let wishListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishListCollectionViewCell", for: indexPath) as! WishListCollectionViewCell
        if indexPath.row == 1 {
            wishListCell.itemImage.image = UIImage(named: "brush")
            wishListCell.itemName.text = "volum brush"
            wishListCell.itemPrice.text = "$80"
            wishListCell.discription.text = "Brush for dry hair"
            wishListCell.sellerName.text = "Revelon"
        }
        return wishListCell
    }
    
    
}
