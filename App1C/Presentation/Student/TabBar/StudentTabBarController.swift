//
//  StudentTabBarController.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

class StudentTabBarController: TabBarController {
    private var coursesListNavigationController: UINavigationController
    
    init(
        mainScreenNavigationController: UINavigationController,
        coursesListNavigationController: UINavigationController,
        settingsNavigationController: UINavigationController
    ) {
        self.coursesListNavigationController = coursesListNavigationController
        
        super.init(
            mainScreenNavigationController: mainScreenNavigationController,
            settingsNavigationController: settingsNavigationController
        )
        
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBar() {
        coursesListNavigationController.tabBarItem = UITabBarItem(title: "Курсы", image: Images.graduationcap.uiImage, tag: 1)
        
        setViewControllers([
            mainScreenNavigationController,
            coursesListNavigationController,
            settingsNavigationController
        ], animated: false)
    }
}


