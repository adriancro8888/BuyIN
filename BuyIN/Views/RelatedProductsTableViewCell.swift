//
//  RelatedProductsTableViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 17/03/2022.
//

import UIKit
import Buy




class RelatedProductsTableViewCell: UITableViewCell {
    static let identifier = className
    
    private var relatedProducts:[Storefront.Product] = []
    private var currentProduct: ProductViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.relatedProductsCollectionView.reloadData()
            }
        }
    }
    
    private let relatedProductsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Recommended for you"
        label.textColor = .black
        return label
    }()
    
    private let relatedProductsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(ProductPreviewCollectionViewCell.self, forCellWithReuseIdentifier: ProductPreviewCollectionViewCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(relatedProductsLabel)
        contentView.addSubview(relatedProductsCollectionView)
        relatedProductsCollectionView.delegate = self
        relatedProductsCollectionView.dataSource = self
        configureConstraints()
    }
    
    func configure(with product: ProductViewModel) {
        currentProduct = product
        Client.shared.fetchProductRecommendation(in: product) { [weak self] result in
            guard let result = result else {
                return
            }
            self?.relatedProducts = result
            DispatchQueue.main.async {
                self?.relatedProductsCollectionView.reloadData()
            }
        }
    }
    
    private func configureConstraints() {
        
        let relatedProductsLabelConstraints = [
            relatedProductsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            relatedProductsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ]
        
        let relatedProductsCollectionViewConstraints = [
            relatedProductsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            relatedProductsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            relatedProductsCollectionView.topAnchor.constraint(equalTo: relatedProductsLabel.bottomAnchor, constant: 10),
            relatedProductsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(relatedProductsLabelConstraints)
        NSLayoutConstraint.activate(relatedProductsCollectionViewConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension RelatedProductsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return relatedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductPreviewCollectionViewCell.identifier, for: indexPath) as? ProductPreviewCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .white
        cell.configure(with: relatedProducts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailsViewController()
//        vc.product = relatedProducts[indexPath.row]
        relatedProducts[indexPath.row].id
        Client.shared
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: contentView.bounds.height)
    }
}
