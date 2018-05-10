//
//  YoutubePlayerViewController.swift
//  OffersScreen
//
//  Created by Mac OS on 21/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import IQKeyboardManagerSwift


class YoutubePlayerViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource,UIScrollViewDelegate,YTPlayerViewDelegate,UITextViewDelegate{

    var serviceController = ServiceController()
    @IBOutlet weak var allOffersTableView: UITableView!
    
    var loginVC = LoginViewController()
    
    @IBOutlet weak var repliesTableView: UITableView!
    var repliesCommentsArray = Array<Any>()
    var repliesCommentsUsernamesArray = Array<Any>()
    @IBOutlet weak var player: YTPlayerView!
    
    var allVideosArray : GetVideosResultVo?
    
    @IBOutlet weak var ytPlayerViewHeight: NSLayoutConstraint!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var skipButton: UIButton!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!

    @IBOutlet weak var loadingImg: UIImageView!
    
    @IBOutlet weak var categoryImgView: UIImageView!
    
    
    @IBOutlet weak var commentView: UIView!
    
    @IBOutlet weak var commentTW: UITextView!
    
    @IBOutlet weak var commentSendBtn: UIButton!
    
    var appVersion          : String = ""
    
    var videoImgStr:String = ""
    var imgData = Data()
    
    var showNav = false
    var videoNameStr = ""
    var categoryName = ""
    var categoryId = Int()
    var ID = Int()

    var commentString : String = "Add a public comment..."

    var isLike = 0
    var isDisLike = 0
    var likeClick = false
    var disLikeClick = false
    var likesCount = 0
    var disLikesCount = 0
    var sendCommentClick = false
    var activeTextView = UITextView()
    var usersLikeClick = false
    var UsersDisLikeClick = false
    var commentsCount = 0
    var replyCountArray = Array<Any>()
    var readMoreBtnIsHidden = true
    

   var replyMainComment = ""
   var replyMainCommentUser = ""
    
    var usersCommentsArray = Array<Any>()
    var CommentsByUserArray = Array<Any>()
    var postIDArray = Array<Any>()
   
    

    var embedLinksAry : [VideoSongsResultVo] = Array<VideoSongsResultVo>()
    var churchNameAry : Array<String> = Array()
    var splitArray : Array<String> = Array()
    var strrrr : Array<String> = Array()
    
    var videoIDArray : Array<String> = Array()
    
    var videoEmbededIDStr = String()
    
    var gggg = String()
    
    var userID = String()
    
    var editUserID = 0
    
   // var commentString = String()
    
    var thumbnailImageURL = String()
    let sectionTitleArray = ["","Comments"]
    let imageView = ["bible1","bible2","bible3","images.jpeg","7c26c4322705738c08d90691d32ff29b-brown-bible","bible9","bible8","bible7","bible6"]
    
    
    let imageView1 = ["bible6","bible7","bible8","bible9","images.jpeg","bible3","bible8","bible2","bible1"]
    
    var playerVars = Dictionary<String, Any>()
    var name = ["calvarychurch","calvarychurch1","calvarychurch","calvarychurch1","calvarychurch","calvarychurch1"]
    
    
    var kID: String = ""
    var postID : Int = 0
    var videoId : Int = 0
    
    var activeLabel = UILabel()
    var activeLblNumberofLines : Int = 3
    
    var parentCommentId = 0
    var replyParentCommentId = 0

    var parentCommentIdArray = Array<Int>()
    var commentingIdArray = Array<Int>()
    var commentId = 0
    
   
    let buttonnn = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.commentTW.delegate = self
        self.commentTW.text = self.commentString
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        categoryImgView.isUserInteractionEnabled = true
        categoryImgView.addGestureRecognizer(tapGestureRecognizer)
        

      
        if videoImgStr == "image" {
            
            player.isHidden = true
            
            categoryImgView.isHidden = false
            
            if !imgData.isEmpty {
                
                categoryImgView.image = UIImage(data: imgData)
                //            categoryImgView.frame = self.view.bounds
                categoryImgView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                categoryImgView.contentMode = .scaleToFill
//                            categoryImgView.isUserInteractionEnabled = true
                
            }
            else {
                
                categoryImgView.image = #imageLiteral(resourceName: "j4")
                
            }
            
            
        }
        else {
            
            player.isHidden = false
            
            categoryImgView.isHidden = true
        }
       
        
        hideKeyboard()
        
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        self.loginVC = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as!LoginViewController
        
        self.loginVC.showNav = true
        self.loginVC.navigationString = "navigationString"
        
