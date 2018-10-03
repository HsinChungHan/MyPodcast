//
//  EpisodesController.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/27.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class EpisodesController: UITableViewController {
    fileprivate let episodeCellName = "EpisodeCell"
    var podcast: Podcast?{
        didSet{
            guard let podcast = podcast else {return}
            navigationItem.title = podcast.trackName
            print("podcast.trackName: ", podcast.trackName)
            fetchEpisode(podcast)
        }
    }
    
    fileprivate let episodeCellId = "EpisodeCellId"
    fileprivate var episodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
}

extension EpisodesController{
    public func setValue(podcast: Podcast){
        self.podcast = podcast
    }
    
    
    fileprivate func setupTableView(){
        let nib = UINib(nibName: episodeCellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: episodeCellId)
        //消除多餘的部分
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func fetchEpisode(_ podcast: Podcast) {
        APIService.shared.fetchEpisodes(podcast: podcast) { (episodes) in
            self.episodes = episodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: episodeCellId, for: indexPath) as! EpisodeCell
        let episode = episodes[indexPath.row]
        cell.setupValue(episode: episode)
        return cell
       
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
        let episode = episodes[indexPath.row]
        mainTabBarController?.maximizePlayerDetailView(episode: episode)
        
        
//        let episode = episodes[indexPath.row]
//        let window = UIApplication.shared.keyWindow
//        let playerDetailView = PlayerDetailView()
//        playerDetailView.setupValue(episode: episode)
//        playerDetailView.setupBackgroundColor(color: UIColor.white)
//        playerDetailView.frame = view.frame
//        window?.addSubview(playerDetailView)
        
        
        //若是用nib的方式程式碼如下。.first代表xib中的第一個階層的view
//        let playerDetailsView = Bundle.main.loadNibNamed("PlayerDetailsView", owner: self, options: nil)?.first as! PlayerDetailsView
        //後來code refactor後，把上述程式碼放到playerDetailView
//        playerDetailView.initFromNib()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let loadingFooterView = LoadingFooterView()
        loadingFooterView.startAnimating()
        return loadingFooterView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return episodes.isEmpty ? 200 : 0
    }
}
