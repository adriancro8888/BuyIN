//
//  LoginViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 13/03/2022.
//

import UIKit

 
 
class LoginViewController: UIViewController {

    var onBoarding : OnboardingParentViewController?
   
    private let loginLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign in"
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

    
    private let guestButton: UIButton = {
       
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle("Continue Shopping as a guest", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        return button
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
        field.backgroundColor = UIColor.systemBackground
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
    
    private let doneToolBar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        toolbar.barStyle = .black
        let spacing = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDone))
        toolbar.items = [spacing, doneButton]
        return toolbar
    }()
    
    private lazy var userPasswordField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        field.layer.masksToBounds = true
        field.backgroundColor =  UIColor.systemBackground
        field.layer.cornerRadius = 10
        field.inputAccessoryView = doneToolBar
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return field
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.setTitle("Continue", for: .normal)
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let promptLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemGreen
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot your password?", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemGreen
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blurredVisualEffect)
        view.addSubview(loginLabel)
        view.addSubview(guestButton)
        view.addSubview(userEmailField)
        view.addSubview(userPasswordField)
        view.addSubview(continueButton)
        view.addSubview(promptLabel)
        view.addSubview(signUpButton)
        view.addSubview(forgotPasswordButton)
        configureConstraints()
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignup), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        guestButton.addTarget(self, action: #selector(didTapLoginAsGuest), for: .touchUpInside)
        
    }
    
    @objc private func didTapLoginAsGuest() {
       self.loginViewControllerDelegateDidTapLoginAsGuest()
    }
    
    @objc private func didTapContinue() {
      self.loginViewControllerDelegateDidTapContinue(email : self.userEmailField.text ?? "" , password : self.userPasswordField.text ?? "")
    }
    
    @objc private func didTapSignup() {
       self.loginViewControllerDelegateDidTapSignup()
    }
    
    @objc private func didTapForgotPassword() {
        self.loginViewControllerDelegateDidTapForgotPassword()
    }
    
    
    
    
    
    func loginViewControllerDelegateDidTapContinue(email: String, password: String) {
        Client.shared.login(email: email, password: password) { accessToken in
            if let accessToken = accessToken {
                AccountController.shared.save(accessToken: accessToken)
                
                let homeVC: UITabBarController = UITabBarController.instantiateFromMainStoryboard()
                homeVC.modalTransitionStyle = .crossDissolve;
                homeVC.modalPresentationStyle = .fullScreen;
                self.present(homeVC, animated: true) {
                    
                }
            } else {
                let alert = UIAlertController(title: "Login Error", message: "Failed to login a customer with this email and password. Please check your credentials and try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    func loginViewControllerDelegateDidTapSignup() {
        
        if let onBoarding = self.onBoarding {
            
            onBoarding.scrollView.setContentOffset(CGPoint(x: onBoarding.scrollView.frame.width, y: 0), animated: true)
        }
       
    }
    
   
    
    func loginViewControllerDelegateDidTapForgotPassword() {
        if let onBoarding = self.onBoarding {
            
            onBoarding.scrollView.setContentOffset(CGPoint(x: onBoarding.scrollView.frame.width * 2 , y: 0), animated: true)
        }
    }
    
    func loginViewControllerDelegateDidTapLoginAsGuest() {
        let homeVC: UITabBarController = UITabBarController.instantiateFromMainStoryboard()
        homeVC.modalTransitionStyle = .crossDissolve;
        homeVC.modalPresentationStyle = .fullScreen;
        self.present(homeVC, animated: true) {
            
        }

    }
    
    func registrationViewControllerDidTapSignIn() {
        if let onBoarding = self.onBoarding {
            onBoarding.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
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
        
        let userPasswordFieldConstraints = [
            userPasswordField.leadingAnchor.constraint(equalTo: userEmailField.leadingAnchor),
            userPasswordField.trailingAnchor.constraint(equalTo: userEmailField.trailingAnchor),
            userPasswordField.topAnchor.constraint(equalTo: userEmailField.bottomAnchor, constant: 30),
            userPasswordField.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let continueButtonConstraints = [
            continueButton.topAnchor.constraint(equalTo: userPasswordField.bottomAnchor, constant: 25),
            continueButton.heightAnchor.constraint(equalToConstant: 70),
            continueButton.leadingAnchor.constraint(equalTo: blurredVisualEffect.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: blurredVisualEffect.trailingAnchor, constant: -20)
        ]
        
        let promptLabelConstraints = [
            promptLabel.leadingAnchor.constraint(equalTo: blurredVisualEffect.leadingAnchor, constant: 20),
            promptLabel.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 10)
        ]
        
        let signUpButtonConstraints = [
            signUpButton.leadingAnchor.constraint(equalTo: promptLabel.trailingAnchor, constant: 5),
            signUpButton.centerYAnchor.constraint(equalTo: promptLabel.centerYAnchor)
        ]
        
        let guestButtonConstraints = [
            guestButton.leadingAnchor.constraint(equalTo: promptLabel.leadingAnchor),
            guestButton.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 10)
        ]
        
        let forgotPasswordButtonConstraints = [
            forgotPasswordButton.leadingAnchor.constraint(equalTo: blurredVisualEffect.leadingAnchor, constant: 20),
            forgotPasswordButton.topAnchor.constraint(equalTo: guestButton.bottomAnchor, constant: 10)
        ]


        NSLayoutConstraint.activate(blurredVisualEffectConstraints)
        NSLayoutConstraint.activate(loginLabelConstraints)

        NSLayoutConstraint.activate(userEmailFieldConstraints)
        NSLayoutConstraint.activate(userPasswordFieldConstraints)
        NSLayoutConstraint.activate(continueButtonConstraints)
        NSLayoutConstraint.activate(promptLabelConstraints)
        NSLayoutConstraint.activate(signUpButtonConstraints)
        NSLayoutConstraint.activate(guestButtonConstraints)
        NSLayoutConstraint.activate(forgotPasswordButtonConstraints)
    }

}



////
///
///

