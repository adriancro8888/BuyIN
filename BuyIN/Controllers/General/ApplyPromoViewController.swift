//
//  ApplyPromoViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 22/03/2022.
//

import UIKit
import Buy
import Pay

protocol ApplyPromoViewControllerDelegate: AnyObject {
    func applyPromoViewControllerDidApplyPromo(_ forCheckout: CheckoutViewModel)
}

class ApplyPromoViewController: UIViewController {

    weak var delegate: ApplyPromoViewControllerDelegate?
    var checkout: CheckoutViewModel?
    
    private lazy var promocodeField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor = .white
        field.textColor = .black
        field.layer.cornerRadius = 4
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(
            string: "Promo code",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return field
    }()
    
    private let promoNavbar: UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        navbar.backgroundColor = .white
        navbar.layer.shadowOpacity = 0.8
        navbar.layer.shadowColor = UIColor.black.cgColor
        navbar.layer.shadowRadius = 5
        return navbar
    }()
    
    private let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.tintColor = .white
        button.setTitle("Apply promo", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.tintColor = .black
        button.setTitle("Go Back", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    private let subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = """
                    Apply now a promocode to get
                    your own discount! Happy shopping!
                    """
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let viewTitleLabel: UILabel = {
    
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Apply promocode"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(promoNavbar)
        view.addSubview(subtitle)
        view.addSubview(promocodeField)
        view.addSubview(subtitle)
        view.addSubview(applyButton)
        applyButton.addTarget(self, action: #selector(didTapApply), for: .touchUpInside)
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        promoNavbar.addSubview(viewTitleLabel)
        configureConstraints()
    }
    
    @objc private func didTapApply() {
        Client.shared.applyDiscount(promocodeField.text!, to: checkout!.id) {[weak self] checkout in
            guard let checkout = checkout else {
                return
            }
            
            if self?.checkout?.subtotalPrice == checkout.subtotalPrice {
                let alert = UIAlertController(title: "Error", message: "Make sure you entered the correct code", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .cancel)
                alert.addAction(action)
                self?.present(alert, animated: true)
            } else {
                self?.delegate?.applyPromoViewControllerDidApplyPromo(checkout)
                self?.navigationController?.popViewController(animated: true)
            }

        }
        
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureConstraints() {
        
        let promoNavbarConstraints = [
            promoNavbar.topAnchor.constraint(equalTo: view.topAnchor),
            promoNavbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            promoNavbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            promoNavbar.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let viewTitleLabelConstraints = [
            viewTitleLabel.bottomAnchor.constraint(equalTo: promoNavbar.bottomAnchor, constant: -10),
            viewTitleLabel.centerXAnchor.constraint(equalTo: promoNavbar.centerXAnchor)
        ]
        
        let promocodeFieldConstraints = [
            promocodeField.topAnchor.constraint(equalTo: promoNavbar.bottomAnchor, constant: 50),
            promocodeField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promocodeField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            promocodeField.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let subtitleConstraints = [
            subtitle.topAnchor.constraint(equalTo: promocodeField.bottomAnchor, constant: 10),
            subtitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let applyButtonConstraints = [
            applyButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            applyButton.heightAnchor.constraint(equalToConstant: 60),
            applyButton.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 20)
        ]
        
        let backButtonConstraints = [
            backButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 60),
            backButton.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(promoNavbarConstraints)
        NSLayoutConstraint.activate(viewTitleLabelConstraints)
        NSLayoutConstraint.activate(promocodeFieldConstraints)
        NSLayoutConstraint.activate(subtitleConstraints)
        NSLayoutConstraint.activate(applyButtonConstraints)
        NSLayoutConstraint.activate(backButtonConstraints)
    }
}
