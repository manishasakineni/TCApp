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
import IQKeyboardManagerSwift

class AudioViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,URLSessionDownloadDelegate,UIDocumentInteractionControllerDelegate  {

    @IBOutlet weak var seekLoadingLabel : UILabel!
    
    @IBOutlet weak var prevButton       : UIButton!
    
    @IBOutlet weak var imageView        : UIImageView!
    
    @IBOutlet weak var playButton       : UIButton!
    
    @IBOutlet weak var nextButton       : UIButton!
    
    @IBOutlet weak var currentTimeLabel : UILabel!
    
    @IBOutlet weak var timeLabel        : UILabel!
    
    @IBOutlet weak var playerSlider     : UISlider!
    
    @IBOutlet weak var loadingLabel     : UILabel!
    
    @IBOutlet weak var backGroundView   : UIView!
    
    @IBOutlet weak var audioTableview   : UITableView!
    
    @IBOutlet weak var repliesTableView : UITableView!

    @IBOutlet weak var secondview       : UIView!
    
    @IBOutlet weak var popupview        : UIView!
    
    @IBOutlet weak var okBtnOutLet      : UIButton!
    
    @IBOutlet weak var canclebtnOutLet  : UIButton!
    
    @IBOutlet weak var textviewOutLet   : UITextView!
    
    @IBOutlet weak var downloadBackGroundView: UIView!
    
    @IBOutlet weak var downloadingLabel : UILabel!
    
    @IBOutlet weak var percentageLabe   : UILabel!
    
    @IBOutlet weak var progress         : UIProgressView!
    
    
//MARK: -  variable declaration
    
    var appVersion          = ""
    var audioIDArray        : Array<String> = Array()
    var audioIDArr          = ""
    var audioIDNameArr      = ""
    var NameArr             = ""
    var playList            : NSMutableArray = NSMutableArray()
    var timer               : Timer?
    var index               : Int = Int()
    var avPlayer            : AVPlayer!
    var isPaused            : Bool!
    var activeTextView      = UITextView()
    var  deleteID           : Int = 0
    var thumbnailImageURL   = String()
    var userID              = 0
    
    var replyDetails        = [CommentDetailsVo]()
    var isLike              = 0
    var isDisLike           = 0
    var viewCount           = 0
    var likeClick           = false
    var disLikeClick        = false
    var likesCount          = 0
    var disLikesCount       = 0
    var ID                  = 0
    var audioID             = 0
    var categoryID          = 0
    var sendCommentClick    = false
    var usersCommentsArray  = Array<Any>()
    
    var parentCommentId     = 0
    var replyParentCommentId = 0
    var comentId            = 0
    var commentString       : String = "Add a public comment...".localize()
    var activeLabel         = UILabel()
    var loginVC             = LoginViewController()
    var parentCommentIdArray = Array<Int>()
    var commentingIdArray   = Array<Int>()
    var eventID             = 0
    var activeLblNumberofLines : Int = 3
    var replyCountArray     = Array<Any>()
    var commentId           = 0
    var replyMainComment    = ""
    var replyMainCommentUser = ""
    var repliesCommentsArray = Array<Any>()
    var repliesCommentsUsernamesArray = Array<Any>()
    var videoId             : Int = 0
    var categoryId          = Int()
    var postID              : Int = 0
    var editUserID          = 0
    var commentsCount       = 0
    var readMoreBtnIsHidden = true
    var commentedByUserArray = Array<Any>()
    var CommentsByUserArray  = Array<Any>()
    var loginUseridsArray    = Array<Int>()
    var eventsDetailsArray   : [EventDetailsListResultVO] = Array<EventDetailsListResultVO>()
    let buttonnn             = UIButton()

    var defaultSession  : URLSession!
    var downloadTask    : URLSessionDownloadTask!

    let sucessLabel = UILabel()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
//MARK: -  view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
        secondview.isHidden = true
        popupview.isHidden = true
        downloadBackGroundView.isHidden = true

        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor(red: 103.0/255.0, green:  171.0/255.0, blue:  208.0/255.0, alpha: 1.0).cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0
        
        // Registring tableview cells
        
        let nibName  = UINib(nibName: "youtubeCLDSSCell" , bundle: nil)
        audioTableview.register(nibName, forCellReuseIdentifier: "youtubeCLDSSCell")
        
        let nibName1  = UINib(nibName: "CommentsCell" , bundle: nil)
        audioTableview.register(nibName1, forCellReuseIdentifier: "CommentsCell")
        
        let nibName2  = UINib(nibName: "SubscribCell" , bundle: nil)
        audioTableview.register(nibName2, forCellReuseIdentifier: "SubscribCell")
        
