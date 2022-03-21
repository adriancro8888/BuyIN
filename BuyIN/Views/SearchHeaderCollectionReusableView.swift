//
//  SearchHeaderCollectionReusableView.swift
//  BuyIN
//
//  Created by Amr Hossam on 19/03/2022.
//

import UIKit


protocol SearchHeaderCollectionReusableViewDelegate: AnyObject {
    func searchHeaderCollectionReusableViewDidTapFilter()
    func searchHeaderCollectionReusableViewDidStartSearching(_ search: String)
}

class SearchHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = className
    weak var delegate: SearchHeaderCollectionReusableViewDelegate?
    
    private let searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let field = UITextField()
        
        field.returnKeyType = .done
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.textColor = .black
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.cornerRadius = 4
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(
            string: "What are you looking for",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 8, width: 25, height: 25))
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        field.sendSubviewToBack(imageView)
        view.addSubview(imageView)
        field.leftView = view
        field.leftViewMode = .always
        field.textColor = .black
        field.delegate = self
        return field
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        let image = UIImage(
            systemName: "slider.horizontal.3",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 22,
                weight: .light))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchView)
        searchView.addSubview(searchTextField)
        searchView.addSubview(filterButton)
        configureConstraints()
        filterButton.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)

        clipsToBounds = true
    }
    
    @objc private func didTapFilter() {
        delegate?.searchHeaderCollectionReusableViewDidTapFilter()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private func configureConstraints() {
        let searchViewConstraints = [
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 45)
        ]
        
        let searchTextFieldConstraints = [
            searchTextField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -90),
            searchTextField.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 10),
            searchTextField.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let filterButtonConstraints = [
            filterButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -20),
            filterButton.centerYAnchor.constraint(equalTo: searchView.centerYAnchor)
        ]
        

        
        NSLayoutConstraint.activate(searchViewConstraints)
        NSLayoutConstraint.activate(searchTextFieldConstraints)
        NSLayoutConstraint.activate(filterButtonConstraints)
    }
}

extension SearchHeaderCollectionReusableView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.searchHeaderCollectionReusableViewDidStartSearching(textField.text!)
        return true
    }
}
