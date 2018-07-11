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
    
   @IBOutlet weak var repliesTableView: UITableView! 
    
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
   
    
    
    var  deleteID : Int = 0
    
    var thumbnailImageURL = String()
    
    var userID = 0
    
    
    var isLike = 0
    var isDisLike = 0
    var likeClick = false
    var disLikeClick = false
    var likesCount = 0
    var disLikesCount = 0
    var ID = 0
    var audioID = 0
    var categoryID = 0
    var sendCommentClick = false
    var usersCommentsArray = Array<Any>()
    
    var parentCommentId = 0
    var replyParentCommentId = 0
    
    var comentId = 0
    
    var commentString : String = "Add a public comment..."
    var activeLabel = UILabel()
     var loginVC = LoginViewController()
    
    var parentCommentIdArray = Array<Int>()
    var commentingIdArray = Array<Int>()
     var eventID = 0
     var activeLblNumberofLines : Int = 3
    
     var replyCountArray = Array<Any>()
    
     var commentId = 0
     var replyMainComment = ""
     var replyMainCommentUser = ""
    var repliesCommentsArray = Array<Any>()
    var repliesCommentsUsernamesArray = Array<Any>()
    
    var videoId : Int = 0
   var categoryId = Int()
   
     var postID : Int = 0
     var editUserID = 0
     var commentsCount = 0
    var readMoreBtnIsHidden = true

     var commentedByUserArray = Array<Any>()
      var CommentsByUserArray = Array<Any>()
    
     var eventsDetailsArray:[EventDetailsListResultVO] = Array<EventDetailsListResultVO>()
    
    let buttonnn = UIButton()
    
  //MARK: -  view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor(red: 103.0/255.0, green:  171.0/255.0, blue:  208.0/255.0, alpha: 1.0).cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0

        Utilities.audioEventViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: self.audioIDNameArr, backTitle: "   C", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
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

        
     //   repliesTableView.register(nibName3, forCellReuseIdentifier: "CommentsCell")
        
      
        
        repliesTableView.delegate = self
        repliesTableView.dataSource = self
        
       repliesTableView.tableFooterView = UIView(frame: .zero)
        
        audioTableview.dataSource = self
        audioTableview.delegate = self
        
        self.navigationController?.isNavigationBarHidden = true
     
        
       
        if kUserDefaults.value(forKey: kIdKey) as? Int != nil {
            
            self.userID = (kUserDefaults.value(forKey: kIdKey) as? Int )!
            
        }
        

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
   
        getEventDetailsByIdApiCall() 
        
        
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

    override func viewDidLayoutSubviews() {
        repliesTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Collectionview  DataSource & Delegate Methods
    
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
        
        else{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            
            return 200.0
        }
        else {
            
            return 100.0
            
            
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
                    usersCommentsTableViewCell.backgroundColor = #colorLiteral(red: 0.9475968553, green: 0.9569790024, blue: 0.9569790024, alpha: 1)
                    //  usersCommentsTableViewCell.replyCommentBtn.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                    return usersCommentsTableViewCell
                }
                    
                else {
                
                    
                
                        
//                        let commentsCell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
//                        
//                        commentsCell.commentTexView.delegate = self
//                        commentsCell.commentTexView.text = self.commentString
//                        commentsCell.commentTexView.tag = 2000
//                    //    activeTextView = commentsCell.commentTexView
//                        if sendCommentClick == false{
//                            
//                            commentsCell.sendBtn.isHidden = true
//                            
//                        }
//                            
//                        else{
//                            
//                            commentsCell.sendBtn.isHidden = false
//                            
//                            
//                        }
//                        
//                        
//                        return commentsCell
//                        
//                    
                    
                    
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
                return usersCommentsTableViewCell
            }
            
        }
        
        
        else{
            
            
         if indexPath.section == 0 {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "youtubeCLDSSCell", for: indexPath) as! youtubeCLDSSCell
        
            
            
            
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
            
            
       
            
            
        }
        
        if indexPath.section == 1 {
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "SubscribCell", for: indexPath) as! SubscribCell
            
            cell2.subscribnameLbl.text = "Channel Name"
            
            return cell2
            
            
        }

        
        if indexPath.section == 2 {
            
            let commentsCell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
            
            
            commentsCell.commentTexView.text = self.commentString
            commentsCell.commentCountLab.text = String(usersCommentsArray.count)
            commentsCell.commentTexView.delegate = self
            commentsCell.commentTexView.tag = 2001
            commentsCell.sendBtn.addTarget(self, action: #selector(commentSendBtnClicked),for: .touchUpInside)
            commentsCell.commentTWBtn.addTarget(self, action: #selector(commentTWBtnClicked),for: .touchUpInside)
            
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
            
            cell3.usersCommentLbl.text = usersCommentsArray[indexPath.row] as! String
            
            cell3.usersNameLbl.text = self.commentedByUserArray[indexPath.row] as? String
            
            cell3.viewCommentsBtn.isHidden = false
            cell3.replyCommentBtn.isHidden = false
          
            cell3.editCommentBn.tag = indexPath.row
        
            
            let commentString = usersCommentsArray[indexPath.row] as? String
            let commentedbyusername = commentedByUserArray[indexPath.row] as? String
            
            cell3.usersLikeCoubtLbl.text = String(commentingIdArray[indexPath.row])
            cell3.editCommentBn.tag = indexPath.row
            
            let commentLblHeight = Int((commentString?.height(withConstrainedWidth: cell3.usersCommentLbl.frame.size.width, font: UIFont(name: "HelveticaNeue", size: 14.0)!))!)
            
            let commentnameLblHeight = Int((commentedbyusername?.height(withConstrainedWidth: cell3.usersNameLbl.frame.size.width, font: UIFont(name: "HelveticaNeue", size: 14.0)!))!)
            

            
            
            if commentLblHeight  > 50  && activeLblNumberofLines == 3 {
                
                
                cell3.usersCommentLbl.numberOfLines = activeLblNumberofLines
//                cell3.readMoreBtn.isHidden = false
//                cell3.readMoreBtnHeight.constant = 15
//                readMoreBtnIsHidden = false
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
       //     cell3.replyCommentBtn.addTarget(self, action: #selector(replyCommentBtnClick), for: UIControlEvents.touchUpInside)
            
            
            cell3.viewCommentsBtn.addTarget(self, action: #selector(viewAllCommentBtnClick), for: UIControlEvents.touchUpInside)
            
            cell3.readMoreBtn.addTarget(self, action: #selector(readmoreClicked), for: .touchUpInside)
            cell3.editCommentBn.addTarget(self, action: #selector(editCommentBnClicked), for: .touchUpInside)
            
            
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
    
    
    
    
    func editCommentBnClicked(sender : UIButton){
        
       
        
        self.editUserID = self.commentingIdArray[sender.tag]
        
        self.parentCommentId = self.parentCommentIdArray[sender.tag]
        self.comentId = self.commentingIdArray[sender.tag]
        let userCommentString = self.usersCommentsArray[sender.tag] as! String
        
        //if self.userID  == self.editUserID {
            
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
            
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
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
            
            
       // }
            
      
        
    }

    
    func deleteCommentAPICall(tag : Int){
        
        let deletePostID : Int  = self.parentCommentIdArray[tag]
        
        
        let postParams = [
            "id": self.deleteID,
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
                self.getEventDetailsByIdApiCall()

                
               // self.getVideoDetailsApiService()
                
                    }
            
            
            
            self.audioTableview.reloadData()
            
            
            
        }) { (failureMessage) in
            
            
            
        }
        
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
            
            audioLikesDislikesCountAPiCall()
            
            
            
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
            
            audioLikesDislikesCountAPiCall()
            
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
        
        
        
    //    commentsCell.commentTexView.text = ""
        
        
        if !(self.userID == 0) {
            
            
            self.comentId = self.comentId != 0 ? self.comentId : 0
            self.parentCommentId = self.parentCommentId != 0 ? self.parentCommentId : 0
        
            commentSendBtnAPIService(textComment: self.commentString)
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Add Comment", clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
            
        }
        
        
    }
    
    func replyCommentBtnClick(sender : UIButton){
        
        if !(self.userID == 0) {
            
            self.getViewAllCommentsAPICall(tag: sender.tag)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.10, execute: {
                
            //    self.activeTextView.becomeFirstResponder()
                
            })
            
            self.audioTableview.endEditing(true)
            
            
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {() -> Void in
                
           
                self.repliesTableView.frame = CGRect(x: 0, y: self.backGroundView.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - self.backGroundView.frame.size.height - 50)
                

                
            }, completion: {(_ finished: Bool) -> Void in
                
            
            })
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Reply", clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
    }
    
    func viewAllCommentBtnClick(sender : UIButton){
        
        if !(self.userID == 0) {
            
            
            
            let indexPath = IndexPath(item: sender.tag, section: 3)
            
            if let usersCommentsTableViewCell = audioTableview.cellForRow(at: indexPath) as? UsersCommentsTableViewCell {
                
                self.replyMainComment = self.usersCommentsArray[sender.tag] as! String
                self.replyMainCommentUser = self.commentedByUserArray[sender.tag] as! String
                
                
            }
            
            
            self.audioTableview.endEditing(true)
            
            self.getViewAllCommentsAPICall(tag: sender.tag)
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {() -> Void in
                
          
                
        self.repliesTableView.frame = CGRect(x: 0, y: self.backGroundView.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - self.backGroundView.frame.size.height - 50)
                

            }, completion: {(_ finished: Bool) -> Void in

                self.repliesTableView.isScrollEnabled = true
                
                
            })
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Reply", clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
    }
  
    
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
                
                self.repliesTableView.reloadData()
                
            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
        
        
    }
    
    
    
    
    
    func repliesCloseBtnClicked(){
        
        self.repliesTableView.endEditing(true)
        self.audioTableview.endEditing(true)
        
        self.audioTableview.isScrollEnabled = true
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {() -> Void in
            
    self.repliesTableView.frame = CGRect(x: 0, y: self.audioTableview.frame.maxY, width: UIScreen.main.bounds.width, height: 0)
            
            
        }, completion: {(_ finished: Bool) -> Void in
            //position screen left after animation
        })
        
        
        
    }
    
    func getVideoDetailsApiService(){
        
        self.parentCommentIdArray.removeAll()
        self.commentingIdArray.removeAll()
        self.CommentsByUserArray.removeAll()
        self.replyCountArray.removeAll()
        self.usersCommentsArray.removeAll()
        
        self.audioTableview.isScrollEnabled = true
        self.repliesTableView.isScrollEnabled = true
        
        let urlStr = LIKEDISLIKECOMMENTSAPI + "" + String(self.videoId) + "/" + String(self.categoryId)
        
        print("GETPOSTBYCATEGORYIDOFVIDEOSONGS -> ",urlStr)
        
        serviceController.getRequest(strURL: urlStr, success: { (result) in
            
            DispatchQueue.main.async(){
                
                print(result)
                
                let respVO:GetAllVideosVo = Mapper().map(JSONObject: result)!
                
                let isSuccess = respVO.isSuccess
                
                
                if isSuccess == true {
                    
                    
                    let resultArr = respVO.result?.commentDetails
                    
                    for id in (respVO.result?.commentDetails)! {
                        
                        self.parentCommentIdArray.append(id.id!)
                        self.commentingIdArray.append(id.userId!)
                        self.CommentsByUserArray.append(id.commentByUser!)
                        self.replyCountArray.append(id.replyCount!)
                       
                    }
                    
                    
                    
                    for list in resultArr! {
                        
                        if list.comment == nil {
                            
                            self.usersCommentsArray.append(" ")
                            
                        }
                        else {
                            
                            self.usersCommentsArray.append(list.comment!)
                        }
                        
                        
                        
                    }
                    
                    for vv in self.usersCommentsArray {
                        
                        
                    }
                    
                    self.likesCount    = (respVO.result?.postDetails![0].likeCount)!
                    self.disLikesCount = (respVO.result?.postDetails![0].disLikeCount)!
                    self.postID  = (respVO.result?.postDetails![0].id)!
                   

                    self.isLike = (respVO.result?.postDetails![0].isLike)!
                    self.isDisLike = (respVO.result?.postDetails![0].isDisLike)!
                    
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
            
            
        }
        
        
    }
    
   
    
    
    
    
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
            
            print(result)
            
            print("\(result)")
            
            let respVO:AddUpdateEventCommentsInfoVO = Mapper().map(JSONObject: result)!
            print("responseString = \(respVO)")
            
            
            let statusCode = respVO.isSuccess
            
            print("StatusCode:\(String(describing: statusCode))")
            
            if statusCode == true
            {
                
                
                let successMsg = respVO.endUserMessage
                
                let createdComment = respVO.result
                 self.commentString = ""
                
               self.getEventDetailsByIdApiCall()
                       
                
            }
                
            else {
                
                let failMsg = respVO.endUserMessage
                
                
                return
                
                
                
            }
            
            
        }) { (failureMessage) in
            
            
            
        }
    }
    
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
            
            
            
        }
    }
   
    
    //MARK: -  UITexview Delegate methods
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        self.audioTableview.isScrollEnabled = false
        self.repliesTableView.isScrollEnabled = false

        
        if textView.text == "Add a public comment..." {
            
            textView.text = ""
            
        }
        
        self.sendCommentClick = false
        textView.textColor = UIColor.black
        
        
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        textView.resignFirstResponder()
        self.audioTableview.isScrollEnabled = true
        self.repliesTableView.isScrollEnabled = true
        self.commentString = textView.text
        
        if textView.text == "" {
            
            textView.text = "Add a public comment..."
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
        

        
        let urlStr = LIKEDISLIKECOMMENTSAPI + "" + String(audioID) + "/" + String(self.userID)
        
        print("GETPOSTBYCATEGORYIDOFVIDEOSONGS -> ",urlStr)
        NSLog("Started")
        
  
        
        serviceController.getRequest(strURL: urlStr, success: { (result) in
            
            DispatchQueue.main.async(){
                 NSLog("end")
                print(result)
                
                let respVO:GetAllVideosVo = Mapper().map(JSONObject: result)!
                
                let isSuccess = respVO.isSuccess
                
                
                if isSuccess == true {
                    
                    
                    let resultArr = respVO.result?.commentDetails
                    
                    for id in (respVO.result?.commentDetails)! {
                        
                        self.parentCommentIdArray.append(id.parentCommentId!)
                        self.commentingIdArray.append(id.id!)
                        if let comment = id.commentByUser{
                            self.CommentsByUserArray.append(comment)
                        }else{
                            self.CommentsByUserArray.append("")
                        }
                       
                        self.replyCountArray.append(id.replyCount!)
                        self.eventID = (id.postId!)
                         self.deleteID = (id.id!)
                        
                    }
                    
                    

                    for list in resultArr! {
                        
                        if list.comment == nil {
                            
                            self.usersCommentsArray.append(" ")
                          //  self.commentedByUserArray.append(" ")
                            
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
                    
                    for vv in self.usersCommentsArray {
                        
                       // self.activeLabel.text = vv as? String
                        
                    }
                    
                    self.likesCount    = (respVO.result?.postDetails![0].likeCount)!
                    self.disLikesCount = (respVO.result?.postDetails![0].disLikeCount)!
                    
                    self.postID  = (respVO.result?.postDetails![0].id)!
                    self.isLike = (respVO.result?.postDetails![0].isLike)!
                    self.isDisLike = (respVO.result?.postDetails![0].isDisLike)!

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
                    self.audioTableview.isScrollEnabled = true
                    //self.repliesTableView.isScrollEnabled = true
                    
                    
                    
                }
                    
                else{
                    
                    
                }
                
                
                
            }
            
            
            
        }) { (failureMessage) in
            
            
        }
        
        
    }
    
    private func focusItemNumberTextField() {
        
        let indexPath = IndexPath.init(row: 0, section: 2)
        
        if let itemNumberCell = audioTableview.cellForRow(at: indexPath) as? CommentsCell {
            
            itemNumberCell.commentTexView.text = ""
        }
    }

    
    
    
    

}

extension UIView {
    
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
        
        self.audioTableview.isScrollEnabled = true
        self.repliesTableView.isScrollEnabled = true
        view.endEditing(true)
        
        
    }
}
