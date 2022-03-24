//
//  ProductDetailsViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 12/03/2022.
//


import UIKit
import Buy

class ProductDetailsViewController: UIViewController {
    
    private let thumbnailCollectionWidth: CGFloat = 60
    

    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light))
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = (product?.images.items.count)!
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        let TransformAngle = Double.pi/2
        pageControl.transform = CGAffineTransform(rotationAngle: CGFloat(TransformAngle))
        pageControl.backgroundStyle = .prominent
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()
    
    private let bagButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "bag", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light))
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()

    private let previewCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductPreviewThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: ProductPreviewThumbnailCollectionViewCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.tag = 1
        return collectionView
    }()
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    
    private func configureCartButton() {
        let added = CartController.shared.items.contains { cartItem in
            cartItem.product.id == product?.id
        }
        
        added ? configureAsAdded() : configureAsNotAdded()
    }
    
    private func configureAsAdded() {
        let image = UIImage(systemName: "bag.fill")
        bagButton.tintColor = .systemGreen
        bagButton.setImage(image, for: .normal)
    }
    
    private func configureAsNotAdded() {
        let image = UIImage(systemName: "bag")
        bagButton.setImage(image, for: .normal)
        bagButton.tintColor = .black
    }

    private var isAdded: Bool = false {
        willSet {
            configureCartButton()
        }
    }
    
    private var isWished: Bool = false {
        willSet {
            configureWishButton()
        }
    }

    var productCardViewController: ProductCardViewController!
    var visualEffectView: UIVisualEffectView!
    
    
    private let cardHeight: CGFloat = 700
    let cardHandleAreaHeight: CGFloat = 65
    var isCardVisible: Bool = false
    
    var nextState: CardState {
        return isCardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat = 0
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.visualEffectView.isUserInteractionEnabled = false
    }
    private func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)
        productCardViewController = ProductCardViewController()
        productCardViewController.product = product
        addChild(productCardViewController)
        productCardViewController.delegate = self
        view.addSubview(productCardViewController.view)
        productCardViewController.didMove(toParent: self)

        productCardViewController.view.frame = CGRect(x: 0, y: view.frame.height - cardHandleAreaHeight - 120, width: view.bounds.width, height: cardHeight)
        

        productCardViewController.view.shadowColor = .black
        productCardViewController.view.shadowOpacity = 0.6
        productCardViewController.view.shadowOffset = .zero
        productCardViewController.view.shadowRadius = 15
        productCardViewController.view.layer.cornerRadius = 40
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleProductCardTap(recognizer:)))
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleProductCardPan(recognizer:)))
        
        productCardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        productCardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    
    @objc private func handleProductCardTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc private func handleProductCardPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.productCardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = self.isCardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    private func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(
                duration: duration,
                dampingRatio: 1) {
                    switch state {
                    case .expanded:
                        self.productCardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                    case .collapsed:
                        self.productCardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight - 120
                    }
                }
            
            frameAnimator.addCompletion { _ in
                self.isCardVisible = !self.isCardVisible
                self.runningAnimations.removeAll()
            }
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.productCardViewController.view.layer.cornerRadius = 12
                    let image = UIImage(systemName: "chevron.compact.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))
                    self.productCardViewController.handleArea.handleImage.image = image
                case .collapsed:
                    self.productCardViewController.view.layer.cornerRadius = 40
                    let image = UIImage(systemName: "chevron.compact.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))
                    self.productCardViewController.handleArea.handleImage.image = image
                }
            }
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimation = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimation.startAnimation()
            runningAnimations.append(blurAnimation)
        }
    }
    
    private func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    private func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    var product: ProductViewModel? = nil {
        didSet {
            productPreviews = (product?.images.items)!
            configureWishButton()
            configureCartButton()

        }
    }
    
    private func configureWishButton() {
        let wished = WishlistController.shared.items.contains { cartItem in
            cartItem.product.id == product?.id
        }
        
        wished ? configureAsWished() : configureAsNotWished()
    }
    
    private func configureAsNotWished() {
        let image = UIImage(systemName: "heart")
        favoriteButton.setImage(image, for: .normal)
        favoriteButton.tintColor = .black
    }
    
    private func configureAsWished() {
        let image = UIImage(systemName: "heart.fill")
        favoriteButton.setImage(image, for: .normal)
        favoriteButton.tintColor = .systemPink
    }
    
    private var productPreviews: [ImageViewModel] = []


    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()



    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(previewCollectionView)
        view.addSubview(bagButton)
        view.addSubview(favoriteButton)
        previewCollectionView.delegate = self
        previewCollectionView.dataSource = self
        previewCollectionView.contentInsetAdjustmentBehavior = .never
        view.addSubview(dismissButton)
        view.addSubview(pageControl)
        setupCard()
        configureConstraints()
        tabBarController?.tabBar.isHidden = true
        pageControl.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)
        dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(didTapFav), for: .touchUpInside)
        bagButton.addTarget(self, action: #selector(didTapBag), for: .touchUpInside)
    }
    
    @objc private func didTapBag() {
        print("Didtapbag")
        isAdded ? removeFromCart() : addToCart()
    }
    
    private func addToCart() {
        CartController.shared.add(CartItem(product: product!, variant: (product?.variants.items.first)!))
        isAdded = true
    }
    
    private func removeFromCart() {
        CartController.shared.removeAllQuantitiesFor(CartItem(product: product!, variant: (product?.variants.items.first)!))
        isAdded = false
    }
    
    private func addToWishList() {
        WishlistController.shared.add(CartItem(product: product!, variant: (product?.variants.items.first)!))
        isWished = true
    }
    
    private func removeFromWishList() {
        WishlistController.shared.removeAllQuantitiesFor(CartItem(product: product!, variant: (product?.variants.items.first)!))
        isWished = false
    }
    
    @objc private func didTapFav() {
        isWished ? removeFromWishList() : addToWishList()
    }
    
    
    
    @objc private func pageControlDidChange() {
        previewCollectionView.scrollToItem(
            at: IndexPath(
                row: pageControl.currentPage,
                section: 0),
            at: .centeredVertically,
            animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewCollectionView.frame = view.bounds

    }
   
    @objc private func didTapDismiss() {
        navigationController?.popViewController(animated: true)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    private func configureConstraints() {
        
        let dismissButtonConstraints = [
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dismissButton.heightAnchor.constraint(equalToConstant: 50),
            dismissButton.widthAnchor.constraint(equalToConstant: 50)
        ]
        
        let bagButtonConstraints = [
            bagButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            bagButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ]

        let pageControlConstraints = [
            pageControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 55),
            pageControl.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        let favoriteButtonConstraints = [
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            favoriteButton.topAnchor.constraint(equalTo: bagButton.bottomAnchor, constant: 35)
        ]
        
        NSLayoutConstraint.activate(dismissButtonConstraints)
        NSLayoutConstraint.activate(bagButtonConstraints)
        NSLayoutConstraint.activate(pageControlConstraints)
        NSLayoutConstraint.activate(favoriteButtonConstraints)
    }
}


extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (product?.images.items.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            previewCollectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCollectionViewCell.identifier, for: indexPath) as? ThumbnailCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: product!.images.items[indexPath.row].url)
            return cell
            
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductPreviewThumbnailCollectionViewCell.identifier, for: indexPath) as? ProductPreviewThumbnailCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: product!.images.items[indexPath.row].url)
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 0 {
            return CGSize(width: thumbnailCollectionWidth, height: 90)
        } else {
            return CGSize(width: view.bounds.width, height: view.bounds.height)
        }
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentlyShown = scrollView.contentOffset.y / view.frame.height
        pageControl.currentPage = Int(currentlyShown)
        if Double(currentlyShown) > Double((product?.images.items.count)!-1) {
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        }
    }
}


extension ProductDetailsViewController: ProductCardViewControllerDelegate {
    func productCardViewControllerDidRecieveAction() {
        let vc = AddReviewViewController()
        vc.product = product
        navigationController?.pushViewController(vc, animated: true)
    }
}
