//
//  RegistrationViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 13/03/2022.
//

import UIKit

 
class RegistrationViewController: UIViewController {
    
    weak var onBoarding: OnboardingParentViewController?
    
    private lazy var blurredVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    
    private lazy var firstNameField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor = .white
        field.textColor = .black
        field.layer.cornerRadius = 10
        field.delegate = self
        field.inputAccessoryView = doneToolBar
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(
            string: "First Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return field
    }()
    
    private lazy var lasNameField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.textColor = .black
        field.backgroundColor = .white
        field.layer.cornerRadius = 10
        field.delegate = self
        field.inputAccessoryView = doneToolBar
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(
            string: "Last Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return field
    }()
    
    private lazy var emailField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor = .white
        field.textColor = .black
        field.layer.cornerRadius = 10
        field.delegate = self
        field.inputAccessoryView = doneToolBar
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return field
    }()
    

    
    private lazy var phoneField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.textColor = .black
        field.layer.masksToBounds = true
        field.backgroundColor = .white
        field.layer.cornerRadius = 10
        field.delegate = self
        field.inputAccessoryView = doneToolBar
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(
            string: "Phone",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return field
    }()
    
    private lazy var passwordField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor = .white
        field.textColor = .black
        field.isSecureTextEntry = true
        field.delegate = self
        field.layer.cornerRadius = 10
        field.inputAccessoryView = doneToolBar
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return field
    }()
    
    private let signupLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign up"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 50, weight: .bold)
        label.alpha = 1
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 10
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.layer.masksToBounds = false
        return label
    }()
    
    private let doneToolBar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        toolbar.barStyle = .black
        let spacing = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDone))
        toolbar.items = [spacing, doneButton]
        return toolbar
    }()
    
    @objc private func didTapDone() {
        for _view in scrollView.subviews {
            if _view.isFirstResponder {
                _view.resignFirstResponder()
                break
            }
        }
    }

    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.setTitle("Register", for: .normal)
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Already have an account?"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let tacPromptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "By clicking register you agree to our"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    
    private let tacButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Terms and conditions", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemGreen
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        return button
    }()
    
    
    private let signInButton: UIButton = {
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
        blurredVisualEffect.contentView.addSubview(scrollView)
        view.addSubview(signupLabel)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lasNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(phoneField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(continueButton)
        scrollView.addSubview(registerButton)
        scrollView.addSubview(promptLabel)
        scrollView.addSubview(signInButton)
        scrollView.addSubview(tacPromptLabel)
        scrollView.addSubview(tacButton)
        scrollView.contentSize = CGSize(
            width: (view.frame.width - 40) * 2,
            height: blurredVisualEffect.frame.height)
        configureConstraints()
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        registerButton.isEnabled = false
        continueButton.isEnabled = false
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        
        
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        
        tacButton.addTarget(self, action: #selector(didTapTacButton), for: .touchUpInside)
        
    }
    
    private func isValidEmail(_ email: String) -> String? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email) ? email : nil
    }
    @objc private func didTapRegister() {
        
        
        Client.shared.CreateCustomer(firstName: self.firstNameField.text!, lastName: self.lasNameField.text!, phone: self.phoneField.text!, email: self.emailField.text!, password: self.passwordField.text!) { [self] customer, errors in
            
            if let customer = customer {
                
                let alert = UIAlertController(title: "Success", message: "Registeration Succeded \n \(customer.createdAt)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            
                    
                    Client.shared.login(email: self.emailField.text!, password: self.passwordField.text!) { accessToken in
                        if let accessToken = accessToken {
                            AccountController.shared.save(accessToken: accessToken)
                           
                        }
                    }
                        
                        
                        
                    let homeVC: UITabBarController = UITabBarController.instantiateFromMainStoryboard()
                    homeVC.modalTransitionStyle = .crossDissolve;
                    homeVC.modalPresentationStyle = .fullScreen;
                    self.present(homeVC, animated: true) {
                        
                    }
                    
                    
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
                
            }  else {
                if let errors = errors  {
                    if errors .count > 0 {
                        let alert = UIAlertController(title: "Failed to register", message: errors[0].message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                    }
                    let alert = UIAlertController(title: "Failed to register", message:"Unknowen error !", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                    
                }
             
                
            }
            
        }
        
    }
    @objc private func didTapContinue() {
        guard let email = emailField.text,
              let validEmail = isValidEmail(email) else {
                  let alert = UIAlertController(title: "Error", message: "Please enter a valid Email", preferredStyle: .alert)
                  let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                  alert.addAction(action)
                  present(alert, animated: true)
                  return
              }
        
        scrollView.setContentOffset(CGPoint(x: scrollView.contentSize.width / 2, y: 0), animated: true)
    }
    
    @objc private func didTapTacButton() {
        let vc = TermsAndConditionsViewController()
        present(vc, animated: true)
    }
    
    @objc private func didTapSignIn() {
        self.registrationViewControllerDidTapSignIn()
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
    private func configureConstraints() {
        let blurredVisualEffectConstraints = [
            blurredVisualEffect.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            blurredVisualEffect.heightAnchor.constraint(equalToConstant: 440),
            blurredVisualEffect.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            blurredVisualEffect.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180)
        ]
        
        let firstNameFieldConstraints = [
            firstNameField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            firstNameField.widthAnchor.constraint(equalToConstant: (scrollView.contentSize.width / 2) - 40
        ),
            firstNameField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            firstNameField.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let lasNameFieldConstraints = [
            lasNameField.leadingAnchor.constraint(equalTo: firstNameField.leadingAnchor),
            lasNameField.trailingAnchor.constraint(equalTo: firstNameField.trailingAnchor),
            lasNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 30),
            lasNameField.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let emailFieldConstraints = [
            emailField.leadingAnchor.constraint(equalTo: lasNameField.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: lasNameField.trailingAnchor),
            emailField.topAnchor.constraint(equalTo: lasNameField.bottomAnchor, constant: 30),
            emailField.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let phoneFieldConstraints = [
            phoneField.leadingAnchor.constraint(equalTo: firstNameField.trailingAnchor, constant: 40),
            phoneField.widthAnchor.constraint(equalToConstant: (scrollView.contentSize.width / 2) - 40),
            phoneField.topAnchor.constraint(equalTo: firstNameField.topAnchor),
            phoneField.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let passwordFieldConstraints = [
            passwordField.leadingAnchor.constraint(equalTo: phoneField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: phoneField.trailingAnchor),
            passwordField.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 30),
            passwordField.heightAnchor.constraint(equalToConstant: 60)
        ]
        let signupLabelConstraints = [
            signupLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signupLabel.bottomAnchor.constraint(equalTo: blurredVisualEffect.topAnchor, constant: -10),
            signupLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        let registerButtonConstraints = [
            registerButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
            registerButton.heightAnchor.constraint(equalToConstant: 60),
            registerButton.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor)
        ]
        
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: blurredVisualEffect.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: blurredVisualEffect.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: blurredVisualEffect.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: blurredVisualEffect.bottomAnchor)
        ]
        
        let continueButtonConstraints = [
            continueButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            continueButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 30),
            continueButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let promptLabelConstraints = [
            promptLabel.leadingAnchor.constraint(equalTo: continueButton.leadingAnchor),
            promptLabel.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 30)
        ]
        
        let signInButtonConstraints = [
            signInButton.leadingAnchor.constraint(equalTo: promptLabel.trailingAnchor, constant: 5),
            signInButton.centerYAnchor.constraint(equalTo: promptLabel.centerYAnchor)
        ]
        
        let tacPromptLabelConstraints = [
            tacPromptLabel.leadingAnchor.constraint(equalTo: registerButton.leadingAnchor),
            tacPromptLabel.bottomAnchor.constraint(equalTo: blurredVisualEffect.bottomAnchor, constant: -60)
        ]
        
        let tacButtonConstraints = [
            tacButton.leadingAnchor.constraint(equalTo: tacPromptLabel.leadingAnchor),
            tacButton.topAnchor.constraint(equalTo: tacPromptLabel.bottomAnchor, constant: 5)
        ]
        
        NSLayoutConstraint.activate(blurredVisualEffectConstraints)
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(firstNameFieldConstraints)
        NSLayoutConstraint.activate(lasNameFieldConstraints)
        NSLayoutConstraint.activate(emailFieldConstraints)
        NSLayoutConstraint.activate(signupLabelConstraints)
        NSLayoutConstraint.activate(continueButtonConstraints)
        NSLayoutConstraint.activate(phoneFieldConstraints)
        NSLayoutConstraint.activate(passwordFieldConstraints)
        NSLayoutConstraint.activate(registerButtonConstraints)
        NSLayoutConstraint.activate(promptLabelConstraints)
        NSLayoutConstraint.activate(signInButtonConstraints)
        NSLayoutConstraint.activate(tacPromptLabelConstraints)
        NSLayoutConstraint.activate(tacButtonConstraints)
    }
}

extension RegistrationViewController: UITextFieldDelegate {

    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let firstName = firstNameField.text,
              let lastName = lasNameField.text,
              let email = emailField.text,
              firstName.count > 0,
              lastName.count > 0,
              email.count > 0 else {
                  continueButton.alpha = 0.9
                  continueButton.isEnabled = false
                  return
              }
        continueButton.alpha = 1
        continueButton.isEnabled = true
        
        
        guard let phone = phoneField.text,
              let password = passwordField.text,
              password.count > 8 else {
                  registerButton.alpha = 0.9
                  registerButton.isEnabled = false
                  return
              }
        registerButton.alpha = 1
        registerButton.isEnabled = true
    }
}