        let nibName3  = UINib(nibName: "UsersCommentsTableViewCell" , bundle: nil)
        audioTableview.register(nibName3, forCellReuseIdentifier: "UsersCommentsTableViewCell")
        
        let nib = UINib(nibName: "AllRepliesHeaderTVCell", bundle: nil)
        repliesTableView.register(nib, forCellReuseIdentifier: "AllRepliesHeaderTVCell")

        let usersCommentsTableViewCell  = UINib(nibName: "UsersCommentsTableViewCell" , bundle: nil)
        repliesTableView.register(usersCommentsTableViewCell, forCellReuseIdentifier: "UsersCommentsTableViewCell")
    
        let nibName4  = UINib(nibName: "CommentsCell" , bundle: nil)
        repliesTableView.register(nibName4, forCellReuseIdentifier: "CommentsCell")

        self.textviewOutLet.delegate     = self
        self.repliesTableView.delegate   = self
        self.repliesTableView.dataSource = self
        self.audioTableview.dataSource   = self
        self.audioTableview.delegate     = self
        
       repliesTableView.tableFooterView = UIView(frame: .zero)
       self.navigationController?.isNavigationBarHidden = true
        
        if kUserDefaults.value(forKey: kIdKey) as? Int != nil {
            
            self.userID = (kUserDefaults.value(forKey: kIdKey) as? Int )!
            
        }
        
        let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
        defaultSession = Foundation.URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
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
        
        if kUserDefaults.value(forKey: kIdKey) as? Int != nil {
            
            self.ID = (kUserDefaults.value(forKey: kIdKey) as? Int )!
            
        }
   
        // calling Event details api
        
        getEventDetailsByIdApiCall() 
       
    }

    // play audio url
    
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
        
        kUserDefaults.removeObject(forKey: kLoginSucessStatus)
        kUserDefaults.set("1", forKey: "1")
        kUserDefaults.synchronize()
        kUserDefaults.removeObject(forKey: "1")
        
        self.navigationController?.popViewController(animated: true)
        print("Back Button Clicked......")
        
    }
    
