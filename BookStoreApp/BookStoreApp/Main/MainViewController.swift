//
//  MainViewController.swift
//  BookStoreApp
//
//  Created by Jimin on 12/30/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let mainView = MainView()
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupView()
        setupDelegates()
        registerCells()
        setupSearch()
    }
    
//    private func setupView() {
//        view.backgroundColor = .white
//        
//        mainView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupSearch() {
        searchBooks(query: "Swift")
    }
    
    private func setupDelegates() {
        mainView.listTableView.delegate = self
        mainView.listTableView.dataSource = self
        mainView.searchBar.delegate = self
    }
    
    private func registerCells() {
        mainView.listTableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reuseIdentifier)
    }
    
    func searchBooks(query: String) {
        NetworkManager.shared.fetchBooks(query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    if books.isEmpty {
                        print("받아온 책 데이터가 없습니다")
                    } else {
                        print("받아온 책: \(books)")
                        self?.mainView.updateBooks(books)
                    }
                    
                case .failure(let error):
                    print("Error fetching books: \(error)")
                }
            }
        }
    }
}




extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainView.getBooks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseIdentifier, for: indexPath) as? SearchCell else {
                return UITableViewCell()
            }
        let book = mainView.getBooks()[indexPath.row]
        print("책 제목: \(book.title)")
            cell.configure(with: book)
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = mainView.getBooks()[indexPath.row]
        let detailVC = BookDetailController()
        
        detailVC.modalPresentationStyle = .popover
        present(detailVC, animated: true, completion: nil)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else {
            print("검색어가 비어있습니다")
            return
        }
        searchBooks(query: query)
    }
}
