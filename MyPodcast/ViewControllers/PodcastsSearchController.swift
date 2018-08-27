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
    var podcasts = [
        Podcast.init(trackName: "Belize Military Service", artistName: "Hsin"),
        Podcast.init(trackName: "Some Podcast", artistName: "Some one")
    ]
    
    
   
    
    
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
        Alamofire.request("https://itunes.apple.com/search", method: .get, parameters: ["term": searchText, "media": "podcast"], encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            
            if let err = dataResponse.error {
                print("Failed to get response:", err)
            }
            
            guard let data = dataResponse.data else { return }
            //            let decodedString = String(data: data, encoding: .utf8)
            //            print(decodedString ?? "")
            
            // let's parse some JSON
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                searchResults.results.forEach({ (podcast) in
                    print(podcast.artistName, podcast.trackName)
                })
                self.podcasts = searchResults.results
                self.tableView.reloadData()
            } catch let decodeErr {
                print("Failed to decode results:", decodeErr)
            }
        }
        
    }
}
