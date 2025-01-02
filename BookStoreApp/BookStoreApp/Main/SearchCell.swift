//
//  SearchCell.swift
//  BookStoreApp
//
//  Created by Jimin on 12/31/24.
//

import UIKit
import SnapKit

class SearchCell: UITableViewCell {
    
    static let reuseIdentifier = "SearchCell"
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = .boldSystemFont(ofSize: 20)
        title.textAlignment = .left
        title.lineBreakMode = .byTruncatingTail
        return title
    }()
    
    private let authorLabel: UILabel = {
        let author = UILabel()
        author.textColor = .gray
        author.font = .systemFont(ofSize: 10)
        author.textAlignment = .center
        return author
    }()
    
    private let priceLabel: UILabel = {
        let price = UILabel()
        price.textColor = .black
        price.font = .systemFont(ofSize: 15)
        price.textAlignment = .center
        return price
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [titleLabel, authorLabel, priceLabel]
            .forEach { contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).inset(10)
            $0.trailing.lessThanOrEqualTo(authorLabel.snp.leading).offset(-10)
        }
        
        authorLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(priceLabel.snp.leading).offset(-10)
            $0.width.equalTo(80)
        }
        
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-10)
            $0.width.equalTo(80)
        }
    }
    
    func configure(with book: Book) {
        titleLabel.text = book.title
        authorLabel.text = book.authors.joined(separator: ", ")
        if book.salePrice == -1 {
            priceLabel.text = "정보없음"
        } else {
            priceLabel.text = "\(book.salePrice)원"
        }
    }
    
    
}
