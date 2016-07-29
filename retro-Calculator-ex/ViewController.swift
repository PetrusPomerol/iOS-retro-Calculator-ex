//
//  ViewController.swift
//  retro-Calculator-ex
//
//  Created by Phu Nguyen on 7/24/16.
//  Copyright © 2016 Phu Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Clear = "Clear"
    }
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var runningNumner = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
       try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
    }
        catch let err as NSError {
            print(err.debugDescription)
        }
        }

    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        runningNumner += "\(btn.tag)"
        outputLbl.text = runningNumner
        
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        processOperation(Operation.Clear)
        outputLbl.text = "0"
        runningNumner = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = Operation.Empty
        result = ""        
        
        
    }
    func processOperation (op:Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumner != "" {
                
                rightValStr = runningNumner
                runningNumner = ""
                if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }
                else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                

                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
        }
        else {
            leftValStr = runningNumner
            runningNumner = ""
            currentOperation = op
            
            
        }
        
    }
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
}

