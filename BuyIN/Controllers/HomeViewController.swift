//
//  ViewController.swift
//  BuyIN
//
//  Created by apple on 3/10/22.
//

import UIKit
import Reachability
import MessageUI


class HomeViewController: UIViewController {
    let reachability = try! Reachability()
    
    
    private var timer: Timer?
    private var mainCategories: [CollectionViewModel] = []
    private let categories: [String] = ["Women", "Men", "Jeans"]
    private let sectionTitles: [String] = ["Shop by category", "Specials", "New Launches"]
    private var newLaunches: [ProductViewModel] = []

    private var salesCollections: [CollectionViewModel] = []
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    @objc private func shouldUpdateBanner() {
        guard let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? HeroHeaderCollectionViewCell else {
            return
        }
        cell.updateCurrentlyShownCell()
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(shouldUpdateBanner), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if salesCollections.count > 0 {
            runTimer()
        }
        tabBarController?.tabBar.isHidden = false
        
    }
    
    
    
    static func layoutProvider(to section: Int) -> NSCollectionLayoutSection {

        switch section {
        case 0:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(650)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            return section

            
        case 1:
            
            let supplementaryViews = [
                NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            ]
    
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(420)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = supplementaryViews
            return section
            
        case 2:

            let supplementaryViews = [
                NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            ]
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = supplementaryViews
            return section
            
        case 3:

            let supplementaryViews = [
                NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top),
                NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
            ]
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(320)), subitem: item, count: 2)
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementaryViews
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
            return section
            
            
            
            
        default:
            return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(50))))
        }
    }
    
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .light))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.alpha = 0
        return button
    }()
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { section, _ in
            HomeViewController.layoutProvider(to: section)
        }))

        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderCollectionReusableView.identifier)
        collectionView.register(HeroHeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeroHeaderCollectionViewCell.identifier)
        collectionView.register(HeroCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: HeroCategoriesCollectionViewCell.identifier)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.register(RecentlyAddedCollectionViewCell.self, forCellWithReuseIdentifier: RecentlyAddedCollectionViewCell.identifier)
        collectionView.register(GifCollectionViewCell.self, forCellWithReuseIdentifier: GifCollectionViewCell.identifier)
        collectionView.register(ProductPreviewCollectionViewCell.self, forCellWithReuseIdentifier: ProductPreviewCollectionViewCell.identifier)
        collectionView.register(HomeFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeFooterCollectionReusableView.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    private lazy var navigationBar: SearchNavigationBar = {
        let navigation = SearchNavigationBar()
        navigation.translatesAutoresizingMaskIntoConstraints = false
        return navigation
    }()
    
    private func configureConstraints() {
        let navigationBarConstraints = [
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 120)
        ]
        navigationBar.layer.zPosition = 2
        let searchButtonConstraints = [
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5)
        ]
        NSLayoutConstraint.activate(navigationBarConstraints)
        NSLayoutConstraint.activate(searchButtonConstraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability.whenReachable = { reachability in
            self.view.backgroundColor = .white
            self.view.addSubview(self.collectionView)
            self.view.addSubview(self.navigationBar)
            self.view.addSubview(self.searchButton)
            self.configureConstraints()
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.backgroundColor = .white
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            self.fetchProductsForHome()
            self.navigationController?.navigationBar.isHidden = true
            self.collectionView.contentInsetAdjustmentBehavior = .never
            self.navigationBar.delegate = self
            self.searchButton.addTarget(self, action: #selector(self.didTapSearchButton), for: .touchUpInside)

        }
        reachability.whenUnreachable = { _ in
            let noInternetViewController: NoInternetViewController = NoInternetViewController.instantiateFromNib()
            self.view.addSubview( noInternetViewController.view)
            self.addChild( noInternetViewController)
            noInternetViewController.activityIndicator.startAnimating()
            let alert = UIAlertController(title: "Disconnected", message: "Mobile is disconnected, please make sure it's connected", preferredStyle: .alert)

            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
             })

            //Add OK button to a dialog message
            alert.addAction(ok)
            // Present Alert to
            self.present(alert, animated: true, completion: nil)


            print("Not reachable")
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }

