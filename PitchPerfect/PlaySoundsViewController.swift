//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by modelf on 6/3/16.
//  Copyright © 2016 modelf. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var recordedAudioURL: NSURL!

    
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    
    enum ButtonType: Int { case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb }
    
    @IBAction func playSoundForButton(sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
            
        }
        configureUI(.Playing)
        print("Play button sound")
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
        stopAudio()
        print("Stop playing sound...")
    }
    
    

    override func viewDidLoad() {
        //fix landscape issues with buttons stretching
        [chipmunkButton, vaderButton, reverbButton, echoButton, snailButton, rabbitButton].forEach { $0.imageView?.contentMode = .ScaleAspectFit }
        super.viewDidLoad()
        setupAudio()
    }
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    




}
