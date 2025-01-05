//
//  SelectedBooksController.swift
//  BookStoreApp
//
//  Created by Jimin on 12/30/24.
//

import UIKit
import SnapKit

class SelectedBooksController: UIViewController {
    
    private let selectedBooksView = SelectedBooksView()
    private var savedBooks: [SavedBook] = []
    
    override func loadView() {
        view = selectedBooksView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBooks()
    }
    
    private func setupActions() {
        selectedBooksView.clearAllButton.addTarget(self, action: #selector(clearAllTapped), for: .touchUpInside)
        selectedBooksView.addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        
        selectedBooksView.tableView.delegate = self
        selectedBooksView.tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: selectedBooksView.addButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: selectedBooksView.clearAllButton)
        
        navigationItem.title = "담은 책"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor.black
        ]
    }
    
    private func loadBooks() {
        savedBooks = CoreDataManager.shared.fetchBooks()
        selectedBooksView.tableView.reloadData()
    }
    
    @objc private func clearAllTapped() {
        let alert = UIAlertController(title: "전체 삭제", message: "모든 책을 삭제하시겠습니까?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            CoreDataManager.shared.deleteAllBooks()
            self?.loadBooks()
        })
        
        present(alert, animated: true)
    }
    
    @objc private func addTapped() {
        if let tabBarController = tabBarController {
            tabBarController.selectedIndex = 0
            if let searchVC = tabBarController.viewControllers?[0] as? UINavigationController,
               let rootVC = searchVC.viewControllers.first as? MainViewController {
                rootVC.activateSearchBar()
            }
        }
    }
}

// MARK: - Extension
extension SelectedBooksController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        let book = savedBooks[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = book.title
        content.secondaryText = book.authors
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = savedBooks[indexPath.row]
            CoreDataManager.shared.deleteBook(book)
            savedBooks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
