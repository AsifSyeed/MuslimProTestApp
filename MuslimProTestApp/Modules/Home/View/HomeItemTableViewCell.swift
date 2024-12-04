//
//  HomeItemTableViewCell.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/3/24.
//

import UIKit

class HomeItemTableViewCell: UITableViewCell {
    
    static let identifier = "HomeItemTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let seeCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "See Comments"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBlue
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [titleLabel, subtitleLabel, seeCommentsLabel].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: seeCommentsLabel.leadingAnchor, constant: -10),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            subtitleLabel.trailingAnchor.constraint(equalTo: seeCommentsLabel.leadingAnchor, constant: -10),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            seeCommentsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            seeCommentsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            seeCommentsLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func configure(with item: HomeItemModel) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}
