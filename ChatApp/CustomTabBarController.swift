//
//  CustomTabBarController.swift
//  ChatApp
//
//  Created by Macbook on 4/21/19.
//  Copyright © 2019 Spiritofthecore. All rights reserved.
//

import UIKit


class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let friendsController = FriendsController()
        let recentMessagesNavController = UINavigationController(rootViewController: friendsController)
        recentMessagesNavController.tabBarItem.title = "Recent"
        recentMessagesNavController.tabBarItem.image = UIImage(named: "recent")
        
        
        
        viewControllers = [recentMessagesNavController, createViewController(title: "Calls", imageName: "call"), createViewController(title: "Groups", imageName: "group"), createViewController(title: "People", imageName: "people"), createViewController(title: "Settings", imageName: "setting")]
        //        window?.rootViewController = UINavigationController(rootViewController: FriendsController())
    }
    
    private func createViewController(title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(named: imageName)
        return nav
    }
}
