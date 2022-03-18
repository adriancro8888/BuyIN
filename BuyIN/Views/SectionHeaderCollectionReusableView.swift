//
//  CategoryHeaderCollectionReusableView.swift
//  BuyIN
//
//  Created by Amr Hossam on 18/03/2022.
//

import UIKit

class SectionHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = className
    
    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionTitleLabel)
        backgroundColor = .white
        configureConstraints()
    }
    
    func configure(with title: String) {
        sectionTitleLabel.text = title
    }
    
    private func configureConstraints() {
        
        let sectionTitleLabelConstraints = [
            sectionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            sectionTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(sectionTitleLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
