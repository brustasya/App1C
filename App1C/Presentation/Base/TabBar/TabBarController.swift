//
//  TabBarController.swift
//  App1C
//
//  Created by Станислава on 01.04.2024.
//

import UIKit

class TabBarController: UITabBarController {
    var mainScreenNavigationController: UINavigationController
    var settingsNavigationController: UINavigationController
    
    init(
        mainScreenNavigationController: UINavigationController,
        settingsNavigationController: UINavigationController
    ) {
        self.mainScreenNavigationController = mainScreenNavigationController
        self.settingsNavigationController = settingsNavigationController
        
        super.init(nibName: nil, bundle: nil)
        
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBar() {
       // tabBar.isTranslucent = false
        tabBar.barTintColor = Colors.paleYellow.uiColor
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.masksToBounds = true
        tabBar.frame = CGRect(x: -1, y: 0, width: view.frame.width + 1, height: 84)
        
        tabBar.backgroundColor = Colors.paleYellow.uiColor
        tabBar.layer.borderColor = UIColor.systemGray4.cgColor
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.tintColor = .black
        
        mainScreenNavigationController.tabBarItem = UITabBarItem(
            title: "Главная",
            image: Images.house.uiImage,
            tag: 0
        )
        
        settingsNavigationController.tabBarItem = UITabBarItem(
            title: "Ещё",
            image: Images.more.uiImage,
            tag: 2
        )
    }
}

