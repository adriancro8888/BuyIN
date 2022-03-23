//
//  TotalsViewController.swift
//  BuyIN
//
//  Created by Akram Elhayani on 12/03/2022.
//

import UIKit
import Pay


protocol TotalsControllerDelegate: AnyObject {
    func requstPayment()
}

class TotalsViewController: UIViewController {

    @IBOutlet private weak var subtotalTitleLabel: UILabel!
    @IBOutlet private weak var subtotalLabel:      UILabel!
    @IBOutlet private weak var buttonStackView:    UIStackView!
    
    weak var delegate: TotalsControllerDelegate?
    
    var itemCount: Int = 0 {
        didSet {
            self.subtotalTitleLabel.text = "\(self.itemCount) Item\(itemCount == 1 ? "" : "s")"
        }
    }
    
    var subtotal: Decimal = 0.0 {
        didSet {
            self.subtotalLabel.text = Currency.stringFrom(self.subtotal)
        }
    }
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPurchaseOptions()
    }
    
    private func loadPurchaseOptions() {
        
        let localCheckout = RoundedButton(type: .system)
        localCheckout.backgroundColor = UIColor(red: 0.53, green: 0.91, blue: 0.69, alpha: 1.00)
        localCheckout.addTarget(self, action: #selector(shopPayCheckoutAction(_:)), for: .touchUpInside)
        localCheckout.setTitle("Checkout",  for: .normal)
        localCheckout.setTitleColor(.white, for: .normal)
        self.buttonStackView.addArrangedSubview(localCheckout)
        
        
        
        let webCheckout = RoundedButton(type: .system)
        webCheckout.backgroundColor = UIColor(red: 100.0, green: 183.0, blue: 56.0,alpha: 1.00)
        webCheckout.addTarget(self, action: #selector(webCheckoutAction(_:)), for: .touchUpInside)
        webCheckout.setTitle("Web Checkout",  for: .normal)
        webCheckout.setTitleColor(.white, for: .normal)
        self.buttonStackView.addArrangedSubview(webCheckout)
        
        let shopPayCheckout = RoundedButton(type: .system)
        shopPayCheckout.backgroundColor = UIColor(red: 0.35, green: 0.19, blue: 0.96, alpha: 1.00)
        shopPayCheckout.addTarget(self, action: #selector(shopPayCheckoutAction(_:)), for: .touchUpInside)
        shopPayCheckout.setTitle("Shop Pay",  for: .normal)
        shopPayCheckout.setTitleColor(.white, for: .normal)
        self.buttonStackView.addArrangedSubview(shopPayCheckout)
        
       
    }
    
    // ----------------------------------
    //  MARK: - Actions -
    //
    @objc func webCheckoutAction(_ sender: Any) {
      //  self.delegate?.totalsController(self, didRequestPaymentWith: .webCheckout)
    }
    
    @objc func shopPayCheckoutAction(_ sender: Any) {
      //  self.delegate?.totalsController(self, didRequestPaymentWith: .shopPay)
    }
    
    @objc func localCheckoutAction(_ sender: Any) {
     //   self.delegate?.totalsController(self, didRequestPaymentWith: .localCheckout)
    }

}
