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
import SDWebImage


class YoutubePlayerViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource,UIScrollViewDelegate,YTPlayerViewDelegate,UITextViewDelegate{

    @IBOutlet weak var allOffersTableView   : UITableView!
    @IBOutlet weak var repliesTableView     : UITableView!
    @IBOutlet weak var player               : YTPlayerView!
    @IBOutlet weak var ytPlayerViewHeight   : NSLayoutConstraint!
    @IBOutlet var       scrollView          : UIScrollView!
    @IBOutlet var       textView            : UITextView!
    @IBOutlet var       pageControl         : UIPageControl!
    @IBOutlet var       skipButton          : UIButton!
    @IBOutlet weak var heightConstraint     : NSLayoutConstraint!
    @IBOutlet weak var topConstraint        : NSLayoutConstraint!
    @IBOutlet weak var loadingImg           : UIImageView!
    @IBOutlet weak var categoryImgView      : UIImageView!
    @IBOutlet weak var commentView          : UIView!
    @IBOutlet weak var commentTW            : UITextView!
    @IBOutlet weak var commentSendBtn       : UIButton!
    @IBOutlet weak var secondview           : UIView!
    @IBOutlet weak var popupview            : UIView!
    @IBOutlet weak var okBtnOutLet          : UIButton!
    @IBOutlet weak var canclebtnOutLet      : UIButton!
    @IBOutlet weak var textviewOutLet       : UITextView!

    
    
    var serviceController    = ServiceController()
    var loginVC              = LoginViewController()
    var allVideosArray       : GetVideosResultVo?
    var embedLinksAry        : [VideoSongsResultVo] = Array<VideoSongsResultVo>()
    var replyDetails         = [CommentDetailsVo]()
    var audioIDArr     = ""
    var audioIDNameArr = ""
    var NameArr        = ""
    var appVersion     = ""
    var videoImgStr    = ""
    var imageData      = ""
    var videoNameStr   = ""
    var categoryName   = ""
    var replyMainComment = ""
    var replyMainCommentUser = ""
    var imageUrl       = ""
    var showNav         = false
    var isFromImageView = false
    var likeClick       = false
    var disLikeClick    = false

    var categoryId      = Int()
    var ID              = Int()
    var imgData         = Data()

    var commentString = "Add a public comment...".localize()

    var isLike          = 0
    var isDisLike       = 0
    var viewCount       = 0
    var likesCount      = 0
    var disLikesCount   = 0
     var deleteId : Int = 0
    var commentsCount   = 0
    var replayMainCommentUserID = 0
    var comentId         = 0
    var editUserID       = 0
    var postID          : Int = 0
    var videoId         : Int = 0
    var activeLabel     = UILabel()
    var activeLblNumberofLines : Int = 3
    var commentId       = 0
    var parentCommentId = 0
    var replyParentCommentId = 0
    
    var sendCommentClick = false
    var usersLikeClick  = false
    var UsersDisLikeClick = false
    var activeTextView  = UITextView()

    
    var usersCommentsArray  = Array<Any>()
    var CommentsByUserArray = Array<Any>()
    var postIDArray         = Array<Any>()
    var repliesCommentsArray = Array<Any>()
    var repliesCommentsUsernamesArray = Array<Any>()
    var replyCountArray     = Array<Any>()
    var loginUseridsArray   = Array<Int>()
    var userImagesArray     = Array<String>()
    var churchNameAry       : Array<String> = Array()
    var splitArray          : Array<String> = Array()
    var strrrr              : Array<String> = Array()
    var videoIDArray        : Array<String> = Array()
    var parentCommentIdArray = Array<Int>()
    var commentingIdArray  = Array<Int>()
    
    var videoEmbededIDStr   = String()
    var gggg                = String()
    var userID              = String()
    var kID                 = ""
    let buttonnn            = UIButton()
    var postShortTitle      = ""
    
   // var commentString = String()
    
