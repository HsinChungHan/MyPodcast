//
//  Extension_String.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation

extension String{
    func toSecureHttps() -> String{
       return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}
