//
//  CustomerCoordinatorStoryBViewController.swift
//  BuyIN
//
//  Created by apple on 3/12/22.
//

import UIKit

class CustomerCoordinatorStoryBViewController: UIViewController {
    private let hostController = UINavigationController(navigationBarClass: UINavigationBar.self, toolbarClass: UIToolbar.self)
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

      
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
        
        let profileController: ProfileViewController = self.storyboard!.instantiateViewController()
        view.addSubview(profileController.view)
        self.addChild(profileController)
    }
    
    private func showLogin(animated: Bool) {
        let loginController: LoginViewController = LoginViewController.instantiateFromNib()
        loginController.delegate = self
        view.addSubview(loginController.view)
        self.addChild(loginController)
        
       // self.present(loginController, animated: animated)
    
    }
    
    

}
extension CustomerCoordinatorStoryBViewController: LoginControllerDelegate {
    
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