    var thumbnailImageURL = String()
    let sectionTitleArray = ["","Comments"]
    let imageView = ["bible1","bible2","bible3","images.jpeg","7c26c4322705738c08d90691d32ff29b-brown-bible","bible9","bible8","bible7","bible6"]
    
    let imageView1 = ["bible6","bible7","bible8","bible9","images.jpeg","bible3","bible8","bible2","bible1"]
    
    var playerVars = Dictionary<String, Any>()
    var name = ["calvarychurch","calvarychurch1","calvarychurch","calvarychurch1","calvarychurch","calvarychurch1"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
        secondview.isHidden = true
        popupview.isHidden  = true
        
        self.textviewOutLet.delegate = self
        self.commentTW.delegate      = self
        self.commentTW.text          = self.commentString
 
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        categoryImgView.isUserInteractionEnabled = true
        categoryImgView.addGestureRecognizer(tapGestureRecognizer)
        

      
        if videoImgStr == "image" {
            
            player.isHidden = true
            
            categoryImgView.isHidden = false
            
            if !imgData.isEmpty {
                
                categoryImgView.image = UIImage(data: imgData)
                categoryImgView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                categoryImgView.contentMode = .scaleToFill
            }
            else {
                categoryImgView.image = #imageLiteral(resourceName: "Church-logo")
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
        
        repliesTableView.delegate = self
        repliesTableView.dataSource = self
        repliesTableView.tableFooterView = UIView(frame: .zero)

        activeLabel.numberOfLines = 0

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
                categoryImgView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                categoryImgView.contentMode = .scaleToFill
            }
            else {
                if(isFromImageView == true){
                    if(imageUrl != ""){
                    let newString = imageUrl.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
                    let url = URL(string:newString)
                    let dataImg = try? Data(contentsOf: url!)
                        if dataImg != nil {
                        categoryImgView.image = UIImage(data: dataImg!)
                        categoryImgView.contentMode = .scaleToFill
                        }
                    }else{
                          categoryImgView.image = #imageLiteral(resourceName: "Church-logo")
                    }
                }else{
                        categoryImgView.image = #imageLiteral(resourceName: "Church-logo")
                }
            }
        }

        self.allOffersTableView.reloadData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if(UIDevice.current.userInterfaceIdiom == .phone){
            self.ytPlayerViewHeight.constant = 200
            }
        else{
            self.ytPlayerViewHeight.constant = 300
        }
        
        print(showNav)

        Utilities.setVideosViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: " \(videoNameStr)", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")

        if kUserDefaults.value(forKey: kIdKey) as? Int != nil {
            
            self.ID = (kUserDefaults.value(forKey: kIdKey) as? Int )!
        }
  
        self.getVideoDetailsApiService()
        self.updateViewCountAPI()
        
        self.allOffersTableView.tableFooterView = UIView()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
       self.player.stopVideo()
    }
    
    func updateViewCountAPI(){
        
        let urlStr = UPDATEVIEWCOUNTBYPOSTID +  "" + String(self.videoId)
        print("UPDATEVIEWCOUNTBYPOSTID -> ",urlStr)
        
        serviceController.getRequest(strURL: urlStr, success: { (result) in
            
            print(result)
            
        }) { (failureMessage) in
            
            
        }
        
        self.allOffersTableView.reloadData()
    }
    
    
    override func viewDidLayoutSubviews() {
        repliesTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    

//MARK: - Add image to Library
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
       
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save Error".localize(), message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK".localize(), style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!".localize(), message: "Your Altered Image Has Been Saved To Your Photos.".localize(), preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK".localize(), style: .default))
            present(ac, animated: true)
        }
    }
   
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if !imgData.isEmpty {
            
            let imageView: UIImage = UIImage(data: imgData)!
            
            UIImageWriteToSavedPhotosAlbum(imageView, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }

    }
    
    func getVideosAPICall(){
        
        let urlStr = GETPOSTBYCATEGORYIDOFVIDEOSONGS + "" + "\(self.ID)"
        
        print("GETPOSTBYCATEGORYIDOFVIDEOSONGS",urlStr)
        
        serviceController.getRequest(strURL: urlStr, success: { (result) in
            
            DispatchQueue.main.async()
                {
                    print(result)
                    
                    let respVO:VideoSongsVo = Mapper().map(JSONObject: result)!
                    
                    let isSuccess = respVO.isSuccess
                    if isSuccess == true {

                        for authorDetails in respVO.listResult!{
                            
                            self.embedLinksAry.append(authorDetails)
                        }
                        
                        self.allOffersTableView.reloadData()
                        
                    }
                    else{
   
                    }
            }
            
            
            
        })
        { (failureMessage) in
            
            print(failureMessage)
        }
        
        
    }
    
