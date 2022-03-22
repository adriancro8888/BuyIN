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
        return section
    }
    
    private let viewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Categories"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    
    private let viewNavbar: UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        navbar.backgroundColor = .white
        navbar.layer.shadowOpacity = 0.8
        navbar.layer.shadowColor = UIColor.black.cgColor
        navbar.layer.shadowRadius = 5
        return navbar
    }()
    
    private let categoryCollection: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(section: CategoryViewController.sectionLayoutProvider()))
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.register(CategoryTabCollectionViewCell.self, forCellWithReuseIdentifier: CategoryTabCollectionViewCell.identifier)
        collection.register(CategoryHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryHeaderCollectionReusableView.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(categoryCollection)
        view.addSubview(viewNavbar)
        view.addSubview(viewTitleLabel)
        categoryCollection.delegate = self
        categoryCollection.backgroundColor = .white
        categoryCollection.dataSource = self
        configureConstraints()
        navigationController?.navigationBar.isHidden = true
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
    
    private func configureConstraints() {
        let viewNavbarConstraints = [
            viewNavbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewNavbar.topAnchor.constraint(equalTo: view.topAnchor),
            viewNavbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewNavbar.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let categoryCollectionConstraints = [
            categoryCollection.topAnchor.constraint(equalTo: viewNavbar.bottomAnchor),
            categoryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let viewTitleLabelConstraints = [
            viewTitleLabel.centerXAnchor.constraint(equalTo: viewNavbar.centerXAnchor),
            viewTitleLabel.bottomAnchor.constraint(equalTo: viewNavbar.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(viewNavbarConstraints)
        NSLayoutConstraint.activate(viewTitleLabelConstraints)
        NSLayoutConstraint.activate(categoryCollectionConstraints)
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
