//
//  PodcastCell.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/26.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {
    var podcast: Podcast? {
        didSet{
            guard let podcast = podcast else {return}
            trackNAmeLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
        }
    }
    @IBOutlet weak var podcastImgView: UIImageView!
    @IBOutlet weak var trackNAmeLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!

}


extension PodcastCell{
    public func setValue(podcast: Podcast){
        self.podcast = podcast
    }
}
