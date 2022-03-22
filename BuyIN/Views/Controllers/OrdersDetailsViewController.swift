//
//  OrdersDetailsViewController.swift
//  BuyIN
//
//  Created by Yousra Eid on 3/14/22.
//

import UIKit

class OrdersDetailsViewController: UIViewController {
     var userInfo : CustomerViewModel?
//    var ordersArray: PageableArray<OrderViewModel>?
    var ordersDetails: OrderViewModel?

    
    @IBOutlet weak var orderNumber: UILabel!
    
    @IBOutlet weak var timeOfProcess: UILabel!
    @IBOutlet weak var orderDetailsCollectionView: StorefrontCollectionView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let orderDetailsNib = UINib(nibName: "OrderDetailsCollectionViewCell", bundle: nil)
        orderDetailsCollectionView.register(orderDetailsNib, forCellWithReuseIdentifier: "OrderDetailsCollectionViewCell")
        let cartNib = UINib(nibName: "OrderCollectionViewCell", bundle: nil)
        orderDetailsCollectionView.register(cartNib, forCellWithReuseIdentifier: "OrderCollectionViewCell")
        let orderSummary = UINib(nibName: "OrderDetailsSummaryCollectionViewCell", bundle: nil)
        orderDetailsCollectionView.register(orderSummary, forCellWithReuseIdentifier: "OrderDetailsSummaryCollectionViewCell")
       let orderID = ordersDetails?.model.node.orderNumber ?? 0
        orderNumber.text = String("OrderID - #\(orderID)")
        if let dateOfOrder = ordersDetails?.model.node.processedAt{
            let dateString = DateFormatterClass.dateFormatter(date: dateOfOrder)
        timeOfProcess.text = "Placed on \(dateString)"
        
    }
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
        }else if indexPath.row > (ordersDetails?.model.node.lineItems.edges.count ?? 0){
            return CGSize(width: 407, height: 242)
        }
        else {
            return CGSize(width: 407, height: 190)
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
    
        return (ordersDetails?.model.node.lineItems.edges.count ?? 0)+2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let orderDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderDetailsCollectionViewCell", for: indexPath) as! OrderDetailsCollectionViewCell
            orderDetailCell.myView.layer.borderWidth = 0.5
            orderDetailCell.myView.layer.borderColor = UIColor.black.cgColor
            let country = ordersDetails?.model.node.shippingAddress?.country ?? ""
            let city = ordersDetails?.model.node.shippingAddress?.city ?? ""
            let address = ordersDetails?.model.node.shippingAddress?.address1 ?? ""
            let addressFormat = country + ", " + city + ", " + address
            
            orderDetailCell.shippingAdress.text = addressFormat
            //orderDetailCell.phoneNumbers.text = ordersDetails?.model.node.phone
            orderDetailCell.phoneNumbers.text = userInfo?.phoneNumber
            let fulfillmentStatus = ordersDetails?.model.node.fulfillmentStatus.rawValue.replacingOccurrences(of: "_", with: " ")
            orderDetailCell.stateOfOrder.text = fulfillmentStatus
            return orderDetailCell
        }else if indexPath.row > (ordersDetails?.model.node.lineItems.edges.count ?? 0){
            
            let orderSummaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderDetailsSummaryCollectionViewCell", for: indexPath) as! OrderDetailsSummaryCollectionViewCell
            
            var items : Decimal = 0
            var shippingCost : Decimal = 0
            var taxCost : Decimal = 0
            var totalOrder: Decimal = 0

            
            let orderSummary = ordersDetails?.model.node
            
            if let lineItems = orderSummary?.lineItems.edges{
            for lineItem in lineItems{
                items += lineItem.node.originalTotalPrice.amount
            }
            }
            
            if let totalOrderBeforeAny = orderSummary?.currentSubtotalPrice {
            totalOrder = totalOrderBeforeAny.amount
            }
            
            if let shipping = orderSummary?.totalShippingPriceV2{
                shippingCost = shipping.amount
            }
            
            if let taxes = orderSummary?.totalTaxV2 {
                taxCost = taxes.amount
            }
            

            
            orderSummaryCell.TotalOrderBefore.text = Currency.stringFrom(items, "EGP")
            
            orderSummaryCell.shipping.text = Currency.stringFrom(shippingCost, "EGP")
            
            orderSummaryCell.taxes.text = Currency.stringFrom(taxCost, "EGP")
            
            orderSummaryCell.totalBeforeDiscount.text = Currency.stringFrom(items + shippingCost, "EGP")
            
            orderSummaryCell.discountCode.text = Currency.stringFrom(items - totalOrder,"EGP")
            if let totalOrder = orderSummary?.totalPriceV2 {
            orderSummaryCell.orderTotal.text = Currency.stringFrom(totalOrder.amount, totalOrder.currencyCode.rawValue)
            }
            
           return orderSummaryCell
        }
        else{
            let orderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCollectionViewCell", for: indexPath) as! OrderCollectionViewCell
            //let orderItem = CartController.shared.orders[indexPath.row]
//            orderCell.cartDelegate = self
//            orderCell.configureFrom(orderItem.viewModel)
//            orderCell.countStepper.isHidden = true
            orderCell.myView.layer.borderWidth = 0.5
            orderCell.myView.layer.borderColor = UIColor.black.cgColor
            let orderItem = ordersDetails?.model.node.lineItems.edges[indexPath.row-1].node
            orderCell.orderNumber.text = orderItem?.title
            let imageURL = orderItem?.variant?.image?.url
            orderCell.orderImage.setImageFrom(imageURL)
            //print(order1.model.node.lineItems.edges[0].node.variant?.image)
            //orderCell.NameOfItem.text = order1.model.node.name
            orderCell.dateOfOrder.text = "Quantity: \(String(orderItem?.currentQuantity ?? 0))"
            orderCell.firstItemInOrderImage.isHidden = true
            orderCell.secondItemInOrderImage.isHidden = true
            orderCell.moreButton.isHidden = true

            if let totalPriceMoney = orderItem?.discountedTotalPrice {
            orderCell.totalPrice.text = Currency.stringFrom(totalPriceMoney.amount, totalPriceMoney.currencyCode.rawValue)
            }
            

        return orderCell
        }
       
    }
    
    
}

