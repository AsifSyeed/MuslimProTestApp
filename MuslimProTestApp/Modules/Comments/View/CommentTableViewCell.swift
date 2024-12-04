//
//  CommentTableViewCell.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/3/24.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    static let identifier = "CommentTableViewCell"
    
    private let userIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
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
        
        [userIconImageView, userNameLabel, commentLabel, timeLabel].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            userIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            userIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userIconImageView.widthAnchor.constraint(equalToConstant: 40),
            userIconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            userNameLabel.leadingAnchor.constraint(equalTo: userIconImageView.trailingAnchor, constant: 12),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            commentLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 4),
            commentLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: commentLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: commentLabel.trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with comment: CommentItemModel) {
        userIconImageView.image = UIImage(systemName: "person.circle")
        userNameLabel.text = comment.userName
        commentLabel.text = comment.text
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        timeLabel.text = formatter.string(from: comment.time)
    }
}
