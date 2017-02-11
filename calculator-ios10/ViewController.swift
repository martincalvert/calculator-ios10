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
    var brain = CalculatorBrain()
    var displayValue: Double {
        set {
            display.text = String(newValue)
        }
        get {
            return Double(display.text!)!
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userInTheMiddleOfTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
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
    }
}

