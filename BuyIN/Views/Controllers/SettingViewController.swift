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
    
    @IBAction func Dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
            cell.signOutLabel.isHidden = true
            return cell
        }
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Address Book"
                cell.signOutLabel.isHidden = true
            case 1:
                cell.textLabel?.text = "My payment Options"
                cell.signOutLabel.isHidden = true
            case 2 :
                cell.textLabel?.text = "Account Security"
                cell.signOutLabel.isHidden = true
            default:
                cell.textLabel?.text = ""
                cell.signOutLabel.isHidden = true
            }
           
            return cell
        }
        if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Country/Region"
                cell.signOutLabel.isHidden = true
            case 1:
                cell.textLabel?.text = "Language"
                cell.signOutLabel.isHidden = true
            case 2 :
                cell.textLabel?.text = "Currency"
                cell.signOutLabel.isHidden = true
            case 3 :
                cell.textLabel?.text = "Contact prefrences"
                cell.signOutLabel.isHidden = true
            case 4 :
                cell.textLabel?.text = "Clear Cashe"
                cell.signOutLabel.isHidden = true
            default:
                cell.textLabel?.text = ""
                cell.signOutLabel.isHidden = true
            }
           
            return cell
        }
        if indexPath.section == 3 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Rating & Feadback"
                cell.signOutLabel.isHidden = true
            case 1:
                cell.textLabel?.text = "Contact with us"
                cell.signOutLabel.isHidden = true
            case 2 :
                cell.textLabel?.text = "About BuyIn"
                cell.signOutLabel.isHidden = true
            case 3 :
                cell.textLabel?.text = "Manage Cookies"
                cell.signOutLabel.isHidden = true
            default:
                cell.textLabel?.text = ""
                cell.signOutLabel.isHidden = true
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

extension SettingViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 4 {
            let loginController: OnboardingParentViewController = OnboardingParentViewController()
            if let accessToken = AccountController.shared.accessToken{
            Client.shared.logout(accessToken: accessToken) { (AccessToken) in
                AccountController.shared.deleteAccessToken()
                print(AccessToken)
                print("LoggedOut")
              //  coordinator.renderUI()
                self.navigationController?.navigationBar.isHidden = true
                loginController.dismissButton .isHidden = true;
                
                self.view.addSubview(loginController.view)
                self.addChild(loginController)
                
            }
            }
        }
    }
}
