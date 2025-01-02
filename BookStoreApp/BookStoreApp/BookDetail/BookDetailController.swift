//
//  BookDetailController.swift
//  BookStoreApp
//
//  Created by Jimin on 12/30/24.
//

import UIKit
import SnapKit

class BookDetailController: UIViewController {
    
    private let bookDetailView = BookDetailView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(bookDetailView)
        view.backgroundColor = .white
        
        bookDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
