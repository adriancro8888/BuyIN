//
//  CustomerCoordinator.swift
//  BuyIN
//
//  Created by Akram Elhayani on 12/03/2022.
//

import UIKit

class CustomerCoordinator: UIViewController {

    
    private let hostController = UINavigationController(navigationBarClass: UINavigationBar.self, toolbarClass: UIToolbar.self)
    // ----------------------------------
    //  MARK: - To be replaced after adding customer screen  -
    //
    
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var emailLable: UILabel!
    
    @IBOutlet weak var phoneLable: UILabel!
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        guard let accessToken = AccountController.shared.accessToken else {
            return
        }
        
        Client.shared.logout(accessToken: accessToken) { success in
            if success {
                AccountController.shared.deleteAccessToken()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    // ----------------------------------
    //  MARK: - View -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        self.updateState()
        
        if let _ = AccountController.shared.accessToken {
            print("View orders")
            self.showOrders(animated: false)
        } else {
            self.showLogin(animated: false)
            print("View login")
        }
        
        
        
    }
    private func showOrders(animated: Bool) {
// TODO view customer screen with orders
//        let token = AccountController.shared.accessToken
//        Client.shared.fetchCustomerAndOrders(accessToken: token!) { container in
//            if let container = container {
//                self.customer = container.customer
//                self.updateState()
//            }
//        }
//
 
       
        
    }
    
    var customer: CustomerViewModel?
    private func updateState() {
        guard let customer = self.customer else {
            self.nameLable.text  = nil
            self.emailLable.text = nil
            self.phoneLable.text = nil
            
            return
        }
        
        self.nameLable.text  = customer.displayName
        self.emailLable.text = customer.email
        self.phoneLable.text = customer.phoneNumber
    }
    
    private func showLogin(animated: Bool) {
        let loginController: LoginViewController = LoginViewController.instantiateFromNib()
        loginController.delegate = self
        view.addSubview(loginController.view)
        self.addChild(loginController)
        
       // self.present(loginController, animated: animated)
    
    }

    
    
    

}


// ----------------------------------
//  MARK: - CustomerControllerDelegate -
//
//extension CustomerCoordinator: CustomerControllerDelegate {
//    func customerControllerDidCancel(_ customerController: CustomerViewController) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    func customerControllerDidLogout(_ customerController: CustomerViewController) {
//        guard let accessToken = AccountController.shared.accessToken else {
//            return
//        }
//
//        Client.shared.logout(accessToken: accessToken) { success in
//            if success {
//                AccountController.shared.deleteAccessToken()
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
//}

// ----------------------------------
//  MARK: - LoginControllerDelegate -
//
extension CustomerCoordinator: LoginControllerDelegate {
    
    func loginControllerDidCancel(_ loginController: LoginViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loginController(_ loginController: LoginViewController, didLoginWith email: String, passowrd: String) {
        Client.shared.login(email: email, password: passowrd) { accessToken in
            if let accessToken = accessToken {
                AccountController.shared.save(accessToken: accessToken)
                self.showOrders(animated: true)
            } else {
                let alert = UIAlertController(title: "Login Error", message: "Failed to login a customer with this email and password. Please check your credentials and try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
