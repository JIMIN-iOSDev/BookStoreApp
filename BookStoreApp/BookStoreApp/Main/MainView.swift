//
//  MainView.swift
//  BookStoreApp
//
//  Created by Jimin on 12/30/24.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    private var books: [Book] = []
    
    // MARK: - UI Components
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .default
        search.showsCancelButton = false
        search.searchTextField.layer.borderColor = UIColor.black.cgColor
        search.searchTextField.layer.borderWidth = 1
        search.searchTextField.layer.cornerRadius = 10
        search.searchTextField.backgroundColor = .white
        search.searchTextField.autocapitalizationType = .none
        return search
    }()
    
    let listTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "BookCell")
        return tableview
    }()
    

    override init(frame: CGRect) {
        super.init(frame:  frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupUI()
    private func setupUI() {
        [searchBar, listTableView]
            .forEach { self.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        listTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    func getBooks() -> [Book] {
        return books
    }
    
    func updateBooks(_ newBooks: [Book]) {
        books = newBooks
        listTableView.reloadData()
    }
}


