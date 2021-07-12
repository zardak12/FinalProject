//
//  UIButton+Extension.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit

extension UIButton {
    func fallAnimation() {
        let animationPosition = CABasicAnimation(keyPath: "position")
        animationPosition.duration = 0.1
        animationPosition.repeatCount = 4
        animationPosition.autoreverses = true
        animationPosition.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animationPosition.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        let animationColor = CABasicAnimation(keyPath: "backgroundColor")
        animationColor.toValue = UIColor.red.cgColor
        animationColor.duration = 0.5
        animationColor.autoreverses = true
        layer.add(animationPosition, forKey: "position")
        layer.add(animationColor, forKey: "animationColor")
    }
}
