//
//  CreateNewCustomerViewController.swift
//  BuyIN
//
//  Created by Akram Elhayani on 11/03/2022.
//

import UIKit

class CreateNewCustomerViewController: UIViewController {

//MARK: - Outlets -

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordConfrmation: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func inputFieldsValueChanged(_ sender: Any) {
        
        
    }
    func validateInput() -> (isValid:Bool,Errors:[String]) {
        var errors = [String]() ;
        
        // TODO Extra emaile validateion
        if emailAddress.text?.count == 0{
            errors.append("Error in email address ")
            // TODO view error in UI
        }
        // TODO Extra phone validateion
        if phoneNumber.text?.count == 0{
            errors.append("Error in phone number ")
            // TODO view error in UI
        }
        if lastName.text?.count == 0{
            errors.append("Error in last name ")
            // TODO view error in UI
        }
        if firstName.text?.count == 0{
            errors.append("Error in first name ")
            // TODO view error in UI
        }
        // TODO Extra password validateion
        if password.text?.count == 0{
            errors.append("Error in password ")
            // TODO view error in UI
        }
        if passwordConfrmation.text?.count == 0 || passwordConfrmation.text != password.text{
            errors.append("Error in password confrmation ")
            // TODO view error in UI
        }
        return (errors.count==0,errors)
    }
    @IBAction func registerClicked(_ sender: Any) {
        
        let validationResult = validateInput()
        if(validationResult.isValid == false){
            //TODO handel validation Error
            return;
        }
        
        Client.shared.CreateCustomer(firstName: firstName.text!, lastName: lastName.text!, phone: phoneNumber.text!, email: emailAddress.text!, password: password.text!) { customer, errors in
            
            if let customer = customer {
                
                let alert = UIAlertController(title: "Success", message: "Register Succeded \n \(customer.id)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                   
                    self.dismiss(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                
                
            }  else {
                let alert = UIAlertController(title: "Login Error", message: "Failed to regester. Please check your credentials and try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
            }
            
                  }
        
        
    }
    
   

    
}
