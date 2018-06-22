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

class AudioViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate {

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
    
    
    @IBOutlet weak var audioTableview: UITableView!
    
    
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
   
    
    
    
    
    var thumbnailImageURL = String()
    
    var userID = Int()
    
    
    var isLike = 0
    var isDisLike = 0
    var likeClick = false
    var disLikeClick = false
    var likesCount = 0
    var disLikesCount = 0
    var ID = 0
    var sendCommentClick = false
    var usersCommentsArray = Array<Any>()
    
    var parentCommentId = 0
    var replyParentCommentId = 0
    
    var commentString : String = "Add a public comment..."
    
     var loginVC = LoginViewController()
    
    
     var eventID = Int()
    
     var eventsDetailsArray:[EventDetailsListResultVO] = Array<EventDetailsListResultVO>()
    
    
  //MARK: -  view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor(red: 103.0/255.0, green:  171.0/255.0, blue:  208.0/255.0, alpha: 1.0).cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0

        Utilities.audioEventViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: self.audioIDNameArr, backTitle: "   C", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
        if kUserDefaults.value(forKey: kIdKey) as? Int != nil {
            
            self.userID = (kUserDefaults.value(forKey: kIdKey) as? Int )!
            
        }
        

        
        
        let nibName  = UINib(nibName: "youtubeCLDSSCell" , bundle: nil)
        audioTableview.register(nibName, forCellReuseIdentifier: "youtubeCLDSSCell")
        
        let nibName1  = UINib(nibName: "CommentsCell" , bundle: nil)
        audioTableview.register(nibName1, forCellReuseIdentifier: "CommentsCell")
        
        let nibName2  = UINib(nibName: "SubscribCell" , bundle: nil)
        audioTableview.register(nibName2, forCellReuseIdentifier: "SubscribCell")
        
        let nibName3  = UINib(nibName: "UsersCommentsTableViewCell" , bundle: nil)
        audioTableview.register(nibName3, forCellReuseIdentifier: "UsersCommentsTableViewCell")
        

        
        
        audioTableview.dataSource = self
        audioTableview.delegate = self
        
        self.navigationController?.isNavigationBarHidden = true
     
        
        
        
        

    }
