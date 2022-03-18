//
//  CartViewController.swift
//  BuyIN
//
//  Created by Akram Elhayani on 12/03/2022.
//

import UIKit
import Pay
import SafariServices
class CartViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var cartItemCount: UILabel!
    
    @IBOutlet weak var totalPrice: UILabel!
    
    fileprivate var paySession: PaySession?
    
    var itemCount: Int = 0 {
        didSet {
            self.cartItemCount.text = "\(self.itemCount)"
        }
    }
    
    var subtotal: Decimal = 0.0 {
        didSet {
            self.totalPrice.text = Currency.stringFrom(self.subtotal)
        }
    }
    
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()

     
        self.configureCollectionView()
        
        self.updateSubtotal()
        
        self.registerNotifications()
        
//        let  swipableExtension = CollectionSwipableCellExtension(with: collectionView)
//        swipableExtension.delegate = self
//        swipableExtension.isEnabled = true
        
        
        
    }
    override func viewDidLayoutSubviews() {
        cartItemCount.cornerRadius = cartItemCount.frame.width / 2
    }
   
    deinit {
        self.unregisterNotifications()
    }

    
    private func configureCollectionView() {
      
        
        
        self.collectionView.register(UINib(nibName: "CartCell", bundle: nil), forCellWithReuseIdentifier: "CartCell")
        
        if self.traitCollection.forceTouchCapability == .available {
//            self.UIContextMenuInteraction(with: self,      sourceView: self.tableView)
        }
    }
    
    // ----------------------------------
    //  MARK: - Notifications -
    //
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(cartControllerItemsDidChange(_:)), name: Notification.Name.CartControllerItemsDidChange, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func cartControllerItemsDidChange(_ notification: Notification) {
        self.updateSubtotal()
    }
    
    // ----------------------------------
    //  MARK: - Update -
    //
    func updateSubtotal() {
        self.subtotal = CartController.shared.subtotal
        self.itemCount
        = CartController.shared.itemCount
        collectionView.reloadData()
    }
    
    // ----------------------------------
    //  MARK: - Actions -
    //
    func openWKWebViewControllerFor(_ url: URL, title: String) {
        let webController = WebViewController(url: url, accessToken: AccountController.shared.accessToken)
        webController.navigationItem.title = title
        self.present(webController, animated: true, completion: nil)
    }
    
    func openSafariViewControllerFor(_ url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(safariViewController, animated: false)
    }

    func buildShopPayURL(_ shopURL: URL, cartItems: [CartItem]) -> URL? {
        func decodeBase64String(_ base64String: String) -> String {
            let decodedData = Data(base64Encoded: base64String)!
            return String(data: decodedData, encoding: .utf8)!
        }
        func extractVariantId(_ fullVariantId: String) -> String {
            // Example string: gid://shopify/ProductVariant/31384149360662
            let pattern = #"gid://shopify/ProductVariant/(\d+)"#
            let regex = try! NSRegularExpression(pattern: pattern, options: [])
            let result = regex.matches(in:fullVariantId, range:NSMakeRange(0, fullVariantId.utf16.count))
            if (result.isEmpty) {
                // Handle error cases.
                return ""
            }
            if let substringRange = Range(result[0].range(at: 1), in: fullVariantId) {
                    return String(fullVariantId[substringRange])
                }
            return ""
        }
        func buildVariantSlugForItem(_ item: CartItem) -> String {
            return extractVariantId(decodeBase64String(item.variant.id)) + ":" + String(item.quantity)
        }
        
        // Build a Shop Pay checkout link.
        var components = URLComponents()
        components.scheme = "https"
        components.host = shopURL.host
        components.path = "/cart/" + cartItems.map(buildVariantSlugForItem).joined(separator: ",")
        components.queryItems = [
            URLQueryItem(name: "payment", value: "shop_pay"),
        ]
        return components.url
    }
    

    @IBAction func checkOutClicked(_ sender: Any) {
        
        totalsController( didRequestPaymentWith: .webCheckout)
        
    }
    
    @IBAction func ClearButton(_ sender: Any) {
        CartController.shared.emptyCart()
    }
    
    // ----------------------------------
    //  MARK: - Discount Codes -
    //
    func promptForCodes(completion: @escaping ((discountCode: String?, giftCard: String?)) -> Void) {
        let alert = UIAlertController(title: "Do you have a discount code of gift cards?", message: "Any valid discount code or gift card can be applied to your checkout.", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.attributedPlaceholder = NSAttributedString(string: "Discount code")
        }
        
        alert.addTextField { textField in
            textField.attributedPlaceholder = NSAttributedString(string: "Gift card code")
        }
        
        alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: { [unowned alert] action in
            let textFields = alert.textFields!
            
            var discountCode = textFields[0].text?.trimmingCharacters(in: .whitespacesAndNewlines)
            var giftCardCode = textFields[1].text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if let code = discountCode, code.isEmpty {
                discountCode = nil
            }
            
            if let code = giftCardCode, code.isEmpty {
                giftCardCode = nil
            }
            
            completion((discountCode: discountCode, giftCard: giftCardCode))
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // ----------------------------------
    //  MARK: - View Controllers -
    //
    func productDetailsViewControllerWith(_ product: ProductViewModel) -> ProductDetailsViewController {
        let controller: ProductDetailsViewController = self.storyboard!.instantiateViewController()
        controller.product = product
        return controller
    }
}


extension CartViewController : CollectionSwipableCellExtensionDelegate {
    func isSwipable(itemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func swipableActionsLayout(forItemAt indexPath: IndexPath) -> CollectionSwipableCellLayout? {
        let actionLayout = CollectionSwipableCellOneButtonLayout(buttonWidth: 100, insets: .zero, direction: .leftToRight)
          actionLayout.action = { [weak self] in
              //do something
          }

          return actionLayout
    }
    
    
    
    
}
// ----------------------------------
//  MARK: - Actions -
//
extension CartViewController {
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// ----------------------------------
//  MARK: - TotalsControllerDelegate -
//
extension CartViewController: TotalsControllerDelegate {
    
    func totalsController(
        //_ totalsController: TotalsViewController,
        didRequestPaymentWith type: PaymentType) {
        let cartItems = CartController.shared.items
        if type == .shopPay {
            Client.shared.fetchShopURL { shopURL in
                guard let shopURL = shopURL else {
                    print("Failed to fetch shop url.")
                    return
                }
                
                let shopPayURL = self.buildShopPayURL(shopURL, cartItems: cartItems)
                if (shopPayURL != nil) {
                    self.openSafariViewControllerFor(shopPayURL!)
                }
            }
        } else {
            Client.shared.createCheckout(with: cartItems) { checkout in
                guard let checkout = checkout else {
                    print("Failed to create checkout.")
                    return
                }
                
                let completeCreateCheckout: (CheckoutViewModel) -> Void = { checkout in
                    switch type {
                    case .webCheckout:
                        self.openWKWebViewControllerFor(checkout.webURL, title: "Checkout")
                        
                    case .localCheckout:
                        Client.shared.fetchShopName { shopName in
                            guard shopName != nil else {
                                print("Failed to fetch shop name.")
                                return
                            }
                        }
                    case .shopPay:
                        // Shouldn't happen as it was handled above.
                        break
                    }
                }
                
                /* ----------------------------------------
                 ** Use "HALFOFF" discount code for a 50%
                 ** discount in the graphql.myshopify.com
                 ** store (the test shop).
                 */
                self.promptForCodes { (discountCode, giftCard) in
                    var updatedCheckout = checkout
                    
                    let queue     = DispatchQueue.global(qos: .userInitiated)
                    let group     = DispatchGroup()
                    let semaphore = DispatchSemaphore(value: 1)
                    
                    if let discountCode = discountCode {
                        group.enter()
                        queue.async {
                            semaphore.wait()
                            
                            print("Applying discount code: \(discountCode)")
                            Client.shared.applyDiscount(discountCode, to: checkout.id) { checkout in
                                if let checkout = checkout {
                                    updatedCheckout = checkout
                                } else {
                                    print("Failed to apply discount to checkout")
                                }
                                semaphore.signal()
                                group.leave()
                            }
                        }
                    }
                    
                    if let giftCard = giftCard {
                        group.enter()
                        queue.async {
                            semaphore.wait()
                            
                            print("Applying gift card: \(giftCard)")
                            Client.shared.applyGiftCard(giftCard, to: checkout.id) { checkout in
                                if let checkout = checkout {
                                    updatedCheckout = checkout
                                } else {
                                    print("Failed to apply gift card to checkout")
                                }
                                semaphore.signal()
                                group.leave()
                            }
                        }
                    }
                    
                    group.notify(queue: .main) {
                        if let accessToken = AccountController.shared.accessToken {
                            
                            print("Associating checkout with customer: \(accessToken)")
                            Client.shared.updateCheckout(updatedCheckout.id, associatingCustomer: accessToken) { associatedCheckout in
                                if let associatedCheckout = associatedCheckout {
                                    completeCreateCheckout(associatedCheckout)
                                } else {
                                    print("Failed to associate checkout with customer.")
                                    completeCreateCheckout(updatedCheckout)
                                }
                            }
                            
                        } else {
                            completeCreateCheckout(updatedCheckout)
                        }
                    }
                }
            }
        }
    }
}


// ----------------------------------
//  MARK: - UIViewControllerPreviewingDelegate -
//
extension CartViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
//        let tableView = previewingContext.sourceView as! UITableView
//        if let indexPath = tableView.indexPathForRow(at: location) {
//            
//            previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
//            
//            let cell    = tableView.cellForRow(at: indexPath) as! CartCell
//            let product = cell.viewModel!.model.product
//            
//            return self.productDetailsViewControllerWith(product)
//        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController!.show(viewControllerToCommit, sender: self)
    }
}

// ----------------------------------
//  MARK: - CartCellDelegate -
//
extension CartViewController: CartCellDelegate {
    
    func cartCell(_ cell: CartCell, didUpdateQuantity quantity: Int) {
        if let indexPath = self.collectionView.indexPath(for: cell) {
            
            let didUpdate = CartController.shared.updateQuantity(quantity, at: indexPath.row)
            if didUpdate {
                
                
                self.collectionView.reloadItems(at:  [indexPath])
               
            }
        }
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDataSource -
//
extension CartViewController: UICollectionViewDataSource {
    
    // ----------------------------------
    //  MARK: - Data -
    //
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CartController.shared.items.count
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell     = collectionView.dequeueReusableCell(withReuseIdentifier: CartCell.className, for: indexPath) as! CartCell
        let cartItem = CartController.shared.items[indexPath.row]
        cell.cartDelegate = self
        cell.configureFrom(cartItem.viewModel)
        cell.delegate = self
     
        return cell
    }

 
   
}

// ----------------------------------
//  MARK: - UITableViewDelegate -
//
 
extension CartViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
     
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 15
        let height = width / 2.5
        return CGSize(width: width, height: height)
        
    }
 
//
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        switch editingStyle {
//        case .delete:
//
//            tableView.beginUpdates()
//
//            CartController.shared.removeAllQuantities(at: indexPath.row)
//
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.endUpdates()
//
//        default:
//            break
//        }
//    }
}
import SwipeCellKit
extension CartViewController: SwipeCollectionViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    
        if orientation == .left {
          //  guard isSwipeRightEnabled else { return nil }
            return nil
        } else {
            let flag = SwipeAction(style: .default, title: "favorite"){ action, indexPath in
               
                // Add to favorite 
            }
            flag.hidesWhenSelected = true
            configure(action: flag, with: .flag)
            
            let delete = SwipeAction(style: .destructive, title: nil) { action, indexPath in
                CartController.shared.removeAllQuantities(at: indexPath.item)
              
              //  collectionView.deleteItems(at: [indexPath])
            }
            configure(action: delete, with: .trash)
            
//            let cell = collectionView.cellForItem(at: indexPath) as! CartCell
//            let closure: (UIAlertAction) -> Void = { _ in cell.hideSwipe(animated: true) }
//            let more = SwipeAction(style: .default, title: nil) { action, indexPath in
//                let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//                controller.addAction(UIAlertAction(title: "Reply", style: .default, handler: closure))
//                controller.addAction(UIAlertAction(title: "Forward", style: .default, handler: closure))
//                controller.addAction(UIAlertAction(title: "Mark...", style: .default, handler: closure))
//                controller.addAction(UIAlertAction(title: "Notify Me...", style: .default, handler: closure))
//                controller.addAction(UIAlertAction(title: "Move Message...", style: .default, handler: closure))
//                controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: closure))
//                self.present(controller, animated: true, completion: nil)
//            }
//            configure(action: more, with: .more)
            
            return [delete, flag] // ,more
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = orientation == .left ? .selection : .destructive
        let defaultOptions = SwipeOptions()
        let buttonStyle: ButtonStyle = .backgroundColor
        options.transitionStyle = defaultOptions.transitionStyle

        switch buttonStyle {
        case .backgroundColor:
            options.buttonSpacing = 11
        case .circular:
            options.buttonSpacing = 4
        #if canImport(Combine)
            if #available(iOS 13.0, *) {
                options.backgroundColor = UIColor.systemGray6
            } else {
                options.backgroundColor = #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
            }
        #else
            options.backgroundColor = #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
        #endif
        }
        
        return options
    }
    
    func visibleRect(for collectionView: UICollectionView) -> CGRect? {
       // if usesTallCells == false { return nil }
        
        if #available(iOS 11.0, *) {
            return collectionView.safeAreaLayoutGuide.layoutFrame
        } else {
            let topInset = navigationController?.navigationBar.frame.height ?? 0
            let bottomInset = navigationController?.toolbar?.frame.height ?? 0
            let bounds = collectionView.bounds
            
            return CGRect(x: bounds.origin.x, y: bounds.origin.y + topInset, width: bounds.width, height: bounds.height - bottomInset)
        }
    }
    
    func configure(action: SwipeAction, with descriptor: ActionDescriptor) {
  
        let buttonStyle: ButtonStyle = .circular
        let buttonDisplayMode: ButtonDisplayMode = .titleAndImage
        
        action.title = descriptor.title(forDisplayMode: buttonDisplayMode)
        action.image = descriptor.image(forStyle: buttonStyle, displayMode: buttonDisplayMode)
        
        switch buttonStyle {
        case .backgroundColor:
            action.backgroundColor = descriptor.color(forStyle: buttonStyle)
        case .circular:
            action.backgroundColor = .clear
            action.textColor = descriptor.color(forStyle: buttonStyle)
            action.font = .systemFont(ofSize: 13)
            action.transitionDelegate = ScaleTransition.default
        }
    }
}

