//
//  HeroHeaderCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 11/03/2022.
//

import UIKit

class HeroHeaderCollectionViewCell: UICollectionViewCell {
    
    private var currentlyShownIndex = 0
    
    private let bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private lazy var pillControl: PillPageControl = {
        let view = PillPageControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static let identifier = "HeroHeaderCollectionViewCell"

    var salesCollections: [CollectionViewModel]? {
        willSet {
            pillControl.pageCount = newValue!.count
            contentView.addSubview(pillControl)
            configureConstraints()
            bannerCollectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerCollectionView)
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
    }
    
    
    func updateCurrentlyShownCell() {
        currentlyShownIndex+=1
        currentlyShownIndex%=salesCollections!.count
        bannerCollectionView.scrollToItem(at: IndexPath(row: currentlyShownIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bannerCollectionView.frame = contentView.bounds
    }
    
    private func configureConstraints() {

        let pillControlConstraints = [
            pillControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            pillControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ]
        
        NSLayoutConstraint.activate(pillControlConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}


extension HeroHeaderCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let salesCollections = salesCollections else {return 0}
        return salesCollections.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let salesCollections = salesCollections else {return UICollectionViewCell()}
        cell.configure(with: salesCollections[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.bounds.width, height: contentView.bounds.height)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        let progressInPage = scrollView.contentOffset.x - (page * scrollView.bounds.width)
        let progress = CGFloat(page) + progressInPage
        pillControl.progress = progress

    }
}
