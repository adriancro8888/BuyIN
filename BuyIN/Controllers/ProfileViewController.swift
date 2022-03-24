//
//  ProfileViewController.swift
//  BuyIN
//
//  Created by Yousra Eid on 10/3/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    //@IBOutlet var itemsTableView: UITableView!
    var userInfo : CustomerViewModel?
    var ordersArray: PageableArray<OrderViewModel>?
    var items : [CartItem] = []
    
    @IBOutlet weak var ordersCollectionViews: StorefrontCollectionView!
    @IBOutlet var wishList: UICollectionView!
    
    @IBOutlet weak var customerName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateWishList()
        self.registerNotifications()

//        print("items\(items)")
        

//        let nib1 = UINib(nibName: "OrdersTableViewCell", bundle: nil)
//        itemsTableView.register(nib1, forCellReuseIdentifier: "OrdersTableViewCell")
//        itemsTableView.separatorStyle = .none
        
//        let nib2 = UINib(nibName: "WishListCollectionViewCell", bundle: nil)
//        self.wishList.register(nib2, forCellWithReuseIdentifier: "WishListCollectionViewCell")
        

        
        
        
        let wishListNib = UINib(nibName: "UpdatedWishListCollectionViewCell", bundle: nil)
        self.wishList.register(wishListNib, forCellWithReuseIdentifier: "UpdatedWishListCollectionViewCell")
        
        let orderNib = UINib(nibName: "OrderCollectionViewCell", bundle: nil)
        self.ordersCollectionViews.register(orderNib, forCellWithReuseIdentifier: "OrderCollectionViewCell")
        fetchOrders()
        
        let noOrderNib = UINib(nibName: "NoOrdersCollectionViewCell", bundle: nil)
        self.ordersCollectionViews.register(noOrderNib, forCellWithReuseIdentifier: "NoOrdersCollectionViewCell")
        
    
        
        
        
        
        
    }


    
   @IBAction func bagButton(_ sender: Any) {
    let cartController : ShoppingBagViewController = ShoppingBagViewController()
   // cartController.modalPresentationStyle = .fullScreen

    
    self.present(cartController, animated: true, completion: nil)
    
    }

    // ----------------------------------
    //  MARK: - Notifications -
    //
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(WishlistControllerItemsDidChange(_:)), name: Notification.Name.WishlistControllerItemsDidChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(OrderlistControllerItemsDidChange(_:)), name: Notification.Name.CartControllerItemsDidChange, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func WishlistControllerItemsDidChange(_ notification: Notification) {
        self.updateWishList()
    }
    
    @objc private func OrderlistControllerItemsDidChange(_ notification: Notification) {
        self.updateOrdersList()
    }
    
    // ----------------------------------
    //  MARK: - Update -
    //
    func updateWishList() {
        self.items = WishlistController.shared.items
        wishList.reloadData()
    }
    
    func updateOrdersList() {
        self.fetchOrders()
    }
    
    func fetchOrders(after cursuer:String? = nil) {
        if let accessToken = AccountController.shared.accessToken{
            print("acesstoken :\(accessToken)")
            Client.shared.fetchCustomerAndOrders(  after: cursuer, accessToken: accessToken){
                container in
                if let container = container{
                    
                    self.userInfo = container.customer
                    self.customerName.text = "Welcome \(self.userInfo?.firstName ?? "User")"
                    self.ordersArray = container.orders
                    self.ordersCollectionViews.reloadData()
                    
                    
                    
                  //  let order =  self.ordersArray?.items[0].model..lineItems.edges[0].node.
                    
                }
            }
        }
    }
    

    @IBAction func settingButton(_ sender: Any) {
        print("Settings Pressed")
        let settingsController : SettingViewController = SettingViewController.instantiateFromNib()
//        self.navigationController?.pushViewController(settingsController, animated: true)
//        self.navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor.black
        settingsController.modalPresentationStyle = .fullScreen
        self.present(settingsController, animated: true, completion: nil)
//
        

    }
    
    @IBAction func moreButton(_ sender: Any) {
        
        let orderController : OrdersViewController = OrdersViewController.instantiateFromNib()
        orderController.modalPresentationStyle = .fullScreen
        orderController.AllordersArray = ordersArray
        orderController.userInfo = userInfo
        
        
        self.present(orderController, animated: true, completion: nil)
        
        
       // let navigationController = UINavigationController(rootViewController: orderController)
       
        //self.navigationController?.pushViewController(orderController, animated: true)
    }
    
    @IBAction func moreButtonForWishList(_ sender: Any) {
        let wishController : WishListViewController = WishListViewController.instantiateFromNib()
        wishController.modalPresentationStyle = .fullScreen
        wishController.wishlistItems = items
        
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
extension ProfileViewController : StorefrontCollectionViewDelegate {
    func collectionViewShouldBeginPaging(_ collectionView: StorefrontCollectionView) -> Bool {
        let flag = self.ordersArray?.hasNextPage ?? false
        
//        if flag {
//
//            // Activity indicator show
//        }
        
        
        
        return flag
    }

    func collectionViewWillBeginPaging(_ collectionView: StorefrontCollectionView) {
        if let orders = self.ordersArray ,
           let lastOrder = orders.items.last{
            if let accessToken = AccountController.shared.accessToken{
            
                Client.shared.fetchCustomerAndOrders(  after: lastOrder.cursor, accessToken: accessToken){
                    container in
                    if let container = container{
                        
                       
                        self.ordersArray?.appendPage( from: container.orders)
                        collectionView.reloadData()
                        collectionView.completePaging()
                        
                    }
                }
            }
            
        }
    }
    
    func collectionViewDidCompletePaging(_ collectionView: StorefrontCollectionView) {
        
    }
    
}

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
           // return ordersArray?.items.count ?? 0
            if let orderCount = ordersArray?.items.count {
                if orderCount >= 2 {
                return 2
                    
                }else{
                return 1
            }

            }
            else
            {
                return 0
            }
        } else {
            if items.count >= 5{
                return 6
            }
            else {
            return items.count + 1
            }
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
            
            let noOrderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoOrdersCollectionViewCell", for: indexPath) as! NoOrdersCollectionViewCell
            
            if let orderCount = ordersArray?.items.count {
                print(orderCount)
                if orderCount >= 1 {
//                    if indexPath.row == 0 {
                    let orderIndex = (self.ordersArray?.items.count ?? 1) - (indexPath.row + 1)
                        if let order = self.ordersArray?.items[orderIndex]{
                        
                        orderCell.orderNumber.text = "Order #\(String(order.model.node.orderNumber))"
                        let imageURL = order.model.node.lineItems.edges[0].node.variant?.image?.url
                        orderCell.orderImage.setImageFrom(imageURL)
                        //print(order1.model.node.lineItems.edges[0].node.variant?.image)
                        //orderCell.NameOfItem.text = order1.model.node.name
                        let dateOfCreation = DateFormatterClass.dateFormatter(date: order.model.node.processedAt)
                        orderCell.dateOfOrder.text = dateOfCreation

                        let totalPriceMoney = order.model.node.currentTotalPrice
                        orderCell.totalPrice.text = Currency.stringFrom(totalPriceMoney.amount, totalPriceMoney.currencyCode.rawValue)
                            let fulfillmentStatus = order.model.node.fulfillmentStatus.rawValue.replacingOccurrences(of: "_", with: " ")
                            orderCell.NameOfItem.text = fulfillmentStatus
                        switch (order.model.node.lineItems.edges.count) {
                        
                        case 1:
                            orderCell.secondItemInOrderImage.isHidden = true
                            let firstImageURL = order.model.node.lineItems.edges[0].node.variant?.image?.url
                            orderCell.firstItemInOrderImage.setImageFrom(firstImageURL)
                            orderCell.moreButton.isHidden = true
                        case 2:
                            let firstImageURL = order.model.node.lineItems.edges[0].node.variant?.image?.url
                            orderCell.firstItemInOrderImage.setImageFrom(firstImageURL)
                            let secondImageURL = order.model.node.lineItems.edges[1].node.variant?.image?.url
                            orderCell.secondItemInOrderImage.setImageFrom(secondImageURL)
                            orderCell.moreButton.isHidden = true
                            
                            
                        default:
                            let firstImageURL = order.model.node.lineItems.edges[0].node.variant?.image?.url
                            orderCell.firstItemInOrderImage.setImageFrom(firstImageURL)
                            let secondImageURL = order.model.node.lineItems.edges[1].node.variant?.image?.url
                            orderCell.secondItemInOrderImage.setImageFrom(secondImageURL)
                        }

                    }
                    return orderCell
                    }
                else
                {
                    return noOrderCell
                }
                
                }
            else
            {
                return noOrderCell
            }
            
            
            
        }else {
            if (indexPath.row > items.count-1) || (indexPath.row == 5) {
                let updatedWishListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpdatedWishListCollectionViewCell", for: indexPath) as! UpdatedWishListCollectionViewCell
                updatedWishListCell.itemPrice.text  = "More"
                updatedWishListCell.wishListItemImage.image = UIImage(named: "More")
                updatedWishListCell.wishListItemImage.contentMode = .scaleAspectFill
               
                return updatedWishListCell
            }
            else{
            let updatedWishListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpdatedWishListCollectionViewCell", for: indexPath) as! UpdatedWishListCollectionViewCell
//            items = WishlistController.shared.items
            updatedWishListCell.itemPrice.text  = items[indexPath.row].product.price
            let imgURL = items[indexPath.row].product.images.items[0].url
            updatedWishListCell.wishListItemImage.setImageFrom(imgURL)
           
            return updatedWishListCell
            }
            }
        }
    }

extension ProfileViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == ordersCollectionViews {
            if let orderCount = ordersArray?.items.count {
                if orderCount >= 1 {
                    let ordersDetailController : OrdersDetailsViewController = OrdersDetailsViewController.instantiateFromNib()
                    let ordersCount = ordersArray?.items.count ?? 1
                    
                    ordersDetailController.ordersDetails = ordersArray?.items[ordersCount-1-indexPath.row]
                    ordersDetailController.userInfo = userInfo
                    self.present(ordersDetailController, animated: true, completion: nil)
                }else {
                    let noOrderController : NoOrdersViewController = NoOrdersViewController.instantiateFromNib()
                    self.present(noOrderController, animated: true, completion: nil)
                }
            
            }
            
            
        }else{
            if (indexPath.row > items.count-1) || (indexPath.row == 5){
                let wishController : WishListViewController = WishListViewController.instantiateFromNib()
                wishController.modalPresentationStyle = .fullScreen
                wishController.wishlistItems = items
                self.present(wishController, animated: true, completion: nil)
            }
            
        }
    }
}
    
    
    
    



