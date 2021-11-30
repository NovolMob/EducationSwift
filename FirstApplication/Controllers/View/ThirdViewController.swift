    //
//  ThirdViewController.swift
//  FirstApplication
//
//  Created by Кирилл Шиков on 26.03.2021.
//

import UIKit

class TrirdViewController: UIViewController {
    
    let simpleNumber = SimpleNumber()
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberSwitch: UISwitch!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        simpleNumber.stop()
        numberSwitch.isOn = false
    }
    
    @IBAction func actionSwitch(_ sender: UISwitch) {
        if sender.isOn {
            simpleNumber.start(primeFound: primeFound)
        } else {
            simpleNumber.stop()
        }
    }

    func primeFound(number: Int) {
        DispatchQueue.main.async { [weak self] in self?.numberLabel?.text = String(number) }
    }
    
}
