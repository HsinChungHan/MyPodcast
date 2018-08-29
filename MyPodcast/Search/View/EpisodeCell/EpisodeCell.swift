//
//  EpisodeCell.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/27.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    @IBOutlet weak var pubDateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    fileprivate var episode: Episode?{
        didSet{
            guard let episode = episode else {return}
            titleLabel.text = episode.title
            descriptionLabel.text = episode.description
            pubDateLabel.text = parseDate(episode: episode)
            print(episode.title)
        }
    }
    
}


extension EpisodeCell{
    public func setupValue(episode: Episode){
        self.episode = episode
    }
    
    fileprivate func parseDate(episode: Episode) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: episode.pubDate)
    }
}
