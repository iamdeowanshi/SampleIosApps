//
//  CalulatorBrain.swift
//  Calculator
//
//  Created by Student on 9/5/17.
//  Copyright © 2017 deowanshi.aaditya. All rights reserved.
//

import Foundation
class CalculatorBrain{
    
    private var accumulator = 0.0
    
    func setOperand(operand : Double) {
        accumulator = operand
    }
    
    private var pending : PendingBinaryInfo?
    
    private struct PendingBinaryInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand : Double
    }
    
    private var operations : Dictionary<String, Operation> = [
        "%" : Operation.UnaryOperation({$0/100}),
        "+" : Operation.BinaryOperation({ $0 + $1}),
        "-" : Operation.BinaryOperation({ $0 - $1}),
        "÷" : Operation.BinaryOperation({ $0 / $1}),
        "×" : Operation.BinaryOperation({ $0 * $1}),
        "±" : Operation.UnaryOperation({ -$0 }),
        "=" : Operation.Equals
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation ((Double, Double) -> Double)
        case Equals
    }
    
    
    private func executePendinBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    func performOperation(symbol : String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value) :
                accumulator = value
            case .BinaryOperation(let function) :
                executePendinBinaryOperation()
                pending = PendingBinaryInfo(binaryFunction: function, firstOperand: accumulator)
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .Equals:
                executePendinBinaryOperation()
            }
        }
    }
    
    var result : Double {
        get {
            return accumulator
        }
    }
}
