//
//  CategoryViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 20/03/2022.
//

import UIKit

class CategoryViewController: UIViewController {
    
    private var collections: [CollectionViewModel] = []

    static func sectionLayoutProvider() -> NSCollectionLayoutSection {
        
//        let supplementaryView = [
//            NSCollectionLayoutBoundarySupplementaryItem(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .absolute(140)
//                ),
//                elementKind: UICollectionView.elementKindSectionHeader,
//                alignment: .top
//            )
//        ]
//
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/2),
                heightDimension: .fractionalHeight(1)
            ))
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(140)
            ),
            subitem: item,
            count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
//        section.boundarySupplementaryItems = supplementaryView
        return section
    }
    
    private let categoryCollection: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(section: CategoryViewController.sectionLayoutProvider()))
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.register(CategoryTabCollectionViewCell.self, forCellWithReuseIdentifier: CategoryTabCollectionViewCell.identifier)
        collection.register(CategoryHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryHeaderCollectionReusableView.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(categoryCollection)
        categoryCollection.delegate = self
        categoryCollection.backgroundColor = .white
        categoryCollection.dataSource = self
        Client.shared.fetchCollections(ofType: .sub) {[weak self] result in
            guard let result = result else {
                return
            }
            
            self?.collections = result.items
            DispatchQueue.main.async {
                self?.categoryCollection.reloadData()
            }
            
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        categoryCollection.frame = view.bounds
    }
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryTabCollectionViewCell.identifier, for: indexPath) as? CategoryTabCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: collections[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductCollectionViewController()
        vc.collectionProducts = collections[indexPath.row].products.items
        navigationController?.pushViewController(vc, animated: true)
    }
}
