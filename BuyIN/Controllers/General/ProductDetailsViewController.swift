//
//  ProductDetailsViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 12/03/2022.
//


import UIKit

class ProductDetailsViewController: UIViewController {

    
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
    
    
    static func previewLayoutProvider() -> NSCollectionLayoutSection {

        
        let supplementaryView = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1/1.8)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
        ]
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(100)),
            subitem: item,
            count: 4
        )

        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = supplementaryView
        return section
    }

    private let previewCollection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(section: ProductDetailsViewController.previewLayoutProvider()))
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(PreviewCollectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PreviewCollectionHeaderCollectionReusableView.identifier)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("  Add to cart", for: .normal)
        button.setImage(UIImage(systemName: "bag.fill"), for: .normal)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        button.tintColor = .white
        button.backgroundColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(addToCartButton)
        view.addSubview(previewCollection)
        view.addSubview(dismissButton)
        configureConstraints()
        tabBarController?.tabBar.isHidden = true
        previewCollection.dataSource = self
        previewCollection.delegate = self
        previewCollection.contentInsetAdjustmentBehavior = .never
        dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        
    }
    
    @objc private func didTapDismiss() {
        dismiss(animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func configureConstraints() {
        let addToCartButtonConstraints = [
            addToCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addToCartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            addToCartButton.heightAnchor.constraint(equalToConstant: 70)
        ]
        
        
        let previewCollectionConstraints = [
            previewCollection.topAnchor.constraint(equalTo: view.topAnchor),
            previewCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let dismissButtonConstraints = [
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dismissButton.heightAnchor.constraint(equalToConstant: 50),
            dismissButton.widthAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(previewCollectionConstraints)
        NSLayoutConstraint.activate(addToCartButtonConstraints)
        NSLayoutConstraint.activate(dismissButtonConstraints)
    }
}

extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 10
        }
        if section == 1 {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemPink
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: PreviewCollectionHeaderCollectionReusableView.identifier,
                for: indexPath) as? PreviewCollectionHeaderCollectionReusableView else {
                    return UICollectionReusableView()
                }
            return header
        }
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
    }
    

}
