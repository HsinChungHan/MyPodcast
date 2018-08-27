//
//  API.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/26.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import Alamofire
class APIService {
    fileprivate let basicITunesSearchURL = "https://itunes.apple.com/search"
    
    //use singleton
    static let shared = APIService()
    
    public func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()){
        //"media": "podcast"參數代表我們的app只在podcast搜尋
        let parameters = ["term": searchText, "media": "podcast"]
        //encoding的用於使用者輸入空格時會自動轉譯成%20，因為api不可以有空格
        Alamofire.request(basicITunesSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let err = dataResponse.error {
                print("Failed to get response:", err)
            }
            guard let data = dataResponse.data else {
                print("No data.")
                return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(searchResults.results)
            } catch let decodeErr {
                print("Failed to decode results:", decodeErr)
            }
        }
    }
    
}
