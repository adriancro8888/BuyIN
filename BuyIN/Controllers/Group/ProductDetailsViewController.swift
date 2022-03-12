//
//  ProductDetailsViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 12/03/2022.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    
    private let addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("  Add to cart", for: .normal)
        button.setImage(UIImage(systemName: "bag.fill"), for: .normal)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        button.tintColor = .white
        button.backgroundColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(addToCartButton)
        configureConstraints()
        tabBarController?.tabBar.isHidden = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func configureConstraints() {
        let addToCartButtonConstraints = [
            addToCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addToCartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            addToCartButton.heightAnchor.constraint(equalToConstant: 70)
        ]
        
        NSLayoutConstraint.activate(addToCartButtonConstraints)
    }
}
