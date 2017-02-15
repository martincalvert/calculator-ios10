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
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "sin": Operation.unaryOperation(sin),
        "tan": Operation.unaryOperation(tan),
        "±": Operation.unaryOperation({-$0}),
        "×": Operation.binaryOperation({$0 * $1}),
        "÷": Operation.binaryOperation({$0 / $1}),
        "+": Operation.binaryOperation({$0 + $1}),
        "−": Operation.binaryOperation({$0 - $1}),
        "^": Operation.binaryOperation(pow),
        "=": Operation.equals
    ]
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    var resultIsPending: Bool? {
        get {
            return (currentPendingBinaryOperation != nil) ? true : false
        }
    }
    
    var description = ""
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol]{
            switch operation {
            case .unaryOperation(let function):
                if accumulator != nil {
                    addToDescription(symbol)
                    accumulator = function(accumulator!)
                }
            case .constant(let value):
                addToDescription(symbol)
                accumulator = value
            case .binaryOperation(let function):
                if accumulator != nil {
                    addToDescription(symbol)
                    currentPendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                if accumulator != nil {
                    accumulator = currentPendingBinaryOperation?.perform(with: accumulator!)
                    currentPendingBinaryOperation = nil
                }
            }
        }
    }
    
    private var currentPendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func addToDescription(_ str: String?) {
        if str != nil {
            if let operation = operations[str!]{
                switch operation {
                case .unaryOperation:
                    if currentPendingBinaryOperation != nil {
                        description = description.replacingOccurrences(of: String(describing: accumulator!), with: "")
                        description = description + "\(str!)(\(accumulator!))"
                    } else {
                        description = "\(str!)(" + description + ")"
                    }
                default:
                    description.append(str!)
                }
            }
        } else {
            if accumulator != nil {
                description.append(String(describing: accumulator!))
            }
        }
    }
    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
        addToDescription(nil)
    }
}
