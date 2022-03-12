//
//  RecentlyViewedHeaderCollectionReusableView.swift
//  BuyIN
//
//  Created by Amr Hossam on 11/03/2022.
//

import UIKit

class RecentlyAddedHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = className
    
    var sectionTitle: String {
        get {
            recentlyViewedLabel.text!
        }
        
        set {
            recentlyViewedLabel.text = newValue
        }
    }
    
    
    private let recentlyViewedLabel: UILabel = {
        let label = UILabel()
        label.text = "Recently Added"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(recentlyViewedLabel)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureConstraints() {
        let recentlyViewedLabelConstraints = [
            recentlyViewedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            recentlyViewedLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(recentlyViewedLabelConstraints)
    }
}
