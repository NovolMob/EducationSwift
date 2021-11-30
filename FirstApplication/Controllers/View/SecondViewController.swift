//
//  SecondViewController.swift
//  FirstApplication
//
//  Created by Кирилл Шиков on 23.03.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    let dataManager = CustomDataManager()
    let minWidthAndHeight = 50
    let maxWidthAndHeight = 250
    
    @IBOutlet var customView: CustomView!
    @IBOutlet weak var widthConstrains: NSLayoutConstraint!
    @IBOutlet weak var heightConstrains: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerDoubleTap()
        registerPan()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        widthConstrains.constant = view.safeAreaLayoutGuide.layoutFrame.size.width
        heightConstrains.constant = view.safeAreaLayoutGuide.layoutFrame.size.height
        customView.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customView.beginStartingAnimation()
        customView.setData(controlData: dataManager.getCustomControlDataWithRandomValues())
        customView.startSwapDataTimer() {
            return self.dataManager.getCustomControlDataWithRandomValues()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        customView.stopSwapDataTimer()
    }
    
    func registerPan() {
        customView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pan(_:))))
    }
    
    func registerDoubleTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        tap.numberOfTapsRequired = 2
        customView.addGestureRecognizer(tap)
    }
    
    @objc func doubleTap(_ sender: UIPinchGestureRecognizer) {
        heightConstrains.constant = self.randomWidthOrHeight()
        widthConstrains.constant = self.randomWidthOrHeight()
        UIView.animate(withDuration: 0.5) {
            self.customView.layoutIfNeeded()
        }
    }
    
    @objc func pan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        switch (sender.state) {
        case .began:
            customView.setScale(scale: 0.9)
        case .changed:
            customView.translate(to: translation)
            sender.setTranslation(CGPoint.zero, in: view)
            break
        case .ended:
            customView.resetScale()
        default:
            break
        }
    }
    
    private func randomWidthOrHeight() -> CGFloat {
        return CGFloat((minWidthAndHeight...maxWidthAndHeight).randomElement()!)
    }
    
}
