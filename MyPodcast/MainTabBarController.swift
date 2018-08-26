//
//  MainTabBarController.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/26.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().prefersLargeTitles = true
        tabBar.tintColor = .purple
        
        setupViewControllers()
    }
    
    
    
}


extension MainTabBarController{
    fileprivate func setupViewControllers(){
        viewControllers = [
            generateNavigationController(for: ViewController(), title: "Favorite", image: UIImage(named: "play")),
            generateNavigationController(for: ViewController(), title: "Search", image: UIImage(named: "search")),
            generateNavigationController(for: ViewController(), title: "Download", image: UIImage(named: "downloads"))
        ]
    }
    
    fileprivate func generateNavigationController(for rootVC: UIViewController, title: String, image: UIImage?) -> UIViewController{
        let naviVC = UINavigationController(rootViewController: rootVC)
        rootVC.navigationItem.title = title
        naviVC.tabBarItem.title = title
        naviVC.tabBarItem.image = image
        return naviVC
    }
}
