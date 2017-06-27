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
    }
    
    // Function to play sounds
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }

}

