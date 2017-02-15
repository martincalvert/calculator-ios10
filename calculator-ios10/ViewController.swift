//
//  ViewController.swift
//  calculator-ios10
//
//  Created by Calvert, Martin on 2/10/17.
//  Copyright © 2017 Calvert, Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var userInTheMiddleOfTyping = false
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var brainDescription: UILabel!
    var brain = CalculatorBrain()
    var displayValue: Double {
        set {
            display.text = String(newValue)
            brainDescription.text = brain.description
        }
        get {
            return Double(display.text!)!
        }
    }
    @IBAction func clear(_ sender: Any) {
        brain = CalculatorBrain()
        displayValue = 0
        userInTheMiddleOfTyping = false
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userInTheMiddleOfTyping {
            if digit == "." {
                if display.text!.contains(".") {
                    return
                }
            }
            display.text = display.text! + digit
        } else {
            if digit == "." {
                display.text = "0."
            } else {
                display.text = digit
            }
            
            userInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
        brainDescription.text = brain.description
    }
}