//MARK: - Registring tableview cells
    
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

        repliesTableView.register(nibName3, forCellReuseIdentifier: "CommentsCell")
        
        repliesTableView.register(usersCommentsTableViewCell, forCellReuseIdentifier: "UsersCommentsTableViewCell")
    }

//MARK: - Tableview Delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
            if tableView == repliesTableView {
                return 2
            }
        
            else {
                return 4
            
            }
   
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if tableView == repliesTableView {
        
            if section == 0 {
                return 1
            }
            else  {
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
                return 0
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
            else {
                return 0
            }
        }
        
        
        return 0
    }
    
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == repliesTableView {
            
            if section == 0 {
     
                let allRepliesHeaderTVCell = self.repliesTableView.dequeueReusableCell(withIdentifier: "AllRepliesHeaderTVCell") as! AllRepliesHeaderTVCell
            
                allRepliesHeaderTVCell.repliesCloseBtn.addTarget(self, action: #selector(repliesCloseBtnClicked), for: .touchUpInside)
                allRepliesHeaderTVCell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                allRepliesHeaderTVCell.repliesCloseBtn = buttonnn
            
                return allRepliesHeaderTVCell
                
            }
            

        }
    
       return nil
    }
    
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if tableView == repliesTableView {
            
            if indexPath.section == 0 {
  
                    let usersCommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersCommentsTableViewCell", for: indexPath) as! UsersCommentsTableViewCell
                    
                    usersCommentsTableViewCell.viewCommentsBtn.isHidden = true
                    usersCommentsTableViewCell.replyCommentBtn.isHidden = true
                    usersCommentsTableViewCell.editCommentBn.isHidden   = true
                    usersCommentsTableViewCell.buttonImgOutLet.isHidden = true
                    usersCommentsTableViewCell.replayCountLbl.text      = ""
                    usersCommentsTableViewCell.viewCommentsBtn.setTitle("View Replies".localize(), for: .normal)
                    
                    usersCommentsTableViewCell.usersCommentLbl.text = self.replyMainComment
                    usersCommentsTableViewCell.usersNameLbl.text = self.replyMainCommentUser
 

                    return usersCommentsTableViewCell
            
            }
        
            else {
            
            let usersCommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersCommentsTableViewCell", for: indexPath) as! UsersCommentsTableViewCell
           
                usersCommentsTableViewCell.viewCommentsBtn.isHidden = true
                usersCommentsTableViewCell.replyCommentBtn.isHidden = true
                usersCommentsTableViewCell.replayCountLbl.isHidden  = true
                usersCommentsTableViewCell.editCommentBn.isHidden   = true
                usersCommentsTableViewCell.buttonImgOutLet.isHidden = true
                usersCommentsTableViewCell.usersCommentLbl.text     = self.repliesCommentsArray[indexPath.row] as? String
                usersCommentsTableViewCell.usersNameLbl.text        = self.repliesCommentsUsernamesArray[indexPath.row] as? String

                usersCommentsTableViewCell.usersLikeBtn.tintColor    = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                usersCommentsTableViewCell.usersDislikeBtn.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                usersCommentsTableViewCell.buttonImgOutLet.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                usersCommentsTableViewCell.replayCountLbl.text       = ""

               
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

            youtubeCLDSSCell.videoTitleName.text     = videoNameStr
            youtubeCLDSSCell.likeCountLbl.text       = String(likesCount)
            youtubeCLDSSCell.disLikeCountLbl.text    = String(disLikesCount)
            youtubeCLDSSCell.viewCountLbl.text       = String(self.viewCount) + " Views".localize()
            
            youtubeCLDSSCell.likeButton.addTarget(self, action: #selector(likeButtonClick(_:)), for: UIControlEvents.touchUpInside)
            youtubeCLDSSCell.unlikeButton.addTarget(self, action: #selector(unLikeButtonClick(_:)), for: UIControlEvents.touchUpInside)
            youtubeCLDSSCell.shareButton.addTarget(self, action: #selector(shareButtonClick(_:)), for: UIControlEvents.touchUpInside)
            youtubeCLDSSCell.shareButton.setTitle("Share".localize(), for: .normal)

            return youtubeCLDSSCell

        }
        
        if indexPath.section == 1 {
            
            let subscribCell = tableView.dequeueReusableCell(withIdentifier: "SubscribCell", for: indexPath) as! SubscribCell
            subscribCell.subscribnameLbl.text = "Channel Name".localize()
            return subscribCell
            
        }
        
        if indexPath.section == 2 {
            
            let commentsCell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
          
            commentsCell.commentTexView.text     = self.commentString
            commentsCell.commentCountLab.text    = String(usersCommentsArray.count) + " " + "Comments".localize()
            commentsCell.commentTexView.delegate = self
            commentsCell.commentTexView.tag      = 2001
            commentsCell.sendBtn.addTarget(self, action: #selector(commentSendBtnClicked),for: .touchUpInside)

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
            
            let usersCommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersCommentsTableViewCell", for: indexPath) as! UsersCommentsTableViewCell  
            var newString = self.userImagesArray[indexPath.row]
            
                 newString = newString.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
          
                if newString != nil {
                
                    let url = URL(string:newString)
                
                    if url != nil {
                        usersCommentsTableViewCell.usersImageView.sd_setImage(with:url , placeholderImage: #imageLiteral(resourceName: "Church-logo"))
                    
                    }
                    else {
                        usersCommentsTableViewCell.usersImageView.image = #imageLiteral(resourceName: "Church-logo")
                    }
                }
                else {
                    usersCommentsTableViewCell.usersImageView.image = #imageLiteral(resourceName: "Church-logo")
                }
            
           
                usersCommentsTableViewCell.usersNameLbl.text = self.CommentsByUserArray[indexPath.row] as? String
            
                let commentString = usersCommentsArray[indexPath.row] as? String
            
                usersCommentsTableViewCell.usersLikeCoubtLbl.text = String(commentingIdArray[indexPath.row])
                usersCommentsTableViewCell.editCommentBn.tag = indexPath.row
            
                let commentLblHeight = Int((commentString?.height(withConstrainedWidth: usersCommentsTableViewCell.usersCommentLbl.frame.size.width, font: UIFont(name: "HelveticaNeue", size: 14.0)!))!)

                print(commentLblHeight)
            
                if commentLblHeight  > 50  && activeLblNumberofLines == 3 {

                    usersCommentsTableViewCell.usersCommentLbl.numberOfLines = activeLblNumberofLines
                    usersCommentsTableViewCell.readMoreBtn.isHidden = true
                }
            
                else {
                    usersCommentsTableViewCell.usersCommentLbl.numberOfLines = activeLblNumberofLines
   
                }
            
                print(activeLabel.numberOfLines)
            
                usersCommentsTableViewCell.usersCommentLbl.text = commentString
                print(usersCommentsTableViewCell.usersCommentLbl.numberOfLines)
 
                let replyCount : Int = replyCountArray[indexPath.row] as! Int

                usersCommentsTableViewCell.usersLikeBtn.tag = indexPath.row
                usersCommentsTableViewCell.usersDislikeBtn.tag = indexPath.row
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
            
            if self.ID == self.loginUseridsArray[indexPath.row]{
                usersCommentsTableViewCell.buttonImgOutLet.isHidden = false
                usersCommentsTableViewCell.editCommentBn.isHidden = false
                usersCommentsTableViewCell.editCommentBn.addTarget(self, action: #selector(editCommentBnClicked), for: .touchUpInside)
            }
            else{
                usersCommentsTableViewCell.buttonImgOutLet.isHidden = true
                usersCommentsTableViewCell.editCommentBn.isHidden = true
            }
            usersCommentsTableViewCell.replyCommentBtn.isHidden = false

            return usersCommentsTableViewCell
    
        }

         return UITableViewCell()
        
      }
   
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == repliesTableView {
        }
        else {
        activeLblNumberofLines = 3
      }
  
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        
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
    
//MARK: - TextView Delegate methods
    
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
    }

//MARK: - Back button action
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {

        kUserDefaults.removeObject(forKey: "1")
        kUserDefaults.removeObject(forKey: kLoginSucessStatus)
        kUserDefaults.set("1", forKey: "1")
        kUserDefaults.synchronize()
        self.navigationController?.popViewController(animated: true)
        
    }
    
//MARK: - Home button action
    
    @IBAction func homeButtonTapped(_ sender:UIButton) {

        kUserDefaults.removeObject(forKey: "1")
        kUserDefaults.removeObject(forKey: kLoginSucessStatus)
        kUserDefaults.set("1", forKey: "1")
        kUserDefaults.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        appDelegate.window?.rootViewController = rootController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


//MARK: - Like button action
    
func  likeButtonClick(_ sendre:UIButton) {
        
    if !(self.ID == 0) {
            
        if likeClick == false {
            likeClick = true
            disLikeClick = false
        }
        else{
            likeClick = false
            disLikeClick = false
        }
        
        // calling like and dislike api service
        
        clickLikesDislikesCommentsCountsAPICAll()

    }
    else {
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Like".localize(), clickAction: {

              self.navigationController?.pushViewController(self.loginVC, animated: true)
            })
        
        }
    
    }

//MARK: - Dislike button action
    func  unLikeButtonClick(_ sendre:UIButton) {
        
        if !(self.ID == 0) {
            if disLikeClick == false {
                disLikeClick = true
                likeClick = false
            }
            else{
                disLikeClick = false
                likeClick = false
        }
            // calling like and dislike api service
        clickLikesDislikesCommentsCountsAPICAll()
        
        }
        else {
    
        Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Unlike".localize(), clickAction: {
            
            self.navigationController?.pushViewController(self.loginVC, animated: true)
            
        })
        }
    
    }

//MARK: - Share button action
    
    func  shareButtonClick(_ sendre:UIButton) {
        
        if !(self.ID == 0) {
            
        let someText:String = "Hello want to share text also"
                let urlString  = SHARELINKURL + "" + postShortTitle
     
          guard let objectsToShare:URL = URL(string: urlString) else {
                return
            }
                let sharedObjects:[AnyObject] = [objectsToShare as AnyObject]
                let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                activityViewController.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
                self.present(activityViewController, animated: true, completion: nil)
        }
        
            else {
        
                Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Share".localize(), clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
            })
            
        }
    }

