//
//  PlayerDetailView.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/29.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import AVKit
import SDWebImage
import Foundation
class PlayerDetailView: BasicView {
    fileprivate var episode: Episode?{
        didSet{
            guard let episode = episode else {return}
            titleLabel.text = episode.title
            authorLabel.text = episode.author
            playEpisode(episode: episode)
            
            let imgUrl = episode.imageUrl?.toSecureHttps()
            guard let url = URL(string: imgUrl ?? "") else {return}
            episodeImgView.sd_setImage(with: url, completed: nil)
            
            
        }
    }
    
    
    let player: AVPlayer = {
       let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    
    
    lazy var dismissButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Dismiss", for: .normal)
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func handleDismiss(){
        removeFromSuperview()
    }
    
    
    fileprivate let shrunkenTransform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    lazy var episodeImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "appicon")
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.setCorner(radius: 5)
        imv.transform = shrunkenTransform
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    
    lazy var timeSlider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(handleCurrentTimeSliderChanged), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    @objc func handleCurrentTimeSliderChanged(sender: UISlider){
        let percentage = sender.value
        guard let duration = player.currentItem?.duration else {return}
        let durationInSeconds = duration.getSeconds()
        let seekTimeInSeconds = Double(percentage) * durationInSeconds
        let seekTime = CMTime(seconds: seekTimeInSeconds, preferredTimescale: 1)
        player.seek(to: seekTime)
    }
    
    
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let durationTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "99:99:99"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = UIColor.lightGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Episode Title"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.purple
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rewindButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(rewindFifteenSeconds), for: .touchUpInside)
        btn.setImage(UIImage(named: "rewind15")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func rewindFifteenSeconds(){
        seekToCurrentTime(delta: -15)
    }
    
    lazy var playPauseButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        btn.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func playPause(){
        if player.timeControlStatus == .paused{
            player.play()
            playPauseButton.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysOriginal), for: .normal)
            enlargeEpisodeImgView()
        }else{
            player.pause()
            playPauseButton.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysOriginal), for: .normal)
            shrinkEpisodeImgView()
        }
    }
    
    
    lazy var fastForwardButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(fastForwardFifteenSecond), for: .touchUpInside)
        btn.setImage(UIImage(named: "fastforward15")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
    @objc func fastForwardFifteenSecond(){
        seekToCurrentTime(delta: 15)
    }
    
    let mutedVolumeImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "muted_volume")
        imv.contentMode = .scaleAspectFit
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    
    
    let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(volumeChanged), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    @objc func volumeChanged(sender: UISlider){
        player.volume = sender.value
    }
    
    
    
    let maxVolumeImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "max_volume")
        imv.contentMode = .scaleAspectFit
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    
    override func setupView() {        
        setupUI()
        detectPlayerStarted()
        observePlayerCurrentTime()
    }

    deinit {
        //當PlayerDetailView的記憶體被釋放時，會觸發deinit function
        print("PlayerDetailView memory being reclained!")
    }
}


extension PlayerDetailView{
    public func setupValue(episode: Episode){
        self.episode = episode
    }
    
    public func setupBackgroundColor(color: UIColor){
        backgroundColor = color
    }
    
    fileprivate func setupUI(){
        let timeLabelStackView = UIStackView()
        timeLabelStackView.setupStackView(views: [currentTimeLabel, durationTimeLabel], axis: .horizontal, distribution: .fillEqually, spacing: 0)
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        durationTimeLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        let buttonsStackView = UIStackView()
        let dummyView1 = UIView()
        let dummyView2 = UIView()
        let dummyView3 = UIView()
        let dummyView4 = UIView()
        buttonsStackView.setupStackView(views: [dummyView1, rewindButton, dummyView2, playPauseButton,dummyView3, fastForwardButton, dummyView4], axis: .horizontal, distribution: .equalCentering , spacing: 0)
        rewindButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        fastForwardButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        let volumeStackView = UIStackView()
        volumeStackView.setupStackView(views: [mutedVolumeImgView, volumeSlider, maxVolumeImgView], axis: .horizontal, distribution: .fill , spacing: 0)
        mutedVolumeImgView.widthAnchor.constraint(equalToConstant: 34).isActive = true
        maxVolumeImgView.widthAnchor.constraint(equalToConstant: 34).isActive = true
        mutedVolumeImgView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        maxVolumeImgView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        volumeSlider.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        let stackView = UIStackView()
        stackView.setupStackView(views: [dismissButton, episodeImgView, timeSlider, timeLabelStackView, titleLabel, authorLabel, buttonsStackView, volumeStackView], axis: .vertical, distribution: .fill , spacing: 0)
        dismissButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        episodeImgView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        timeSlider.heightAnchor.constraint(equalToConstant: 36).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        addSubview(stackView)
        stackView.fullAnchor(superView: self, topPadding: 0, bottomPadding: 30, leftPadding: 10, rightPadding: 10)
    }
    
    //MARK: - player
    fileprivate func playEpisode(episode: Episode){
        guard let url = URL(string: episode.streamUrl)  else {return}
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    fileprivate func detectPlayerStarted(){
        
        let time = CMTime(value: 1, timescale: 3)// 1/3 second = 0.33 second
        let times = [NSValue(time: time)]
        //這邊會造成retain cycle，player和self互相reference
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) {[weak self] in
            //Episode started to play
            self?.enlargeEpisodeImgView()
        }
    }
    
    fileprivate func observePlayerCurrentTime(){
        let interval = CMTime(value: 1, timescale: 2) // 1/2 second
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] (time) in
            self?.currentTimeLabel.text = time.toDisplayString()
            let durationTime = self?.player.currentItem?.duration.toDisplayString()
            self?.durationTimeLabel.text = durationTime
            self?.updateCurrentTimeSlider()
        }
    }
    
    fileprivate func seekToCurrentTime(delta: Int64){
        let shiftSeconds = CMTime(value: delta, timescale: 1)
        let seekTime = player.currentTime().add(shiftSeconds)
        player.seek(to: seekTime)
    }
    
    
    
    //MARK: - episodeImgView
    fileprivate func enlargeEpisodeImgView(){
        //讓圖像damping一下，用於開始和play
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {[weak self] in
            self?.episodeImgView.transform = .identity
        })
    }
    
    
    
    fileprivate func shrinkEpisodeImgView(){
        //讓圖像縮小，用於pause
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {[weak self] in
            guard let shrunkenTransform = self?.shrunkenTransform else {return}
            self?.episodeImgView.transform = shrunkenTransform
        })
    }
    
    //MARK: - timeSlider
    fileprivate func updateCurrentTimeSlider(){
        let currentTimeSeconds = player.currentTime().getSeconds()
        let durationSeconds = (player.currentItem?.duration ?? CMTime(value: 1, timescale: 1)).getSeconds()
        let percentage = currentTimeSeconds / durationSeconds
        timeSlider.value = Float(percentage)
    }
    
    
}
