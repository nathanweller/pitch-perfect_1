//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Nathan Weller on 5/18/15.
//  Copyright (c) 2015 Nathan Weller. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl
                , error: nil)
            audioPlayer.enableRate=true
    
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stopAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }

    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        stopAudio()
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playVaderAudio(sender: UIButton) {
        stopAudio()
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playEcho(sender: UIButton) {
        stopAudio()
        playAudioWithVariablePitch(0)
        audioPlayer.rate=1.0
        audioPlayer.currentTime=0.0
        NSThread.sleepForTimeInterval(1.0)
        audioPlayer.play()
    }

    @IBAction func slowButton(sender: UIButton) {
        stopAudio()
        audioPlayer.rate=0.5
        audioPlayer.currentTime=0.0
        audioPlayer.play()
    }
    
    @IBAction func fastButton(sender: UIButton) {
        stopAudio()
        audioPlayer.rate=1.5
        audioPlayer.currentTime=0.0
        audioPlayer.play()
    
    }
    
    @IBAction func stopButton(sender: UIButton) {
        stopAudio()
    }

    

}
