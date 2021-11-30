//
//  CustomControlData.swift
//  FirstApplication
//
//  Created by Кирилл Шиков on 23.03.2021.
//

import UIKit

struct CustomControlData {
    let color: UIColor
    let text: String
    
    init(color: UIColor, text: String) {
        self.color = color
        self.text = text.uppercased()
    }
}