//MARK: -  view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isPaused = false
        playButton.setImage(UIImage(named:"puseImage"), for: .normal)
        self.playList.add(audioIDArr)
        self.play(url: URL(string:(playList[self.index] as! String))!)
        self.setupTimer()
        
        
        Utilities.audioEventViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: self.audioIDNameArr, backTitle: "   C", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
   
        
        
        
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
    
    //MARK:- Collectionview  DataSource & Delegate Methods
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 4
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if section == 0 {

        return 1
        }
        
        if section == 1 {
            
            return 1
        }
        
        if section == 2 {
            
            return 1
        }

        
        
       return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            
            return 200.0
        }
        else {
            
            return 100.0
            
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
         if indexPath.section == 0 {
            
            
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "youtubeCLDSSCell", for: indexPath) as! youtubeCLDSSCell
        
      //      if eventsDetailsArray.count > 0 {
                
//        let eventList: EventDetailsListResultVO = self.eventsDetailsArray[0]
//                
//
//            
//            cell.videoTitleName.text = eventList.churchName
                
            
            cell.likeCountLbl.text = String(likesCount)
            
            cell.disLikeCountLbl.text = String(disLikesCount)
            
            cell.likeButton.addTarget(self, action: #selector(likeButtonClicked(_:)), for: UIControlEvents.touchUpInside)
            cell.unlikeButton.addTarget(self, action: #selector(unlikeButtonClicked(_:)), for: UIControlEvents.touchUpInside)
            cell.shareButton.addTarget(self, action: #selector(shareButtonClick(_:)), for: UIControlEvents.touchUpInside)
            
            if self.isLike == 0 {
                
                cell.likeButton.tintColor = #colorLiteral(red: 0.4352941215, green: 0.4431372583, blue: 0.4745098054, alpha: 1)
                
            }
            else {
                
                cell.likeButton.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            }
            
            if self.isDisLike == 0{
                
                cell.unlikeButton.tintColor = #colorLiteral(red: 0.4352941215, green: 0.4431372583, blue: 0.4745098054, alpha: 1)
                
            }
            else {
                
                cell.unlikeButton.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            }
            
            return cell
     
            
            
    //        }
            
            
            
       
            
            
        }
        
        if indexPath.section == 1 {
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "SubscribCell", for: indexPath) as! SubscribCell
            
            
            
            return cell2
            
            
        }

        
        if indexPath.section == 2 {
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
            
            cell1.commentTexView.text = self.commentString
            cell1.commentCountLab.text = String(usersCommentsArray.count)
            cell1.commentTexView.delegate = self
            
            cell1.sendBtn.addTarget(self, action: #selector(commentSendBtnClicked),for: .touchUpInside)
            
            if sendCommentClick == false{
                
                cell1.sendBtn.isHidden = true
                
            }
                
            else{
                
                cell1.sendBtn.isHidden = false
                
                
            }
        
            
            return cell1
            
            
        }
        
        
        if indexPath.section == 3 {
            
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "UsersCommentsTableViewCell", for: indexPath) as! UsersCommentsTableViewCell
            
            
            
            return cell3
            
            
        }

        
        
        
        
        return UITableViewCell()
    }
  
    
    
    func  likeButtonClicked(_ sendre:UIButton) {
        
        if !(self.userID == 0) {
            
            if likeClick == false {
                
                likeClick = true
                disLikeClick = false
                
                
            }
                
            else{
                
                likeClick = false
                disLikeClick = false
                
                
            }
            
            eventLikesDislikesCountAPiCall()
            
            
            
        }
            
        else {
            
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Like", clickAction: {
                
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                
                self.navigationController?.pushViewController(loginVC!, animated: true)
                
            })
            
        }
        
        
    }
    
    func  unlikeButtonClicked(_ sendre:UIButton) {
        
        if !(self.userID == 0) {
            
            if disLikeClick == false {
                
                disLikeClick = true
                likeClick = false
                
            }
                
            else{
                disLikeClick = false
                likeClick = false
                
                
            }
            
            print("UnLike Clicked.............")
            
            eventLikesDislikesCountAPiCall()
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Unlike", clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
            
        }
        
    }
    
    func  shareButtonClick(_ sendre:UIButton) {
        
        if !(self.userID == 0) {
            
            let someText:String = "Hello want to share text also"
            let objectsToShare:URL = URL(string: "http://www.google.com")!
            let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
            let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            
            activityViewController.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            
            self.present(activityViewController, animated: true, completion: nil)
            
            print("Share Clicked.............")
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Share", clickAction: {
                
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
            })
            
        }
    }
    
    
    func commentSendBtnClicked(){
        
        self.sendCommentClick = false
        
        self.audioTableview.endEditing(true)
        
        print(self.commentString)
        
        
        
        
        if !(self.userID == 0) {
            
            
            self.parentCommentId = 0
            
            commentSendBtnAPIService(textComment: self.commentString)
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Add Comment", clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
            
        }
        
        
    }
    
    func commentSendBtnAPIService(textComment : String){
        
        
        let  EVENTCOMMENTSAPISTR = EVENTCOMMENTAPI
        
        let params = ["id": 0,
                      "eventId": eventID,
                      "description": textComment,
                      "parentCommentId": self.parentCommentId,
                      "userId": self.ID
            
            
            ] as [String : Any]
        
        print("dic params \(params)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: EVENTCOMMENTSAPISTR as NSString, postParams: params as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            print("\(result)")
            
            let respVO:AddUpdateEventCommentsInfoVO = Mapper().map(JSONObject: result)!
            print("responseString = \(respVO)")
            
            
            let statusCode = respVO.isSuccess
            
            print("StatusCode:\(String(describing: statusCode))")
            
            if statusCode == true
            {
                
                
                let successMsg = respVO.endUserMessage
                
                self.usersCommentsArray.insert(self.commentString, at: 0)
                self.commentString = "Add a public comment..."
                self.audioTableview.reloadSections(IndexSet(integersIn: 2...3), with: UITableViewRowAnimation.top)
                
                
                
                
                
            }
                
            else {
                
                let failMsg = respVO.endUserMessage
                
                
                return
                
                
                
            }
            
            
        }) { (failureMessage) in
            
            
            
        }
    }
    
    func eventLikesDislikesCountAPiCall(){
        
        
        let  EVENTSLIKEDISLIKEAPISTR = EVENTSLIKEDISLIKEAPI
        
        let params = [ "eventId": eventID,
                       "userId": self.ID,
                       "like": likeClick,
                       "disLike": disLikeClick   ] as [String : Any]
        
        print("dic params \(params)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: EVENTSLIKEDISLIKEAPISTR as NSString, postParams: params as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            
            let responseVO:LikeDislikeVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = responseVO.isSuccess
            
            if isSuccess == true {
                
                self.likesCount = (responseVO.result?.likeCount)!
                self.disLikesCount = (responseVO.result?.dislikeCount)!
                
                self.isLike = (responseVO.result?.likeResult?[0].like)!
                self.isDisLike = (responseVO.result?.likeResult?[0].disLike)!
                
                let indexPath = IndexPath(item: 1, section: 0)
                self.audioTableview.reloadRows(at: [indexPath], with: .automatic)
                
            }
            
            
        }) { (failureMessage) in
            
            
            
        }
    }
   
    
    //MARK: -  UITexview Delegate methods
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
        
        if textView.text == "Add a public comment..." {
            
            textView.text = ""
            
        }
        
        self.sendCommentClick = false
        textView.textColor = UIColor.black
        
        
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        textView.resignFirstResponder()
        
        self.commentString = textView.text
        
        if textView.text == "" {
            
            textView.text = "Add a public comment..."
            textView.textColor = UIColor.lightGray
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let indexPath : IndexPath = IndexPath(row: 0, section: 2)
        
        if let commentsCell = self.audioTableview.cellForRow(at: indexPath) as? CommentsCell {
            
            let newString = (textView.text! as NSString).replacingCharacters(in: range, with: text)
            
            print(commentsCell.commentTexView.text.characters.count)
            
            self.commentString = commentsCell.commentTexView.text
            
            if (newString.characters.count) > 0  {
                
                
                
                print(self.commentString)
                
                commentsCell.sendBtn.isHidden = false
                
            }
                
            else{
                
                commentsCell.sendBtn.isHidden = true
                
            }
        }
        
        
        return true
        
    }
 
    
    //MARK: -    Get Event Details By Id API Call
    
    func getEventDetailsByIdApiCall(){
        
        let getEventDetailsByIdApi = GETEVENTDETAILSBYID + String(eventID) + "/" + String(self.userID)
        
        serviceController.getRequest(strURL: getEventDetailsByIdApi, success: { (result) in
            
            if result.count > 0{
                
                print(result)
                
                let responseVO:EventDetailsVO = Mapper().map(JSONObject: result)!
                
                let isSuccess = responseVO.isSuccess
                print("StatusCode:\(String(describing: isSuccess))")
                
                if isSuccess == true{
                    
                    let listResult = responseVO.result?.eventDetails
                    
                    let commentDetailsVO = responseVO.result?.commentDetails
                    
                    if (listResult?.count)! > 0 {
                        
                        self.audioTableview.isHidden = false
                        
                        self.eventsDetailsArray = listResult!
                        
                        
                        
                        for commentDetails in commentDetailsVO! {
                            
                        self.usersCommentsArray.append(commentDetails.comment)
                            
                        }
                        
                        
                        self.likesCount = self.eventsDetailsArray[0].likeCount!
                        self.disLikesCount = self.eventsDetailsArray[0].disLikeCount!
                        
                        self.isLike = self.eventsDetailsArray[0].isLike!
                        self.isDisLike = self.eventsDetailsArray[0].isDisLike!
                        
                        print(self.eventsDetailsArray)
                        
                        if self.isLike == 0{
                            
                            self.likeClick = false
                            
                        }
                            
                        else {
                            
                            self.likeClick = true
                            
                        }
                        
                        if self.isDisLike == 0{
                            
                            self.disLikeClick = false
                            
                        }
                            
                        else {
                            
                            self.disLikeClick = true
                            
                        }
                        
                        self.audioTableview.reloadData()
                    }
                    else {
                        
                        
                        self.audioTableview.isHidden = true
                    }
                    
                }
                else{
                    
                    
                    self.audioTableview.isHidden = true
                    
                }
                
                
            }
                
            else{
                
                
                print(" No result Found ")
                
            }
            
            
        }) { (failureMessege) in
            
            print(failureMessege)
            
        }
        
        
    }
    


    
    
    
    

}
