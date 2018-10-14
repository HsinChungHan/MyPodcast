//
//  UIApplication_Extension.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/10/14.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

extension UIApplication{
    static func mainTabBarController() -> MainTabBarController?{
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
}
