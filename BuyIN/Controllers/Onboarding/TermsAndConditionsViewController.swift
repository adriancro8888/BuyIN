//
//  TermsAndConditionsViewController.swift
//  BuyIN
//
//  Created by Amr Hossam on 14/03/2022.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {

    
    private let dismissButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TermsAndConditionsTableViewCell.self, forCellReuseIdentifier: TermsAndConditionsTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var blurredVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let tacLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blurredVisualEffect)
        view.addSubview(tableView)
        view.addSubview(dismissButton)
        view.addSubview(tacLabel)
        tableView.dataSource = self
        configureConstraints()
        dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
    }
    
    
    @objc private func didTapDismiss() {
        dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        blurredVisualEffect.frame = view.bounds
        tableView.frame = view.frame
    }
    
    private func configureConstraints() {
        let dismissButtonConstraints = [
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            dismissButton.widthAnchor.constraint(equalToConstant: 40),
            dismissButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let tacLabelConstraints = [
            tacLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tacLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(dismissButtonConstraints)
        NSLayoutConstraint.activate(tacLabelConstraints)
    }
}

extension TermsAndConditionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TermsAndConditionsTableViewCell.identifier, for: indexPath) as? TermsAndConditionsTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
