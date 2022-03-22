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
        

      
      //  self.updateState()
        self.renderUI()
        
        
        
    }
    func renderUI(){
        if let _ = AccountController.shared.accessToken {
            print("View orders")
            self.showOrders(animated: false)
        } else {
            self.showLogin(animated: false)
            print("View login")
        }
    }
    private func showOrders(animated: Bool) {
        let profileController: ProfileViewController = ProfileViewController.instantiateFromMainStoryboard()
        view.addSubview(profileController.view)
        self.addChild(profileController)
        
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
        let loginController: OnboardingParentViewController = OnboardingParentViewController()
        loginController.dismissButton .isHidden = true;
        view.addSubview(loginController.view)
        self.addChild(loginController)
    
    }

    
    
    

}
 
