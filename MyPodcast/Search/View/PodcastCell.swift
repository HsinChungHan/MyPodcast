//
//  PodcastCell.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/26.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import SDWebImage
class PodcastCell: UITableViewCell {
    @IBOutlet weak var podcastImgView: UIImageView!
    @IBOutlet weak var trackNAmeLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    fileprivate var podcast: Podcast? {
        didSet{
            guard let podcast = podcast else {return}
            trackNAmeLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
            episodeCountLabel.text = "\(podcast.trackCount ?? 0) Episodes"
            
            guard let url = URL(string: podcast.artworkUrl600 ?? "") else {
                return
            }
            
            podcastImgView.sd_setImage(with: url, completed: nil)
            
            
        }
    }
    
    
    
}


extension PodcastCell{
    public func setValue(podcast: Podcast){
        self.podcast = podcast
    }
    
    fileprivate func downloadImg(url: URL){
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
            DispatchQueue.main.async {
                self.podcastImgView.image = UIImage(data: data)
            }
        }.resume()
    }
}
