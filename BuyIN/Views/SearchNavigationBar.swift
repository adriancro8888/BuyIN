//
//  NavigationBar.swift
//  BuyIN
//
//  Created by Amr Hossam on 19/03/2022.
//

import UIKit

protocol SearchNavigationBarDelegate: AnyObject {
    func searchNavigationBarDidStartSearching()
}

class SearchNavigationBar: UIView {

    weak var delegate: SearchNavigationBarDelegate?
    
    private lazy var searchTextField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.textColor = .black
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.white.cgColor
        field.layer.cornerRadius = 6
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(
            string: "What are you looking for",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 8, width: 25, height: 25))
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        field.sendSubviewToBack(imageView)
        
        view.addSubview(imageView)
        field.leftView = view
        field.leftViewMode = .always
        field.textColor = .black
        field.delegate = self
        return field
    }()
    

    private func configureConstraints() {
        
        let searchTextFieldConstraints = [
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            searchTextField.heightAnchor.constraint(equalToConstant: 45)
        ]
        NSLayoutConstraint.activate(searchTextFieldConstraints)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchTextField)
        configureConstraints()
//        searchTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapTextField)))
        
    }
    
    @objc private func didTapTextField() {
        delegate?.searchNavigationBarDidStartSearching()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}



extension SearchNavigationBar: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.searchNavigationBarDidStartSearching()
        return false
    }
}