//MARK: - Send Comment  button action
    
    func commentSendBtnClicked() {
     
        self.sendCommentClick = false
        self.allOffersTableView.endEditing(true)
        
        if !(self.ID == 0) {
            self.comentId = self.comentId != 0 ? self.comentId : 0
            self.parentCommentId = self.parentCommentId != 0 ? self.parentCommentId : 0
            commentSendBtnAPIService(textComment: self.commentString)
    
        }
        
        else {
        
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Add Comment".localize(), clickAction: {
            
            self.navigationController?.pushViewController(self.loginVC, animated: true)
            
        })
        
        }

        
    }
    
// MARK :- CommentAPIService
    
    func commentSendBtnAPIService(textComment : String){

        let  strUrl = ADDUPDATECOMMENTAPI

        let dictParams = [
                        "id": self.comentId,
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
                        self.commentString = "Add a public comment...".localize()
                        self.comentId = 0
                        self.parentCommentId = 0
                        self.getVideoDetailsApiService()
                    }
                        
                    else {
                        let failMsg = respVO.endUserMessage
                        return
                    }
      
            }
        },
         failureHandler: {(error) in
            
            print(error)
            
        })
    
    }
   
//MARK: - Userslike button action
    
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
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Like".localize(), clickAction: {
                
               self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
        
        
    }