//MARK: -    Home Left Button Tapped
    
    @IBAction func homeButtonTapped(_ sender:UIButton) {
        
        kUserDefaults.removeObject(forKey: "1")
        kUserDefaults.removeObject(forKey: kLoginSucessStatus)
        kUserDefaults.set("1", forKey: "1")
        kUserDefaults.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        print("Home Button Clicked......")
        
    }

    override func viewDidLayoutSubviews() {
        repliesTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK:- Tableview  DataSource & Delegate Methods
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == repliesTableView {
            return 2
        }
        else {
            
            return 4
        }
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if tableView == repliesTableView{
            
            if section == 0 {
                return 2
            }
            else {
                return self.repliesCommentsArray.count
            }
        }
        
        else{
            if section == 0 {
                return 1
            }
            if section == 1 {
                return 1
            }
            if section == 2 {
                return 1
            }
            if section == 3 {
                return usersCommentsArray.count
        }
        
       return 1
     }
  }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == repliesTableView {
            
            return UITableViewAutomaticDimension
        }
        
        else {
            
            if indexPath.section == 0  {
                
                return 90
                
            }
            
            if indexPath.section == 1  {
                
                return 60
                
            }
                
            else {
                
                
                return UITableViewAutomaticDimension
                
            }
            
        }    
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tableView == repliesTableView {
            
            if section == 0 {
                return 40
                
            }
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == repliesTableView {
            
            if section == 0 {
                
                let allRepliesHeaderTVCell = self.repliesTableView.dequeueReusableCell(withIdentifier: "AllRepliesHeaderTVCell") as! AllRepliesHeaderTVCell
                
                allRepliesHeaderTVCell.repliesCloseBtn.addTarget(self, action: #selector(repliesCloseBtnClicked), for: .touchUpInside)
                allRepliesHeaderTVCell.backgroundColor = #colorLiteral(red: 0.9999127984, green: 1, blue: 0.9998814464, alpha: 1)
                allRepliesHeaderTVCell.repliesCloseBtn = buttonnn
                
                return allRepliesHeaderTVCell
                
            }
            
        }
        
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
      
        if tableView == repliesTableView   {
            
            if indexPath.section == 0 {
                
                if indexPath.row == 0{
                    
                    let usersCommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersCommentsTableViewCell", for: indexPath) as! UsersCommentsTableViewCell
                    
                    usersCommentsTableViewCell.viewCommentsBtn.isHidden = false
                    usersCommentsTableViewCell.replyCommentBtn.isHidden = false
                    
                    usersCommentsTableViewCell.usersCommentLbl.text = self.replyMainComment
                    usersCommentsTableViewCell.usersNameLbl.text = self.replyMainCommentUser
                    if replyCountArray.count > 0{
                        usersCommentsTableViewCell.replayCountLbl.text = String(repliesCommentsArray.count)
                    }
                    
                    else{
                        
                        usersCommentsTableViewCell.buttonImgOutLet.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        usersCommentsTableViewCell.editCommentBn.isHidden = true
                        usersCommentsTableViewCell.viewCommentsBtn.isHidden = true
                        usersCommentsTableViewCell.replayCountLbl.text = ""
                    }

                    return usersCommentsTableViewCell
                }
                    
                else {
                    
                    
                }
                
            }
                
            else {
                
                let usersCommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersCommentsTableViewCell", for: indexPath) as! UsersCommentsTableViewCell
                
                usersCommentsTableViewCell.usersCommentLbl.text = self.repliesCommentsArray[indexPath.row] as? String
                usersCommentsTableViewCell.usersNameLbl.text = self.repliesCommentsUsernamesArray[indexPath.row] as? String
                usersCommentsTableViewCell.viewCommentsBtn.isHidden = false
                usersCommentsTableViewCell.replyCommentBtn.isHidden = true
                usersCommentsTableViewCell.editCommentBn.isHidden = true
                usersCommentsTableViewCell.usersLikeBtn.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                usersCommentsTableViewCell.usersDislikeBtn.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                
                usersCommentsTableViewCell.buttonImgOutLet.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                usersCommentsTableViewCell.editCommentBn.isHidden = true
                usersCommentsTableViewCell.viewCommentsBtn.isHidden = true
                usersCommentsTableViewCell.replayCountLbl.text = ""
                
                

                return usersCommentsTableViewCell
            }
            
        }
        
        
        else{
            
            
         if indexPath.section == 0 {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "youtubeCLDSSCell", for: indexPath) as! youtubeCLDSSCell
        
            
            cell.likeCountLbl.text = String(likesCount)
            cell.disLikeCountLbl.text = String(disLikesCount)
            cell.viewCountLbl.text = String(self.viewCount) + "Views"
            
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
            
            
        }
        
        if indexPath.section == 1 {
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "SubscribCell", for: indexPath) as! SubscribCell
            
            cell2.subscribnameLbl.text = "Channel Name"
            
            return cell2
            
            
        }

        
        if indexPath.section == 2 {
            
            let commentsCell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
            
                commentsCell.commentTexView.text     = self.commentString
                commentsCell.commentCountLab.text    = String(usersCommentsArray.count) + " " + "Comments".localize()
                commentsCell.commentTexView.delegate = self
                commentsCell.commentTexView.tag      = 2001
                commentsCell.sendBtn.addTarget(self, action: #selector(commentSendBtnClicked),for: .touchUpInside)
                commentsCell.commentTWBtn.addTarget(self, action: #selector(commentTWBtnClicked),for: .touchUpInside)
            
            
            if(commentString == "Add a public comment...".localize()){
                commentsCell.commentTexView.textColor = UIColor.lightGray
            }else{
                commentsCell.commentTexView.textColor = UIColor.black
            }
            
            if sendCommentClick == false {
                
                commentsCell.sendBtn.isHidden = true
                
            }
            else{
                commentsCell.sendBtn.isHidden = false
            }
            
            return commentsCell            
            
        }
        
        if indexPath.section == 3 {
            
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "UsersCommentsTableViewCell", for: indexPath) as! UsersCommentsTableViewCell
            
            cell3.usersCommentLbl.text     = usersCommentsArray[indexPath.row] as? String
            cell3.usersNameLbl.text        = self.commentedByUserArray[indexPath.row] as? String
            cell3.viewCommentsBtn.isHidden = false
            cell3.replyCommentBtn.isHidden = false
            cell3.editCommentBn.tag        = indexPath.row
        
            
            let commentString       = usersCommentsArray[indexPath.row] as? String
            let commentedbyusername = commentedByUserArray[indexPath.row] as? String
            cell3.usersLikeCoubtLbl.text = String(commentingIdArray[indexPath.row])
            
            
            let commentLblHeight = Int((commentString?.height(withConstrainedWidth: cell3.usersCommentLbl.frame.size.width, font: UIFont(name: "HelveticaNeue", size: 14.0)!))!)
            
            let commentnameLblHeight = Int((commentedbyusername?.height(withConstrainedWidth: cell3.usersNameLbl.frame.size.width, font: UIFont(name: "HelveticaNeue", size: 14.0)!))!)
            
            if commentLblHeight  > 50  && activeLblNumberofLines == 3 {
                cell3.usersCommentLbl.numberOfLines = activeLblNumberofLines
            }
                
            else {
                
            cell3.usersCommentLbl.numberOfLines = activeLblNumberofLines
               
            }
            
            print(activeLabel.numberOfLines)
            cell3.usersCommentLbl.text = commentString
            print(cell3.usersCommentLbl.numberOfLines)
            
            let replyCount : Int = replyCountArray[indexPath.row] as! Int
            
            cell3.usersLikeBtn.tag = indexPath.row
            cell3.usersDislikeBtn.tag = indexPath.row
            cell3.readMoreBtn.tag = indexPath.row
            cell3.viewCommentsBtn.tag = indexPath.row
            cell3.replyCommentBtn.tag = indexPath.row
            
            cell3.replayCountLbl.text = String(replyCount)
            
            if replyCount > 0{
                
                cell3.viewCommentsBtn.isHidden = false
                cell3.replayCountLbl.text = String(replyCount)
            }
                
            else{
                
                cell3.viewCommentsBtn.isHidden = false
                cell3.replayCountLbl.text = ""
            }
            
            cell3.usersLikeBtn.addTarget(self, action: #selector(likeButtonClicked), for: UIControlEvents.touchUpInside)
            cell3.usersDislikeBtn.addTarget(self, action: #selector(unlikeButtonClicked), for: UIControlEvents.touchUpInside)
            cell3.replyCommentBtn.addTarget(self, action: #selector(replyCommentBtnClick), for: UIControlEvents.touchUpInside)
            cell3.viewCommentsBtn.addTarget(self, action: #selector(viewAllCommentBtnClick), for: UIControlEvents.touchUpInside)
            cell3.readMoreBtn.addTarget(self, action: #selector(readmoreClicked), for: .touchUpInside)
   
            if self.ID == self.loginUseridsArray[indexPath.row]{
                
                cell3.buttonImgOutLet.isHidden = false
                cell3.editCommentBn.addTarget(self, action: #selector(editCommentBnClicked), for: .touchUpInside)
            }
            else{
                cell3.buttonImgOutLet.isHidden = true
            }
                cell3.replyCommentBtn.isHidden = false
            
            return cell3
        }
        
        }
        return UITableViewCell()
    
    }
    
    func commentTWBtnClicked(){
        
        
    }
    
    func readmoreClicked(sender : UIButton){
        readMoreBtnIsHidden = false
        activeLblNumberofLines = 0
        
        let indexPath = IndexPath(item: sender.tag, section: 3)
        self.audioTableview.reloadRows(at: [indexPath], with: .automatic)
        
    }
 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        

        if tableView == repliesTableView {
            
        }
            
        else {
            activeLblNumberofLines = 3
        }
        
    }
    
    
 //MARK: -    edit Comment Btn Clicked
    
    func editCommentBnClicked(sender : UIButton){
        
         if self.ID == self.loginUseridsArray[sender.tag]{
        
         self.editUserID = self.commentingIdArray[sender.tag]
        
   //   self.parentCommentId = self.parentCommentIdArray[sender.tag]
        self.comentId = self.commentingIdArray[sender.tag]
        let userCommentString = self.usersCommentsArray[sender.tag] as! String

            let actionSheet = UIAlertController(title: nil, message: "Select", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let edit = UIAlertAction(title: "Edit", style: .default, handler: { (alert: UIAlertAction!) -> Void in
                
                let indexPath3 = IndexPath(row: 0, section: 2)
                
                self.commentString = ""
                self.audioTableview.scrollToRow(at: indexPath3, at: .top, animated: true)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                    
                    if let commentsCell = self.audioTableview.cellForRow(at: indexPath3) as? CommentsCell {
                      
                        commentsCell.commentTexView.text = userCommentString
                        commentsCell.commentTexView.becomeFirstResponder()
                        
                    }
                    
                })
               
                
            })
            
            let delete = UIAlertAction(title: "Delete", style: .default, handler: { (alert: UIAlertAction!) -> Void in
                
                
                self.deleteCommentAPICall(tag: sender.tag)
                
                
            })
            
            
            actionSheet.addAction(edit)
            
            actionSheet.addAction(delete)
            
            
            let cancelAction = UIAlertAction(title: "Cancel".localize(), style: UIAlertActionStyle.cancel, handler: {
                (alert: UIAlertAction) -> Void in
            })
            actionSheet.addAction(cancelAction)
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
                
                self.present(actionSheet, animated: true, completion: nil)
            }
                
            else{
                
                let popup = UIPopoverController.init(contentViewController: actionSheet)
                
                popup.present(from: CGRect(x:self.view.frame.width/2, y:self.view.frame.maxY, width:0, height:0), in: self.view, permittedArrowDirections: UIPopoverArrowDirection.down, animated: true)
                
                
            }
            
    }
        
    }

 //MARK: -    delete Comment API Call
    
    func deleteCommentAPICall(tag : Int){
        
        
        if !(self.userID == 0) {
            
        Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Are You Sure Want To Delete".localize(), clickAction: {
            
        
        let deletePostID : Int  = self.commentingIdArray[tag]
        
        
        let postParams = [
            "id": deletePostID,
            "postId": self.postID,
            "userId": self.userID,
            "churchId": ""
            ] as [String : Any]
        
        print("dic params \(postParams)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        serviceController.postRequest(strURL: DELETECOMMETAPI as NSString, postParams: postParams as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            let responseVO : DeletePostCommentVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = responseVO.isSuccess
            
            if isSuccess == true {
                
                self.comentId = 0
                self.parentCommentId = 0
                
                self.getEventDetailsByIdApiCall()
                
                    }
            
            
            
                self.audioTableview.reloadData()
            
            
            
        }) { (failureMessage) in
            
            print(failureMessage)
            
        }
            
    
    })
    }
        
        else {
            
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Delete".localize(), clickAction: {
                
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                
                self.navigationController?.pushViewController(loginVC!, animated: true)
                
            })
            
        }
    
    
    }
    

    
