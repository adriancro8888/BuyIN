//
//  SettingViewController.swift
//  BuyIN
//
//  Created by apple on 3/18/22.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    var userInfo : CustomerViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOrders()

       let nib = UINib(nibName: "SettingTableViewCell", bundle: nil)
        settingTableView.register(nib, forCellReuseIdentifier: "SettingTableViewCell")
        
    }
    func fetchOrders(after cursuer:String? = nil) {
        if let accessToken = AccountController.shared.accessToken{
            print("acesstoken :\(accessToken)")
            Client.shared.fetchCustomerAndOrders(  after: cursuer, accessToken: accessToken){
                container in
                if let container = container{
                    
                    self.userInfo = container.customer
                    //self.ordersArray = container.orders
                    self.settingTableView.reloadData()
                    
                    
                    
                  //  let order =  self.ordersArray?.items[0].model..lineItems.edges[0].node.
                    
                }
            }
        }
    }



}
extension SettingViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 5
        case 3:
            return 4
        case 4:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell")as! SettingTableViewCell
        if indexPath.section == 0 {
            cell.textLabel?.text = userInfo?.email
            return cell
        }
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Address Book"
            case 1:
                cell.textLabel?.text = "My payment Options"
            case 2 :
                cell.textLabel?.text = "Account Security"
            default:
                cell.textLabel?.text = ""
            }
           
            return cell
        }
        if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Country/Region"
            case 1:
                cell.textLabel?.text = "Language"
            case 2 :
                cell.textLabel?.text = "Currency"
            case 3 :
                cell.textLabel?.text = "Contact prefrences"
            case 4 :
                cell.textLabel?.text = "Clear Cashe"
            default:
                cell.textLabel?.text = ""
            }
           
            return cell
        }
        if indexPath.section == 3 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Rating & Feadback"
            case 1:
                cell.textLabel?.text = "Contact with us"
            case 2 :
                cell.textLabel?.text = "About BuyIn"
            case 3 :
                cell.textLabel?.text = "Manage Cookies"
            default:
                cell.textLabel?.text = ""
            }
           
            return cell
        }
        if indexPath.section == 4 {

            cell.signOutLabel.text = "Sign out"
           
            return cell
        }
        return cell
    }
    
    
}
