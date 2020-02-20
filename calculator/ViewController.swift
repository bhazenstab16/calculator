//
//  ViewController.swift
//  calculator
//
//  Created by xcode on 1/31/20.
//  Copyright © 2020 xcode. All rights reserved.
//

/* Add decimal, division, percentage, and plus/minus (allows for negative) */

import UIKit

enum modes
{
    case not_set
    case addition
    case subtraction
    case multiplication
    case division
}

class ViewController: UIViewController
{
    @IBOutlet weak var labelOutput: UILabel!
    
    @IBOutlet weak var errorLog: UITextView!
    
    var labelString:String = "0"
    var currentMode:modes = .not_set
    var savedNum:Double = 0
    var lastButtonWasMode:Bool = false
    var divideByZeroFlag:Int = 0
    var firstNumber:Double = 0
    var decimalFlag:Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        updateText()
    }

    @IBAction func didPressPlus(_ sender: Any)
    {
        changeModes(newMode: .addition)
        
    }
    
    @IBAction func didPressMinus(_ sender: Any)
    {
        changeModes(newMode: .subtraction)
        
    }
    
    @IBAction func didPressTimes(_ sender: Any)
    {
        changeModes(newMode: .multiplication)
    }
    
    
    @IBAction func didPressDivide(_ sender: Any)
    {
        changeModes(newMode: .division)
    }
    
    @IBAction func didPressNegative(_ sender: Any)
    {
        /* NEGATIVE CODE HERE */
    }

    @IBAction func didPressDecimal(_ sender: Any)
    {
        /* Decimal code here */
    }
    
    @IBAction func didPressEquals(_ sender: Any)
    {
        guard let labelDouble:Double = Double(labelString)
        else
        {
            return
        }
        
        if(currentMode == .not_set || lastButtonWasMode == true)
        {
            return
        }
        
        if(currentMode == .addition)
        {
            savedNum += labelDouble
        }
        else if(currentMode == .subtraction)
        {
            savedNum -= labelDouble
        }
        else if(currentMode == .multiplication)
        {
            savedNum *= labelDouble
        }
        else if(currentMode == .division)
        {
            if((labelOutput.text == "0") || firstNumber == 0)
            {
                divideByZeroFlag = 1
                errorLog.text = "\(divideByZeroFlag)"
            }
            savedNum /= labelDouble
        }
        if(divideByZeroFlag == 1)
        {
            labelOutput.text = "ERRRRRR"
            currentMode = .not_set
            lastButtonWasMode = true
        }
        else
        {
            currentMode = .not_set
            labelString = "\(savedNum)"
            updateText()
            lastButtonWasMode = true
        }
        divideByZeroFlag = 0
    }
    
    @IBAction func didPressClearEntry(_ sender: Any)
    {
        labelString = "0"
        labelOutput.text = "0"
    }
    
    @IBAction func didPressClearAll(_ sender: Any)
    {
        labelString = "0"
        currentMode = .not_set
        savedNum = 0
        lastButtonWasMode = false
        labelOutput.text = "0"
    }
    
    @IBAction func didPressNumber(_ sender: UIButton)
    {
        let stringValue:String? = sender.titleLabel?.text
            
        if(lastButtonWasMode == true)
        {
            lastButtonWasMode = false
            labelString = "0"
        }
        labelString = labelString.appending(stringValue!)
        updateText()
    }
    
    
    func updateText()
    {
        guard let labelDouble:Double = Double(labelString)
        else
        {
            return
        }
        
        if(currentMode == .not_set)
        {
            savedNum = Double(labelDouble)
        }
        
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num:NSNumber = NSNumber(value: labelDouble)
        
        labelOutput.text = formatter.string(from: num)
    }
    
    func changeModes(newMode:modes)
    {
        currentMode = newMode
        lastButtonWasMode = true
    }
    
}

