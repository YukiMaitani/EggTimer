//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    let eggTimes = ["Soft":5,"Medium":7,"Hard":12]
    let oneMinuteSeconds = 60
    var timer = Timer()
    var secondsPassed = 0
    var setTime = 0
    var player: AVAudioPlayer!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0.0
        if let hardness = sender.currentTitle{
            setTime = eggTimes[hardness]! * oneMinuteSeconds
            secondsPassed = 0
            messageLabel.text = hardness
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateTime(){
        if secondsPassed < setTime{
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed)/Float(setTime)
            print("\(secondsPassed) seconds .")
        }else{
            timer.invalidate()
            messageLabel.text = "Done!!!"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}
