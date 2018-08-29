//
//  DownloadImgService.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
class DownloadImgService {
    //use singleton
    static let shared = DownloadImgService()
    
    public func downloadImg(url: URL, completionHandler: @escaping  (_ data: Data) -> ()){
        //用這種方式，不會將圖片存到cache
        //可以用framework SDWebImage
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("error: ", error)
                return
            }
            
            guard let data = data else {
                print("No data.")
                return
            }
           
            completionHandler(data)
//                self.podcastImgView.image = UIImage(data: data)
            }.resume()
    }
    
}
