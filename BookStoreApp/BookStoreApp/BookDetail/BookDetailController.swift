//
//  BookDetailController.swift
//  BookStoreApp
//
//  Created by Jimin on 12/30/24.
//

import UIKit
import SnapKit


protocol BookDetailDelegate: AnyObject {
    func didAddBook(title: String)
    func didDismissDetail()
}

class BookDetailController: UIViewController {
    
    private let bookDetailView = BookDetailView()
    private var book: Book?
    weak var delegate: BookDetailDelegate?
    
    override func loadView() {
        view = bookDetailView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActions()
        
        modalPresentationStyle = .pageSheet
        if let sheet = sheetPresentationController {
            sheet.detents = [.large()]
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bookDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupActions() {
        bookDetailView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        bookDetailView.selectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.didDismissDetail()
        }
    }
    
    @objc private func selectButtonTapped() {
        guard let book = book else { return }
        CoreDataManager.shared.saveBook(book)
        
        dismiss(animated: true) {
            self.delegate?.didAddBook(title: book.title)
        }
    }
    
    func configure(with book: Book) {
        self.book = book
        
        bookDetailView.titleLabel.text = book.title
        bookDetailView.authorLabel.text = book.authors.joined(separator: ", ")
        
        if book.salePrice == -1 {
            bookDetailView.priceLabel.text = "정보없음"
        } else {
            bookDetailView.priceLabel.text = "\(book.salePrice)원"
        }
        
        bookDetailView.detailLabel.text = book.contents
        
        if let imageURL = book.thumbnail, let url = URL(string: imageURL) {
            loadImage(from: url)
        }
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self?.bookDetailView.bookImage.image = UIImage(data: data)
            }
        }.resume()
    }
}

