//
//  TapBar.swift
//  BookStoreApp
//
//  Created by Jimin on 12/30/24.
//

import UIKit

class TapBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {

        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        
        
        let searchNavVC = UINavigationController(rootViewController: MainViewController())
        let selectedBooksNavVC = UINavigationController(rootViewController: SelectedBooksController())
        
        searchNavVC.tabBarItem = UITabBarItem(title: "검색 탭", image: .none, tag: 0)
        selectedBooksNavVC.tabBarItem = UITabBarItem(title: "담은 책 리스트 탭", image: .none, tag: 1)
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        searchNavVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        selectedBooksNavVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        
        viewControllers = [searchNavVC, selectedBooksNavVC]
        
    }
    
}
