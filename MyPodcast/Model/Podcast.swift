//
//  Podcast.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/26.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation



struct Podcast: Decodable {
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var trackCount: Int?
    var feedUrl: String?
    
    
    
    
    init(trackName: String, artistName: String) {
        self.trackName = trackName
        self.artistName = artistName
    }
}

