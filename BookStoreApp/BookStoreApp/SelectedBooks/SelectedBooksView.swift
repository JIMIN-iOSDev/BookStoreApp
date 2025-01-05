//
//  SelectedBooksView.swift
//  BookStoreApp
//
//  Created by Jimin on 12/30/24.
//

import UIKit
import SnapKit

class SelectedBooksView: UIView {
    
    let tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "BookCell")
        return tableview
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        return button
    }()
    
    let clearAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(tableView)
        addSubview(addButton)
        addSubview(clearAllButton)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
        clearAllButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
}
