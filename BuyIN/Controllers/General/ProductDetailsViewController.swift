//
//  ProductDetailsViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 12/03/2022.
//


import UIKit

class ProductDetailsViewController: UIViewController {
    
    enum CardState {
        case expanded
        case collapsed
    }

    var productCardViewController: ProductCardViewController!
    var visualEffectView: UIVisualEffectView!
    
    
    let cardHeight: CGFloat = 600
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
        addChild(productCardViewController)
        view.addSubview(productCardViewController.view)
        productCardViewController.didMove(toParent: self)
        productCardViewController.view.frame = CGRect(x: 0, y: view.frame.height - cardHandleAreaHeight, width: view.bounds.width, height: cardHeight)
        
        productCardViewController.view.clipsToBounds = true
        
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
                        self.productCardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
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
                case .collapsed:
                    self.productCardViewController.view.layer.cornerRadius = 0
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
            DispatchQueue.main.async { [weak self] in
//                self?.previewCollection.reloadData()
            }
        }
    }
    
    private var productPreviews: [ImageViewModel] = []

    private var selectedIndex: Int = 0 {
        didSet {
            DispatchQueue.main.async {
//                self.previewCollection.reloadData()
            }
        }
    }
    
  //  var product: ProductViewModel!
    
    
    
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.backgroundColor = .lightGray
        return button
    }()


//    static func previewLayoutProvider(_ section: Int) -> NSCollectionLayoutSection {
//
//        switch section {
//        case 0:
//
//            let supplementaryView = [
//                NSCollectionLayoutBoundarySupplementaryItem(
//                    layoutSize: NSCollectionLayoutSize(
//                        widthDimension: .fractionalWidth(1),
//                        heightDimension: .fractionalHeight(1/1.8)),
//                    elementKind: UICollectionView.elementKindSectionHeader,
//                    alignment: .top)
//            ]
//
//            let item = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1/3),
//                    heightDimension: .fractionalHeight(1))
//            )
//            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
//            let group = NSCollectionLayoutGroup.horizontal(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .absolute(130)),
//                subitem: item,
//                count: 4
//            )
//
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .continuous
//            section.boundarySupplementaryItems = supplementaryView
//            return section
//
//        case 1:
//
//            let item = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .fractionalHeight(1))
//            )
//            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
//            let group = NSCollectionLayoutGroup.horizontal(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .absolute(250)),
//                subitem: item,
//                count: 1
//            )
//
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .continuous
//            return section
//
//        case 2:
//
//            let item = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .fractionalHeight(1))
//            )
//            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
//            let group = NSCollectionLayoutGroup.horizontal(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .estimated(200)),
//                subitem: item,
//                count: 1
//            )
//
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .continuous
//            return section
//
//        case 3:
//
//            let supplementaryView = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
//
//            let item = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .fractionalHeight(1))
//            )
//            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
//            let group = NSCollectionLayoutGroup.horizontal(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1/3),
//                    heightDimension: .estimated(160)),
//                subitem: item,
//                count: 1
//            )
//
//
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.boundarySupplementaryItems = supplementaryView
//            section.orthogonalScrollingBehavior = .continuous
//            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0)
//            return section
//
//        default:
//            let item = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .fractionalHeight(1))
//            )
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
//            return NSCollectionLayoutSection(group: group)
//        }
//
//    }

//    private let previewCollection: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(section: ProductDetailsViewController.previewLayoutProvider()))
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { section, _ in
//            ProductDetailsViewController.previewLayoutProvider(section)
//        }))
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.register(PreviewCollectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PreviewCollectionHeaderCollectionReusableView.identifier)
//        collectionView.register(PreviewAnglesCollectionViewCell.self, forCellWithReuseIdentifier: PreviewAnglesCollectionViewCell.identifier)
//        collectionView.register(ProductHeaderCollectionViewCell.self, forCellWithReuseIdentifier: ProductHeaderCollectionViewCell.identifier)
//        collectionView.register(ProductPreviewDescriptionCollectionViewCell.self, forCellWithReuseIdentifier: ProductPreviewDescriptionCollectionViewCell.identifier)
//        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
//        collectionView.register(RelevantCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RelevantCollectionReusableView.identifier)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()


    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        view.addSubview(previewCollection)
        view.addSubview(dismissButton)
        setupCard()
        configureConstraints()
        tabBarController?.tabBar.isHidden = true
//        previewCollection.dataSource = self
//        previewCollection.delegate = self
//        previewCollection.contentInsetAdjustmentBehavior = .never
        dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
//        addGradient()

        
//        previewCollection.collectionViewLayout.invalidateLayout()
    }
    
   
    @objc private func didTapDismiss() {
        dismiss(animated: true)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    private func configureConstraints() {
        
       

//        let previewCollectionConstraints = [
//            previewCollection.topAnchor.constraint(equalTo: view.topAnchor),
//            previewCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            previewCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            previewCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ]

        let dismissButtonConstraints = [
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dismissButton.heightAnchor.constraint(equalToConstant: 50),
            dismissButton.widthAnchor.constraint(equalToConstant: 50)
        ]

//        NSLayoutConstraint.activate(previewCollectionConstraints)
        NSLayoutConstraint.activate(dismissButtonConstraints)
    }
}

//extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return (product?.images.items.count)!
//
//        case 3:
//            return 10
//            
//        default:
//            return 1
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch indexPath.section {
//        case 0:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewAnglesCollectionViewCell.identifier, for: indexPath) as? PreviewAnglesCollectionViewCell else {
//                return UICollectionViewCell()
//            }
//            cell.isCellSelected = indexPath.row == selectedIndex
//            cell.configure(with: productPreviews[indexPath.row])
//            return cell
//            
//        case 1:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductHeaderCollectionViewCell.identifier, for: indexPath) as? ProductHeaderCollectionViewCell else {
//                return UICollectionViewCell()
//            }
//            
//            cell.configure(with: product!)
//
//            return cell
//            
////            ProductPreviewDescriptionCollectionViewCell
//        case 2:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductPreviewDescriptionCollectionViewCell.identifier, for: indexPath) as? ProductPreviewDescriptionCollectionViewCell else {
//                return UICollectionViewCell()
//            }
//            
//            cell.configure(with: product!)
////            cell.backgroundColor = .red
////            cell.sizeToFit()
//            return cell
//            
//        case 3:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
//                return UICollectionViewCell()
//            }
//            
//            cell.configure(with: "", thumbnail: "")
////            cell.backgroundColor = .red
////            cell.sizeToFit()
//            return cell
//            
//        default:
//            return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedIndex = indexPath.row
//    
//    }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//        switch indexPath.section {
//        case 0:
//            guard let header = collectionView.dequeueReusableSupplementaryView(
//                ofKind: UICollectionView.elementKindSectionHeader,
//                withReuseIdentifier: PreviewCollectionHeaderCollectionReusableView.identifier,
//                for: indexPath) as? PreviewCollectionHeaderCollectionReusableView else {
//                    return UICollectionReusableView()
//                }
//            header.configure(with: (product?.images.items[selectedIndex])!)
//            return header
//            
//        case 3:
//            guard let header = collectionView.dequeueReusableSupplementaryView(
//                ofKind: UICollectionView.elementKindSectionHeader,
//                withReuseIdentifier: RelevantCollectionReusableView.identifier,
//                for: indexPath) as? RelevantCollectionReusableView else {
//                    return UICollectionReusableView()
//                }
//
//            return header
//            
//        default:
//            return UICollectionReusableView()
//        }
//    }
//
//
//  
//    
//
//}
