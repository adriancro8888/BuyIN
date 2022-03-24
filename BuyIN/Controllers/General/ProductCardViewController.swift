//
//  ProductCardViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 16/03/2022.
//

import UIKit
import Buy


class HandleArea: UIView {
    
    let handleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        let image = UIImage(systemName: "chevron.compact.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))
        imageView.image = image
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(handleImage)
        configureConstraints()
        backgroundColor = .clear
    }
    
    private func configureConstraints() {
        let handleImageConstraints = [
            handleImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            handleImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(handleImageConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

protocol ProductCardViewControllerDelegate: AnyObject {
    func productCardViewControllerDidRecieveAction()
}

class ProductCardViewController: UIViewController {
    
    private var colorActions:[UIAction] = [UIAction]()
    private var sizeActions:[UIAction] = [UIAction]()
    weak var delegate: ProductCardViewControllerDelegate?
    
    private var reviews: [Review] = []
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Size"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private let sizeNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("XL", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        button.showsMenuAsPrimaryAction = true
        return button
    }()

    private let productTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textColor = .black
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Color"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        return label
    }()
    
    private let colorNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Black", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    
    
    private let addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("  Add", for: .normal)
        let image = UIImage(systemName: "bag", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        return button
    }()
    
    private let colorBlockView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private let sizeBlockView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
        
    private let colorDropdownImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "arrowtriangle.down.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 9, weight: .light))
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let sizesDropdownImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "arrowtriangle.down.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 9, weight: .light))
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let handleArea: HandleArea = {
        let view = HandleArea()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        fetchReviews()
    }
    
    var product: ProductViewModel? {

        
        willSet {
            productTitle.text = newValue?.title
            productPrice.text = "\(newValue?.price ?? "")"
        }
    }
    
    
    private var widthConstarint: NSLayoutConstraint?
    
    private let cardTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CardDescriptionTableViewCell.self, forCellReuseIdentifier: CardDescriptionTableViewCell.identifier)
        tableView.register(RelatedProductsTableViewCell.self, forCellReuseIdentifier: RelatedProductsTableViewCell.identifier)
        tableView.register(ProductReviewTableViewCell.self, forCellReuseIdentifier: ProductReviewTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(handleArea)
        view.addSubview(productTitle)
        view.addSubview(productPrice)

        view.addSubview(addToCartButton)
        view.addSubview(colorBlockView)
        view.addSubview(sizeBlockView)
        colorBlockView.addSubview(colorLabel)
        colorBlockView.addSubview(colorNameButton)
        sizeBlockView.addSubview(sizeLabel)
        sizeBlockView.addSubview(sizeNameButton)
        view.addSubview(cardTableView)
        view.backgroundColor = .white
        colorBlockView.addSubview(colorDropdownImage)
        sizeBlockView.addSubview(sizesDropdownImage)
        configureConstraints()
        view.shadowColor = .black
        view.shadowOpacity = 0.7
        view.shadowOffset = .zero
        view.shadowRadius = 10
        cardTableView.delegate = self
        cardTableView.dataSource = self
        colorNameButton.addTarget(self, action: #selector(didTapMenu), for: .touchUpInside)
        sizeNameButton.addTarget(self, action: #selector(didTapMenu), for: .touchUpInside)
        configureMenus()
        cardTableView.backgroundColor = .white
        addToCartButton.addTarget(self, action: #selector(didTapAddToCart), for: .touchUpInside)
    }
    
    
    
    private func fetchReviews() {
        FirestoreManager.shared.fetchReviews(for: product!) { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.reviews = reviews
                DispatchQueue.main.async {
                    self?.cardTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func didTapAddToCart() {
        let index = sizeActions.firstIndex { action in
            return action.title == sizeNameButton.titleLabel!.text!
        }!
        CartController.shared.add(CartItem(product: product!, variant: product!.variants.items[index]))
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.widthConstarint?.constant = (self?.view.frame.width)!
            self?.addToCartButton.backgroundColor = .systemGreen
            self?.view.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) { [weak self] in
                self?.widthConstarint?.constant = ((self?.view.frame.width)!/3)
                self?.view.layoutIfNeeded()
            } completion: { _ in
                self.addToCartButton.backgroundColor = .black
            }
        }

    }
    
  
    @objc private func didTapMenu() {}
    
    private func configureMenus() {


        var colors: Set<String> = []
        var sizes: Set<String> = []
        

        for varr in product!.variants.items {
            let option = varr.title.split(separator: Character("/"))
            if option.count > 1 {
                colors.insert(option[1].trimmingCharacters(in: CharacterSet(charactersIn: " ")))
            }
            sizes.insert(option[0].trimmingCharacters(in: CharacterSet(charactersIn: " ")))
        

        }
        
        for color in colors {
            colorActions.append(UIAction(title: color, state: .off) { [weak self] action in
                self?.colorNameButton.setTitle("\(action.title)", for: .normal)
            })
        }

        for size in sizes {
            sizeActions.append(UIAction(title: size, state: .off) { [weak self] action in
                self?.sizeNameButton.setTitle("\(action.title)", for: .normal)
            })
        }
        colorNameButton.setTitle("\(colors.first ?? "N/A")", for: .normal)
        sizeNameButton.setTitle("\(sizes.first ?? "N/A")", for: .normal)
        colorNameButton.menu = UIMenu(title: "", children: colorActions)
        sizeNameButton.menu = UIMenu(title: "", children: sizeActions)
    }

    
 
    
    private func configureConstraints() {
        
        let handleImageConstraints = [
            handleArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            handleArea.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            handleArea.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            handleArea.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        let productTitleConstraints = [
            productTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productTitle.topAnchor.constraint(equalTo: handleArea.bottomAnchor, constant: 10),
            productTitle.widthAnchor.constraint(equalToConstant: 250)
        ]

        
        let productPriceConstriants = [
            productPrice.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productPrice.bottomAnchor.constraint(equalTo: productTitle.bottomAnchor),
        ]

        
        let colorLabelConstraints = [
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            colorLabel.topAnchor.constraint(equalTo: colorBlockView.topAnchor, constant: 10)
        ]

        let colorNameButtonConstraints = [
            colorNameButton.leadingAnchor.constraint(equalTo: colorLabel.leadingAnchor),
            colorNameButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor)
        ]
        
        
        
        widthConstarint = NSLayoutConstraint(item: addToCartButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.frame.width.magnitude/3)
        let addToCartButtonConstraints = [
            addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addToCartButton.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 10),
//            addToCartButton.widthAnchor.constraint(equalToConstant: view.frame.width.magnitude/3),
            addToCartButton.heightAnchor.constraint(equalToConstant: 60),
            widthConstarint!
        ]
        
        let colorBlockViewConstraints = [
            colorBlockView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorBlockView.topAnchor.constraint(equalTo: addToCartButton.topAnchor),
            colorBlockView.heightAnchor.constraint(equalToConstant: 60),
            colorBlockView.widthAnchor.constraint(equalToConstant: view.bounds.width/3)
        ]
        
        let sizeBlockViewConstraints = [
            sizeBlockView.leadingAnchor.constraint(equalTo: colorBlockView.trailingAnchor),
            sizeBlockView.topAnchor.constraint(equalTo: addToCartButton.topAnchor),
            sizeBlockView.trailingAnchor.constraint(equalTo: addToCartButton.leadingAnchor),
            sizeBlockView.heightAnchor.constraint(equalToConstant: 60)
        ]

        let sizeLabelConstraints = [
            sizeLabel.leadingAnchor.constraint(equalTo: sizeBlockView.leadingAnchor, constant: 20),
            sizeLabel.topAnchor.constraint(equalTo: sizeBlockView.topAnchor, constant: 10)
        ]
        
        let sizeNameButtonConstraints = [
            sizeNameButton.leadingAnchor.constraint(equalTo: sizeLabel.leadingAnchor),
            sizeNameButton.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor)
        ]
        
        let cardTableViewConstraints = [
            cardTableView.topAnchor.constraint(equalTo: sizeBlockView.bottomAnchor),
            cardTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let colorDropdownImageConstraints = [
            colorDropdownImage.leadingAnchor.constraint(equalTo: colorNameButton.trailingAnchor, constant: 5),
            colorDropdownImage.centerYAnchor.constraint(equalTo: colorNameButton.centerYAnchor, constant: 0)
        ]
        
        let sizeDropdownImageConstraints = [
            sizesDropdownImage.leadingAnchor.constraint(equalTo: sizeNameButton.trailingAnchor, constant: 5),
            sizesDropdownImage.centerYAnchor.constraint(equalTo: sizeNameButton.centerYAnchor, constant: 0)
        ]
        
        
        
        NSLayoutConstraint.activate(handleImageConstraints)
        NSLayoutConstraint.activate(productTitleConstraints)
        NSLayoutConstraint.activate(productPriceConstriants)
        NSLayoutConstraint.activate(colorLabelConstraints)
        NSLayoutConstraint.activate(colorNameButtonConstraints)
        NSLayoutConstraint.activate(addToCartButtonConstraints)
        NSLayoutConstraint.activate(colorBlockViewConstraints)
        NSLayoutConstraint.activate(sizeBlockViewConstraints)
        NSLayoutConstraint.activate(sizeLabelConstraints)
        NSLayoutConstraint.activate(sizeNameButtonConstraints)
        NSLayoutConstraint.activate(cardTableViewConstraints)
        NSLayoutConstraint.activate(colorDropdownImageConstraints)
        NSLayoutConstraint.activate(sizeDropdownImageConstraints)
    }
}

extension ProductCardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CardDescriptionTableViewCell.identifier, for: indexPath) as? CardDescriptionTableViewCell else {
                return UITableViewCell()
            }
            guard let summary = product?.summary else {
                return UITableViewCell()
            }
            cell.backgroundColor = .white
            cell.configure(with: summary)
            return cell
            
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RelatedProductsTableViewCell.identifier, for: indexPath) as? RelatedProductsTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: product!)
            cell.backgroundColor = .white
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductReviewTableViewCell.identifier, for: indexPath) as? ProductReviewTableViewCell else {
                return UITableViewCell()
            }
            
            cell.reviews = reviews
            cell.delegate = self
            cell.backgroundColor = .white
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else {
            return 320
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProductCardViewController: ProductReviewTableViewCellDelegate {
    func productReviewTableViewCellDelegateDidTapAddReview() {
        delegate?.productCardViewControllerDidRecieveAction()
    }
}
