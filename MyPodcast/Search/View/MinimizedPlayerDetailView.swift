//
//  MinimizedPlayerDetailView.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/10/3.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

protocol MinimizedPlayerDetailViewDelegate{
    func playPause()
    func fastForwardFifteenSecond()
}


class MinimizedPlayerDetailView: BasicView {
    var delegate: MinimizedPlayerDetailViewDelegate?
    
    fileprivate var episode: Episode?{
        didSet{
            guard let episode = episode else {return}
            titleLabel.text = episode.title
            let imgUrl = episode.imageUrl?.toSecureHttps()
            guard let url = URL(string: imgUrl ?? "") else {return}
            episodeImgView.sd_setImage(with: url, completed: nil)
        }
    }
    
    
    lazy var episodeImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "appicon")
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.setCorner(radius: 5)
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
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
    
    lazy var playPauseButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        btn.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func playPause(){
        delegate?.playPause()
    }
    
    
    lazy var fastForwardButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(fastForwardFifteenSecond), for: .touchUpInside)
        btn.setImage(UIImage(named: "fastforward15")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func fastForwardFifteenSecond(){
        delegate?.fastForwardFifteenSecond()
    }
    
    override func setupView() {
        setupStackView()
    }

}


extension MinimizedPlayerDetailView{
    public func setValues(episod: Episode){
        self.episode = episod
    }
    
    
    fileprivate func setupStackView(){
        let stackView = UIStackView()
        stackView.setupStackView(views: [episodeImgView, titleLabel, playPauseButton, fastForwardButton], axis: .horizontal , distribution: .fill, spacing: 0)
        stackView.alignment = .fill
        episodeImgView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        fastForwardButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        addSubview(stackView)
        stackView.fullAnchor(superView: self)
    }
}
