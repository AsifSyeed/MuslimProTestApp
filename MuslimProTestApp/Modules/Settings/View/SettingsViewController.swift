//
//  SettingsViewController.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/2/24.
//

import UIKit

class SettingsViewController: UIViewController {
    private let viewModel = SettingsViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsItemTableViewCell.self, forCellReuseIdentifier: SettingsItemTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        fetchTableViewData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fetchTableViewData() {
        viewModel.fetchSettings()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsItemTableViewCell.identifier, for: indexPath) as? SettingsItemTableViewCell else {
            return UITableViewCell()
        }
        
        let setting = viewModel.settings[indexPath.row]
        cell.configure(with: setting)
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedSetting = viewModel.settings[indexPath.row]
        
        if !selectedSetting.hasSwitch {
            print("\(selectedSetting.title) selected")
        }
    }
}

// MARK: - SettingsItemTableViewCellDelegate
extension SettingsViewController: SettingsItemTableViewCellDelegate {
    func didToggleSwitch(for cell: SettingsItemTableViewCell, isOn: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        var setting = viewModel.settings[indexPath.row]
        setting.isOn = isOn
        print("\(setting.title) is now \(isOn ? "enabled" : "disabled")")
    }
}
