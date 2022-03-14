//
//  LoginViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 13/03/2022.
//

import UIKit

class SecondLoginViewController: UIViewController {

    

    private let loginLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign in"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 50, weight: .bold)
        label.alpha = 0
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 10
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.layer.masksToBounds = false
        return label
    }()


    
    private lazy var blurredVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let userEmailField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor = .white
        field.layer.cornerRadius = 10
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return field
    }()
    
    private let userPasswordField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor = .white
        field.layer.cornerRadius = 10
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

        view.addSubview(userEmailField)
        view.addSubview(userPasswordField)
        view.addSubview(continueButton)
        view.addSubview(promptLabel)
        view.addSubview(signUpButton)
        view.addSubview(forgotPasswordButton)
        configureConstraints()
        
        
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
            blurredVisualEffect.heightAnchor.constraint(equalToConstant: 400),
            blurredVisualEffect.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            blurredVisualEffect.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
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
            promptLabel.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20)
        ]
        
        let signUpButtonConstraints = [
            signUpButton.leadingAnchor.constraint(equalTo: promptLabel.trailingAnchor, constant: 5),
            signUpButton.centerYAnchor.constraint(equalTo: promptLabel.centerYAnchor)
        ]
        
        let forgotPasswordButtonConstraints = [
            forgotPasswordButton.leadingAnchor.constraint(equalTo: blurredVisualEffect.leadingAnchor, constant: 20),
            forgotPasswordButton.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 20)
        ]


        NSLayoutConstraint.activate(blurredVisualEffectConstraints)
        NSLayoutConstraint.activate(loginLabelConstraints)

        NSLayoutConstraint.activate(userEmailFieldConstraints)
        NSLayoutConstraint.activate(userPasswordFieldConstraints)
        NSLayoutConstraint.activate(continueButtonConstraints)
        NSLayoutConstraint.activate(promptLabelConstraints)
        NSLayoutConstraint.activate(signUpButtonConstraints)
        NSLayoutConstraint.activate(forgotPasswordButtonConstraints)
    }

}
