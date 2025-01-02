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
        
        selectedBooksNavVC.navigationBar.topItem?.title = "담은 책"
        
        searchNavVC.tabBarItem = UITabBarItem(title: "검색 탭", image: .none, tag: 0)
        selectedBooksNavVC.tabBarItem = UITabBarItem(title: "담은 책 리스트 탭", image: .none, tag: 1)
        
        viewControllers = [searchNavVC, selectedBooksNavVC]
        
    }
    
}
