//
//  ShoppingBagFooterCollectionReusableView.swift
//  BuyIN
//
//  Created by Amr Hossam on 22/03/2022.
//

import UIKit
import SwipeCellKit
import PassKit


protocol ShoppingBagFooterCollectionReusableViewDelegate: AnyObject {
    func shoppingBagFooterCollectionReusableViewDidTapPromoButton(_ checkout: CheckoutViewModel)
    func shoppingBagFooterCollectionReusableViewDidTapCheckoutButton()
    
    
    func shoppingBagFooterCollectionReusableViewDidTapApplePayCheckoutButton()
}

class ShoppingBagFooterCollectionReusableView: UICollectionReusableView {
    
    weak var delegate: ShoppingBagFooterCollectionReusableViewDelegate?

        
    static let identifier = className
    private let promotionalCode: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Promotion code"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.setTitle("Procceed to checkout", for: .normal)
        return button
    }()
    
    
    private let applePayButton: PKPaymentButton = {
        let button = PKPaymentButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        return button
    }()
    
    private let promotionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.35)
        return view
    }()
    
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Total"
        label.textColor = .black
        return label
    }()
    
    private let vatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "(VAT included)"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    func configure(with model: CheckoutViewModel?, subtotal: Decimal) {
        guard let model = model else {
            priceLabel.text = Currency.stringFrom(subtotal)
            return
        }
        priceLabel.text = Currency.stringFrom(model.subtotalPrice)
        promotionButton.setTitle("Promotion Applied", for: .normal)
        promotionButton.isEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(totalPriceLabel)
        addSubview(promotionalCode)
        addSubview(promotionButton)
        addSubview(separator)
        addSubview(vatLabel)
        addSubview(priceLabel)
        addSubview(checkoutButton)
        addSubview(applePayButton)
        promotionButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        checkoutButton.addTarget(self, action: #selector(didTapCheckout), for: .touchUpInside)
        applePayButton.addTarget(self, action: #selector(didTapApplePayButton), for: .touchUpInside)
        configureConstraints()
        registerNotifications()
    }
    
    @objc private func didTapCheckout() {
        delegate?.shoppingBagFooterCollectionReusableViewDidTapCheckoutButton()
    }
    @objc private func didTapApplePayButton() {
        delegate?.shoppingBagFooterCollectionReusableViewDidTapApplePayCheckoutButton()
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(cartControllerItemsDidChange(_:)), name: Notification.Name.CartControllerItemsDidChange, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func cartControllerItemsDidChange(_ notification: Notification) {
        priceLabel.text = Currency.stringFrom(CartController.shared.subtotal)
    }
    
   
    

    @objc private func didTapAdd() {
        Client.shared.createCheckout(with: CartController.shared.items) { [weak self] checkout in
            self?.delegate?.shoppingBagFooterCollectionReusableViewDidTapPromoButton(checkout!)
        }
    }
    
    private func configureConstraints() {
        
        let promotionalCodeConstraints = [
            promotionalCode.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            promotionalCode.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            promotionalCode.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let promotionButtonConstraints = [
            promotionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            promotionButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            promotionButton.heightAnchor.constraint(equalToConstant: 40)

        ]
        
        let separatorConstraints = [
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            separator.topAnchor.constraint(equalTo: promotionalCode.bottomAnchor, constant: 15),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        let totalPriceLabelConstraints = [
            totalPriceLabel.leadingAnchor.constraint(equalTo: separator.leadingAnchor),
            totalPriceLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10)
        ]
        
        let vatLabelConstraints = [
            vatLabel.leadingAnchor.constraint(equalTo: totalPriceLabel.trailingAnchor, constant: 5),
            vatLabel.bottomAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor)
        ]
        
        let priceLabelConstraints = [
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            priceLabel.topAnchor.constraint(equalTo: totalPriceLabel.topAnchor)
        ]
        
        let checkoutButtonConstraints = [
            checkoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            checkoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            checkoutButton.topAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor, constant: 20),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let applePayButtonConstraints = [
            applePayButton.leadingAnchor.constraint(equalTo: checkoutButton.leadingAnchor),
            applePayButton.trailingAnchor.constraint(equalTo: checkoutButton.trailingAnchor),
            applePayButton.topAnchor.constraint(equalTo: checkoutButton.bottomAnchor, constant: 10),
            applePayButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(promotionalCodeConstraints)
        NSLayoutConstraint.activate(promotionButtonConstraints)
        NSLayoutConstraint.activate(separatorConstraints)
        NSLayoutConstraint.activate(totalPriceLabelConstraints)
        NSLayoutConstraint.activate(vatLabelConstraints)
        NSLayoutConstraint.activate(priceLabelConstraints)
        NSLayoutConstraint.activate(checkoutButtonConstraints)
        NSLayoutConstraint.activate(applePayButtonConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
