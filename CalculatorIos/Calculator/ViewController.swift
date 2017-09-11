//
//  ViewController.swift
//  Calculator
//
//  Created by Student on 9/5/17.
//  Copyright © 2017 deowanshi.aaditya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!
    
    var userTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userTyping {
            let typdText = display.text!
            display!.text = typdText + digit
        } else {
            display!.text = digit
        }
        
        userTyping = true
        clearButton.setTitle("C", for: UIControlState.normal)
    }
    
    @IBAction func clearScreen(_ sender: UIButton) {
        let typdText = display.text!
        let newText = typdText.substring(to: typdText.index(before: typdText.endIndex))
        display!.text = newText
    }
    var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userTyping {
            brain.setOperand(operand : displayValue)
            userTyping = false
            clearButton.setTitle("AC", for: .normal)
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        
        displayValue = brain.result
    }

}