//MARK: -    like Button Clicked
    
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
            
            // calling audioLikesDislikesCountAPiCall
            audioLikesDislikesCountAPiCall()
        }
            
        else {

            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Like".localize(), clickAction: {
                
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                
                self.navigationController?.pushViewController(loginVC!, animated: true)
                
            })
            
        }
        
        
    }
    
 //MARK: -    unlike Button Clicked
    
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
            // calling audioLikesDislikesCountAPiCall
            audioLikesDislikesCountAPiCall()
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Unlike".localize(), clickAction: {
                
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                self.navigationController?.pushViewController(loginVC!, animated: true)
                
            })
            
        }
        
    }
    
 //MARK: -    share Button Clicked
    
    func  shareButtonClick(_ sendre:UIButton) {
        
        if !(self.userID == 0) {
            
            let someText:String     = "Hello want to share text also"
            let objectsToShare:URL  = URL(string: "http://183.82.111.111/TeluguChurches/Web/")!
            let sharedObjects:[AnyObject] = [objectsToShare as AnyObject]
            let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view  
            activityViewController.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            
            self.present(activityViewController, animated: true, completion: nil)
            
            print("Share Clicked.............")
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Share".localize(), clickAction: {

                self.navigationController?.pushViewController(self.loginVC, animated: true)
            })
            
        }
    }
    
