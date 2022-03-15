//
//  OrdersDetailsViewController.swift
//  BuyIN
//
//  Created by Yousra Eid on 3/14/22.
//

import UIKit

class OrdersDetailsViewController: UIViewController {
//    var userInfo : CustomerViewModel?
//    var ordersArray: PageableArray<OrderViewModel>?
    
    @IBOutlet weak var orderDetailsCollectionView: StorefrontCollectionView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let orderDetailsNib = UINib(nibName: "OrderDetailsCollectionViewCell", bundle: nil)
        orderDetailsCollectionView.register(orderDetailsNib, forCellWithReuseIdentifier: "OrderDetailsCollectionViewCell")
        let cartNib = UINib(nibName: "CartCell", bundle: nil)
        orderDetailsCollectionView.register(cartNib, forCellWithReuseIdentifier: "CartCell")
        
    }
    
//    func fetchOrders(after cursuer:String? = nil) {
//        if let accessToken = AccountController.shared.accessToken{
//        
//            Client.shared.fetchCustomerAndOrders(  after: cursuer, accessToken: accessToken){
//                container in
//                if let container = container{
//                    
//                    self.userInfo = container.customer
//                    self.ordersArray = container.orders
//                    self.orderDetailsCollectionView.reloadData()
//                    
//                    
//                 let order =  self.ordersArray?.items[0].model..lineItems.edges[0].node.
//                    
//                }
//            }
//        }
//    }


}
//extension OrdersDetailsViewController : StorefrontCollectionViewDelegate {
//    func collectionViewShouldBeginPaging(_ collectionView: StorefrontCollectionView) -> Bool {
//        let flag = self.ordersArray?.hasNextPage ?? false
//        
////        if flag {
////            
////            // Activity indicator show
////        }
//        
//        
//        
//        return flag
//    }
//    
//    func collectionViewWillBeginPaging(_ collectionView: StorefrontCollectionView) {
//        if let orders = self.ordersArray ,
//           let lastOrder = orders.items.last{
//            if let accessToken = AccountController.shared.accessToken{
//            
//                Client.shared.fetchCustomerAndOrders(  after: lastOrder.cursor, accessToken: accessToken){
//                    container in
//                    if let container = container{
//                        
//                       
//                        self.ordersArray?.appendPage( from: container.orders)
//                        collectionView.reloadData()
//                        collectionView.completePaging()
//                        
//                    }
//                }
//            }
//            
//        }
//    }
//    
//    func collectionViewDidCompletePaging(_ collectionView: StorefrontCollectionView) {
//        
//    }
//    
//    
//    
//}
extension OrdersDetailsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
        return CGSize(width: 414, height: 336)
        }else {
            return CGSize(width: 414, height: 144)
        }
//        let width = collectionView.frame.width - 15
//        let height = width / 2.5
//        return CGSize(width: width, height: height)
        
        
       
    }
    
       
}
extension OrdersDetailsViewController : CartCellDelegate {
    
    func cartCell(_ cell: CartCell, didUpdateQuantity quantity: Int) {
        if let indexPath = self.orderDetailsCollectionView.indexPath(for: cell) {
            
            let didUpdate = CartController.shared.updateQuantity(quantity, at: indexPath.row)
            if didUpdate {
                
                
                self.orderDetailsCollectionView.reloadItems(at:  [indexPath])
               
            }
        }
    }
}

extension OrdersDetailsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return CartController.shared.orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let orderDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderDetailsCollectionViewCell", for: indexPath) as! OrderDetailsCollectionViewCell
            return orderDetailCell
        }else {
            let orderCell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCell.className, for: indexPath) as! CartCell
            let orderItem = CartController.shared.orders[indexPath.row]
            orderCell.cartDelegate = self
            orderCell.configureFrom(orderItem.viewModel)
            orderCell.countStepper.isHidden = true

        return orderCell
       }
       
    }
    
    
}
