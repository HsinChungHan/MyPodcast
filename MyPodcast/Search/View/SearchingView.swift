//
//  SearchingView.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class SearchingView: BasicView {
    let activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.style = .whiteLarge
        indicatorView.color = .darkGray
        return indicatorView
    }()
    
    let searchingLabel: UILabel = {
        let label = UILabel()
        label.text = "Currently searching, please wait!"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor.purple
        label.textAlignment = .center
        return label
    }()
    override func setupView() {
       addSubview(activityIndicatorView)
        addSubview(searchingLabel)
        activityIndicatorView.anchor(top: topAnchor, bottom: nil, left: nil, right: nil, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 50, height: 50)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        searchingLabel.anchor(top: activityIndicatorView.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 10, leftPadding: 20, rightPadding: 20, width: 0, height: 0)
    }

}
extension SearchingView{
    public func startAnimating(){
        activityIndicatorView.startAnimating()
    }
}
