//
//  RelevantCollectionReusableView.swift
//  BuyIN
//
//  Created by Amr Hossam on 12/03/2022.
//

import UIKit

class RelevantCollectionReusableView: UICollectionReusableView {
        
    static let identifier = className
    
    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Related products"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionTitleLabel)
        configureConstraints()
    }
    
    private func configureConstraints() {
        let sectionTitleLabelConstraints = [
            sectionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            sectionTitleLabel.topAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(sectionTitleLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
