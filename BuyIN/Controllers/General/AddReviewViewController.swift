//
//  AddReviewViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 23/03/2022.
//

import UIKit

class AddReviewViewController: UIViewController {
    
    var product: ProductViewModel?

    
    private lazy var doneToolBar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        toolbar.barStyle = .black
        let spacing = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDone))
        toolbar.items = [spacing, doneButton]
        return toolbar
    }()
    
    @objc private func didTapDone() {
        reviewAuthorField.resignFirstResponder()
        reviewTextView.resignFirstResponder()
    }
    
    private lazy var reviewAuthorField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor =  UIColor.white
        field.textColor = .black
        field.inputAccessoryView = doneToolBar
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(
            string: "Full Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return field
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        return button
    }()

    
    private let addReviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit Review", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    private lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        textView.inputAccessoryView = doneToolBar
        textView.font = .systemFont(ofSize: 14)
        return textView
    }()
    
    
    
    private func configureConstraints() {
        
        let reviewAuthorFieldConstraints = [
            reviewAuthorField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            reviewAuthorField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            reviewAuthorField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            reviewAuthorField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        
        let reviewTextViewConstraints = [
            reviewTextView.leadingAnchor.constraint(equalTo: reviewAuthorField.leadingAnchor),
            reviewTextView.trailingAnchor.constraint(equalTo: reviewAuthorField.trailingAnchor),
            reviewTextView.topAnchor.constraint(equalTo: reviewAuthorField.bottomAnchor, constant: 15),
            reviewTextView.heightAnchor.constraint(equalToConstant: 350)
        ]
        
        let addReviewButtonConstraints = [
            addReviewButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            addReviewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addReviewButton.topAnchor.constraint(equalTo: reviewTextView.bottomAnchor, constant: 20),
            addReviewButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let cancelButtonConstraints = [
            cancelButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cancelButton.topAnchor.constraint(equalTo: addReviewButton.topAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: addReviewButton.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(reviewAuthorFieldConstraints)
        NSLayoutConstraint.activate(reviewTextViewConstraints)
        NSLayoutConstraint.activate(addReviewButtonConstraints)
        NSLayoutConstraint.activate(cancelButtonConstraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Review"
        view.backgroundColor = .white
        view.addSubview(reviewAuthorField)
        view.addSubview(reviewTextView)
        view.addSubview(addReviewButton)
        view.addSubview(cancelButton)
        configureConstraints()
        addReviewButton.addTarget(self, action: #selector(didTapSubmitReviewButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    }
    
    @objc private func didTapCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapSubmitReviewButton() {
        
        guard let reviewAuthor = reviewAuthorField.text,
              let reviewText = reviewTextView.text else {
            return
        }
        

        let review = Review(itemID: product!.id, reviewAuthor: reviewAuthor, reviewText: reviewText)
        
        FirestoreManager.shared.commitReview(for: review) { [weak self] result in
            switch result {
            case .success():
                let alert = UIAlertController(title: "Success", message: "Review was added successfully", preferredStyle: .alert)
                let action = UIAlertAction(title: "Done", style: .cancel) { _ in
                    self?.navigationController?.popViewController(animated: true)
                }
                alert.addAction(action)
                self?.present(alert, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
}
