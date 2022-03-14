//
//  ViewController.swift
//  BuyIN
//
//  Created by apple on 3/10/22.
//

import UIKit
import CoreML

class HomeViewController: UIViewController {


    
    private let categories: [String] = ["Shoes", "Hats", "Shirts", "Pants", "Glasses"]
    private var recentlyAddedItems: [ProductViewModel] = []
    private var flashSaleItems: [ProductViewModel] = []
    let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search items..."
        searchController.searchBar.searchBarStyle = .minimal
        searchController.definesPresentationContext = true
        return searchController
    }()
    
    
    static func layoutProvider(to section: Int) -> NSCollectionLayoutSection {
        

        switch section {
        case 0:
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(450)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            return section

        case 1:
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(80)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
            
        case 2:
            
            let supplementaryView = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 5, bottom: 4, trailing: 5)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(160), heightDimension: .absolute(290)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = [supplementaryView]
            return section
            
        case 3:
            
            let supplementaryView = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 10, trailing: 4)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(370)), subitem: item, count: 2)
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [supplementaryView]
            return section
                     
            
        default:
            return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(50))))
        }
    }

  
    private let collectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { section, _ in
            HomeViewController.layoutProvider(to: section)
        }))
        collectionView.register(
            FlashSaleSectionHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: FlashSaleSectionHeaderCollectionReusableView.identifier)
        
        collectionView.register(
            RecentlyAddedHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: RecentlyAddedHeaderCollectionReusableView.identifier)
        
        collectionView.register(HeroHeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeroHeaderCollectionViewCell.identifier)
        collectionView.register(HeroCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: HeroCategoriesCollectionViewCell.identifier)
        collectionView.register(HotProductsCollectionViewCell.self, forCellWithReuseIdentifier: HotProductsCollectionViewCell.identifier)
        collectionView.register(RecentlyAddedCollectionViewCell.self, forCellWithReuseIdentifier: RecentlyAddedCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        navigationItem.searchController = searchController
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.white
        fetchProductsForHome()
//        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        let vc = WelcomingViewController()
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: false)
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func fetchProductsForHome() {
        
        
        Client.shared.fetchCollections {[weak self] result in
            guard let result = result else {
                return
            }
            self?.recentlyAddedItems = result.items[1].products.items
            self?.flashSaleItems = result.items[0].products.items
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
            return 5
        }
        
        else if section == 1{
            return categories.count
        }
        
        else if section == 2{
            return flashSaleItems.count
        }
        
        else if section == 3{
            return recentlyAddedItems.count
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
            
            return cell
//            HeroCategoriesCollectionViewCell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroCategoriesCollectionViewCell.identifier, for: indexPath) as? HeroCategoriesCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.categoryTitle = categories[indexPath.row]
            return cell
            
            
//            HotProductsCollectionViewCell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotProductsCollectionViewCell.identifier, for: indexPath) as? HotProductsCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.contentView.layer.shadowColor = UIColor.black.cgColor
            cell.contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
            cell.contentView.layer.shadowRadius = 10
            cell.contentView.layer.shadowOpacity = 0.5
            cell.configure(with: flashSaleItems[indexPath.row])
            return cell
            
            
//            RecentlyAddedCollectionViewCell
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyAddedCollectionViewCell.identifier, for: indexPath) as? RecentlyAddedCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.contentView.layer.shadowColor = UIColor.black.cgColor
            cell.contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
            cell.contentView.layer.shadowRadius = 10
            cell.contentView.layer.shadowOpacity = 0.5
            cell.configure(with: recentlyAddedItems[indexPath.row])
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .systemPink
            return cell
        }

    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 2 {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: FlashSaleSectionHeaderCollectionReusableView.identifier,
                for: indexPath) as? FlashSaleSectionHeaderCollectionReusableView else {
                    return UICollectionReusableView()
                }
            header.sectionTitle = "Flash Sale"
            return header
        }
        
        if indexPath.section == 3 {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: RecentlyAddedHeaderCollectionReusableView.identifier,
                for: indexPath) as? RecentlyAddedHeaderCollectionReusableView else {
                    return UICollectionReusableView()
                }
            header.sectionTitle = "Recently Added"
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailsViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.product = flashSaleItems[indexPath.row]
        present(vc, animated: true)
    }
}
