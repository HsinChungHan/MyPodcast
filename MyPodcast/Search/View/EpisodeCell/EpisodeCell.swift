//
//  EpisodeCell.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/27.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import SDWebImage
class EpisodeCell: UITableViewCell {
    
    
    @IBOutlet weak var episodeImgView: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.numberOfLines = 2
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.numberOfLines = 2
        }
    }
    
    fileprivate var episode: Episode?{
        didSet{
            guard let episode = episode else {return}
            titleLabel.text = episode.title
            descriptionLabel.text = episode.description
            pubDateLabel.text = parseDate(episode: episode)
            let imgUrl = URL(string: episode.imageUrl?.toSecureHttps() ?? "")
            episodeImgView.sd_setImage(with: imgUrl)
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
