//
//  Extension_CMTime.swift
//  MyPodcast
//
//  Created by 辛忠翰 on 2018/8/30.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import AVKit
extension CMTime {
    
    func toDisplayString() -> String {
        if self.seconds.isNaN {
            return "--:--"
        }
        
        let totalSeconds = Int(self.seconds)
        let seconds = totalSeconds % 60
        let minutes = totalSeconds % (60 * 60) / 60
        let hours = totalSeconds / 60 / 60
        let timeFormatString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        return timeFormatString
    }
    
}
