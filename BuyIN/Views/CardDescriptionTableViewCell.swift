//
//  CardDescriptionTableViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 17/03/2022.
//

import UIKit

class CardDescriptionTableViewCell: UITableViewCell {
    
    static let identifier = className
    
    private let summaryDetailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Summary"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    

    func configure(with model: String) {
        summaryDetailsLabel.text = model
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(summaryLabel)
        contentView.addSubview(summaryDetailsLabel)
        configureConstraints()
        
    }
    
    
    private func configureConstraints() {
        let summaryLabelConstraints = [
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            summaryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            summaryLabel.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let summaryDetailsLabelConstraints = [
            summaryDetailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            summaryDetailsLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor),
            summaryDetailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            summaryDetailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(summaryLabelConstraints)
        NSLayoutConstraint.activate(summaryDetailsLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
