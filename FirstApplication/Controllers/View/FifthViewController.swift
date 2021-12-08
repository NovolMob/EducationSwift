//
//  FifthViewController.swift
//  FirstApplication
//

//  Created by Кирилл Шиков on 05.04.2021.
//

import UIKit

class FifthViewController: UIViewController {
    var text: String?
    @IBOutlet weak var label: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        label.text = text;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func actionPop(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
