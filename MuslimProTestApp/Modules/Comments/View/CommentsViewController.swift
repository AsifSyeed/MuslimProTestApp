//
//  CommentsViewController.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/3/24.
//

import UIKit

class CommentsViewController: UIViewController {
    private let viewModel: CommentsViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var commentInputContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        return textView
    }()
    
    private lazy var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = false
        button.setTitleColor(.gray, for: .disabled)
        button.addTarget(self, action: #selector(postComment), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var commentTextViewHeightConstraint: NSLayoutConstraint?
    private var commentInputContainerBottomConstraint: NSLayoutConstraint?
    
    init(viewModel: CommentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel.title
        setupViews()
        setupKeyboardObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupViews() {
        [tableView, commentInputContainer].forEach {
            view.addSubview($0)
        }
        
        [commentTextView, postButton].forEach {
            commentInputContainer.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: commentInputContainer.topAnchor),
            
            commentInputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commentInputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            commentTextView.leadingAnchor.constraint(equalTo: commentInputContainer.leadingAnchor, constant: 8),
            commentTextView.topAnchor.constraint(equalTo: commentInputContainer.topAnchor, constant: 8),
            commentTextView.bottomAnchor.constraint(equalTo: commentInputContainer.bottomAnchor, constant: -8),
            commentTextView.trailingAnchor.constraint(equalTo: postButton.leadingAnchor, constant: -8),
            
            postButton.trailingAnchor.constraint(equalTo: commentInputContainer.trailingAnchor, constant: -8),
            postButton.centerYAnchor.constraint(equalTo: commentTextView.centerYAnchor),
            postButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        commentTextViewHeightConstraint = commentTextView.heightAnchor.constraint(equalToConstant: 36)
        commentTextViewHeightConstraint?.isActive = true
        
        commentInputContainerBottomConstraint = commentInputContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        commentInputContainerBottomConstraint?.isActive = true
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func handleKeyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        let safeAreaInsetBottom = view.safeAreaInsets.bottom
        commentInputContainerBottomConstraint?.constant = -(keyboardFrame.height - safeAreaInsetBottom)
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func handleKeyboardWillHide(_ notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        commentInputContainerBottomConstraint?.constant = 0
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func postComment() {
        guard let text = commentTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else { return }
        
        let userName = "User \(viewModel.comments.count + 1)"
        viewModel.addComment(text, by: userName)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: viewModel.comments.count - 1, section: 0), at: .bottom, animated: true)
        
        commentTextView.text = ""
        commentTextViewHeightConstraint?.constant = 36
        postButton.isEnabled = false
        
        view.endEditing(true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CommentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as! CommentTableViewCell
        let comment = viewModel.comments[indexPath.row]
        cell.configure(with: comment)
        return cell
    }
}

// MARK: - UITextViewDelegate
extension CommentsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        commentTextViewHeightConstraint?.constant = max(min(size.height, 100), 36)
        postButton.isEnabled = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        view.layoutIfNeeded()
    }
}
