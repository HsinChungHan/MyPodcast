//
//  LoadingFooterView.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
class LoadingFooterView: BasicView {
    let activityIndicatorView: UIActivityIndicatorView = {
       let indicatorView = UIActivityIndicatorView()
        indicatorView.activityIndicatorViewStyle = .whiteLarge
        indicatorView.color = .darkGray
        return indicatorView
    }()
    override func setupView() {
        addSubview(activityIndicatorView)
        activityIndicatorView.centerAnchor(superView: self, width: 50, height: 50)
    }
}


extension LoadingFooterView{
    public func startAnimating(){
        activityIndicatorView.startAnimating()
    }
    
    public func stopAnimating(){
        activityIndicatorView.stopAnimating()
    }
    
}
