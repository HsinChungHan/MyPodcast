//
//  Episode.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/27.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import FeedKit
struct Episode {
    let title: String
    let pubDate: Date
    let description: String
    let author: String
    let streamUrl: String
    
    
    
    var imageUrl: String?
    
    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.description ?? ""
        self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href
        self.streamUrl = feedItem.enclosure?.attributes?.url ?? ""
        self.author = feedItem.iTunes?.iTunesAuthor ?? ""
        
    }
}