        allOffersTableView.allowsSelection = false
        allOffersTableView.delegate = self
        allOffersTableView.dataSource = self
       // allOffersTableView.separatorStyle = .none
        
        repliesTableView.delegate = self
        repliesTableView.dataSource = self
       // repliesTableView.tableFooterView = UIView()
       repliesTableView.tableFooterView = UIView(frame: .zero)
       IQKeyboardManager.sharedManager().enableAutoToolbar = false
        
        activeLabel.numberOfLines = 0
        
//        if kUserDefaults.value(forKey: "usersCommentsArray") != nil{
//            
//            self.usersCommentsArray = kUserDefaults.value(forKey: "usersCommentsArray") as! Array<Any>
//
//        }
// 
//        
//        
//        kUserDefaults.synchronize()
        
        
        self.player.delegate = self
        
        playerVars = [
            "controls" : 1 ,
            "playsinline" : 1,
            "autoplay" : 1,
            //   "autohide" : 1,
            "rel" : 0,
            "showinfo" : 0,
            //    "showing" : 1,
            "color" : "white",
            "modestbranding" : 0
        ]
        
        //  self.loadingImg.image = UIImage(named: "Video")
        
        //        self.player.load(withVideoId: self.videosIDArray[0])
        //
        //        self.player.load(withPlayerParams: ["showinfo" : 3])
        
        
        //  self.player.load(withVideoId: self.embedLinksAry[0],playerVars: playerVars)
        
        
        // self.player.load(withPlaylistId: self.videosIDArray[0], playerVars: playerVars)
        
        //  self.player.load(withPlaylistId: self.videosIDArray[0], playerVars: playerVars)
        
        
        if let catID = UserDefaults.standard.value(forKey: "categoryId")  as? Int {
            
            self.categoryId = catID
        }
        
        
        if let vID = UserDefaults.standard.value(forKey: "videoID") as? Int  {
            
            self.videoId = vID
        }
        
//        if let videoEmbededID = UserDefaults.standard.value(forKey: "videoEmbededIDStr") as? String  {
//            
//            self.videoEmbededIDStr = videoEmbededID
//        }
        
        kUserDefaults.synchronize()
        
        registerTableViewCells()
        
        
        print(videoIDArray)
        
        if !videoEmbededIDStr.isEmpty {
            
            categoryImgView.isHidden = true
            
            player.isHidden = false
            
             self.player.load(withVideoId: videoEmbededIDStr,playerVars: self.playerVars)
            
        }
        else{
            
            categoryImgView.isHidden = false
            
            player.isHidden = true
            
            if !imgData.isEmpty {
                
                categoryImgView.image = UIImage(data: imgData)
                //            categoryImgView.frame = self.view.bounds
                categoryImgView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                categoryImgView.contentMode = .scaleToFill
                //            categoryImgView.isUserInteractionEnabled = true
                
            }
            else {
                
                categoryImgView.image = #imageLiteral(resourceName: "j4")
                
            }
        }
       
        
        
        self.allOffersTableView.reloadData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        if(UIDevice.current.userInterfaceIdiom == .phone){
        
        self.ytPlayerViewHeight.constant = 200
        }
        else{
            
        self.ytPlayerViewHeight.constant = 300
            
        }
        
        print(showNav)
        
