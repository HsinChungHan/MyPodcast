//
//  MainTabBarController.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/26.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    let playerDetailView = PlayerDetailView()
    var playerDetailViewMaximizedTopAnchor: NSLayoutConstraint?
    var playerDetailViewMinimizedTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().prefersLargeTitles = true
        tabBar.tintColor = .purple
        setupViewControllers()
        setupPlayerDetailView()
        
        //在MainTabBarController建立時，呼叫這個function
//        perform(#selector(maximizePlayerDetailView), with: nil, afterDelay: 1.0)
    }
    
   
    
}


extension MainTabBarController{
    fileprivate func setupViewControllers(){
        viewControllers = [
            generateNavigationController(for: PodcastsSearchController(), title: "Search", image: UIImage(named: "search")!),
            generateNavigationController(for: ViewController(), title: "Favorite", image: UIImage(named: "play")!),
            generateNavigationController(for: ViewController(), title: "Download", image: UIImage(named: "downloads")!)
        ]
    }
    
    fileprivate func generateNavigationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        //        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
    
    //MARK: - Animated PlayerDetailView
    
    fileprivate func setupPlayerDetailView(){
        
        view.insertSubview(playerDetailView, belowSubview: tabBar)
        playerDetailView.backgroundColor = .white
        setAnchorForPlayerDetailView(playerDetailView)
        
        //set maximized top anchor for PlayerDetailView
        //set the playerDetailView down below screen in the beginning
        playerDetailViewMaximizedTopAnchor = playerDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        playerDetailViewMaximizedTopAnchor?.isActive = true
        
        //set minimized top anchor for PlayerDetailView
        playerDetailViewMinimizedTopAnchor = playerDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -tabBar.frame.height)
    }
    
    //set basic anchor for PlayerDetailView
    fileprivate func setAnchorForPlayerDetailView(_ playerDetailView: PlayerDetailView) {
        playerDetailView.translatesAutoresizingMaskIntoConstraints = false
        playerDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerDetailView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
    }
    
    
    @objc func minimizePlayerDetailView(){
        playerDetailViewMaximizedTopAnchor?.isActive = false
        playerDetailViewMinimizedTopAnchor?.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            //as long as playerDetailView minimize, tabBar should show
            self.tabBar.transform = .identity
            
            self.playerDetailView.maximizedPlayerDetailView.alpha = 0.0
            self.playerDetailView.minimizedPlayerDetailView.alpha = 1.0
        })
    }
    
    public func maximizePlayerDetailView(episode: Episode?){
        playerDetailViewMinimizedTopAnchor?.isActive = false
        playerDetailViewMaximizedTopAnchor?.isActive = true
        playerDetailViewMaximizedTopAnchor?.constant = 0
        if episode != nil{
            playerDetailView.setupValue(episode: episode!)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            //as long as playerDetailView appeared, tabBar should hide down below view
            self.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            self.playerDetailView.maximizedPlayerDetailView.alpha = 1.0
            self.playerDetailView.minimizedPlayerDetailView.alpha = 0.0
        })
        
        
    }
    
}
