//
//  FourthViewController.swift
//  FirstApplication
//
//  Created by Кирилл Шиков on 01.04.2021.
//

import UIKit

class FourthViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func actionPush(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "FifthViewController") as? FifthViewController else {
            return
        }
        viewController.text = textField.text
        navigationController?.pushViewController(viewController, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showFifth" else { return }
        guard let destination = segue.destination as? FifthViewController else { return }
        destination.text = textField.text
    }
    
    @IBAction func actionAlert(_ sender: Any) {
        let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func actionPresent(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "FifthViewController") as? FifthViewController else {
            return
        }
        viewController.modalPresentationStyle = .popover
        viewController.modalTransitionStyle = .coverVertical        
        viewController.text = textField.text
        present(viewController, animated: true, completion: nil)
    }
    
}
