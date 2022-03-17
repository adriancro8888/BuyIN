//
//  FlashSaleSectionHeaderCollectionReusableView.swift
//  BuyIN
//
//  Created by Amr Hossam on 11/03/2022.
//

import UIKit

class FlashSaleSectionHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = className

    var sectionTitle: String {
        get {
            sectionTitleLabel.text!
        }
        
        set {
            sectionTitleLabel.text = newValue
        }
    }
    
    
    private let sectionTitleLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionTitleLabel)
        configureConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureConstraints() {
        let sectionTitleLabelConstraints = [
            sectionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            sectionTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]

        NSLayoutConstraint.activate(sectionTitleLabelConstraints)
    }
}
