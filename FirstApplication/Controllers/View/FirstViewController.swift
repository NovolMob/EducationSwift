//
//  ViewController.swift
//  FirstApplication
//
//  Created by Кирилл Шиков on 15.03.2021.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var orientationLabel: UILabel!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextField.delegate = self
    }
    
    @IBAction func setNumber(_ sender: Any) {
        textView.text = myTextField.text
        myTextField.endEditing(true)
    }
    
    @IBAction func actionSlider(_ sender: Any) {
        if let slider = sender as? UISlider {
            progressBar.progress = slider.value
        }
    }
    
    @IBAction func actionSwitch(_ sender: Any) {
        if let mySwitch = sender as? UISwitch {
            if mySwitch.isOn {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateNameOrientation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateNameOrientation()
    }
    
    func updateNameOrientation() {
        var text = ""
        switch UIDevice.current.orientation {
            case .portrait:
                text = "portrait"
            case .landscapeLeft:
                text = "landscapeLeft"
            case .landscapeRight:
                text = "landscapeRight"
            case .portraitUpsideDown:
                text = "portraitUpsideDown"
            case .faceUp:
                text = "faceUp"
            case .faceDown:
                text = "faceDown"
            default:
                text = "unknown"
            }
        orientationLabel.text = text;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

