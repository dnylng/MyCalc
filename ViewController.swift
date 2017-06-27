//
//  ViewController.swift
//  MyCalc
//
//  Created by Danny Luong on 6/27/17.
//  Copyright © 2017 dnylng. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // Reference to a button sound
    var btnSound: AVAudioPlayer!
    
    // Reference to the output label
    @IBOutlet weak var outputLbl: UILabel!
    
    // Reference to the running number, stage before the result in the calc
    var runningNum = ""
    
    // Reference to left val string
    var leftValStr = ""
    
    // Reference to right val string
    var rightValStr = ""
    
    // Reference to the final result
    var result = ""
    
    // Different calculator operations
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    // Reference to the current op
    var currentOperation = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the path of the btn sound and create a URL for it
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        // It's good to use ! (unwrapping it) bc we wouldn't want app to run w/o this sound
        let soundURL = URL (fileURLWithPath: path!)
        
        // Just like a try/catch statement
        do {
            // Test the sound coming from the URL
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.volume = 0.1
            btnSound.prepareToPlay()
        } catch let err as NSError {
            // If failed, just print the err
            print(err.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // An action for pressed calc buttons
    @IBAction func numPressed(sender: UIButton) {
        playSound()
        
        // We assigned each button a tag, when btn is pressed, append to runningNum
        runningNum += "\(sender.tag)"
        outputLbl.text = runningNum
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    // Function to play sounds
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    // Function to solve the operations
    func processOperation(operation: Operation) {
        // Make sure operation is not empty
        if currentOperation != Operation.Empty {
            
            // A user selected an operator, but then selected another operator without first entering a number
            if runningNum != "" {
                // Set the right val str as the num user just pressed
                rightValStr = runningNum
                
                // Reset the running num
                runningNum = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)!*Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)!/Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)!-Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)!+Double(rightValStr)!)"
                }
                
                // After finishing the calc, store it into the left in case of more operations
                leftValStr = result
                
                // Set the text to the result
                outputLbl.text = result
            }
            
            // Set the current operation to the operation the user just performed
            currentOperation = operation
        } else {
            // First time an operator is pressed
            leftValStr = runningNum
            runningNum = ""
            currentOperation = operation
        }
    }

}