//MARK: - Usersdislike button action
    
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
        let indexPath = IndexPath(item: sender.tag, section: 3)
        self.allOffersTableView.reloadRows(at: [indexPath], with: .automatic)
    
       }
       else {
        
        Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Unlike".localize(), clickAction: {
            
            self.navigationController?.pushViewController(self.loginVC, animated: true)
            })
        }
    }

//MARK: - Readmore button action
    
    func readmoreClicked(sender : UIButton){
            activeLblNumberofLines = 0
            let indexPath = IndexPath(item: sender.tag, section: 3)
            self.allOffersTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
//MARK: - ReplayComment button action
    func replyCommentBtnClick(sender : UIButton){
        
        popupview.isHidden = false
        secondview.isHidden = false
        textviewOutLet.text = "Add a public reply...".localize()
        textviewOutLet.textColor = UIColor.lightGray
        self.parentCommentId = self.commentingIdArray[sender.tag]
        self.comentId = 0

        if !(self.ID == 0) {
            let indexPath3 = IndexPath(item: 0, section: 2)
            self.allOffersTableView.scrollToRow(at: indexPath3, at: .top, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                if let commentsCell = self.allOffersTableView.cellForRow(at: indexPath3) as? CommentsCell {
                }
            })
        }
        else {
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Reply".localize(), clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
    }

//MARK: - ViewAllComments button action
    
    func viewAllCommentBtnClick(sender : UIButton){
        
        if !(self.ID == 0) {
              var commentIdNum = 0
                let indexPath = IndexPath(item: sender.tag, section: 3)
                if let usersCommentsTableViewCell = allOffersTableView.cellForRow(at: indexPath) as? UsersCommentsTableViewCell {
                    self.replyMainComment        = self.usersCommentsArray[sender.tag] as! String
                    self.replyMainCommentUser    = self.CommentsByUserArray[sender.tag] as! String
                    self.replayMainCommentUserID = self.loginUseridsArray[sender.tag]
                    commentIdNum                 = self.commentingIdArray[sender.tag]
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
            self.allOffersTableView.endEditing(true)
            self.repliesTableView.reloadData()
            self.allOffersTableView.endEditing(true)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {() -> Void in
            self.repliesTableView.frame = CGRect(x: 0, y: self.player.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - self.player.frame.size.height - 50)
  
            }, completion: {(_ finished: Bool) -> Void in

                })
            
        }
            
        else {
            
                Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Reply".localize(), clickAction: {
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
    }

//MARK: - RepliesClose button action
    func repliesCloseBtnClicked(){
        
       self.repliesTableView.endEditing(true)
       self.allOffersTableView.endEditing(true)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {() -> Void in
            
            self.repliesTableView.frame = CGRect(x: 0, y: self.allOffersTableView.frame.maxY, width: UIScreen.main.bounds.width, height: 0)
  
        }, completion: {(_ finished: Bool) -> Void in
            //position screen left after animation
        })
        
        
        
    }

//MARK: - LikesDislikesCommentsCountsAPICAll
    
    func clickLikesDislikesCommentsCountsAPICAll(){
        
        
        let  LIKEANDDISLIKECOUNTAPISTR = LIKEANDDISLIKECOUNTAPI
        
        let params = [ "postId": self.postID,
                       "userId": self.ID,
                       "like1": likeClick,
                       "disLike": disLikeClick ] as [String : Any]
        
        print("dic params \(params)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: LIKEANDDISLIKECOUNTAPISTR as NSString , postParams: params as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
 
            print(result)

            let responseVO:LikeandDislikeVo = Mapper().map(JSONObject: result)!
            let isSuccess = responseVO.isSuccess
            if isSuccess == true {
                
                self.likesCount = (responseVO.result?.likeCount)!
                self.disLikesCount = (responseVO.result?.dislikeCount)!
                
                if ((responseVO.result?.likeResult?.count)! > 0){
                    
                    self.isLike = (responseVO.result?.likeResult?[0].like1)!
                    self.isLike = (responseVO.result?.likeResult?[0].disLike)!
                }
                    let indexPath = IndexPath(item: 0, section: 0)
                    self.allOffersTableView.reloadRows(at: [indexPath], with: .automatic)
            }
   
        })
        { (failureMessage) in
            
            print(failureMessage)
        }
    }
    

