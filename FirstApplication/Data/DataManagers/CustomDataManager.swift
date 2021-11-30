//
//  CustomDataManager.swift
//  FirstApplication
//
//  Created by Кирилл Шиков on 25.03.2021.
//

import UIKit

class CustomDataManager {
    
    let colors = [UIColor.red, UIColor.yellow, UIColor.blue, UIColor.green, UIColor.white, UIColor.gray]
    let texts = ["Привет", "Как дела?", "Молодец!", "Что делаешь?", "Круто!", "Зря ты это."]
    
    func getCustomControlDataWithRandomValuesFromArray(colors: [UIColor], texts:[String]) -> CustomControlData {
        return CustomControlData.init(
            color: colors.randomElement() ?? UIColor.black,
            text: texts.randomElement() ?? ""
        )
    }
    
    func getCustomControlDataWithRandomValues() -> CustomControlData {
        return getCustomControlDataWithRandomValuesFromArray(colors: colors, texts: texts)
    }
    
}