//MARK: -    comment Send Btn Clicked
    
    func commentSendBtnClicked(){
        
        self.sendCommentClick = false
        self.audioTableview.endEditing(true)
        print(self.commentString)

        if !(self.userID == 0) {
            
            self.comentId = self.comentId != 0 ? self.comentId : 0
            self.parentCommentId = self.parentCommentId != 0 ? self.parentCommentId : 0
         
            // calling commentSendBtnAPIService
            
            commentSendBtnAPIService(textComment: self.commentString)
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Add Comment".localize(), clickAction: {
                
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                self.navigationController?.pushViewController(loginVC!, animated: true)
                
            })
            
        }
        
        
    }
    
//MARK: -    reply Comment Btn Click
    
    func replyCommentBtnClick(sender : UIButton){
 
        popupview.isHidden = false
        secondview.isHidden = false
        textviewOutLet.text = "Add a public comment...".localize()
        textviewOutLet.textColor = UIColor.lightGray
        self.parentCommentId = self.commentingIdArray[sender.tag]
        
        self.comentId = 0
        
        if !(self.userID == 0) {
            let indexPath3 = IndexPath(item: 0, section: 2)
            self.audioTableview.scrollToRow(at: indexPath3, at: .top, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                if let commentsCell = self.audioTableview.cellForRow(at: indexPath3) as? CommentsCell {
  
                }
                
            })
            
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Reply".localize(), clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
    }
    
