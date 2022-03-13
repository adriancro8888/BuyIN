//
//  OrdersViewController.swift
//  BuyIN
//
//  Created by apple on 3/12/22.
//

import UIKit

class OrdersViewController: UIViewController {

    @IBOutlet weak var ordersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib1 = UINib(nibName: "OrdersTableViewCell", bundle: nil)
        ordersTableView.register(nib1, forCellReuseIdentifier: "OrdersTableViewCell")
        ordersTableView.separatorStyle = .none
        
    }


    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    

}
extension OrdersViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ordersTableView.rowHeight = 259
        
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

