//
//  RegistrationViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 13/03/2022.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private lazy var blurredVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let firstNameField: UITextField = {
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
            string: "First Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return field
    }()
    
    private let lasNameField: UITextField = {
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
            string: "last Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return field
    }()
    
    private let emailField: UITextField = {
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
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return field
    }()
    
    
    private let phoneField: UITextField = {
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
            string: "Phone",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return field
    }()
    
    private let passwordField: UITextField = {
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
    
    private let signupLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign up"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 50, weight: .bold)
        label.alpha = 1
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 10
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.layer.masksToBounds = false
        return label
    }()

    private let registerButton: UIButton = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blurredVisualEffect)
        view.addSubview(signupLabel)
        view.addSubview(firstNameField)
        view.addSubview(lasNameField)
        view.addSubview(emailField)
        view.addSubview(phoneField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)

        configureConstraints()
    }
    
    private func configureConstraints() {
        let blurredVisualEffectConstraints = [
            blurredVisualEffect.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            blurredVisualEffect.heightAnchor.constraint(equalToConstant: 600),
            blurredVisualEffect.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            blurredVisualEffect.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140)
        ]
        
        let firstNameFieldConstraints = [
            firstNameField.leadingAnchor.constraint(equalTo: blurredVisualEffect.leadingAnchor, constant: 20),
            firstNameField.trailingAnchor.constraint(equalTo: blurredVisualEffect.trailingAnchor, constant: -20),
            firstNameField.topAnchor.constraint(equalTo: blurredVisualEffect.topAnchor, constant: 30),
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
            phoneField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            phoneField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            phoneField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 30),
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
            registerButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 25),
            registerButton.heightAnchor.constraint(equalToConstant: 70),
            registerButton.leadingAnchor.constraint(equalTo: blurredVisualEffect.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: blurredVisualEffect.trailingAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(firstNameFieldConstraints)
        NSLayoutConstraint.activate(lasNameFieldConstraints)
        NSLayoutConstraint.activate(emailFieldConstraints)
        NSLayoutConstraint.activate(blurredVisualEffectConstraints)
        NSLayoutConstraint.activate(signupLabelConstraints)
        NSLayoutConstraint.activate(phoneFieldConstraints)
        NSLayoutConstraint.activate(passwordFieldConstraints)
        NSLayoutConstraint.activate(registerButtonConstraints)
    }
}