//MARK: -    view All Comment Btn Click
    
    func viewAllCommentBtnClick(sender : UIButton){
        
        if !(self.userID == 0) {
            
            var commentIdNum = 0
            let indexPath = IndexPath(item: sender.tag, section: 3)
            if let usersCommentsTableViewCell = audioTableview.cellForRow(at: indexPath) as? UsersCommentsTableViewCell {
                
                self.replyMainComment = self.usersCommentsArray[sender.tag] as! String
                self.replyMainCommentUser = self.commentedByUserArray[sender.tag] as! String

                  commentIdNum = self.commentingIdArray[sender.tag]
            }
            
            self.repliesCommentsUsernamesArray.removeAll()
            self.repliesCommentsArray.removeAll()
            
            
            if((replyDetails.count) > 0){
                
                for eachComment in replyDetails{
                    
                    if(commentIdNum == (eachComment.parentCommentId!)){
                        
                        if let comment = eachComment.comment{
                            
                            self.repliesCommentsArray.append(comment)
                        }
                        
                        if let commentByUser = eachComment.commentByUser{
                            self.repliesCommentsUsernamesArray.append(commentByUser)
                        }
                    }
                    
                    
                }
            }
            self.audioTableview.endEditing(true)
            self.repliesTableView.reloadData()

            self.audioTableview.endEditing(true)

            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {() -> Void in

         self.repliesTableView.frame = CGRect(x: 0, y: self.backGroundView.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - self.backGroundView.frame.size.height - 50)
                

            }, completion: {(_ finished: Bool) -> Void in
    
            })
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Reply".localize(), clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
    }
  
 //MARK: -  get  view All Comment API Call
    
    func getViewAllCommentsAPICall(tag : Int){
        
        self.commentId = self.parentCommentIdArray[tag]
        
        let getViewAllCommentsAPI = VIDEOVIEWALLCOMMENTSAPI + String(self.commentId)
        
        
        print(getViewAllCommentsAPI)
        
        serviceController.getRequest(strURL: getViewAllCommentsAPI, success: { (result) in
            
            print(result)
            
            let responseVO : ReplayCommentVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = responseVO.isSuccess
            
            if isSuccess == true {

                let resultArr = responseVO.listResult
                
                self.repliesCommentsArray.removeAll()
                self.repliesCommentsUsernamesArray.removeAll()
                
                for listResults in responseVO.listResult! {

                    if listResults.comment == nil {
                        
                        self.repliesCommentsArray.append(" ")
                        
                    }
                    else {
                        
                        self.repliesCommentsArray.append(listResults.comment!)
                    }
                    
                    if listResults.commentByUser == nil {
                        
                        self.repliesCommentsUsernamesArray.append(" ")
                        
                    }
                    else {
                        
                        self.repliesCommentsUsernamesArray.append(listResults.commentByUser!)
                    }
  
                }
                
                self.repliesCommentsArray.remove(at: 0)
                self.repliesCommentsUsernamesArray.remove(at: 0)

            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
        
        
    }
    
    
 //MARK: -    replies Close Btn Clicked
    
    
    func repliesCloseBtnClicked(){
        
        self.repliesTableView.endEditing(true)
        self.audioTableview.endEditing(true)

        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {() -> Void in
            
            self.repliesTableView.frame = CGRect(x: 0, y: self.audioTableview.frame.maxY, width: UIScreen.main.bounds.width, height: 0)
        
        }, completion: {(_ finished: Bool) -> Void in
            //position screen left after animation
        })
        
        
        
    }
    
 
//MARK: -    comment Send Btn API Service
    
    func commentSendBtnAPIService(textComment : String){
        
        let  EVENTCOMMENTSAPISTR = EVENTPOSTCOMMENTAPI
        
        let params = ["id": self.comentId,
                      "postId": postID,
                      "description": textComment,
                      "parentCommentId": self.parentCommentId,
                      "userId": self.userID
            
            
            ] as [String : Any]
        
        print("dic params \(params)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: EVENTCOMMENTSAPISTR as NSString, postParams: params as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in

            print("\(result)")
            
            let respVO:AddUpdateEventCommentsInfoVO = Mapper().map(JSONObject: result)!
            print("responseString = \(respVO)")
            
            
            let statusCode = respVO.isSuccess
            
            print("StatusCode:\(String(describing: statusCode))")
            
            if statusCode == true
            {
                
                let successMsg = respVO.endUserMessage
                
                let createdComment = respVO.result
                
                 self.commentString = "Add a public comment...".localize()
                 self.comentId = 0
                 self.parentCommentId = 0
                
                // Calling  getEventDetailsByIdApiCall
                self.getEventDetailsByIdApiCall()
                
            }
                
            else {
                
                let failMsg = respVO.endUserMessage
                
                return
   
            }
            
        }) { (failureMessage) in
            
            
            
        }
    }
    
 //MARK: -   audio Likes Dislikes Count APi Call
    
    func audioLikesDislikesCountAPiCall(){
        
        let  AUDIOLIKEDISLIKEAPISTR = LIKEANDDISLIKECOUNTAPI
        
        let params = [ "postId": postID,
                       "userId": self.userID ,
                       "like1": likeClick,
                       "disLike": disLikeClick
            
            ] as [String : Any]

        print("dic params \(params)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: AUDIOLIKEDISLIKEAPISTR as NSString, postParams: params as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            let responseVO:LikeandDislikeVo = Mapper().map(JSONObject: result)!
            
            let isSuccess = responseVO.isSuccess
            
            if isSuccess == true {
                
                self.likesCount = (responseVO.result?.likeCount)!
                self.disLikesCount = (responseVO.result?.dislikeCount)!
                
                if ((responseVO.result?.likeResult?.count)! > 0){
                    self.isLike = (responseVO.result?.likeResult?[0].like1)!
                    self.isDisLike = (responseVO.result?.likeResult?[0].disLike)!
              }
                let indexPath = IndexPath(row: 0, section: 0)
                self.audioTableview.reloadRows(at: [indexPath], with: .automatic)
                
            }
            
        }) { (failureMessage) in
            print(failureMessage)
            
        }
    }
   
    