//MARK: - Edit button Action
    
func editCommentBnClicked(sender : UIButton){
        
        if  self.ID == self.loginUseridsArray[sender.tag] {

            self.editUserID = self.commentingIdArray[sender.tag]

            self.comentId = self.commentingIdArray[sender.tag]

            let userCommentString = self.usersCommentsArray[sender.tag] as! String

            let actionSheet = UIAlertController(title: nil, message: "Select".localize(), preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let edit = UIAlertAction(title: "Edit".localize(), style: .default, handler: { (alert: UIAlertAction!) -> Void in

                let indexPath3 = IndexPath(item: 0, section: 2)
                self.commentString = ""
                self.allOffersTableView.scrollToRow(at: indexPath3, at: .top, animated: true)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                    
                    if let commentsCell = self.allOffersTableView.cellForRow(at: indexPath3) as? CommentsCell {
                    commentsCell.commentTexView.text = userCommentString
                    commentsCell.commentTexView.becomeFirstResponder()
                }
   
                })
                
            })
            
            let delete = UIAlertAction(title: "Delete".localize(), style: .default, handler: { (alert: UIAlertAction!) -> Void in
                self.deleteCommentAPICall(tag: sender.tag)
            })
                actionSheet.addAction(edit)
                actionSheet.addAction(delete)

            let cancelAction = UIAlertAction(title: "Cancel".localize(), style: UIAlertActionStyle.cancel, handler: {
                (alert: UIAlertAction) -> Void in
            })
            actionSheet.addAction(cancelAction)
            self.present(actionSheet, animated: true, completion: nil)
        }
    
    }
    
    private func focusItemNumberTextField() {
        
        let indexPath = IndexPath.init(row: 0, section: 2)
        if let itemNumberCell = allOffersTableView.cellForRow(at: indexPath) as? CommentsCell {
            itemNumberCell.commentTexView.text = ""
        }
    }
    
    
