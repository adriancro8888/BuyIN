//
//  ProductCardViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 16/03/2022.
//

import UIKit


class HandleArea: UIView {
    
    private let handleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "chevron.compact.up")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(handleImage)
        configureConstraints()
        backgroundColor = .white
    }
    
    private func configureConstraints() {
        let handleImageConstraints = [
            handleImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            handleImage.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(handleImageConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class ProductCardViewController: UIViewController {

    let handleArea: HandleArea = {
        let view = HandleArea()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(handleArea)
        view.backgroundColor = .yellow
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        let handleImageConstraints = [
            handleArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            handleArea.topAnchor.constraint(equalTo: view.topAnchor),
            handleArea.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            handleArea.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(handleImageConstraints)
    }

}
