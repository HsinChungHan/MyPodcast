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
    
    fileprivate let podcastCellId = "PodcastCellId"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var podcasts = [Podcast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        registerTableViewCell()
    }
    
    
}


extension PodcastsSearchController{
    fileprivate func setupSearchBar(){
        definesPresentationContext = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        tableView.separatorStyle = .none
    }
    
    fileprivate func registerTableViewCell(){
        let nib = UINib(nibName: "PodcastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: podcastCellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: podcastCellId, for: indexPath) as! PodcastCell
        cell.setValue(podcast: podcasts[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodeVC = EpisodesController()
        let podcast = podcasts[indexPath.item]
        episodeVC.setValue(podcast: podcast)
        navigationController?.pushViewController(episodeVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Plz text a search term!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return podcasts.count > 0 ? 0 : 250
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
