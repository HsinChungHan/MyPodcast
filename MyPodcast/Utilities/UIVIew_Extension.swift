//
//  UIViewControllerExtension.swift
//  LottieAnimationStartedProject
//
//  Created by 辛忠翰 on 13/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import QuartzCore
extension UIView{
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, topPadding: CGFloat, bottomPadding: CGFloat, leftPadding: CGFloat, rightPadding: CGFloat, width: CGFloat, height: CGFloat ) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
        }
        
        if let left = left{
            leftAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true
        }
        
        if let right = right{
            rightAnchor.constraint(equalTo: right, constant: -rightPadding).isActive = true
        }
        
        if width != 0{
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0{
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func fullAnchor(superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: superView.topAnchor, bottom: superView.bottomAnchor, left: superView.leftAnchor, right: superView.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
    }
    
    func fullAnchor(superView: UIView, topPadding: CGFloat, bottomPadding: CGFloat, leftPadding: CGFloat, rightPadding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: superView.topAnchor, bottom: superView.bottomAnchor, left: superView.leftAnchor, right: superView.rightAnchor, topPadding: topPadding, bottomPadding: bottomPadding, leftPadding: leftPadding, rightPadding: rightPadding, width: 0, height: 0)
    }
    
    func centerAnchor(superView: UIView, width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: nil, bottom: nil, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: width, height: height)
        centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    }
    
    
    func scaleAnimationRepeated(scaleX: CGFloat, scaleY: CGFloat) {
        let minimizeTransform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        transform = minimizeTransform
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .autoreverse], animations: { [weak self] in
            self?.transform = CGAffineTransform.identity
        }) { (_) in
        }
    }
    
    func scaleAnimationNoRepeated(scaleX: CGFloat, scaleY: CGFloat) {
        let scaleTransform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: { [weak self] in
            self?.transform = scaleTransform
        }) { (_) in
        }
    }
    
    func rotateAnimation(angle: CGFloat, duraation: Double, completion: @escaping ()->()){
        let rotatedAngle = angle / 180 * .pi
        print("angle: ", angle)
        print("rotatedAngle: ", rotatedAngle)
        let rotateTransform = CGAffineTransform(rotationAngle: rotatedAngle)
        UIView.animate(withDuration: duraation, delay: 0 , options: .curveEaseInOut , animations: { [weak self] in
            self?.transform = rotateTransform
        }) { (_) in
            completion()
        }
    }
    
    func moveAnimation(dx: CGFloat?, completion: @escaping ()->()) {
        let moveTransform = CGAffineTransform(translationX: dx!, y: 0)
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {[weak self] in
            self?.transform = moveTransform
            
        }) { (_) in
            completion()
        }
    }
    
    func moveAnimation(dy: CGFloat?, completion: @escaping ()->()) {
        let moveTransform = CGAffineTransform(translationX: 0, y: dy!)
        UIView.animate(withDuration: 3.0, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: [.repeat, .curveEaseInOut], animations: {[weak self] in
            self?.transform = moveTransform
            
        }) { (_) in
            completion()
        }
    }
    
    
    
    func moveAnimation(endView: UIView, duration: Double, completion: @escaping ()->()) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {[weak self] in
            let endPoint = CGPoint(x: endView.frame.origin.x - 40 , y: endView.frame.origin.y)
            self?.frame.origin = endPoint
        }) { (_) in
            completion()
        }
    }
    
    func moveCenterAnimation(endView: UIView, duration: Double, completion: @escaping ()->()) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {[weak self] in
            let endPoint = CGPoint(x: endView.center.x , y: endView.center.y)
            self?.frame.origin = endPoint
        }) { (_) in
            completion()
        }
    }
    
    func movAnimation(endView: UIView, duration: Double, offsetX: CGFloat, offSetY: CGFloat, completion: @escaping ()->()) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {[weak self] in
            let endPoint = CGPoint(x: endView.frame.origin.x + offsetX , y: endView.frame.origin.y + offSetY)
            self?.frame.origin = endPoint
        }) { (_) in
            completion()
        }
    }
    
    
    func addConstraintsWithFormat(format: String, views: UIView...)  {
        var viewsDictionary = [String : UIView]()
        for(index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func setCorner(radius: CGFloat){
        self.layoutIfNeeded()
        self.layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func setShadow(shadowColor: UIColor, shadowOpacity: Float, offsetWidth width: CGFloat, offsetHeight height: CGFloat){
        self.layoutIfNeeded()
        layer.shadowPath = UIBezierPath(roundedRect:
            bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: width, height: height)
        //        layer.shadowRadius = 1
        layer.masksToBounds = false
    }
    
    func getShadowArguments() -> (shadowColor: UIColor, shadowOpacity: Float, offsetWidth: CGFloat, offsetHeight: CGFloat){
        self.layoutIfNeeded()
        return (
            UIColor(cgColor: layer.shadowColor!),
            layer.shadowOpacity,
            layer.shadowOffset.width,
            layer.shadowOffset.height
        )
    }
    
}


extension UIView: CAAnimationDelegate{
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
}
