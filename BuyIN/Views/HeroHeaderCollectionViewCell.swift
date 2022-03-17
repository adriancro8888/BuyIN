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
    
    private let pillControl: PillPageControl = {
        let view = PillPageControl()
        view.pageCount = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static let identifier = "HeroHeaderCollectionViewCell"
    
//
//    private let heroTextLabel: UILabel = {
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "New Arrivals"
//        label.numberOfLines = 0
//        label.textColor = .white
//        label.font =  .systemFont(ofSize: 74, weight: .heavy)
//        return label
//    }()
//

//    private let heroImageView: UIImageView = {
//
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.backgroundColor = .red
//        imageView.clipsToBounds = true
//
//        return imageView
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerCollectionView)
//        contentView.addSubview(overlayView)

        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        contentView.addSubview(pillControl)
//        contentView.addSubview(heroImageView)
//        contentView.addSubview(heroTextLabel)
//        configureConstraints()
//        guard let url = URL(string: "https://images.unsplash.com/photo-1568196004494-b1ee34f3b436?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80") else {return}
//        heroImageView.setImageFrom(url, placeholder: UIImage(systemName: "house"))
//
        
        configureConstraints()
    }
    
    
    func updateCurrentlyShownCell() {
        currentlyShownIndex+=1
        currentlyShownIndex%=5
        bannerCollectionView.scrollToItem(at: IndexPath(row: currentlyShownIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bannerCollectionView.frame = contentView.bounds
//        heroImageView.frame = contentView.bounds
//        overlayView.frame = contentView.bounds
    }
    
    private func configureConstraints() {
//        let heroTextLabelConstraints = [
//            heroTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            heroTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
//            heroTextLabel.widthAnchor.constraint(equalToConstant: 280)
//        ]
//
//        NSLayoutConstraint.activate(heroTextLabelConstraints)
        
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
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
            
        }
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
