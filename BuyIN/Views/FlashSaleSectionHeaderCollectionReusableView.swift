//
//  FlashSaleSectionHeaderCollectionReusableView.swift
//  BuyIN
//
//  Created by Amr Hossam on 11/03/2022.
//

import UIKit

class FlashSaleSectionHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "FlashSaleSectionHeaderCollectionReusableView"
    
    private let saleDeadlineLabel: UILabel = {
        let label = UILabel()
        label.text = "closes in"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let saleDeadlineTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:12:45"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
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
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionTitleLabel)
        addSubview(saleDeadlineLabel)
        addSubview(saleDeadlineTimeLabel)
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
        
        let saleDeadlineTimeLabelConstraints = [
            saleDeadlineTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            saleDeadlineTimeLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let saleDeadlineLabelConstraints = [
            saleDeadlineLabel.trailingAnchor.constraint(equalTo: saleDeadlineTimeLabel.leadingAnchor, constant: -10),
            saleDeadlineLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(sectionTitleLabelConstraints)
        NSLayoutConstraint.activate(saleDeadlineTimeLabelConstraints)
        NSLayoutConstraint.activate(saleDeadlineLabelConstraints)
    }
}