     //   self.navigationController?.navigationBar.isHidden = false
        
        
        Utilities.setVideosViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: videoNameStr, backTitle: videoNameStr, rightImage: "home icon", secondRightImage: "Up", thirdRightImage: "Up")
        
        if kUserDefaults.value(forKey: kuserIdKey) as? String != nil {
            
            self.userID = (kUserDefaults.value(forKey: kuserIdKey) as? String)!
            
        }
        
        if kUserDefaults.value(forKey: kIdKey) as? Int != nil {
            
            self.ID = (kUserDefaults.value(forKey: kIdKey) as? Int )!
            
        }
       
        self.getVideoDetailsApiService()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
       IQKeyboardManager.sharedManager().enableAutoToolbar = true
       self.player.stopVideo()
        
    }
    
    override func viewDidLayoutSubviews() {
        repliesTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    //MARK: - Add image to Library
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save Error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your Altered Image Has Been Saved To Your Photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
   
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
//        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if !imgData.isEmpty {
            
            let imageView: UIImage = UIImage(data: imgData)!
            
            UIImageWriteToSavedPhotosAlbum(imageView, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
       
        // Your action
    }
    
    func getVideosAPICall(){
        
        let videoSongsID : Int = 8
        
        let urlStr = GETPOSTBYCATEGORYIDOFVIDEOSONGS + "" + "\(videoSongsID)"
        
        print("GETPOSTBYCATEGORYIDOFVIDEOSONGS",urlStr)
        
        serviceController.getRequest(strURL: urlStr, success: { (result) in
            
            DispatchQueue.main.async()
                {
                    
                    
                    
                    print(result)
                    
                    let respVO:VideoSongsVo = Mapper().map(JSONObject: result)!
                    
                    //  if result.count > 0 {
                    
                    
                    print(result)
                    
                    // let respVO:VideoSongsVo = Mapper().map(JSONObject: result)!
                    
                    
                    let isSuccess = respVO.isSuccess
                    if isSuccess == true {
                        
                        
                        //  let authorDetails = respVO.listResult!
                        
                        for authorDetails in respVO.listResult!{
                            
                            self.embedLinksAry.append(authorDetails)
                        }
                        
                        self.allOffersTableView.reloadData()
                        // print(self.authorDetailsArray)
                        
                    }
                        
                    else{
                        
                        
                    }
                    
                    
                    //  }
            }
            
            
            
        }) { (failureMessage) in
            
            
            
            
        }
        
        
    }
    
    private func registerTableViewCells() {

        
        let nibName1  = UINib(nibName: "youtubeCLDSSCell" , bundle: nil)
        allOffersTableView.register(nibName1, forCellReuseIdentifier: "youtubeCLDSSCell")
        
        
        let nibName2  = UINib(nibName: "SubscribCell" , bundle: nil)
        allOffersTableView.register(nibName2, forCellReuseIdentifier: "SubscribCell")
        
        let nibName3  = UINib(nibName: "CommentsCell" , bundle: nil)
        allOffersTableView.register(nibName3, forCellReuseIdentifier: "CommentsCell")
        
        let usersCommentsTableViewCell  = UINib(nibName: "UsersCommentsTableViewCell" , bundle: nil)
        allOffersTableView.register(usersCommentsTableViewCell, forCellReuseIdentifier: "UsersCommentsTableViewCell")
        

        let nib = UINib(nibName: "AllRepliesHeaderTVCell", bundle: nil)
        repliesTableView.register(nib, forCellReuseIdentifier: "AllRepliesHeaderTVCell")
        
       // let nibName3  = UINib(nibName: "CommentsCell" , bundle: nil)
        repliesTableView.register(nibName3, forCellReuseIdentifier: "CommentsCell")
        
       // let usersCommentsTableViewCell  = UINib(nibName: "UsersCommentsTableViewCell" , bundle: nil)
        repliesTableView.register(usersCommentsTableViewCell, forCellReuseIdentifier: "UsersCommentsTableViewCell")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == repliesTableView {
            
        return 2
            
        }
        
        else {
        
        return 4
            
        }
            
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
       if tableView == repliesTableView{
        
        if section == 0 {
        
            return 2
        }
        
        else {
        
           return self.repliesCommentsArray.count
        }
        
        }
        
       else {
        if section == 3 {
            
            return usersCommentsArray.count
        }
       
         else  {
            
        return 1
            
        }
    }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
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
        
        if tableView == repliesTableView {
            
            if indexPath.section == 0 {
            
                if indexPath.row == 0{
                
                let usersCommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersCommentsTableViewCell", for: indexPath) as! UsersCommentsTableViewCell
                    
               usersCommentsTableViewCell.viewCommentsBtn.isHidden = true
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
                
                  let commentsCell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
                    
                    commentsCell.commentTexView.delegate = self
                    commentsCell.commentTexView.text = self.commentString
                    commentsCell.commentTexView.tag = 2000
                    activeTextView = commentsCell.commentTexView
                    if sendCommentClick == false{
                        
                        commentsCell.sendBtn.isHidden = true
                        
                    }
                        
                    else{
                        
                        commentsCell.sendBtn.isHidden = false
                        
                        
                    }
                 
                    
                    return commentsCell
                
                }
            
            }
            
            else {
            
            let usersCommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersCommentsTableViewCell", for: indexPath) as! UsersCommentsTableViewCell
           
                usersCommentsTableViewCell.usersCommentLbl.text = self.repliesCommentsArray[indexPath.row] as? String
                usersCommentsTableViewCell.usersNameLbl.text = self.repliesCommentsUsernamesArray[indexPath.row] as? String
                usersCommentsTableViewCell.viewCommentsBtn.isHidden = true
                usersCommentsTableViewCell.replyCommentBtn.isHidden = true
                usersCommentsTableViewCell.editCommentBn.isHidden = true
                usersCommentsTableViewCell.usersLikeBtn.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                usersCommentsTableViewCell.usersDislikeBtn.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                return usersCommentsTableViewCell
            }
            
        }
            
        else {
            
        if indexPath.section == 0 {
            
           
            let youtubeCLDSSCell = tableView.dequeueReusableCell(withIdentifier: "youtubeCLDSSCell", for: indexPath) as! youtubeCLDSSCell
            
            if likeClick == true{
                
            youtubeCLDSSCell.likeButton.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
           
                
            }
            else {
                
            youtubeCLDSSCell.likeButton.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            
            
            }
            
            
            if disLikeClick == true{
                
                youtubeCLDSSCell.unlikeButton.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
               
                
            }
                
            else {

                youtubeCLDSSCell.unlikeButton.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                
            }
            
            
           
            youtubeCLDSSCell.videoTitleName.text = videoNameStr
            youtubeCLDSSCell.likeCountLbl.text = String(likesCount)
            youtubeCLDSSCell.disLikeCountLbl.text = String(disLikesCount)
            
            youtubeCLDSSCell.likeButton.addTarget(self, action: #selector(likeButtonClick(_:)), for: UIControlEvents.touchUpInside)
            youtubeCLDSSCell.unlikeButton.addTarget(self, action: #selector(unLikeButtonClick(_:)), for: UIControlEvents.touchUpInside)
            youtubeCLDSSCell.shareButton.addTarget(self, action: #selector(shareButtonClick(_:)), for: UIControlEvents.touchUpInside)

            return youtubeCLDSSCell

        }
        
        if indexPath.section == 1 {
            
            let subscribCell = tableView.dequeueReusableCell(withIdentifier: "SubscribCell", for: indexPath) as! SubscribCell
            
            
            subscribCell.subscribnameLbl.text = "Channel Name"
            
            return subscribCell
            
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
            
            let usersCommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersCommentsTableViewCell", for: indexPath) as! UsersCommentsTableViewCell
            
          // self.parentCommentId = self.parentCommentIdArray[indexPath.row]
         //  self.replyParentCommentId = self.parentCommentIdArray[indexPath.row]
            
           
           usersCommentsTableViewCell.usersNameLbl.text = self.CommentsByUserArray[indexPath.row] as? String
            
            let commentString = usersCommentsArray[indexPath.row] as? String
            
            usersCommentsTableViewCell.usersLikeCoubtLbl.text = String(commentingIdArray[indexPath.row])
            usersCommentsTableViewCell.editCommentBn.tag = indexPath.row
            
            let commentLblHeight = Int((commentString?.height(withConstrainedWidth: usersCommentsTableViewCell.usersCommentLbl.frame.size.width, font: UIFont(name: "HelveticaNeue", size: 14.0)!))!)
            
//            if repliesCommentsArray.count > 0{
//            
//           // usersCommentsTableViewCell.viewCommentsBtnHeight.constant = 0
//            usersCommentsTableViewCell.viewCommentsBtn.isHidden = false
//                
//            }
//            else {
//            
//                usersCommentsTableViewCell.viewCommentsBtnHeight.constant = 0
//                usersCommentsTableViewCell.viewCommentsBtn.isHidden = true
//            }
            
            print(commentLblHeight)
            
            if commentLblHeight  > 50  && activeLblNumberofLines == 3 {
            
            
                 usersCommentsTableViewCell.usersCommentLbl.numberOfLines = activeLblNumberofLines
                 usersCommentsTableViewCell.readMoreBtn.isHidden = false
                 usersCommentsTableViewCell.readMoreBtnHeight.constant = 15
                 readMoreBtnIsHidden = false
            }
            
            else {
                
                 usersCommentsTableViewCell.usersCommentLbl.numberOfLines = activeLblNumberofLines
                 usersCommentsTableViewCell.readMoreBtn.isHidden = true
                 usersCommentsTableViewCell.readMoreBtnHeight.constant = 0
                 readMoreBtnIsHidden = true
            }
            
            print(activeLabel.numberOfLines)
            
            usersCommentsTableViewCell.usersCommentLbl.text = commentString
           // usersCommentsTableViewCell.usersCommentLbl.text = self.activeLabel.text
            print(usersCommentsTableViewCell.usersCommentLbl.numberOfLines)
            
          //  usersCommentsTableViewCell.usersCommentLbl = activeLabel
            
            
            let replyCount : Int = replyCountArray[indexPath.row] as! Int
            
          //  usersCommentsTableViewCell.replyCommentBtn.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            
            usersCommentsTableViewCell.usersLikeBtn.tag = indexPath.row
            
            usersCommentsTableViewCell.usersDislikeBtn.tag = indexPath.row
            
            usersCommentsTableViewCell.readMoreBtn.tag = indexPath.row
            usersCommentsTableViewCell.viewCommentsBtn.tag = indexPath.row
            usersCommentsTableViewCell.replyCommentBtn.tag = indexPath.row
            
            usersCommentsTableViewCell.replayCountLbl.text = String(replyCount)
            
            if usersLikeClick == true{
                
                usersCommentsTableViewCell.usersLikeBtn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            }
            else {
                
                usersCommentsTableViewCell.usersLikeBtn.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
            
            
            if UsersDisLikeClick == true {
                
                usersCommentsTableViewCell.usersDislikeBtn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    
            }
            else {
                
                usersCommentsTableViewCell.usersDislikeBtn.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
            
            if replyCount > 0{
                
            usersCommentsTableViewCell.viewCommentsBtn.isHidden = false
            usersCommentsTableViewCell.replayCountLbl.text = String(replyCount)
            }
                
            else{
            
            usersCommentsTableViewCell.viewCommentsBtn.isHidden = true
            usersCommentsTableViewCell.replayCountLbl.text = ""
            }
            
        usersCommentsTableViewCell.usersLikeBtn.addTarget(self, action: #selector(usersLikeBtnClick), for: UIControlEvents.touchUpInside)
        usersCommentsTableViewCell.usersDislikeBtn.addTarget(self, action: #selector(usersDislikeBtnClick), for: UIControlEvents.touchUpInside)
        usersCommentsTableViewCell.replyCommentBtn.addTarget(self, action: #selector(replyCommentBtnClick), for: UIControlEvents.touchUpInside)
            
        usersCommentsTableViewCell.viewCommentsBtn.addTarget(self, action: #selector(viewAllCommentBtnClick), for: UIControlEvents.touchUpInside)
            
        usersCommentsTableViewCell.readMoreBtn.addTarget(self, action: #selector(readmoreClicked), for: .touchUpInside)
        usersCommentsTableViewCell.editCommentBn.addTarget(self, action: #selector(editCommentBnClicked), for: .touchUpInside)
            
        
            //usersCommentsTableViewCell.viewCommentsBtn.isHidden = false
            usersCommentsTableViewCell.replyCommentBtn.isHidden = false
           
           
            return usersCommentsTableViewCell
            
            
            
            
        }
        
        
         return UITableViewCell()
        
    }
    
     //   return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
//        if readMoreBtnIsHidden == true {
//        
//            activeLblNumberofLines = 0
//        }
//        
//        else {
//        
//        activeLblNumberofLines = 3
//        }
        if tableView == repliesTableView {
            
            
        }
            
        else {
        activeLblNumberofLines = 3
      }
  
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        
        // self.loadingImg.image = UIImage(named: "video")
        
        player.playVideo()
        
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .buffering:
            fallthrough
        case .playing: break
        //     hidePoster()
        case .ended:
            fallthrough
        case .paused: break
        //     showPoster()
        default:
            ()
        }
    }
    
    internal func updateTimer(){
        //
    }
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        
        
       return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        self.allOffersTableView.isScrollEnabled = false
        self.repliesTableView.isScrollEnabled = false
        
        if textView.text == "Add a public comment..." {
            
            textView.text = ""
            
        }
        
        self.sendCommentClick = false
        textView.textColor = UIColor.black
//        self.allOffersTableView.reloadSections(IndexSet(integersIn: 2...2), with: UITableViewRowAnimation.none)

        
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
            
//        if textView.tag == 2001 {
//            
////            let indexPath : IndexPath = IndexPath(row: 1, section: 0)
////            
////            if let commentsCell = self.repliesTableView.cellForRow(at: indexPath) as? CommentsCell {
////                
////                let newString = (textView.text! as NSString).replacingCharacters(in: range, with: text)
////                
////                print(commentsCell.commentTexView.text.characters.count)
////                
////                self.commentString = commentsCell.commentTexView.text
////                
////                if (newString.characters.count) > 0  {
////                    
////                    
////                    
////                    print(self.commentString)
////                    
////                    commentsCell.sendBtn.isHidden = false
////                    
////                }
////                    
////                else{
////                    
////                    commentsCell.sendBtn.isHidden = true
////                    
////                }
////            }
//            
//            let newString = (textView.text! as NSString).replacingCharacters(in: range, with: text)
//            
//            self.commentString = self.commentTW.text
//            
//            if (newString.characters.count) > 0  {
//                
//                
//                
//                                    print(self.commentString)
//                
//                                    self.commentSendBtn.isHidden = false
//                
//                                }
//                
//                                else{
//                                    
//                                    self.commentSendBtn.isHidden = true
//                                    
//                                }
//        
//            return true
//            
//        }
        
        else {
            
        let indexPath : IndexPath = IndexPath(row: 0, section: 2)
        
        if let commentsCell = self.allOffersTableView.cellForRow(at: indexPath) as? CommentsCell {
            
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
        
       // return true
    }
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        
        

        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
                
        self.navigationController?.popViewController(animated: true)
        
        
        print("Back Button Clicked......")
        
        
    }
    
    
    
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
    


    
func  likeButtonClick(_ sendre:UIButton) {
        
    if !(self.userID.isEmpty) {
            
        if likeClick == false {
        
        likeClick = true
        disLikeClick = false
        
            
        }
        
        else{
            
        likeClick = false
        disLikeClick = false
    
        
        }
        
        clickLikesDislikesCommentsCountsAPICAll()
        
        
        
        }
        
        else {
        
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Like", clickAction: {

              self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        
        }
            
            
    }
    
func  unLikeButtonClick(_ sendre:UIButton) {
        
    if !(self.userID.isEmpty) {
        
        if disLikeClick == false {
            
            disLikeClick = true
            likeClick = false
 
        }
            
        else{
            disLikeClick = false
            likeClick = false
          
            
        }
        
        print("UnLike Clicked.............")
        
        clickLikesDislikesCommentsCountsAPICAll()
        
    }
        
    else {
    
        Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Unlike", clickAction: {
            
            self.navigationController?.pushViewController(self.loginVC, animated: true)
            
        })
    
    }
    
    }
    
    func  shareButtonClick(_ sendre:UIButton) {
        
        if !(self.userID.isEmpty) {
            
        let someText:String = "Hello want to share text also"
        let objectsToShare:URL = URL(string: "http://www.google.com")!
        let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
//        activityViewController.excludedActivityTypes = [UIActivityType.airDrop,        UIActivityType.postToFacebook,UIActivityType.postToTwitter,UIActivityType.mail]
        
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
        
    
    
    func commentSendBtnClicked() {
     
    self.sendCommentClick = false
    
     self.allOffersTableView.endEditing(true)
    
    print(self.commentString)
    
        
        
   // self.usersCommentsArray.append(self.commentString)
        
    if !(self.userID.isEmpty) {
        
        
       self.parentCommentId = 0
        
    commentSendBtnAPIService(textComment: self.commentString)
    
        }
        
    else {
        
        Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Add Comment", clickAction: {
            
            self.navigationController?.pushViewController(self.loginVC, animated: true)
            
        })
        
        }

        
    }
    
    
    func commentTWBtnClicked(){

//    self.commentTW.becomeFirstResponder()
    
    
    }
    
    
    @IBAction func commentSendBtnAction(_ sender: Any) {
        
  
        
        
    }
    
    // MARK :- CommentAPIService
    
    func commentSendBtnAPIService(textComment : String){


        
        let  strUrl = ADDUPDATECOMMENTAPI
        
        
        let dictParams = [
            "id": 1,
            "postId": self.postID,
            "description": textComment,
            "parentCommentId": self.parentCommentId,
            "userId" : self.ID
             ] as [String : Any]
        
        print("dic params \(dictParams)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        print("dictHeader:\(dictHeaders)")

        
        serviceController.postRequest(strURL: strUrl as NSString, postParams: dictParams as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
            
            DispatchQueue.main.async()
                {
  
                    print("\(result)")
                    
                    let respVO:AddUpdateCommentsVo = Mapper().map(JSONObject: result)!
                    print("responseString = \(respVO)")
                    
                    
                    let statusCode = respVO.isSuccess
                    
                    print("StatusCode:\(String(describing: statusCode))")
                    
                    if statusCode == true
                    {
                        
                        
                        let successMsg = respVO.endUserMessage
                        
                        print(respVO.result)
                        
                        self.usersCommentsArray.insert(self.commentString, at: 0)
                        self.commentString = "Add a public comment..."
                        self.allOffersTableView.reloadSections(IndexSet(integersIn: 2...3), with: UITableViewRowAnimation.top)
                        
                        
                        
                        
                        //                        self.utillites.alertWithOkButtonAction(vc: self, alertTitle: "Success".localize(), messege: successMsg!, clickAction: {
                        //
                        //
                        //                            self.removeAnimate()
                        //
                        //
                        //
                        //                        })
                        
                        
                    }
                        
                    else {
                        
                        let failMsg = respVO.endUserMessage
                        
                        //   self.showAlertViewWithTitle("Alert".localize(), message: failMsg!, buttonTitle: "Ok".localize())
                        
                        return
                        
                    }
                    
                   // self.allOffersTableView.reloadData()

                    
            }
        }, failureHandler: {(error) in
            
        })
        
        
    }
   
    
    func usersLikeBtnClick(sender : UIButton){
    
        if !(self.userID.isEmpty) {
            
        if usersLikeClick == false {
            
            usersLikeClick = true
            UsersDisLikeClick = false
            
            
        }
            
        else{
            
            usersLikeClick = false
            UsersDisLikeClick = false
            
            
        }
        
        
        
        let indexPath = IndexPath(item: sender.tag, section: 3)
        self.allOffersTableView.reloadRows(at: [indexPath], with: .automatic)
    
    }
        else {
        
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Like", clickAction: {
                
               self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
        
        
    }
    
    func usersDislikeBtnClick(sender : UIButton){
    
       if !(self.userID.isEmpty) {
        
        if UsersDisLikeClick == false {
            
            UsersDisLikeClick = true
            usersLikeClick = false
            
        }
            
        else{
            UsersDisLikeClick = false
            usersLikeClick = false
            
            
        }
        
        print("UnLike Clicked.............")
        
        let indexPath = IndexPath(item: sender.tag, section: 3)
        self.allOffersTableView.reloadRows(at: [indexPath], with: .automatic)
    
    }
        
       else {
        
        Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Unlike", clickAction: {
            
            self.navigationController?.pushViewController(self.loginVC, animated: true)
            
        })
        }
    }
    
    func readmoreClicked(sender : UIButton){
        
       
            readMoreBtnIsHidden = false
            activeLblNumberofLines = 0
        
            let indexPath = IndexPath(item: sender.tag, section: 3)
            self.allOffersTableView.reloadRows(at: [indexPath], with: .automatic)
        
        
    }
    
    
    func replyCommentBtnClick(sender : UIButton){
    
        if !(self.userID.isEmpty) {

           self.getViewAllCommentsAPICall(tag: sender.tag)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.10, execute: {
                
               self.activeTextView.becomeFirstResponder()
                
            })
            
        self.allOffersTableView.endEditing(true)
            
        
            
         UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {() -> Void in
            
            self.repliesTableView.frame = CGRect(x: 0, y: self.player.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - self.player.frame.size.height - 50)
              
            
            
            }, completion: {(_ finished: Bool) -> Void in
                //position screen left after animation
               // self.repliesTableView.isScrollEnabled = false
                
            })
            
        }
        
        else {
        
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Reply", clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
    }
    
    func viewAllCommentBtnClick(sender : UIButton){
        
        if !(self.userID.isEmpty) {
            
            
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.10, execute: {
//                
//                self.activeTextView.becomeFirstResponder()
//                
//            })
            let indexPath = IndexPath(item: sender.tag, section: 3)
            
            if let usersCommentsTableViewCell = allOffersTableView.cellForRow(at: indexPath) as? UsersCommentsTableViewCell {
                
                self.replyMainComment = self.usersCommentsArray[sender.tag] as! String
                self.replyMainCommentUser = self.CommentsByUserArray[sender.tag] as! String
                
            }
            
            
            self.allOffersTableView.endEditing(true)
            
           self.getViewAllCommentsAPICall(tag: sender.tag)
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {() -> Void in
                
                self.repliesTableView.frame = CGRect(x: 0, y: self.player.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - self.player.frame.size.height - 50)
                
                
                
            }, completion: {(_ finished: Bool) -> Void in
                //position screen left after animation
                self.repliesTableView.isScrollEnabled = true
                
            })
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Reply", clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
    }

    
    func repliesCloseBtnClicked(){
        
       self.repliesTableView.endEditing(true)
       self.allOffersTableView.endEditing(true)
     
        self.allOffersTableView.isScrollEnabled = true
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {() -> Void in
            
            self.repliesTableView.frame = CGRect(x: 0, y: self.allOffersTableView.frame.maxY, width: UIScreen.main.bounds.width, height: 0)
            
            
        }, completion: {(_ finished: Bool) -> Void in
            //position screen left after animation
        })
        
        
        
    }
    
    func clickLikesDislikesCommentsCountsAPICAll(){
        
        
        let  LIKEANDDISLIKECOUNTAPISTR = LIKEANDDISLIKECOUNTAPI
        
        let params = [ "postId": self.postID,
                       "userId": self.ID,
                       "like1": likeClick,
                       "disLike": disLikeClick   ] as [String : Any]
        
        print("dic params \(params)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: LIKEANDDISLIKECOUNTAPISTR as NSString , postParams: params as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            
            print(result)
            
            
            let responseVO:LikeDislikeVO = Mapper().map(JSONObject: result)!

            let isSuccess = responseVO.isSuccess
            
            if isSuccess == true {
                
                self.likesCount = (responseVO.result?.likeCount)!
                self.disLikesCount = (responseVO.result?.dislikeCount)!
                
                let indexPath = IndexPath(item: 0, section: 0)
                self.allOffersTableView.reloadRows(at: [indexPath], with: .automatic)
                
            }
            
            
            
        }) { (failureMessage) in
            
            
            
        }
        
        
    }
    
    
    func editCommentBnClicked(sender : UIButton){
        
//        let indexPath = IndexPath(item: sender.tag, section: 3)
//        
//        if let usersCommentsTableViewCell = allOffersTableView.cellForRow(at: indexPath) as? UsersCommentsTableViewCell {
// 
//            self.editUserID = Int(usersCommentsTableViewCell.usersLikeCoubtLbl.text!)!
//   
//        }
        
        self.editUserID = self.commentingIdArray[sender.tag]
        
        
        
        if self.ID == self.editUserID {
        
        let actionSheet = UIAlertController(title: nil, message: "Select", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let edit = UIAlertAction(title: "Edit", style: .default, handler: { (alert: UIAlertAction!) -> Void in
                
   
                let indexPath3 = IndexPath(item: 0, section: 2)
                
                
                self.allOffersTableView.scrollToRow(at: indexPath3, at: .top, animated: true)
                
                if let commentsCell = self.allOffersTableView.cellForRow(at: indexPath3) as? CommentsCell {
 
                    commentsCell.commentTexView.text = self.usersCommentsArray[sender.tag] as! String
                    commentsCell.commentTexView.becomeFirstResponder()
                }
   
                
            })
            
            let delete = UIAlertAction(title: "Delete", style: .default, handler: { (alert: UIAlertAction!) -> Void in
                
                
                
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

        
        }
        
        else {
         
        
        }
  
    }
    
    func getVideoDetailsApiService(){

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
                           

                           // self.CommentsByUserArray.append(list.commentByUser!)
                            
                        }
              
                        for vv in self.usersCommentsArray {
                        
                        self.activeLabel.text = vv as? String
                            
                        }
                        
                        self.likesCount    = (respVO.result?.postDetails![0].likeCount)!
                        self.disLikesCount = (respVO.result?.postDetails![0].disLikeCount)!
                        self.postID  = (respVO.result?.postDetails![0].id)!
                        self.isLike = (respVO.result?.postDetails![0].isLike)!
                        self.isDisLike = (respVO.result?.postDetails![0].isDisLike)!
                       // self.commentsCount = (respVO.result?.postDetails![0].commentCount)!
                       // self.videoId = (respVO.result?.postDetails![0].id)!
         
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
                        
                        self.allOffersTableView.reloadData()
                        
                        
                        
                        
                    }
                        
                    else{
                        
                        
                    }
                    
                    
                    //  }
            }
            
            
            
        }) { (failureMessage) in
            
            
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
                
                
              //  let resultArr = responseVO.listResult
                
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
                    
                    
                        // self.CommentsByUserArray.append(list.commentByUser!)
                    
                    
                  
                
                }
                
                self.repliesCommentsArray.remove(at: 0)
                self.repliesCommentsUsernamesArray.remove(at: 0)
                
                self.repliesTableView.reloadData()
                
            }
            
        }) { (failureMessage) in
            
            
           print(failureMessage)
            
        }
    
    
    }

    
    @IBAction func replySendBtnClicked(_ sender: Any) {
        
       
        self.parentCommentId = self.replyParentCommentId
   //     commentSendBtnAPIService(textComment: self.replyCommentTW.text)
        
        
    }
   
    
    
}

extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: frame.size.width, height: width)
        border.superlayer?.cornerRadius = 15
        self.layer.addSublayer(border)
    }
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addTopBorderWithClr(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
}

extension YoutubePlayerViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(YoutubePlayerViewController.dismissKeyboard))
       
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        
        self.allOffersTableView.isScrollEnabled = true
        self.repliesTableView.isScrollEnabled = true
        view.endEditing(true)
        
        
    }
}
