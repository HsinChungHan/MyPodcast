//
//  PlayerDetailView.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/29.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import SDWebImage
class PlayerDetailView: BasicView {
    fileprivate var episode: Episode?{
        didSet{
            guard let episode = episode else {return}
            titleLabel.text = episode.title
            
            let imgUrl = episode.imageUrl?.toSecureHttps()
            guard let url = URL(string: imgUrl ?? "") else {return}
            episodeImgView.sd_setImage(with: url, completed: nil)
        }
    }
    
    
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
    
    let episodeImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "appIcon")
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    
    let timeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let endTimeLabel: UILabel = {
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
        btn.addTarget(self, action: #selector(rewind), for: .touchUpInside)
        btn.setImage(UIImage(named: "rewind15")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func rewind(){
    }
    
    lazy var playPauseButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        btn.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
    @objc func playPause(){
    }
    
    
    lazy var fastForwardButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(fastForward), for: .touchUpInside)
        btn.setImage(UIImage(named: "fastforward15")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
    @objc func fastForward(){
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
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    let maxVolumeImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "max_volume")
        imv.contentMode = .scaleAspectFit
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    
    override func setupView() {        
        setupUI()
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
        timeLabelStackView.setupStackView(views: [currentTimeLabel, endTimeLabel], axis: .horizontal, distribution: .fillEqually, spacing: 0)
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        endTimeLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
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
    
    fileprivate func stackTimeLabel(){
        
    }
    
}
