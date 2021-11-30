//
//  RootTabController.swift
//  FirstApplication
//
//  Created by Кирилл Шиков on 23.03.2021.
//

import UIKit

class RootTabController: UITabBarController {
        
    override var shouldAutorotate: Bool {
        get {
            return !(UIDevice.current.orientation != .portrait && tabBar.selectedItem?.tag == 1)
        }
    }
}
