//
//  FilterContainerView.swift
//  BuyIN
//
//  Created by Amr Hossam on 19/03/2022.
//

import UIKit

protocol FilterContainerViewDelegate: AnyObject {
    func filterContainerViewDidReceiveAction(_ action: UIAction, type: String)
}

class FilterSectionHeader: UICollectionReusableView {
    static let identifier = className
        
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.text = "Filter by"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        configureConstraints()
    }
    
    private func configureConstraints() {
        let labelConstraints = [
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(labelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class FilterContainerView: UIView {

    private var filterProperties: [String] = ["Brand", "Category", "Tag", "Type",]
    private var filters: [[String]] = []
    weak var delegate: FilterContainerViewDelegate?
    
    private let filterCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            FilterSectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: FilterSectionHeader.identifier)
        collectionView.register(FilterOptionCollectionViewCell.self, forCellWithReuseIdentifier: FilterOptionCollectionViewCell.identifier)
        return collectionView
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(filterCollection)
        filterCollection.delegate = self
        filterCollection.dataSource = self
        filters.append(Client.shared.Brands)
        filters.append(Client.shared.Categories)
        filters.append(Client.shared.Tags)
        filters.append(Client.shared.Types)
        configureConstraints()
    }
    

    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureConstraints() {
        
        let filterCollectionConstraints = [
            filterCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterCollection.topAnchor.constraint(equalTo: topAnchor),
            filterCollection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(filterCollectionConstraints)
    }
}


extension FilterContainerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterProperties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterOptionCollectionViewCell.identifier, for: indexPath) as? FilterOptionCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.filter = filters[indexPath.row]
        cell.configure(with: filterProperties[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = filterProperties[indexPath.row].size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "arial", size: 30)!]).width
        let height = 30.0
        return CGSize(width: width, height: height)
    }
    

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilterSectionHeader.identifier, for: indexPath) as? FilterSectionHeader else {
            return UICollectionReusableView()
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 80, height: collectionView.bounds.height)
    }
}

extension FilterContainerView: FilterOptionCollectionViewCellDelegate {
    func filterOptionCollectionViewCellDidTapAction(_ action: UIAction, type: String) {
        delegate?.filterContainerViewDidReceiveAction(action, type: type)
    }
}
