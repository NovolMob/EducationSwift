//
//  NumberUtils.swift
//  FirstApplication
//
//  Created by Кирилл Шиков on 01.04.2021.
//

import UIKit

class SimpleNumber {
    private var start = false
    
    func start(primeFound: @escaping ((_ number: Int) -> Void)) {
        if start {
            return
        }
        start = true
        DispatchQueue(label: "firstQueue").async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            var i = 0
            while self.start {
                if self.isPrime(number: i) {
                    primeFound(i)
                }
                i += 1
            }
        }
    }
    
    func stop() {
        start = false;
    }
    
    func getFirstPrimes(count: Int) -> [Int] {
        var array = [Int]()
        var number = 2
        while array.count < count {
            if isPrime(number: number) {
                array.append(number)
            }
            number += 1;
        }
        return array
    }
    
    func isPrime(number: Int) -> Bool {
        let startNumber = 2
        if number < startNumber {
            return true
        }
        for i in startNumber..<number {
            if number % i == 0 {
                return false
            }
        }
        return true
    }
}
