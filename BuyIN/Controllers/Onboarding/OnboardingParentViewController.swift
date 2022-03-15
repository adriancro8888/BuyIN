//
//  OnboardingParentViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 13/03/2022.
//

import UIKit

class OnboardingParentViewController: UIViewController {

    
    private let loginVC = LoginViewController()
    private let signupVC = RegistrationViewController()
    private let resetPasswordVC = ResetPasswordViewController()
    
     let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "loginImage")
        return imageView
    }()
    
    
    @objc private func didTapDismiss() {
        dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        view.addSubview(scrollView)
        view.addSubview(dismissButton)

 
        scrollView.contentSize = CGSize(width: view.frame.width * 3, height: scrollView.frame.height)
        addChildren()
        dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        configureConstraints()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        backgroundImageView.frame = view.bounds
    }
    
    private func addChildren() {
        addChild(loginVC)
        scrollView.addSubview(loginVC.view)
        loginVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        loginVC.didMove(toParent: self)
        loginVC.onBoarding = self
        
        addChild(signupVC)
        scrollView.addSubview(signupVC.view)
        signupVC.view.frame = CGRect(x: view.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        signupVC.didMove(toParent: self)
        signupVC.onBoarding = self
        
        addChild(resetPasswordVC)
        scrollView.addSubview(resetPasswordVC.view)
        resetPasswordVC.view.frame = CGRect(x: view.frame.width*2, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        resetPasswordVC.didMove(toParent: self)
        resetPasswordVC.onBoarding = self
        
        
    }
    
    private func configureConstraints() {
        let dismissButtonConstraints = [
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            dismissButton.widthAnchor.constraint(equalToConstant: 50),
            dismissButton.heightAnchor.constraint(equalToConstant: 50)
        ]

        NSLayoutConstraint.activate(dismissButtonConstraints)
    }
}

 
