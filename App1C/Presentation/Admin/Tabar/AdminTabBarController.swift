//
//  AdminTabBarController.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

class AdminTabBarController: TabBarController {
    private var eventsNavigationController: UINavigationController
    
    init(
        mainScreenNavigationController: UINavigationController,
        eventsNavigationController: UINavigationController,
        settingsNavigationController: UINavigationController
    ) {
        self.eventsNavigationController = eventsNavigationController
        
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
        eventsNavigationController.tabBarItem = UITabBarItem(title: "События", image: Images.events.uiImage, tag: 1)
        
        setViewControllers([
            mainScreenNavigationController,
            eventsNavigationController,
            settingsNavigationController
        ], animated: false)
    }
}

