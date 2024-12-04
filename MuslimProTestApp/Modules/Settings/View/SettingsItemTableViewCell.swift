//
//  SettingsItemTableViewCell.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/3/24.
//

import UIKit

protocol SettingsItemTableViewCellDelegate: AnyObject {
    func didToggleSwitch(for cell: SettingsItemTableViewCell, isOn: Bool)
}

class SettingsItemTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsItemTableViewCell"
    
    weak var delegate: SettingsItemTableViewCellDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.isHidden = true
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        [titleLabel, toggleSwitch].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            toggleSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            toggleSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        toggleSwitch.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
    }
    
    @objc private func switchToggled() {
        delegate?.didToggleSwitch(for: self, isOn: toggleSwitch.isOn)
    }
    
    func configure(with setting: SettingsItemModel) {
        titleLabel.text = setting.title
        toggleSwitch.isHidden = !setting.hasSwitch
        toggleSwitch.isOn = setting.isOn
    }
}
