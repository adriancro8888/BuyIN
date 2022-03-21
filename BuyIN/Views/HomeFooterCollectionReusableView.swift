//
//  HomeFooterCollectionReusableView.swift
//  BuyIN
//
//  Created by Amr Hossam on 21/03/2022.
//

import UIKit

protocol HomeFooterCollectionReusableViewDelegate: AnyObject {
    func homeFooterCollectionReusableViewDelegateDidTapEmail()
}

class HomeFooterCollectionReusableView: UICollectionReusableView {
        
    static let identifier = className
    weak var delegate: HomeFooterCollectionReusableViewDelegate?
    private let emailButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("   Email it to us", for: .normal)
        let image = UIImage(systemName: "envelope", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let suggestionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .light)
        label.text = "Got a suggestion?"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(suggestionLabel)
        addSubview(emailButton)
        configureConstraints()
        emailButton.addTarget(self, action: #selector(didTapEmail), for: .touchUpInside)
    }
    
    @objc private func didTapEmail() {
        delegate?.homeFooterCollectionReusableViewDelegateDidTapEmail()
    }
    
    private func configureConstraints() {
        
        let suggestionLabelConstraints = [
            suggestionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            suggestionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30)
        ]
        
        let emailButtonConstraints = [
            emailButton.leadingAnchor.constraint(equalTo: suggestionLabel.leadingAnchor),
            emailButton.topAnchor.constraint(equalTo: suggestionLabel.bottomAnchor, constant: 20),
            emailButton.widthAnchor.constraint(equalToConstant: 200),
            emailButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        NSLayoutConstraint.activate(suggestionLabelConstraints)
        NSLayoutConstraint.activate(emailButtonConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
