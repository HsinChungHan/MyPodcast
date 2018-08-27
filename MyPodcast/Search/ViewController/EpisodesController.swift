//
//  EpisodesController.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/27.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class EpisodesController: UITableViewController {

    fileprivate var podcast: Podcast?{
        didSet{
            guard let podcast = podcast else {return}
            navigationItem.title = podcast.trackName
            APIService.shared.fetchEpisodes(podcast: podcast) { (episodes) in
                self.episodes = episodes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    fileprivate let cellId = "cellId"
    fileprivate var episodes = [Episode]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    

}

extension EpisodesController{
    fileprivate func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    public func setValue(podcast: Podcast){
        self.podcast = podcast
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let episode = episodes[indexPath.row]
        cell.textLabel?.text = episode.title
        return cell
    }
}
