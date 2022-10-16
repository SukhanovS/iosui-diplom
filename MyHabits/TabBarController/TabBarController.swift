//
//  TabBarController.swift
//  MyHabits
//
//  Created by Stas Sukhanov on 16.10.2022.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    var firstTabNavigationController : UINavigationController!
    var secondTabNavigationControoller : UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        firstTabNavigationController = UINavigationController.init(rootViewController: HabitsViewController())
        secondTabNavigationControoller = UINavigationController.init(rootViewController: InfoViewController())
        
        self.viewControllers = [firstTabNavigationController, secondTabNavigationControoller]
        
        let item1 = UITabBarItem(title: "Привычки", image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        
        let item2 = UITabBarItem(title: "Информация", image:  UIImage(systemName: "info.circle.fill"), tag: 1)
        
        firstTabNavigationController.tabBarItem = item1
        secondTabNavigationControoller.tabBarItem = item2
        
        UITabBar.appearance().tintColor = .systemPurple
        UITabBar.appearance().backgroundColor = .secondarySystemBackground
        
        
        
        
        
    }
}
