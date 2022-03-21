//
//  CartCoordinatorViewController.swift
//  BuyIN
//
//  Created by apple on 3/21/22.
//

import UIKit

class CartCoordinatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showCart(animated: true)
        // Do any additional setup after loading the view.
    }
    
    private func showCart(animated: Bool) {
        let cartController: CartViewController = CartViewController.instantiateFromNib()
        
        cartController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cartController.view)
        

        let leftSideConstraint = NSLayoutConstraint(item: cartController.view, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0.0)
//        let bottomConstraint = NSLayoutConstraint(item: cartController.view, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(item: cartController.view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0.0)
////        let topConstraint = NSLayoutConstraint(item: cartController.view, attribute: .top, relatedBy: .equal, toItem: navigationController, attribute: .bottom, multiplier: 1.0, constant: 10)
        cartController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: (self.navigationController?.navigationBar.frame.height ?? 10) + 5).isActive = true
        cartController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(self.tabBarController?.tabBar.frame.height ?? 10)).isActive = true
        view.addConstraints([leftSideConstraint, widthConstraint])

        self.addChild(cartController)
        cartController.cancelBtn.isHidden = true
        
    }
}
