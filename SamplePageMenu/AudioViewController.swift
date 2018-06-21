//
//  AudioViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/16/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class AudioViewController: UIViewController {

    @IBOutlet weak var seekLoadingLabel: UILabel!
    
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var playButton: UIButton!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var playerSlider: UISlider!
    
    @IBOutlet weak var loadingLabel: UILabel!
    
    @IBOutlet weak var backGroundView: UIView!
    
//MARK: -  variable declaration
    
    var appVersion          : String = ""

    var audioIDArray : Array<String> = Array()
    var audioIDArr = ""
    var audioIDNameArr = ""
    var NameArr = ""

    var playList: NSMutableArray = NSMutableArray()
    var timer: Timer?
    var index: Int = Int()
    var avPlayer: AVPlayer!
    var isPaused: Bool!
    
    
  //MARK: -  view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor(red: 103.0/255.0, green:  171.0/255.0, blue:  208.0/255.0, alpha: 1.0).cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0

        Utilities.audioEventViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: self.audioIDNameArr, backTitle: "   C", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")

    }
//MARK: -  view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isPaused = false
        playButton.setImage(UIImage(named:"puseImage"), for: .normal)
        self.playList.add(audioIDArr)
        self.play(url: URL(string:(playList[self.index] as! String))!)
        self.setupTimer()
    }
    
    func play(url:URL) {
        self.avPlayer = AVPlayer(playerItem: AVPlayerItem(url: url))
        if #available(iOS 10.0, *) {
            self.avPlayer.automaticallyWaitsToMinimizeStalling = false
        }
        avPlayer!.volume = 1.0
        avPlayer.play()
    }
    
 //MARK: -  view Will DisAppear
    
    override func viewWillDisappear( _ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        self.avPlayer = nil
        self.timer?.invalidate()
    }
    
    @available(iOS 10.0, *)
    func togglePlayPause() {
        if avPlayer.timeControlStatus == .playing  {
            playButton.setImage(UIImage(named:"playImage"), for: .normal)
            avPlayer.pause()
            isPaused = true
        } else {
            playButton.setImage(UIImage(named:"puseImage"), for: .normal)
            avPlayer.play()
            isPaused = false
        }
    }
    
  //MARK: -  setup Timer
    
    func setupTimer(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.didPlayToEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        timer = Timer(timeInterval: 0.001, target: self, selector: #selector(AudioViewController.tick), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    func didPlayToEnd() {
        self.nextTrack()
    }
    
    func tick(){
        if(avPlayer.currentTime().seconds == 0.0){
            loadingLabel.alpha = 1
        }else{
            loadingLabel.alpha = 0
        }
        
        if(isPaused == false){
            if(avPlayer.rate == 0){
                avPlayer.play()
                seekLoadingLabel.alpha = 1
            }else{
                seekLoadingLabel.alpha = 0
            }
        }
        
        if((avPlayer.currentItem?.asset.duration) != nil){
            let currentTime1 : CMTime = (avPlayer.currentItem?.asset.duration)!
            let seconds1 : Float64 = CMTimeGetSeconds(currentTime1)
            let time1 : Float = Float(seconds1)
            playerSlider.minimumValue = 0
            playerSlider.maximumValue = time1
            let currentTime : CMTime = (self.avPlayer?.currentTime())!
            let seconds : Float64 = CMTimeGetSeconds(currentTime)
            let time : Float = Float(seconds)
            self.playerSlider.value = time
            timeLabel.text =  self.formatTimeFromSeconds(totalSeconds: Int32(Float(Float64(CMTimeGetSeconds((self.avPlayer?.currentItem?.asset.duration)!)))))
            currentTimeLabel.text = self.formatTimeFromSeconds(totalSeconds: Int32(Float(Float64(CMTimeGetSeconds((self.avPlayer?.currentItem?.currentTime())!)))))
            
        }else{
            playerSlider.value = 0
            playerSlider.minimumValue = 0
            playerSlider.maximumValue = 0
            timeLabel.text = "Live stream \(self.formatTimeFromSeconds(totalSeconds: Int32(CMTimeGetSeconds((avPlayer.currentItem?.currentTime())!))))"
        }
    }
    
    
    func nextTrack(){
        if(index < playList.count-1){
            index = index + 1
            isPaused = false
            playButton.setImage(UIImage(named:"puseImage"), for: .normal)
            self.play(url: URL(string:(playList[self.index] as! String))!)
            
            
        }else{
            index = 0
            isPaused = false
            playButton.setImage(UIImage(named:"puseImage"), for: .normal)
            self.play(url: URL(string:(playList[self.index] as! String))!)
        }
    }
    
    func prevTrack(){
        if(index > 0){
            index = index - 1
            isPaused = false
            playButton.setImage(UIImage(named:"puseImage"), for: .normal)
            self.play(url: URL(string:(playList[self.index] as! String))!)
            
        }
    }
    
    func formatTimeFromSeconds(totalSeconds: Int32) -> String {
        let seconds: Int32 = totalSeconds%60
        let minutes: Int32 = (totalSeconds/60)%60
        let hours: Int32 = totalSeconds/3600
        return String(format: "%02d:%02d:%02d", hours,minutes,seconds)
    }
    
    
 //MARK: -  play Button Clicked
    
    @IBAction func playButtonClicked(_ sender: UIButton) {
        
        if #available(iOS 10.0, *) {
            self.togglePlayPause()
        } else {
            
        }
        
    }
    
  //MARK: -  next Button Clicked
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        self.nextTrack()

    }
    
   //MARK: -  preview Button Clicked
    
    @IBAction func prevButtonClicked(_ sender: Any) {
        
        self.prevTrack()

    }
    
 //MARK: -  slider Value Change
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        
        let seconds : Int64 = Int64(sender.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        avPlayer!.seek(to: targetTime)
        if(isPaused == false){
            seekLoadingLabel.alpha = 1
        }
        
        
    }
    
    @IBAction func sliderTapped(_ sender: UILongPressGestureRecognizer) {
        
        if let slider = sender.view as? UISlider {
            if slider.isHighlighted { return }
            let point = sender.location(in: slider)
            let percentage = Float(point.x / slider.bounds.width)
            let delta = percentage * (slider.maximumValue - slider.minimumValue)
            let value = slider.minimumValue + delta
            slider.setValue(value, animated: false)
            let seconds : Int64 = Int64(value)
            let targetTime:CMTime = CMTimeMake(seconds, 1)
            avPlayer!.seek(to: targetTime)
            if(isPaused == false){
                seekLoadingLabel.alpha = 1
            }
        }
        
    }
    
 //MARK: -    Back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        
        UserDefaults.standard.set("1", forKey: "1")

        UserDefaults.standard.synchronize()
        UserDefaults.standard.removeObject(forKey: "1")
    
        self.navigationController?.popViewController(animated: true)
        
        
        print("Back Button Clicked......")
        
    }
    
//MARK: -    Home Left Button Tapped
    
    @IBAction func homeButtonTapped(_ sender:UIButton) {
        
        
        UserDefaults.standard.removeObject(forKey: "1")
        
        
        
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        
        
        
        print("Home Button Clicked......")
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
