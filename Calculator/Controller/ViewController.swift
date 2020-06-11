//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTypingNumber: Bool = true
        private var displayValue: Double {

            get {
            guard let currentDisplayValue = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label to a Double!")
            }
            return currentDisplayValue
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    private var calculator = CalculatorLogic()

    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        if let calcMethod = sender.currentTitle {
            
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        // isFinishedTypingNumber is used so that if a non-number is used
        // displayLabel.text will be overriden by the input
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                if numValue == "." {
                    // if the current display value has any element other than numbers, such as the period
                    // the input will not be added to the displayLable.text, but simply returned
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return
                    }
                }
                
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }
    
}

