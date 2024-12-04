//
//  ProfileViewController.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/2/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileItemTableViewCell.self, forCellReuseIdentifier: ProfileItemTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupTableHeader()
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
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupTableHeader() {
        let headerView = ProfileHeaderView()
        headerView.configure(name: "John Doe", email: "johndoe@example.com")
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        tableView.tableHeaderView = headerView
    }
    
    private func fetchTableViewData() {
        viewModel.fetchProfile()
        tableView.reloadData()
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileItemTableViewCell.identifier, for: indexPath) as? ProfileItemTableViewCell else {
            return UITableViewCell()
        }
        
        let row = viewModel.rows[indexPath.row]
        
        cell.textLabel?.text = row.title
        cell.textLabel?.font = .systemFont(ofSize: 16)
        cell.imageView?.image = UIImage(systemName: row.iconName ?? "")
        cell.accessoryType = row.action != nil ? .disclosureIndicator : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.rows[indexPath.row].action?()
    }
}
