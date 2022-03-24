//
//  ProductReviewTableViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 23/03/2022.
//

import UIKit



protocol ProductReviewTableViewCellDelegate: AnyObject {
    func productReviewTableViewCellDelegateDidTapAddReview()
}

class ProductReviewCell: UITableViewCell {
    
    static let identifier = className
    
    private let reviewAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let reviewText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    
 
    
    func configure(with model: Review) {
        reviewAuthor.text = model.reviewAuthor
        reviewText.text = model.reviewText
    }
    
    private func configureConstraints() {
        let reviewAuthorConstraints = [
            reviewAuthor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            reviewAuthor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15)
        ]
        
        let reviewTextConstraints = [
            reviewText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            reviewText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            reviewText.topAnchor.constraint(equalTo: reviewAuthor.bottomAnchor, constant: 5),
            reviewText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(reviewAuthorConstraints)
        NSLayoutConstraint.activate(reviewTextConstraints)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(reviewAuthor)
        contentView.addSubview(reviewText)
        contentView.backgroundColor = .white
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class ProductReviewTableViewCell: UITableViewCell {

    static let identifier = className
    
    var reviews: [Review] = [] {
        willSet {
            DispatchQueue.main.async { [weak self] in
                newValue.count > 0 ? self?.configureAsFilled() : self?.configureAsEmpty()
                self?.reviewsTableView.reloadData()
            }
        }
    }
    weak var delegate: ProductReviewTableViewCellDelegate?
    private let addReviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add review", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    private let noReviewsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "No Reviews for this item yet."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let reviewsTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .white
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(ProductReviewCell.self, forCellReuseIdentifier: ProductReviewCell.identifier)
        return tableview
    }()
    
    
    private func configureAsEmpty() {
        reviewsTableView.alpha = 0
    }
    
    private func configureAsFilled() {
        reviewsTableView.alpha = 1
    }
    
    private let reviewsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = "Reviews"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
 
    
    private func configureConstraints() {
        
        let reviewsLabelConstraints = [
            reviewsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            reviewsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15)
        ]
        
        let addReviewButtonConstraints = [
            addReviewButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            addReviewButton.bottomAnchor.constraint(equalTo: reviewsLabel.bottomAnchor)
        ]
        
        let noReviewsLabelConstraints = [
            noReviewsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            noReviewsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            noReviewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ]
        
        
        let reviewsTableViewConstraints = [
            reviewsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            reviewsTableView.topAnchor.constraint(equalTo: reviewsLabel.bottomAnchor, constant: 5),
            reviewsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            reviewsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(reviewsLabelConstraints)
        NSLayoutConstraint.activate(addReviewButtonConstraints)
        NSLayoutConstraint.activate(noReviewsLabelConstraints)
        NSLayoutConstraint.activate(reviewsTableViewConstraints)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(reviewsLabel)
        contentView.addSubview(addReviewButton)
        contentView.addSubview(noReviewsLabel)
        contentView.addSubview(reviewsTableView)
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
        configureConstraints()
        addReviewButton.addTarget(self, action: #selector(didTapAddReview), for: .touchUpInside)
    }
    
    @objc private func didTapAddReview() {
        delegate?.productReviewTableViewCellDelegateDidTapAddReview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ProductReviewTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductReviewCell.identifier, for: indexPath) as? ProductReviewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: reviews[indexPath.row])
        return cell
    }
    
    
    
}
