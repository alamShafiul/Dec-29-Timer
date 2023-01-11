//
//  ViewController.swift
//  Dec-29-Timer
//
//  Created by Admin on 29/12/22.
//

import UIKit

class StopWatchVC: UIViewController {
    
//MARK: - Variables
    var H = "00"
    var M = "00"
    var S = "00"
    var h = 0
    var m = 0
    var s = 0
    var customTimer = Timer()
    var play_pauseBtnFlag = 0 // 0 -> play, 1-> pause
    
    
    
//MARK: - Outlets
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var startBtnOutlet: UIButton!
    
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        hourLabel.text = "00"
        minuteLabel.text = "00"
        secondLabel.text = "00"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    
//MARK: - Action Buttons
    @IBAction func startBtnPressed(_ sender: Any) {
        if(play_pauseBtnFlag == 0) {
            startBtnOutlet.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            runClock()
            play_pauseBtnFlag = 1
        }
        else {
            startBtnOutlet.setImage(UIImage(systemName: "play.circle"), for: .normal)
            customTimer.invalidate()
            play_pauseBtnFlag = 0
        }
    }
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        startBtnOutlet.setImage(UIImage(systemName: "play.circle"), for: .normal)
        resetClockValue()
        play_pauseBtnFlag = 0
    }
    
//MARK: - All functions
    func resetClockValue() {
        customTimer.invalidate()
        H = "00"
        M = "00"
        S = "00"
        h = 0
        m = 0
        s = 0
        hourLabel.text = H
        minuteLabel.text = M
        secondLabel.text = S
    }
   
    func runClock() {
        customTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [weak self] timer in
            guard let self = self else { return }
            
            self.s += 1
            if(self.s == 10) { // 60
                self.m += 1
                self.s = 0
            }
            if(self.m == 10) { // 60
                self.h += 1
                self.m = 0
            }
            if(self.h == 10) { // 24
                self.h = 0
            }
            self.S = String(self.s)
            self.M = String(self.m)
            self.H = String(self.h)
            if(0<=self.s && self.s<=9) {
                self.S = "0" + self.S
            }
            if(0<=self.m && self.m<=9) {
                self.M = "0" + self.M
            }
            if(0<=self.h && self.h<=9) {
                self.H = "0" + self.H
            }
            
            self.secondLabel.text = self.S
            self.minuteLabel.text = self.M
            self.hourLabel.text = self.H
        })
    }
}

