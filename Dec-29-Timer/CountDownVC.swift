//
//  CountDownVC.swift
//  Dec-29-Timer
//
//  Created by Admin on 30/12/22.
//

import UIKit

class CountDownVC: UIViewController {
    
//MARK: - Variables
    var timer = Timer()
    var initValue = 0
    var totalSecond: Float!
    var bar: Float!
    var decrease: Float!
    var play_pauseBtnFlag = 0 // 0 -> play, 1-> pause

//MARK: - Outlets
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var startBtnOutlet: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.setProgress(1.0, animated: false)
    }
    
//MARK: - Action Buttons
    @IBAction func startBtnPressed(_ sender: Any) {
        if(initValue == 0) {
            totalSecond = Float(timePicker.countDownDuration)
            bar = 1.0
            decrease = 1.0/self.totalSecond
            initValue = 1
        }
        if(play_pauseBtnFlag == 0) {
            startBtnOutlet.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            doCountDown()
            play_pauseBtnFlag = 1
        }
        else {
            startBtnOutlet.setImage(UIImage(systemName: "play.circle"), for: .normal)
            timer.invalidate()
            play_pauseBtnFlag = 0
        }
    }
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        resetCounter()
        totalSecond = 0.0
        bar = 1.0
        decrease = 0.0
        initValue = 0
        startBtnOutlet.setImage(UIImage(systemName: "play.circle"), for: .normal)
        play_pauseBtnFlag = 0
    }
    
    
//MARK: - All functions
    func doCountDown() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            if(self.totalSecond < 0) {
                self.progressBar.setProgress(0.0, animated: true)
                timer.invalidate()
                self.startBtnOutlet.setImage(UIImage(systemName: "play.circle"), for: .normal)
                return
            }
            self.progressBar.setProgress(self.bar, animated: true)
            self.bar -= self.decrease
            self.totalSecond -= 1.0
        }
    }
    
    func resetCounter() {
        timer.invalidate()
        progressBar.setProgress(1.0, animated: false)
    }
}
