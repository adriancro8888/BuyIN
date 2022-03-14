//
//  WelcomingViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 13/03/2022.
//

import UIKit

class WelcomingViewController: UIViewController {

    private var currentlyShownImageIndex: Int = 1
    private var toBeShownImageIndex: Int = 2
    private var isBackgroundShown: Bool = false
    private var images: [String] = []
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BuyIN'"
        label.font = .systemFont(ofSize: 102, weight: .bold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Expect more. Pay less."
        label.font = .systemFont(ofSize: 30, weight: .medium)
        return label
    }()
    
    private let getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Started.", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.tintColor = .black
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        return button
    }()
    
    private var timer: Timer?

    private func showBackground() {
        foregroundImageView.alpha = 0
        backgroundImageView.alpha = 1
    }
    
    private func showForeground() {
        foregroundImageView.alpha = 1
        backgroundImageView.alpha = 0
    }
    
    private func updateBackgroundImage() {
        currentlyShownImageIndex += 2
        currentlyShownImageIndex %= images.count
        backgroundImageView.image = UIImage(named: images[currentlyShownImageIndex])
    }
    
    private func updateForegroundImage() {
        toBeShownImageIndex += 2
        toBeShownImageIndex %= images.count
        foregroundImageView.image = UIImage(named: images[toBeShownImageIndex])
    }
    
    @objc func updateScreen() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) { [weak self] in
            if !(self!.isBackgroundShown) {
                self?.showBackground()
                self?.updateBackgroundImage()
            } else {
                self?.showForeground()
                self?.updateForegroundImage()

            }

        } completion: { _ in
            self.isBackgroundShown.toggle()
        }

    }
    
    private let overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45)
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "\(toBeShownImageIndex)")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var foregroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "\(currentlyShownImageIndex)")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    private func configureLabels() {
        logoLabel.transform = CGAffineTransform(translationX: -400, y: 0)
        descriptionLabel.transform = CGAffineTransform(translationX: -400, y: 0)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(updateScreen), userInfo: nil, repeats: true)
        for i in 1...6 {
            images.append("\(i)")
        }
        print(images)
        view.addSubview(backgroundImageView)
        view.addSubview(foregroundImageView)
        view.addSubview(overlayView)
        view.addSubview(logoLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(getStartedButton)
        
        configureConstraints()
        configureLabels()
        
        getStartedButton.addTarget(self, action: #selector(didTapGetStarted), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        UIView.animate(withDuration: 0.8, delay: 0.5, options: .curveEaseOut) { [weak self] in
            self?.logoLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        } completion: { _ in
            
        }
        
        UIView.animate(withDuration: 0.8, delay: 0.8, options: .curveEaseOut) { [weak self] in
            self?.descriptionLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        } completion: { _ in
            
        }
    }
    
    
    @objc private func didTapGetStarted() {
        let vc = OnboardingParentViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        timer?.invalidate()
        present(vc, animated: true)
    }
    
    private func configureConstraints() {
        
        let overlayViewConstraints = [
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let backgroundImageViewConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let foregroundImageViewConstraints = [
            foregroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            foregroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            foregroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            foregroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let logoLabelConstraints = [
            logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        ]
        
        let descriptionLabelConstraints = [
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 5)
        ]
        
        let getStartedButtonConstraints = [
            getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            getStartedButton.heightAnchor.constraint(equalToConstant: 70)
        ]
        
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(foregroundImageViewConstraints)
        NSLayoutConstraint.activate(overlayViewConstraints)
        NSLayoutConstraint.activate(logoLabelConstraints)
        NSLayoutConstraint.activate(descriptionLabelConstraints)
        NSLayoutConstraint.activate(getStartedButtonConstraints)

    }
}
