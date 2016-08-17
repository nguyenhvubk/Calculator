//
//  ViewController.swift
//  6.Caculator
//
//  Created by Hoang Vu on 8/11/16.
//  Copyright © 2016 ViNZ. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operator: String {
        case Devide = "/"
        case Multiple = "*"
        case Plus = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var OutputLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperator: Operator = Operator.Empty
    var Result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func ButtonPressed (btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        OutputLabel.text = runningNumber
    }
    
    @IBAction func DevidePressed (sender: AnyObject) {
        processOperator(Operator.Devide)
    }
    @IBAction func MultiplyPressed(sender: AnyObject) {
        processOperator(Operator.Multiple)
    }
    @IBAction func PlusPressed(sender: AnyObject) {
        processOperator(Operator.Plus)
    }
    @IBAction func SubtractPressed(sender: AnyObject) {
        processOperator(Operator.Subtract)
    }
    @IBAction func EqualsPressed(sender: AnyObject) {
        processOperator(currentOperator)
    }
    
    func processOperator (op: Operator) {
        playSound()
        
        if currentOperator != Operator.Empty {
            if runningNumber != ""{
            rightValStr = runningNumber
            runningNumber = ""
            if currentOperator == Operator.Devide {
                Result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            } else if currentOperator == Operator.Multiple {
                Result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            } else if currentOperator == Operator.Plus {
                Result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            } else if currentOperator == Operator.Subtract {
                Result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            }
            
            leftValStr = Result
            OutputLabel.text = Result
            
        }
            currentOperator = op
            
        } else {
            //First Operator ever
            leftValStr = runningNumber
            runningNumber = ""
            currentOperator = op
            
        }
    }
    
    func playSound () {
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
    
}
//test for git
