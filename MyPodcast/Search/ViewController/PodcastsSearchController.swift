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
    
    fileprivate var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        registerTableViewCell()
    }
    
    
}


extension PodcastsSearchController{
    fileprivate func setupSearchBar(){
        definesPresentationContext = true//這行設定才會出現navigationBar
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    fileprivate func registerTableViewCell(){
        tableView.tableFooterView = UIView()
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
//        navigationController?.present(episodeVC, animated: true, completion: nil)
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
        return podcasts.isEmpty && searchController.searchBar.text?.isEmpty == true ? 250 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let searchingView = SearchingView()
        searchingView.startAnimating()
        return searchingView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return podcasts.isEmpty && searchController.searchBar.text?.isEmpty == false ? 250 : 0
    }
}




extension PodcastsSearchController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //使用者每打一個字，都先把之前在podcasts的元素清掉(為了讓searching時的提示view可以出現)
        podcasts = []
        tableView.reloadData()
        
        //use small delay to fire off search Api for saving user's internet
        //use timer
        timer?.invalidate()//每處發一次就砍掉一次timer
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
            //每隔0.5秒處發一次api，讓使用者不會每輸入一個字就觸發一次api
            APIService.shared.fetchPodcasts(searchText: searchText) { (podcasts) in
                self.podcasts = podcasts
                self.tableView.reloadData()
            }
        })
        
    }
}
