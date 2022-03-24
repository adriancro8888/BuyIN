//
//  ResetPasswordViewController.swift
//  BuyIN
//
//  Created by Akram Elhayani on 15/03/2022.
//

import Foundation
import UIKit
class ResetPasswordViewController: UIViewController {

   var onBoarding : OnboardingParentViewController?
  
   private let loginLabel: UILabel = {
      
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.text = "Reset password"
       label.numberOfLines = 0
       label.font = .systemFont(ofSize: 50, weight: .bold)
       label.alpha = 0
       label.textColor = .white
       label.layer.shadowColor = UIColor.black.cgColor
       label.layer.shadowRadius = 10
       label.layer.shadowOpacity = 1
       label.layer.shadowOffset = CGSize(width: 4, height: 4)
       label.layer.masksToBounds = false
       return label
   }()
 

   
   private lazy var blurredVisualEffect: UIVisualEffectView = {
       let blurEffect = UIBlurEffect(style: .dark)
       let view = UIVisualEffectView(effect: blurEffect)
       view.translatesAutoresizingMaskIntoConstraints = false
       view.clipsToBounds = true
       view.layer.masksToBounds = true
       view.layer.cornerRadius = 30
       return view
   }()
   
   private lazy var userEmailField: UITextField = {
       let field = UITextField()
       field.returnKeyType = .next
       field.leftViewMode = .always
       field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
       field.autocapitalizationType = .none
       field.autocorrectionType = .no
       field.layer.masksToBounds = true
       field.backgroundColor = .white
       field.layer.cornerRadius = 10
       field.inputAccessoryView = doneToolBar
       field.translatesAutoresizingMaskIntoConstraints = false
       field.attributedPlaceholder = NSAttributedString(
           string: "Email",
           attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
       )
       return field
   }()
   
   @objc private func didTapDone() {
       for _view in view.subviews {
           if _view.isFirstResponder {
               _view.resignFirstResponder()
               break
           }
       }
   }
   
   private lazy var doneToolBar: UIToolbar = {
       let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
       toolbar.barStyle = .default
       let spacing = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDone))
       toolbar.items = [spacing, doneButton]
       return toolbar
   }()
   
  
   
   private let continueButton: UIButton = {
       let button = UIButton(type: .system)
       button.tintColor = .white
       button.backgroundColor = .systemGreen
       button.setTitle("Send Email", for: .normal)
       button.layer.masksToBounds = true
       button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
       button.layer.cornerRadius = 10
       button.clipsToBounds = true
       button.translatesAutoresizingMaskIntoConstraints = false
       return button
   }()
   
  
   
   private let signinButton: UIButton = {
       let button = UIButton(type: .system)
       button.setTitle("Sign in", for: .normal)
       button.translatesAutoresizingMaskIntoConstraints = false
       button.tintColor = .systemGreen
       button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
       return button
   }()
   
  
   override func viewDidLoad() {
       super.viewDidLoad()

       
       view.addSubview(blurredVisualEffect)
       view.addSubview(loginLabel)
       view.addSubview(userEmailField)
       view.addSubview(signinButton)
       view.addSubview(continueButton)
       configureConstraints()
       continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
       signinButton.addTarget(self, action: #selector(didTapSignin), for: .touchUpInside)
   }
 
   
   @objc private func didTapContinue() {
       Client.shared.resetPassword(withEmail: userEmailField.text ?? "") { errorMessage in
           
           if let errorMessage = errorMessage{
               let alert = UIAlertController(title: "Reset Error", message: errorMessage, preferredStyle: .alert)
                              alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                              self.present(alert, animated: true, completion: nil)
               
           }else{
               let alert = UIAlertController(title: "Email was sent ", message: "we have send you an email with a reset link .", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: {   _ in
                   if let onBoarding = self.onBoarding {
                       onBoarding.scrollView.setContentOffset(CGPoint(x: 0 , y: 0), animated: true)
                   }
               }))
                              self.present(alert, animated: true, completion: nil)
               
               
           }
           
           
       }
   }
   
   @objc private func didTapSignin() {
       if let onBoarding = self.onBoarding {
           onBoarding.scrollView.setContentOffset(CGPoint(x: 0 , y: 0), animated: true)
       }
   }
   
 
    

   override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
       UIView.animate(withDuration: 1, delay: 0.4, options: .curveEaseOut) { [weak self] in
           self?.loginLabel.alpha = 1
       }
   }
   
   private func configureConstraints() {
       
  
       
       let blurredVisualEffectConstraints = [
           blurredVisualEffect.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           blurredVisualEffect.heightAnchor.constraint(equalToConstant: 420),
           blurredVisualEffect.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           blurredVisualEffect.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180)
       ]
       
       
       let loginLabelConstraints = [
           loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           loginLabel.bottomAnchor.constraint(equalTo: blurredVisualEffect.topAnchor, constant: -10),
           loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
       ]
       

       
       let userEmailFieldConstraints = [
           userEmailField.leadingAnchor.constraint(equalTo: blurredVisualEffect.leadingAnchor, constant: 20),
           userEmailField.trailingAnchor.constraint(equalTo: blurredVisualEffect.trailingAnchor, constant: -20),
           userEmailField.topAnchor.constraint(equalTo: blurredVisualEffect.topAnchor, constant: 30),
           userEmailField.heightAnchor.constraint(equalToConstant: 60)
       ]
       
   
       let continueButtonConstraints = [
           continueButton.topAnchor.constraint(equalTo: userEmailField.bottomAnchor, constant: 25),
           continueButton.leadingAnchor.constraint(equalTo: userEmailField.leadingAnchor, constant: 0),
           continueButton.trailingAnchor.constraint(equalTo: userEmailField.trailingAnchor, constant: 0),
           continueButton.heightAnchor.constraint(equalToConstant: 70)
   
       ]
       
 
       
       let signinButtonConstraints = [
           signinButton.leadingAnchor.constraint(equalTo: continueButton.leadingAnchor),
           signinButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 15),
           signinButton.heightAnchor.constraint(equalToConstant: 20),
           signinButton.widthAnchor.constraint(equalToConstant: 60)
       ]

       NSLayoutConstraint.activate(blurredVisualEffectConstraints)
       NSLayoutConstraint.activate(loginLabelConstraints)
       NSLayoutConstraint.activate(userEmailFieldConstraints)
       NSLayoutConstraint.activate(continueButtonConstraints)
       NSLayoutConstraint.activate(signinButtonConstraints)
   }

}

