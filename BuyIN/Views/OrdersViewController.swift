//
//  OrdersViewController.swift
//  BuyIN
//
//  Created by apple on 3/12/22.
//

import UIKit

class OrdersViewController: UIViewController {
    var AllordersArray: PageableArray<OrderViewModel>?

    @IBOutlet weak var ordersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib1 = UINib(nibName: "OrdersTableViewCell", bundle: nil)
        ordersTableView.register(nib1, forCellReuseIdentifier: "OrdersTableViewCell")
       // ordersTableView.separatorStyle = .none
        
    }


    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    

}
extension OrdersViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllordersArray?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ordersTableView.rowHeight = 259
        
        let orderCell = tableView.dequeueReusableCell(withIdentifier: "OrdersTableViewCell") as! OrdersTableViewCell
        orderCell.itemImage.layer.cornerRadius = 20
        orderCell.layer.cornerRadius = 20
       // itemCell.layer.borderWidth = 350
//        if indexPath.row == 1 {
//            itemCell.itemImage.image = UIImage(named: "lipstick")
//            itemCell.orderId.text = "Order #124"
//            itemCell.orderType.text = "Lipstick by charlotte tilbury"
//            itemCell.orderTime.text = "created: 28/2/2022"
//            itemCell.orderPrice.text = "$30"
//        }
        
        if let orderCount = AllordersArray?.items.count {
            if let order = AllordersArray?.items[indexPath.row]{
                orderCell.orderId.text = "Order #\(String(order.model.node.orderNumber))"
                let imageURL = order.model.node.lineItems.edges[0].node.variant?.image?.url
                orderCell.itemImage.setImageFrom(imageURL)
                //print(order1.model.node.lineItems.edges[0].node.variant?.image)
                //orderCell.NameOfItem.text = order1.model.node.name
                let dateOfCreation = DateFormatterClass.dateFormatter(date: order.model.node.processedAt)
                orderCell.orderTime.text = dateOfCreation

                let totalPriceMoney = order.model.node.currentTotalPrice
                orderCell.orderPrice.text = Currency.stringFrom(totalPriceMoney.amount, totalPriceMoney.currencyCode.rawValue)
            }
        }
        else
        {
            //return no orders cell
        }
        return orderCell
    }
    
    
}
extension OrdersViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetailsViewController = OrdersDetailsViewController(nibName: "OrdersDetailsViewController", bundle: nil)
        orderDetailsViewController.ordersDetails = AllordersArray?.items[indexPath.row]
        

        // Present View "Modally"
        self.present(orderDetailsViewController, animated: true, completion: nil)
    }
}