//        view.backgroundColor = .white
//        view.addSubview(collectionView)
//        view.addSubview(navigationBar)
//        view.addSubview(searchButton)
//        configureConstraints()
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.backgroundColor = .white
//        navigationController?.navigationBar.barTintColor = UIColor.white
//        fetchProductsForHome()
//        navigationController?.navigationBar.isHidden = true
//        collectionView.contentInsetAdjustmentBehavior = .never
//        navigationBar.delegate = self
//        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)

        
    }

    @objc private func didTapSearchButton() {
        presentSearchController()
    }

    private func presentSearchController() {
        let vc = SearchViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func fetchProductsForHome() {

        Client.shared.fetchCollections(ofType: .sales) { [weak self] result in
            guard let result = result else {
                return
            }
            self?.salesCollections = result.items
            DispatchQueue.main.async {
                self?.runTimer()
                self?.collectionView.reloadData()
            }
        }
        
        Client.shared.fetchCollections(ofType: .category) { [weak self] result in
            guard let result = result else {
                return
            }
            self?.mainCategories = result.items
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        Client.shared.fetchProducts { [weak self] result in
            guard let result = result else {
                return
            }
            self?.newLaunches = result.items
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        else if section == 1{
            return mainCategories.count
        }
        
        else if section == 2{
            return 1
        }
        else if section == 3 {
            return 4
        }
        
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroHeaderCollectionViewCell.identifier, for: indexPath) as? HeroHeaderCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.indexerDelegate = self
            cell.salesCollections = salesCollections
            return cell

            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: mainCategories[indexPath.row])
            return cell
            
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifCollectionViewCell.identifier, for: indexPath) as? GifCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductPreviewCollectionViewCell.identifier, for: indexPath) as? ProductPreviewCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.configure(with: newLaunches[indexPath.row])

            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .systemPink
            return cell
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderCollectionReusableView.identifier, for: indexPath) as? SectionHeaderCollectionReusableView else {
                return UICollectionReusableView()
            }
            if indexPath.section == 0 {return header}
            header.configure(with: sectionTitles[indexPath.section-1])
            
            
            return header
            
        default:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeFooterCollectionReusableView.identifier, for: indexPath) as? HomeFooterCollectionReusableView else {
                return UICollectionReusableView()
            }
            footer.delegate = self
            
            return footer
            
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = indexPath.section

         if section == 1 {
            let vc = ProductCollectionViewController()
            vc.collectionProducts = mainCategories[indexPath.row].products.items
            vc.navigationController?.navigationBar.isHidden = false
            navigationController?.pushViewController(vc, animated: true)
        } else if section == 2 {
            Client.shared.fetchCollections(ofType: .specials) { [weak self] result in
                guard let result = result else {
                    return
                }
                
                let vc = ProductCollectionViewController()
                vc.collectionProducts = result.items.first?.products.items
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        } else if section == 3 {
            let vc = ProductDetailsViewController()
            vc.product = newLaunches[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }


    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        navigationBar.transform = CGAffineTransform(translationX: 0, y: min(-min(contentOffset, 110), 0))
        searchButton.alpha = max(0, min(1, (contentOffset-40)/40))
    }
}


extension HomeViewController: SearchNavigationBarDelegate {
    
    func searchNavigationBarDidStartSearching() {
        presentSearchController()
    }
}


extension HomeViewController: HomeFooterCollectionReusableViewDelegate, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    func homeFooterCollectionReusableViewDelegateDidTapEmail() {
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.delegate = self
            vc.setSubject("Contact us/Feedback")
            vc.setToRecipients(["Amrhossam96@gmail.com"])
            vc.setCcRecipients([""])
            vc.setBccRecipients([""])
            present(vc, animated: true)
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
}

extension HomeViewController: HeroHeaderCollectionViewCellDelegate {
    func HeroHeaderCollectionViewCellDelegateDidSelectCollection(_ productCollection: [ProductViewModel]) {
        let vc = ProductCollectionViewController()
        vc.collectionProducts = productCollection
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
