//
//  RecordsSoundsViewController.swift
//  PitchPerfect
//
//  Created by modelf on 6/1/16.
//  Copyright © 2016 modelf. All rights reserved.
//

import UIKit
import AVFoundation

class RecordsSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAction(_ sender: AnyObject) {
        recordingLabel.text = "Recording..."
        recordButton.isEnabled = false
        stopRecordingButton.isEnabled = true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "peepee.wav"
        let pathString = "\(dirPath)/ + \(recordingName)"
        let filePath = URL(fileURLWithPath: pathString)
        
//        let filePath = URL.fileURL(withPathComponents: pathArray)
        //print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        print(audioRecorder.url)
        
    }
    @IBAction func stopRecording(_ sender: AnyObject) {
        recordingLabel.text = "Tap to Record"
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        
        audioRecorder.stop()

    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorder finished recording")
        if(flag) {
            self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else {
            print("Audio failed to save")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

}

