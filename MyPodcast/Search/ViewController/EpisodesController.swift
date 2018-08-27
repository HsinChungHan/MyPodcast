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
            navigationItem.title = podcast?.trackName
        }
    }
    
    fileprivate let cellId = "cellId"
    fileprivate var episodes = [
        Episode.init(title: "First"),
        Episode.init(title: "Second"),
        Episode.init(title: "Third")
    ]
    
    
    
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