//MARK: - GetVideoDetailsApiService
    
    func getVideoDetailsApiService(){

        self.parentCommentIdArray.removeAll()
        self.commentingIdArray.removeAll()
        self.CommentsByUserArray.removeAll()
        self.replyCountArray.removeAll()
        self.usersCommentsArray.removeAll()
        self.loginUseridsArray.removeAll()
        self.userImagesArray.removeAll()

        let urlStr = LIKEDISLIKECOMMENTSAPI + "" + String(self.videoId) + "/" + String(self.ID)
        
        print("GETPOSTBYCATEGORYIDOFVIDEOSONGS -> ",urlStr)
        
        serviceController.getRequest(strURL: urlStr, success: { (result) in
            
            DispatchQueue.main.async(){
                    
                    print(result)
                    
                    let respVO:GetAllVideosVo = Mapper().map(JSONObject: result)!
                    
                    let isSuccess = respVO.isSuccess
                    if isSuccess == true {
                        let resultArr = respVO.result?.commentDetails
                        for id in (respVO.result?.commentDetails)! {
                            self.commentingIdArray.append(id.id!)
                            self.CommentsByUserArray.append(id.commentByUser == nil ? "" : id.commentByUser!)
                            self.replyCountArray.append(id.replyCount!)
                            self.loginUseridsArray.append(id.userId!)
                            self.userImagesArray.append(id.userImage == nil ? "" : id.userImage!)
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
                            self.activeLabel.text = vv as? String
                        }
                        if (respVO.result?.commentDetails?.count)! > 0{
                            self.replyDetails = (respVO.result?.replyDetails!)!
   
                        }

                        self.likesCount    = (respVO.result?.postDetails![0].likeCount)!
                        self.disLikesCount = (respVO.result?.postDetails![0].disLikeCount)!
                        self.postID        = (respVO.result?.postDetails![0].id)!
                        self.isLike        = (respVO.result?.postDetails![0].isLike)!
                        self.isDisLike     = (respVO.result?.postDetails![0].isDisLike)!
                        self.viewCount     = (respVO.result?.postDetails![0].viewCount) == nil ? 0 : (respVO.result?.postDetails![0].viewCount)!
  
                        if (respVO.result?.postDetails![0].postShortTitle) != nil {
                            self.postShortTitle = (respVO.result?.postDetails![0].postShortTitle)!
                        }

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
            }
   
        }) { (failureMessage) in
            
            print(failureMessage)
        }
   
    }

//MARK: - GetViewAllCommentsAPICall
    
    func getViewAllCommentsAPICall(tag : Int){

        self.commentId = self.parentCommentIdArray[tag]
        
       let getViewAllCommentsAPI = VIDEOVIEWALLCOMMENTSAPI + String(self.commentId)
        
        
        print(getViewAllCommentsAPI)
        
        serviceController.getRequest(strURL: getViewAllCommentsAPI, success: { (result) in
            
           print(result)
            
            let responseVO : ReplayCommentVO = Mapper().map(JSONObject: result)!
            let isSuccess = responseVO.isSuccess
            if isSuccess == true {

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
            
        })
        { (failureMessage) in
           print(failureMessage)
            
        }
    }

    
    @IBAction func replySendBtnClicked(_ sender: Any) {
        self.parentCommentId = self.replyParentCommentId
    }
   
//MARK: - GetViewAllCommentsAPICall
    
    func deleteCommentAPICall(tag : Int){
        
        if !(self.ID == 0) {
        
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Are You Sure Want To Delete".localize(), clickAction: {
                let deletePostID : Int  = self.commentingIdArray[tag]
                
                let postParams = [
                                "id": deletePostID,
                                "postId": self.postID,
                                "userId": self.ID,
                                "churchId": ""
                                ] as [String : Any]
    
                print("dic params \(postParams)")
        
                let dictHeaders = ["":"","":""] as NSDictionary
        
                self.serviceController.postRequest(strURL: DELETECOMMETAPI as NSString, postParams: postParams as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
        
                    print(result)
        
                    let responseVO : DeletePostCommentVO = Mapper().map(JSONObject: result)!
        
                    let isSuccess = responseVO.isSuccess
        
                    if isSuccess == true {
                        self.comentId = 0
                        self.parentCommentId = 0
                        self.getVideoDetailsApiService()
                    }

                    self.allOffersTableView.reloadData()
        
        
            })
                { (failureMessage) in
        
                    print(failureMessage)
        
                }
            })
        
     }
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Delete".localize(), clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
        
    }
    
    
    @IBAction func cancleAction(_ sender: Any) {
                
        popupview.isHidden = true
        secondview.isHidden = true
   
    }
    
    
    @IBAction func okAction(_ sender: Any) {
        
 
        self.allOffersTableView.endEditing(true)
        self.sendCommentClick = false
        self.commentString = self.textviewOutLet.text
        secondview.isHidden = true
        
        if (self.commentString == "" || self.commentString == "Add a public comment...".localize()){
           appDelegate.window?.makeToast("Please Add Reply".localize(), duration:kToastDuration, position:CSToastPositionCenter)
            return
        }
        else {
             popupview.isHidden = true
            if !(self.ID == 0) {
                self.comentId = self.comentId != 0 ? self.comentId : 0
                self.parentCommentId = self.parentCommentId != 0 ? self.parentCommentId : 0
                commentSendBtnAPIService(textComment: self.commentString)
                self.textviewOutLet.text = ""
                self.commentString = ""
        }
        else {
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Add Comment".localize(), clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
            })
        }
        }
        
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

        view.endEditing(true)
        
        
    }
}
