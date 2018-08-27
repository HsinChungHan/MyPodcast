//
//  PodcastsSearchController.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/26.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import Alamofire
class PodcastsSearchController: UITableViewController {
    
    let cellId = "cellId"
    let searchController = UISearchController(searchResultsController: nil)
    var podcasts = [Podcast]()
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        registerTableViewCell()
    }
    
    
}


extension PodcastsSearchController{
    fileprivate func setupSearchBar(){
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
    }
    
    fileprivate func registerTableViewCell(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let podcast = podcasts[indexPath.row]
        cell.textLabel?.text = "\(podcast.trackName)\n\(podcast.artistName)"
        //makes textLabel be multiline
        cell.textLabel?.numberOfLines = -1
        cell.imageView?.image = UIImage(named: "appicon")
        return cell
    }
}




extension PodcastsSearchController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        APIService.shared.fetchPodcasts(searchText: searchText) { (podcasts) in
            self.podcasts = podcasts
            self.tableView.reloadData()
        }
        
    }
}
