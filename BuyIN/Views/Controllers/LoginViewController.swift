//
//  LoginViewController.swift
//  BuyIN
//
//  Created by Akram Elhayani on 11/03/2022.
//

import UIKit
protocol LoginControllerDelegate: AnyObject {
    func loginControllerDidCancel(_ loginController: LoginViewController)
    func loginController(_ loginController: LoginViewController, didLoginWith email: String, passowrd: String)
}



class LoginViewController: UIViewController {

   // private weak var loginButton:   UIButton!
   // private weak var usernameField: UITextField!
   // private weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    
   

    private var email: String {
        return self.usernameField.text ?? ""
    }
    
    private var password: String {
        return self.passwordField.text ?? ""
    }
    
    weak var delegate: LoginControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        self.updateLoginState()
    }
    @IBAction func createAccontClicked(_ sender: Any) {
        
         let view:CreateNewCustomerViewController = CreateNewCustomerViewController.instantiateFromNib()
         self.present(view, animated: true, completion: nil)
      //  self.dismiss(animated:true, completion: nil)
    }
    
    private func updateLoginState() {
        let isValid = !self.email.isEmpty && !self.password.isEmpty
        
        self.loginButton.isEnabled = isValid
        self.loginButton.alpha     = isValid ? 1.0 : 0.5
    }

    @IBAction private func textFieldValueDidChange(textField: UITextField) {
        self.updateLoginState()
    }
    
    @IBAction private func loginAction(_ sender: UIButton) {
        self.delegate?.loginController(self, didLoginWith: self.email, passowrd: self.password)
    }
    
    @IBAction private func cancelAction(_ sender: UIButton) {
        self.delegate?.loginControllerDidCancel(self)
    }
}

// ----------------------------------
//  MARK: - Actions -
//
 
