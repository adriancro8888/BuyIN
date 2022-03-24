//
//  FilterOptionCollectionViewCell.swift
//  BuyIN
//
//  Created by Amr Hossam on 19/03/2022.
//

import UIKit


protocol FilterOptionCollectionViewCellDelegate: AnyObject {
    func filterOptionCollectionViewCellDidTapAction(_ action: UIAction, type: String)
}

class FilterOptionCollectionViewCell: UICollectionViewCell {
    
    static let identifier = className
    weak var delegate: FilterOptionCollectionViewCellDelegate?
    
    var filter: [String]? {
        willSet {
            configure(with: newValue!)
        }
    }
    
    private let filterButton: UIButton = {
       
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(filterButton)
        configureConstraints()
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 6
        
    }
    
    private func configure(with filters: [String]) {
        var actions:[UIAction] = [UIAction]()
        
        for filter in filters {
            actions.append(UIAction(title: filter, state: .off) { [weak self] action in
                self?.delegate?.filterOptionCollectionViewCellDidTapAction(action, type: (self?.filterButton.titleLabel!.text!)!)
            })
        }
        
        filterButton.menu = UIMenu(title: "", options: .displayInline, children: actions)

    }

    
    func configure(with title: String) {
        filterButton.setTitle(title, for: .normal)
    }
    
    private func configureConstraints() {
        
        let filterButtonConstraints = [
            filterButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            filterButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            filterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            filterButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(filterButtonConstraints)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
