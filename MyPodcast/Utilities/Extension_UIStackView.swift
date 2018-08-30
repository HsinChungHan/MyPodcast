//
//  UIStackViewExtension.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/20.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
extension UIStackView{
    func setupStackView(views: [UIView], axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, spacing: CGFloat ) {
        for view in views{
            addArrangedSubview(view)
        }
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
    }
}
