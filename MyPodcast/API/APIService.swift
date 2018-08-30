//
//  API.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/26.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import Alamofire
import FeedKit
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
    
    public func fetchEpisodes(podcast: Podcast, completion: @escaping ([Episode]) -> ()){
        guard let feedUrl = podcast.feedUrl else {return}
        
        //將網址強迫轉為https
        let secureFeedUrl = feedUrl.toSecureHttps()
        
        guard let url = URL(string: secureFeedUrl) else {return}
        let parser = FeedParser(URL: url)
        parser?.parseAsync(result: { (result) in
            switch result{
            case let .rss(feed):
                var episodes = [Episode]()
                feed.items?.forEach({ (item) in
                    let episode = Episode.init(feedItem: item)
                    episodes.append(episode)
                })
                completion(episodes)
                break
            case let .failure(error):
                print("Parse failed: ", error)
            default:
                print("Found a feed...")
            }
        })
    }
    
}