//MARK: -  UITexview Delegate methods
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {

        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.text == "Add a public comment...".localize() {
            textView.text = ""
        }
        self.sendCommentClick = false
        textView.textColor = UIColor.black
  
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        textView.resignFirstResponder()
        self.commentString = textView.text
        if textView.text == "" {
            textView.text = "Add a public comment...".localize()
            textView.textColor = UIColor.lightGray
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView.tag == 2000 {
            
            let indexPath : IndexPath = IndexPath(row: 1, section: 0)
            
            if let commentsCell = self.repliesTableView.cellForRow(at: indexPath) as? CommentsCell {
                
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
    
        else {
            
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

    }

        
//MARK: -    Get Event Details By Id API Call
    
    func getEventDetailsByIdApiCall(){
        
        self.parentCommentIdArray.removeAll()
        self.commentingIdArray.removeAll()
        self.CommentsByUserArray.removeAll()
        self.replyCountArray.removeAll()
        self.usersCommentsArray.removeAll()
        self.loginUseridsArray.removeAll()

        let urlStr = LIKEDISLIKECOMMENTSAPI + "" + String(audioID) + "/" + String(self.userID)
        
        print("GETPOSTBYCATEGORYIDOFVIDEOSONGS -> ",urlStr)

        serviceController.getRequest(strURL: urlStr, success: { (result) in
            
            DispatchQueue.main.async(){
                 NSLog("end")
                print(result)
                
                let respVO:GetAllVideosVo = Mapper().map(JSONObject: result)!
                
                let isSuccess = respVO.isSuccess
                
                
                if isSuccess == true {
                    
                    
                    let resultArr = respVO.result?.commentDetails
                    
                    for id in (respVO.result?.commentDetails)! {

                        self.commentingIdArray.append(id.id!)
                        if let comment = id.commentByUser{
                            self.CommentsByUserArray.append(comment)
                        }else{
                            self.CommentsByUserArray.append("")
                        }
                       
                        self.replyCountArray.append(id.replyCount!)
                        self.eventID = (id.postId!)
                        self.deleteID = (id.id!)
                        self.loginUseridsArray.append(id.userId!)
                        
                    }

                    for list in resultArr! {
                        
                        if list.comment == nil {
                            self.usersCommentsArray.append(" ")
                        }
                        else {
                            self.usersCommentsArray.append(list.comment!)
                            self.commentedByUserArray.append(list.commentByUser ?? "")
                        }
                        if let comment = list.commentByUser{
                            self.CommentsByUserArray.append(comment)
                        }else{
                            self.CommentsByUserArray.append("")
                        }
                        
                    }

                    if (respVO.result?.commentDetails?.count)! > 0{
                        self.replyDetails = (respVO.result?.replyDetails!)!
   
                    }

                    self.likesCount    = (respVO.result?.postDetails![0].likeCount)!
                    self.disLikesCount = (respVO.result?.postDetails![0].disLikeCount)!
                    self.postID        = (respVO.result?.postDetails![0].id)!
                    self.isLike        = (respVO.result?.postDetails![0].isLike)!
                    self.isDisLike     = (respVO.result?.postDetails![0].isDisLike)!
                    self.viewCount     = (respVO.result?.postDetails![0].viewCount)!

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
                    
                else{
                    
                }
            }
  
        }) { (failureMessage) in
              print(failureMessage)
        }
  
    }

//MARK: - Cancel button action
    @IBAction func cancleAction(_ sender: Any) {

        popupview.isHidden = true
        secondview.isHidden = true
   
    }
    
//MARK: -  OK button action
    @IBAction func okAction(_ sender: Any) {
        
        self.audioTableview.endEditing(true)
        self.sendCommentClick    = false
        self.textviewOutLet.text = self.commentString
        popupview.isHidden       = true
        secondview.isHidden      = true
        
        if (self.commentString == "" || self.commentString == "Add a public comment...".localize()){
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Add Reply".localize(), clickAction: {

            })
            return
   
        }

        if !(self.userID == 0) {
            
            self.comentId = self.comentId != 0 ? self.comentId : 0
            self.parentCommentId = self.parentCommentId != 0 ? self.parentCommentId : 0
            
            // calling commentSendBtnAPIService
            commentSendBtnAPIService(textComment: self.commentString)
            
            self.textviewOutLet.text = ""
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Add Comment".localize(), clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
            
        }
        
        
    }

//MARK: -  Audio download button Action
    
    @IBAction func downloadBtn(_ sender: UIButton) {

        let urlString = audioIDArr.trimmingCharacters(in: .whitespacesAndNewlines)
            print("urlString",urlString)
        
        guard let url = URL(string: urlString) else { return
        }
       let validateUrl =  AVAsset(url: url).isPlayable
        print(validateUrl)
        
        if(validateUrl == true){
              startDownloading (audioUrl: urlString)
              downloadFileUI()
            
        }else{
            appDelegate.window?.makeToast(invalidUrlMessage, duration:kToastDuration, position:CSToastPositionBottom)
            print("invalid url")
        }

    }

//MARK: -  Download file api
    
    func downloadFileUI(){
        
        downloadBackGroundView.isHidden = false
        downloadingLabel.isHidden       = false
        progress.isHidden               = false
        downloadBackGroundView.layer.cornerRadius   = 3.0
        downloadBackGroundView.layer.shadowColor    = UIColor.lightGray.cgColor
        downloadBackGroundView.layer.shadowOffset   = CGSize(width: 0, height: 3)
        downloadBackGroundView.layer.shadowOpacity  = 0.6
        downloadBackGroundView.layer.shadowRadius   = 2.0
        
    }

    func startDownloading (audioUrl : String) {
        let url = URL(string: audioUrl)!
        
        downloadTask = defaultSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    func showFileWithPath(path: String){
        let isFileFound:Bool? = FileManager.default.fileExists(atPath: path)
        if isFileFound == true{
            let viewer = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
            viewer.delegate = self
            viewer.presentPreview(animated: true)
        }
        
    }
    

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {

        print(downloadTask)
        print("File download succesfully")

        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath.appendingFormat("/file.mp3"))
        if fileManager.fileExists(atPath: destinationURLForFile.path){
            downloadingLabel.isHidden = true
            progress.isHidden = true
            percentageLabe.text = "Download SuccessFull"
            print("path of download file",destinationURLForFile.path)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.downloadBackGroundView.isHidden = true
                self.percentageLabe.text = "%"
                self.progress.setProgress(0.0, animated: true)
                self.showFileWithPath(path: destinationURLForFile.path)
            }
  
        }
        else{
            do {
                try fileManager.moveItem(at: location, to: destinationURLForFile)
                // show file
                 showFileWithPath(path: destinationURLForFile.path)
            }catch{
                print("An error occurred while moving file to destination url")
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        progress.setProgress(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite), animated: true)
        //   let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite) * 100
        //  print(percentage)
        downloadingLabel.isHidden = false
        let perce = progress.progress * 100
        print("progress progress",sucessLabel)
        print("progressdasdasdasd",progress)
        let actualPerceArr = String(perce).components(separatedBy: ".")
        let actualPercentage    = actualPerceArr[0]
        let removePercentage = actualPerceArr[1]
        print("Total Percentage",actualPerceArr,actualPercentage,removePercentage)
        print(percentageLabe.text ?? "")
        percentageLabe.text = "\(actualPercentage) %"

    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        downloadTask = nil

        if (error != nil) {
            print("didCompleteWithError \(error?.localizedDescription ?? "no value")")
        }
        else {
            print("The task finished successfully")
        }
        
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController
    {
        return self
    }
    
    private func focusItemNumberTextField() {
        
        let indexPath = IndexPath.init(row: 0, section: 2)
        
        if let itemNumberCell = audioTableview.cellForRow(at: indexPath) as? CommentsCell {
            
            itemNumberCell.commentTexView.text = ""
        }
    }
  

}

extension AudioViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(AudioViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)

    }
}
