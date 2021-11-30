//
//  CustomView.swift
//  FirstApplication
//
//  Created by Кирилл Шиков on 25.03.2021.
//

import UIKit
import SwiftUI

class CustomView: UIView {
    
    var label = UILabel()
    let startAlpha = 0.5
    let startScale = 0.1
    var swapDataTimer: Timer!
    
    @IBInspectable var cornerRadius: Double {
            get {
                return Double(self.layer.cornerRadius)
            }
            set {
                label.layer.cornerRadius = CGFloat(newValue)
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    func customInit() {
        self.addSubview(label)
        backgroundColor = .green
        
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func startSwapDataTimer(_ getNewData: @escaping () -> CustomControlData) {
        swapDataTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) {_ in
            self.setData(controlData: getNewData())
        }
    }
    
    func stopSwapDataTimer() {
        swapDataTimer.invalidate()
    }
    
    override func prepareForInterfaceBuilder() {
        customInit()
    }
    
    func beginStartingAnimation() {
        isOpaque = false
        alpha = startAlpha
        setScale(scale: startScale)
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.alpha = 1
            self.resetScale()
        })
    }
    
    func setData(controlData: CustomControlData) {
        label.text = controlData.text
        label.backgroundColor = controlData.color
    }
    
    func translate(to: CGPoint) {
        center = CGPoint(x: center.x + to.x, y: center.y + to.y)
    }
    
    func setScale(scale: CGFloat) {
        transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    func resetScale() {
        setScale(scale: 1.0)
    }
    
}
