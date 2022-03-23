//
//  ShoppingBagViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 21/03/2022.
//

import UIKit
import Pay
import SafariServices
import SwipeCellKit

class ShoppingBagViewController: UIViewController {
    
    private var checkout: CheckoutViewModel?
    
    static func collectionLayoutProvider() -> NSCollectionLayoutSection {
        
        let supplementaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)),
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
        ]
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            ))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(230)),
            subitem: item,
            count: 1
        )
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = supplementaryViews
        return section
    }
    
    
    private let viewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Shopping Bag"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let cartNavbar: UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        navbar.backgroundColor = .white
        navbar.layer.shadowOpacity = 0.8
        navbar.layer.shadowColor = UIColor.black.cgColor
        navbar.layer.shadowRadius = 5
        return navbar
    }()
    
    fileprivate var paySession: PaySession?
    
    var itemCount: Int = 0 {
        didSet {
            //            self.cartItemCount.text = "\(self.itemCount)"
        }
    }
    
    var subtotal: Decimal = 0.0 {
        didSet {
            //            self.totalPrice.text = Currency.stringFrom(self.subtotal)
        }
    }
    
    private let emptyShoppingBagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Your shopping bag is empty".uppercased()
        return label
    }()
    
    private let wishListButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View Wishlist".uppercased(), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    
    private let newArrivalsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Arrivals".uppercased(), for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    private let subShoppingBagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = """
                    Check if there any products on your wishlist
                    and snatch them up before they're gone!
                    You can also check the latest arrivals ;)
                    """
        label.textAlignment = .center
        return label
    }()
    
    private let collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(section: ShoppingBagViewController.collectionLayoutProvider()))
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(ShoppingBagCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingBagCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ShoppingBagFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ShoppingBagFooterCollectionReusableView.identifier)
        return collectionView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        CartController.shared.items.count > 0 ? configureAsFilled() : configureAsEmpty()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        view.addSubview(collectionView)
        view.addSubview(emptyShoppingBagLabel)
        view.addSubview(subShoppingBagLabel)
        view.addSubview(wishListButton)
        view.addSubview(newArrivalsButton)
        view.addSubview(cartNavbar)
        
        cartNavbar.addSubview(viewTitleLabel)
        navigationController?.navigationBar.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        configureConstraints()
        newArrivalsButton.addTarget(self, action: #selector(didTapNewArrival), for: .touchUpInside)
        wishListButton.addTarget(self, action: #selector(didTapWishList), for: .touchUpInside)
        self.registerNotifications()
    }
    
    @objc private func didTapWishList() {
        let wishController : WishListViewController = WishListViewController.instantiateFromNib()
        wishController.modalPresentationStyle = .fullScreen
        wishController.wishlistItems = WishlistController.shared.items
        
        self.present(wishController, animated: true, completion: nil)
    }
    
    @objc private func didTapNewArrival() {
        
    }
    
    
    private func configureAsEmpty() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.collectionView.alpha = 0
            self?.emptyShoppingBagLabel.alpha = 1
            self?.subShoppingBagLabel.alpha = 1
            self?.wishListButton.alpha = 1
            self?.newArrivalsButton.alpha = 1
        } completion: { _ in}
    }
    
    private func configureAsFilled() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.collectionView.alpha = 1
            self?.emptyShoppingBagLabel.alpha = 0
            self?.subShoppingBagLabel.alpha = 0
            self?.wishListButton.alpha = 0
            self?.newArrivalsButton.alpha = 0
        } completion: { _ in}
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(cartControllerItemsDidChange(_:)), name: Notification.Name.CartControllerItemsDidChange, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func cartControllerItemsDidChange(_ notification: Notification) {
        self.updateSubtotal()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func updateSubtotal() {
        self.subtotal = CartController.shared.subtotal
        self.itemCount
        = CartController.shared.itemCount
        collectionView.reloadData()
        itemCount > 0 ? configureAsFilled() : configureAsEmpty()
        
    }
    
    private func configureConstraints() {
        
        let cartNavbarConstraints = [
            cartNavbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartNavbar.topAnchor.constraint(equalTo: view.topAnchor),
            cartNavbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartNavbar.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let emptyShoppingBagLabelConstraints = [
            emptyShoppingBagLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyShoppingBagLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        let subShoppingBagLabelConstraints = [
            subShoppingBagLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subShoppingBagLabel.topAnchor.constraint(equalTo: emptyShoppingBagLabel.bottomAnchor, constant: 15)
        ]
        
        let wishListButtonConstraints = [
            wishListButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            wishListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wishListButton.heightAnchor.constraint(equalToConstant: 50),
            wishListButton.widthAnchor.constraint(equalToConstant: 270)
        ]
        
        let newArrivalsButtonConstraints = [
            newArrivalsButton.leadingAnchor.constraint(equalTo: wishListButton.leadingAnchor),
            newArrivalsButton.trailingAnchor.constraint(equalTo: wishListButton.trailingAnchor),
            newArrivalsButton.topAnchor.constraint(equalTo: wishListButton.bottomAnchor, constant: 15),
            newArrivalsButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let collectionViewConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: cartNavbar.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let viewTitleLabelConstraints = [
            viewTitleLabel.centerXAnchor.constraint(equalTo: cartNavbar.centerXAnchor),
            viewTitleLabel.bottomAnchor.constraint(equalTo: cartNavbar.bottomAnchor, constant: -20)
        ]
        
        
        NSLayoutConstraint.activate(emptyShoppingBagLabelConstraints)
        NSLayoutConstraint.activate(subShoppingBagLabelConstraints)
        NSLayoutConstraint.activate(wishListButtonConstraints)
        NSLayoutConstraint.activate(newArrivalsButtonConstraints)
        NSLayoutConstraint.activate(collectionViewConstraints)
        NSLayoutConstraint.activate(cartNavbarConstraints)
        NSLayoutConstraint.activate(viewTitleLabelConstraints)
    }
    
    
    
}


extension ShoppingBagViewController: UICollectionViewDelegate, UICollectionViewDataSource,
                                     CollectionSwipableCellExtensionDelegate{
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CartController.shared.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingBagCollectionViewCell.identifier, for: indexPath) as? ShoppingBagCollectionViewCell else {
            return UICollectionViewCell()
        }
        let cartItem = CartController.shared.items[indexPath.row]
        cell.configureFrom(cartItem.viewModel)
        cell.delegate = self
        cell._delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ShoppingBagFooterCollectionReusableView.identifier, for: indexPath) as? ShoppingBagFooterCollectionReusableView else
        {
            return UICollectionReusableView()
        }
        
        footer.configure(with: checkout, subtotal: CartController.shared.subtotal)
        footer.delegate = self
        return footer
    }
}

extension ShoppingBagViewController: SwipeCollectionViewCellDelegate {
    
    
    
    
    
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
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView.reloadData()
                }
                
            }
            configure(action: delete, with: .trash)
            return [delete] // ,more
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


extension ShoppingBagViewController: ApplyPromoViewControllerDelegate {
    func applyPromoViewControllerDidApplyPromo(_ forCheckout: CheckoutViewModel) {
        self.checkout = forCheckout
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension ShoppingBagViewController: ShoppingBagFooterCollectionReusableViewDelegate {
    func shoppingBagFooterCollectionReusableViewDidTapPromoButton(_ checkout: CheckoutViewModel) {
        let vc = ApplyPromoViewController()
        vc.delegate = self
        vc.checkout = checkout
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func shoppingBagFooterCollectionReusableViewDidTapCheckoutButton() {
        requstPayment()
    }
}


extension ShoppingBagViewController: ShoppingBagCollectionViewCellDelegate {
    func shoppingBagCollectionViewCellDidTapPlus(_ forItem: CartItemViewModel) {
        let index = CartController.shared.items.firstIndex { cartItem in
            cartItem.viewModel.title == forItem.title
        }
        
        CartController.shared.incrementAt(index!)
        
    }
    
    func shoppingBagCollectionViewCellDidTapMinus(_ forItem: CartItemViewModel) {
        let index = CartController.shared.items.firstIndex { cartItem in
            cartItem.viewModel.title == forItem.title
        }
        CartController.shared.decrementAt(index!)
        
    }
}


extension ShoppingBagViewController: TotalsControllerDelegate {
    
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
    
    
    func requstPayment() {
       
        

        
        if checkout == nil {
            
            let cartItems = CartController.shared.items
            Client.shared.createCheckout(with: cartItems) { checkout in
                guard let checkout = checkout else {
                    print("Failed to create checkout.")
                    return
                }
                self.checkout = checkout
                self.requstPayment()
                return
            }
        }
        
        
        guard let checkout = checkout else {
                        print("Failed to create checkout.")
                        return
                    }
            var updatedCheckout = checkout
            if let accessToken = AccountController.shared.accessToken {
                print("Associating checkout with customer: \(accessToken)")
                Client.shared.updateCheckout(checkout.id, associatingCustomer: accessToken) { associatedCheckout in
                    if let associatedCheckout = associatedCheckout {
                        updatedCheckout = associatedCheckout
                        self.openWKWebViewControllerFor(updatedCheckout.webURL, title: "Checkout")
                    } else {
                        print("Failed to associate checkout with customer.")
                    }
                }
           // }
        }
    }
}

