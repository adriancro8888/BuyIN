//
//  RelatedProductsTableViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 17/03/2022.
//

import UIKit

class RelatedProductsTableViewCell: UITableViewCell {

    static let identifier = className
    
    
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
        label.text = "Related Products"
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductPreviewCollectionViewCell.identifier, for: indexPath) as? ProductPreviewCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .white
        cell.configure(with: currentProduct!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: contentView.bounds.height)
    }
}
