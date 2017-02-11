//
//  CalculatorBrain.swift
//  calculator-ios10
//
//  Created by Calvert, Martin on 2/10/17.
//  Copyright © 2017 Calvert, Martin. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    // MARK: Variables
    private var accumulator: Double?
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    mutating func performOperation(_ symbol: String) {
        switch symbol {
        case "π":
            accumulator = Double.pi
        case "√":
            if let operand = accumulator {
                accumulator = sqrt(operand)
            }
        default:
            break
            
        }
    }
    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
}
