//
//  AboutViewController.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/2/24.
//

import UIKit

class AboutViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "app.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "MyApp"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.text = "Version 1.0.0"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ac velit eu magna fermentum feugiat. Pellentesque et justo nec lorem sodales pellentesque nec in ligula. Curabitur et interdum lacus. Vivamus in odio nec nulla interdum scelerisque. Aenean feugiat, sapien non venenatis pulvinar, orci mauris fermentum purus, sit amet cursus augue libero non metus.
        
        Ut faucibus, sem ac ultricies dapibus, erat elit aliquet tortor, a tincidunt sem magna vel ligula. Integer vitae purus nulla. Aliquam facilisis elit at erat accumsan, nec dapibus velit elementum. Duis volutpat interdum justo sed tristique. Nunc blandit, ipsum a tincidunt pharetra, elit ex dapibus nisi, a interdum neque turpis a ligula. Proin vel malesuada eros. Nulla facilisi. In hac habitasse platea dictumst.
        """
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Privacy Policy", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(privacyPolicyTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var termsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Terms & Conditions", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupContent()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupContent() {
        [appIconImageView, appNameLabel, versionLabel, descriptionLabel, privacyPolicyButton, termsButton].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            appIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            appIconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            appIconImageView.widthAnchor.constraint(equalToConstant: 100),
            appIconImageView.heightAnchor.constraint(equalToConstant: 100),
            
            appNameLabel.topAnchor.constraint(equalTo: appIconImageView.bottomAnchor, constant: 20),
            appNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            appNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            versionLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 5),
            versionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            versionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            privacyPolicyButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            privacyPolicyButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            termsButton.topAnchor.constraint(equalTo: privacyPolicyButton.bottomAnchor, constant: 15),
            termsButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            termsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    @objc private func privacyPolicyTapped() {
        print("Privacy Policy tapped")
    }
    
    @objc private func termsTapped() {
        print("Terms & Conditions tapped")
    }
}
