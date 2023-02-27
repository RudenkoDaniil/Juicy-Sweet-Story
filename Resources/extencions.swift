//
//  extencions.swift
//  Juicy Sweet Story
//
//  Created by Даниил on 24.02.2023.
//

import Foundation
import UIKit


func convertSecondsToMinutesAndSeconds(seconds: Int) -> (Int, Int) {
    let minutes = seconds / 60
    let remainingSeconds = seconds % 60
    return (minutes, remainingSeconds)
}

extension UIView{
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left{
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right{
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant:  width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension UIViewController {
    @objc func dismissSelf(){
        dismiss(animated: true, completion: nil)
    }
}



