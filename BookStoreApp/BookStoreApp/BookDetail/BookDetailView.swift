//
//  BookDetailView.swift
//  BookStoreApp
//
//  Created by Jimin on 12/30/24.
//

import UIKit
import SnapKit

class BookDetailView: UIView {
    
    // MARK: - UI Components
    let contentView = UIView()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.textAlignment = .center
        title.font = .boldSystemFont(ofSize: 30)
        title.numberOfLines = 0
        return title
    }()
    
    let authorLabel: UILabel = {
        let author = UILabel()
        author.textColor = .gray
        author.textAlignment = .center
        author.font = .systemFont(ofSize: 15)
        return author
    }()
    
    let bookImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let priceLabel: UILabel = {
        let price = UILabel()
        price.textColor = .black
        price.textAlignment = .center
        price.font = .boldSystemFont(ofSize: 20)
        return price
    }()
    
    let detailLabel: UILabel = {
        let detail = UILabel()
        detail.textColor = .black
        detail.textAlignment = .center
        detail.font = .systemFont(ofSize: 16)
        detail.numberOfLines = 0
        return detail
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    let cancelButton: UIButton = {
        let cancel = UIButton()
        cancel.setTitle("x", for: .normal)
        cancel.setTitleColor(.white, for: .normal)
        cancel.backgroundColor = .gray
        cancel.layer.cornerRadius = 10
        return cancel
    }()
    
    let selectButton: UIButton = {
        let select = UIButton()
        select.setTitle("담기", for: .normal)
        select.setTitleColor(.white, for: .normal)
        select.backgroundColor = .systemGreen
        select.layer.cornerRadius = 10
        return select
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupUI()
    private func setupUI() {
        
        addSubview(scrollView)
        addSubview(stackView)
        scrollView.addSubview(contentView)
        
        stackView.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(stackView.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        [titleLabel, authorLabel, bookImage, priceLabel, detailLabel]
            .forEach{ contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        bookImage.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(350)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(bookImage.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        [cancelButton, selectButton]
            .forEach { stackView.addArrangedSubview($0) }
        
        cancelButton.snp.makeConstraints {
            $0.width.equalTo(selectButton.snp.width).multipliedBy(0.333)
            $0.height.equalTo(50)
        }
        
    }
    
}
