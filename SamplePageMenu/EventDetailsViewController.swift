//
//  EventDetailsViewController.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 19/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize
import IQKeyboardManagerSwift

class EventDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate,UITextViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var eventDetailsTableView: UITableView!
    
    @IBOutlet weak var norecordsFoundLbl: UILabel!
    
    var delegate: eventDetailsSubtitleOfIndexDelegate?

     @IBOutlet weak var repliesTableView: UITableView!
    
    
    
    @IBOutlet weak var secondview: UIView!
    
    
    @IBOutlet weak var popupview: UIView!
    
    @IBOutlet weak var okBtnOutLet: UIButton!
    
    
    @IBOutlet weak var canclebtnOutLet: UIButton!
    
    @IBOutlet weak var textviewOutLet: UITextView!
    
    //MARK: -  variable declaration
    
    var documentController: UIDocumentInteractionController = UIDocumentInteractionController()
    var saveLocationString      : String        = ""
    var isSavingPDF             : Bool          = false
    var pdfTitle                : String        = ""
    var isDownloadingOnProgress : Bool          = false
    var navigationStr = String()
    var eventsDetailsArray:[EventDetailsListResultVO] = Array<EventDetailsListResultVO>()
    var eventID = Int()
    var loginVC = LoginViewController()
    var eventChurchName = ""
    var eventName = ""
    var catgoryID:Int = 0
    var churchName1 : String = ""

    let buttonnn = UIButton()
    var imagesArray : [ImagesResultVo] = Array<ImagesResultVo>()
    var allCagegoryListArray : CategoriesListResultVo?
    var noOfRows : Array<Dictionary<String,Any>> = Array()
    var numberOfRows : Dictionary<String,Any> = Dictionary()
    var imagesArrayTag : Dictionary<String,Any> = Dictionary()
    var isResponseFromServer = false
    var videoIDArray : Array<String> = Array()
    var docsIDArray : Array<String> = Array()
    var audioIDArray : Array<String> = Array()
    var gggg = String()
    var categoryStr : Array<String> = Array()
    var authorName : String = ""
    var appVersion  : String = ""
    
    var imageView = UIImageView()
    var comentId = 0
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
    var readmoreCommentClick = false
    var usersCommentsArray = Array<Any>()
    var commentedByUserArray = Array<Any>()
    var loginUseridsArray = Array<Int>()
    
    var parentCommentId = 0
    var replyParentCommentId = 0
    var commentString : String = "Add a public comment...".localize()
    var commentedbyusername : String = "Add a public comment...".localize()
    var username = String()
    var usersLikeClick = false
    var UsersDisLikeClick = false
    var commentId = 0
    var repliesCommentsArray = Array<Any>()
    var repliesCommentsUsernamesArray = Array<Any>()
    var replyDetails = [EventcommentrepliesListResultVo]()
    var parentCommentIdArray = Array<Int>()
    var commentingIdArray = Array<Int>()
    var repliesCountArray = Array<Int>()
    var CommentIdArray = Array<Int>()
    var postID : Int = 0
    var activeTextView = UITextView()
    var activeLabel = UILabel()
    var activeLblNumberofLines : Int = 3
    var readMoreBtnIsHidden = true
    var replyMainComment = ""
    var replyMainCommentUser = ""
    var editUserID = 0
    
    var eventShortTitle = ""
    
//MARK: -   View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
        self.norecordsFoundLbl.isHidden = true
        
        secondview.isHidden = true
        popupview.isHidden = true
        
        if kUserDefaults.value(forKey: kIdKey) as? Int != nil {
            
            self.userID = (kUserDefaults.value(forKey: kIdKey) as? Int )!
            
        }

        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        self.loginVC = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        self.loginVC.showNav = true
        self.loginVC.navigationString = "eventNavigationString"
        
         self.textviewOutLet.delegate = self
        
        eventDetailsTableView.delegate = self
        eventDetailsTableView.dataSource = self
        
        let headImgTableViewCell = UINib(nibName: "HeadImgTableViewCell", bundle: nil)
        eventDetailsTableView.register(headImgTableViewCell, forCellReuseIdentifier: "HeadImgTableViewCell")
        
        let informationTableViewCell  = UINib(nibName: "InformationTableViewCell" , bundle: nil)
        eventDetailsTableView.register(informationTableViewCell, forCellReuseIdentifier: "InformationTableViewCell")
        
        let nibName  = UINib(nibName: "homeCategoriesCell" , bundle: nil)
        eventDetailsTableView.register(nibName, forCellReuseIdentifier: "homeCategoriesCell")
        
        let youtubeCLDSSCell  = UINib(nibName: "youtubeCLDSSCell" , bundle: nil)
        eventDetailsTableView.register(youtubeCLDSSCell, forCellReuseIdentifier: "youtubeCLDSSCell")
        
        let nibName3  = UINib(nibName: "CommentsCell" , bundle: nil)
        eventDetailsTableView.register(nibName3, forCellReuseIdentifier: "CommentsCell")
        
        
        let CommentsTableViewCell  = UINib(nibName: "UsersCommentsTableViewCell" , bundle: nil)
        eventDetailsTableView.register(CommentsTableViewCell, forCellReuseIdentifier: "UsersCommentsTableViewCell")

        let nib = UINib(nibName: "AllRepliesHeaderTVCell", bundle: nil)
        repliesTableView.register(nib, forCellReuseIdentifier: "AllRepliesHeaderTVCell")
        
        
        let nibName4  = UINib(nibName: "CommentsCell" , bundle: nil)
        repliesTableView.register(nibName4, forCellReuseIdentifier: "CommentsCell")
        
//  repliesTableView.register(nibName3, forCellReuseIdentifier: "CommentsCell")
        
        let usersCommentsTableViewCell  = UINib(nibName: "UsersCommentsTableViewCell" , bundle: nil)
        repliesTableView.register(usersCommentsTableViewCell, forCellReuseIdentifier: "UsersCommentsTableViewCell")
        
             
        
        repliesTableView.delegate = self
        repliesTableView.dataSource = self
        
        repliesTableView.tableFooterView = UIView(frame: .zero)

        
        getEventDetailsByIdApiCall()
       // getVideosAPICall()
        
        if let loginUserName = kUserDefaults.value(forKey: kUserName) {
            
            self.username = loginUserName as! String
        }
        
        
    }

    
    override func viewDidLayoutSubviews() {
        repliesTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: -   View WillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        

//        Utilities.authorDetailsnextViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr: self, titleView: nil, withText:"", backTitle: "  \(authorName)".localize(), rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
        
        if kUserDefaults.value(forKey: kIdKey) as? Int != nil {
            
            self.ID = (kUserDefaults.value(forKey: kIdKey) as? Int )!
            
        }
        
    }
    
 //MARK: -   View viewWillDisappear
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        
//        Utilities.authorDetailsnextViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr: self, titleView: nil, withText: "", backTitle: "".localize(), rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
    }
    

//MARK: -    Get Event Details By Id API Call
 
    func getEventDetailsByIdApiCall(){
        
     let getEventDetailsByIdApi = GETEVENTDETAILSBYID + String(eventID) + "/" + String(self.userID)
        
        serviceController.getRequest(strURL: getEventDetailsByIdApi, success: { (result) in
            
            if result.count > 0{
                
       print(result)
        self.getViewAllCommentsAPICall(tag: 0)
        let responseVO:EventDetailsVO = Mapper().map(JSONObject: result)!
                
        let isSuccess = responseVO.isSuccess
        print("StatusCode:\(String(describing: isSuccess))")
                
        if isSuccess == true{
                    
        let listResult = responseVO.result?.eventDetails
                    
        let commentDetailsVO = responseVO.result?.commentDetails
                    
        if (listResult?.count)! > 0 {
                        
        self.norecordsFoundLbl.isHidden = true
        self.eventDetailsTableView.isHidden = false
        self.eventsDetailsArray = listResult!
                       
                       
                        
//                        for commentDetails in commentDetailsVO! {
//                        
//                        self.usersCommentsArray.append(commentDetails.comment!)
//                        self.commentedByUserArray.append(commentDetails.commentByUser!)
//                        self.commentingIdArray.append(commentDetails.id!)
//                        self.parentCommentIdArray.append(commentDetails.parentCommentId!)
//                            
//                            self.CommentIdArray.append(commentDetails.eventId!)
//                        
//                        }
                        
            if self.eventsDetailsArray[0].likeCount != nil {
                self.likesCount = self.eventsDetailsArray[0].likeCount!
            }
            if self.eventsDetailsArray[0].disLikeCount != nil {
                self.disLikesCount = self.eventsDetailsArray[0].disLikeCount!
            }
      
            if self.eventsDetailsArray[0].isLike != nil {
                self.isLike = self.eventsDetailsArray[0].isLike!
            }
            if self.eventsDetailsArray[0].isDisLike != nil {
                 self.isDisLike = self.eventsDetailsArray[0].isDisLike!
            }
        
            if self.eventsDetailsArray[0].eventShortTitle != nil {
                self.eventShortTitle = self.eventsDetailsArray[0].eventShortTitle!
            }
        
            
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
                        
    self.eventDetailsTableView.reloadData()
            
        }
    else {
                        
        //  self.norecordsFoundLbl.isHidden = false
                        
        self.eventDetailsTableView.isHidden = true
            
            }
                   
        }
    else{
                
    self.norecordsFoundLbl.isHidden = false
                    
    self.eventDetailsTableView.isHidden = true
                
    }
                
            
    }
            
    else{
        
        print(" No result Found ")
            
            }
           
            
        }) { (failureMessege) in
            
            print(failureMessege)
            
        }
    
    
    }
    
   //MARK: -   View event Likes Dislikes CountAPiCall
    
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
                self.eventDetailsTableView.reloadRows(at: [indexPath], with: .automatic)
                
            }
            
        
        }) { (failureMessage) in
            
            
            
        }
    }
    
//MARK: -    Get Videos API Call
    
    
    func getVideosAPICall(){
        
        let urlStr = GETPOSTBYEVENTIDAPI + String(eventID)
        
        print("GETPOSTBYCATEGORYIDOFVIDEOSONGS",urlStr)
        serviceController.getRequest(strURL: urlStr, success: { (result) in
            
            DispatchQueue.main.async()
                {
                    
                    print(result)
                    
                    if result.count > 0 {
                        
                    let respVO:GetCategoriesResultVo = Mapper().map(JSONObject: result)!
                    
                    let isSuccess = respVO.isSuccess
                    
                    self.imagesArray.removeAll()
                    
                    if isSuccess == true {
                        
                        
                        self.allCagegoryListArray = respVO.result
                        
                        if respVO.result != nil{
                            
                        
                        let videoList = self.allCagegoryListArray?.videos
                        
                        var i = 0
                        
                        if !(videoList?.isEmpty)! {
                            
                            self.categoryStr.append("Videos")
                        }

                        
                        for authorDetails in videoList!{
                            
                            self.numberOfRows.updateValue(videoList?.count, forKey: "\(i)")
                            
                            self.imagesArrayTag.updateValue(videoList, forKey: "\(i)")
                            
                            self.imagesArray.append(authorDetails)
                        }
                        
                        i = (videoList?.count)! > 0 ? i + 1 : i
                        
                        let audioList = self.allCagegoryListArray?.audios
                        
                        if !(audioList?.isEmpty)! {
                            
                            self.categoryStr.append("Audios")
                        }
                        
                        for audioDetails in audioList!{
                            
                            self.numberOfRows.updateValue(audioList?.count, forKey: "\(i)")
                            
                            self.imagesArrayTag.updateValue(audioList, forKey: "\(i)")
                            
                            self.imagesArray.append(audioDetails)
                        }
                        
                        i = (audioList?.count)! > 0 ? i + 1 : i
                        
                        let docsList = self.allCagegoryListArray?.documents
                        
                        if !(docsList?.isEmpty)! {
                            
                            self.categoryStr.append("Documents")
                        }

                        
                        for docsDetails in docsList!{
                            
                            self.numberOfRows.updateValue(docsList?.count, forKey: "\(i)")
                            
                            self.imagesArrayTag.updateValue(docsList, forKey: "\(i)")
                            
                            self.imagesArray.append(docsDetails)
                        }
                        
                        i = (docsList?.count)! > 0 ? i + 1 : i
                        
                        let imageList = self.allCagegoryListArray?.images
                        
                        if !(imageList?.isEmpty)! {
                            
                            self.categoryStr.append("Images")
                        }
                        
                        for imageDetails in imageList!{
                            
                            self.numberOfRows.updateValue(imageList?.count , forKey: "\(i)")
                            
                            self.imagesArrayTag.updateValue(imageList, forKey: "\(i)")
                            
                            self.imagesArray.append(imageDetails)
                        }
                        
                        self.isResponseFromServer = true
                        self.eventDetailsTableView.reloadData()
                        }
                    }
                        
                    else{
                        
                        
                    }
                    
            }
            
        }
        
        }) { (failureMessage) in
            
            
        }
        
        
    }
    

//MARK: -   TableView Delegate & DataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        if tableView == repliesTableView {
            
            return 2
            
        }
            
        else {
            
            return 4
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == repliesTableView{
            
            if section == 0 {
                
                return 2
            }
                
            else {
                
                return self.repliesCommentsArray.count
            }
            
        }
        
        if  section == 0 {

            return 10
            
        }
            
    
        if section == 1 {
        
            if(isResponseFromServer == true){
                
                return numberOfRows.count
                
            }
            
            return 0
            
        }
        
        if section == 2 {
        
            return 1
            
        }
            
        else {
            
            return self.usersCommentsArray.count
        }
        
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == repliesTableView {
            
            return UITableViewAutomaticDimension
        }
            
        else  {
            
        
        if indexPath.section == 0 {
        
            if indexPath.row == 0 {
            
             return 150
        
        }
            
            if indexPath.row == 1 {
                
                return 90
                
            }
        }
        else {
        
            return UITableViewAutomaticDimension
        
        }
    }
        
       if  indexPath.section == 1 {
        
        
        return 150 
        
        }
    
        if  indexPath.section == 2 {
            
            
            return UITableViewAutomaticDimension
            
        }
    
        return UITableViewAutomaticDimension
        
}

    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension

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

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == repliesTableView   {
            
            if indexPath.section == 0 {
                
                if indexPath.row == 0{
                    
                    let usersCommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersCommentsTableViewCell", for: indexPath) as! UsersCommentsTableViewCell
                    
                    usersCommentsTableViewCell.viewCommentsBtn.isHidden = false
                    usersCommentsTableViewCell.replyCommentBtn.isHidden = false
                    
                    usersCommentsTableViewCell.usersCommentLbl.text = self.replyMainComment
                    usersCommentsTableViewCell.usersNameLbl.text = self.replyMainCommentUser
                    
                    if repliesCommentsArray.count > 0{
                        
                        usersCommentsTableViewCell.replayCountLbl.text = String(repliesCommentsArray.count)
                   
                    }else{
                         usersCommentsTableViewCell.buttonImgOutLet.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                          usersCommentsTableViewCell.editCommentBn.isHidden = true
                        usersCommentsTableViewCell.viewCommentsBtn.isHidden = true
                         usersCommentsTableViewCell.replayCountLbl.text = ""
                    }
                  //  usersCommentsTableViewCell.backgroundColor = #colorLiteral(red: 0.9475968553, green: 0.9569790024, blue: 0.9569790024, alpha: 1)
                    
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
            
        else {

        
        if indexPath.section == 0 {
         
        if eventsDetailsArray.count > 0 {
            
        let eventList: EventDetailsListResultVO = self.eventsDetailsArray[0]
            
        if indexPath.row == 0 {
        
        let headImgTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HeadImgTableViewCell", for: indexPath) as! HeadImgTableViewCell
            
            let img = eventList.eventImage
            
            let newString = img?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            if newString != nil {
                
                let url = URL(string:newString!)
                
                if url != nil {
                    
                    let dataImg = try? Data(contentsOf: url!)
                    
                    if dataImg != nil {
                        
                        headImgTableViewCell.churchImage.image = UIImage(data: dataImg!)
                    }
                    else {
                        
                        headImgTableViewCell.churchImage.image = #imageLiteral(resourceName: "eventsdetails")
                    }
                    
                }
                else {
                    
                    headImgTableViewCell.churchImage.image = #imageLiteral(resourceName: "eventsdetails")
                }
            }
            else {
                
                headImgTableViewCell.churchImage.image = #imageLiteral(resourceName: "eventsdetails")
            }
            
        headImgTableViewCell.churchNameLabel.isHidden = true
          
    
            
        return headImgTableViewCell
        
        }
            
            
        if indexPath.row == 1{
                
        let youtubeCLDSSCell = tableView.dequeueReusableCell(withIdentifier: "youtubeCLDSSCell", for: indexPath) as! youtubeCLDSSCell
            
            youtubeCLDSSCell.videoTitleName.text = eventList.churchName
            
            youtubeCLDSSCell.likeCountLbl.text = String(likesCount)
            
             youtubeCLDSSCell.disLikeCountLbl.text = String(disLikesCount)
            
            youtubeCLDSSCell.likeButton.addTarget(self, action: #selector(likeButtonClicked(_:)), for: UIControlEvents.touchUpInside)
            youtubeCLDSSCell.unlikeButton.addTarget(self, action: #selector(unlikeButtonClicked(_:)), for: UIControlEvents.touchUpInside)
            youtubeCLDSSCell.shareButton.addTarget(self, action: #selector(shareButtonClick(_:)), for: UIControlEvents.touchUpInside)
            
            if self.isLike == 0 {
            
            youtubeCLDSSCell.likeButton.tintColor = #colorLiteral(red: 0.4352941215, green: 0.4431372583, blue: 0.4745098054, alpha: 1)
                
            }
            else {
            
                youtubeCLDSSCell.likeButton.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            }
            
            if self.isDisLike == 0{
                
                youtubeCLDSSCell.unlikeButton.tintColor = #colorLiteral(red: 0.4352941215, green: 0.4431372583, blue: 0.4745098054, alpha: 1)
                
            }
            else {
                
                youtubeCLDSSCell.unlikeButton.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            }
            
                return youtubeCLDSSCell
                
            }
        
        else{
        
        let informationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell", for: indexPath) as! InformationTableViewCell
            
            if indexPath.row == 2 {
                
        informationTableViewCell.infoLabel.text = "Event Details".localize()
        informationTableViewCell.infoLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
                
        informationTableViewCell.addressLabel.text =  ""
                
        informationTableViewCell.addressLabel.textColor = UIColor.white
                
   //     informationTableViewCell.addressLabel.font = 15
                
        informationTableViewCell.symbolLbl.textColor =  UIColor.white


        }
 
        if indexPath.row == 3 {
                
            informationTableViewCell.infoLabel.text = "Event Name:".localize()
                
            informationTableViewCell.addressLabel.text =  eventList.title
                
            }
            
        if indexPath.row == 4 {
                
                informationTableViewCell.infoLabel.text = "Church Name".localize()
                
                informationTableViewCell.addressLabel.text =  eventList.churchName
                
            }
            
        if indexPath.row == 5 {
                
                informationTableViewCell.infoLabel.text = "Author Name".localize()
                
                informationTableViewCell.addressLabel.text =  eventList.authorName
                
            }
            
        if indexPath.row == 6 {
                
            informationTableViewCell.infoLabel.text = "Contact Number".localize()
                
            informationTableViewCell.addressLabel.text =  eventList.contactNumber
                
            }
            
        if indexPath.row == 7 {
                
            informationTableViewCell.infoLabel.text = "Start Date".localize()
                
            let startAndEndDate1 =   returnEventDateWithoutTim1(selectedDateString: eventList.startDate!)
                
            informationTableViewCell.addressLabel.text =  startAndEndDate1
            }
            
        if indexPath.row == 8 {
                
            informationTableViewCell.infoLabel.text = "End Date".localize()
                
            let startAndEndDate1 = returnEventDateWithoutTim1(selectedDateString: eventList.endDate!)
                
            informationTableViewCell.addressLabel.text =  startAndEndDate1
                
            }
            
        if indexPath.row == 9 {
                
                informationTableViewCell.infoLabel.text = "Description".localize()

                informationTableViewCell.addressLabel.text =  eventList.description
                
            }
            
            return informationTableViewCell
        }
            
    }
    }
            
        if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeCategoriesCell", for: indexPath) as! homeCategoriesCell
            
            cell.homeCollectionView.register(UINib.init(nibName: "homeCategoriesCollectionCell", bundle: nil),
                                             forCellWithReuseIdentifier: "homeCategoriesCollectionCell")
            cell.homeCollectionView.tag = indexPath.row
            
            cell.selectionStyle = .none
            
            cell.homeCollectionView.collectionViewLayout.invalidateLayout()
            
            cell.homeCollectionView.reloadData()
            
            
            cell.homeCollectionView.delegate = self
            cell.homeCollectionView.dataSource = self
            
            if categoryStr.count > 0 {
            
           cell.categorieName.text = self.categoryStr[indexPath.row]

            }
            
            return cell
            
        
        }
       
        if indexPath.section == 2 {
            
            let commentsCell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
    
            commentsCell.commentTexView.text = self.commentString
            commentsCell.commentCountLab.text = String(usersCommentsArray.count) + " " + "Comments".localize()
            commentsCell.commentTexView.delegate = self
            commentsCell.commentTexView.tag = 2001
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
        
      
            let usersCommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersCommentsTableViewCell", for: indexPath) as! UsersCommentsTableViewCell
            
            
           usersCommentsTableViewCell.usersCommentLbl.text = usersCommentsArray[indexPath.row] as? String
   
            usersCommentsTableViewCell.viewCommentsBtn.isHidden = false
            usersCommentsTableViewCell.replyCommentBtn.isHidden = false
            
            usersCommentsTableViewCell.usersNameLbl.text = self.commentedByUserArray[indexPath.row] as? String
            
            usersCommentsTableViewCell.replayCountLbl.text = (self.repliesCountArray[indexPath.row] as? Int)! > 0 ? "\((self.repliesCountArray[indexPath.row]))" : ""
            
            
            let commentString = usersCommentsArray[indexPath.row] as? String
            let commentedbyusername = commentedByUserArray[indexPath.row] as? String
            
    //         usersCommentsTableViewCell.usersLikeCoubtLbl.text = String(commentingIdArray[indexPath.row])
            
            usersCommentsTableViewCell.editCommentBn.tag = indexPath.row
            
            let commentLblHeight = Int((commentString?.height(withConstrainedWidth: usersCommentsTableViewCell.usersCommentLbl.frame.size.width, font: UIFont(name: "HelveticaNeue", size: 14.0)!))!)
            
      
            let commentnameLblHeight = Int((commentedbyusername?.height(withConstrainedWidth: usersCommentsTableViewCell.usersNameLbl.frame.size.width, font: UIFont(name: "HelveticaNeue", size: 14.0)!))!)
            

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
            
            usersCommentsTableViewCell.usersNameLbl.text = commentedbyusername
            //commentedbyusername
            
            print(usersCommentsTableViewCell.usersCommentLbl.numberOfLines)
    
            usersCommentsTableViewCell.usersLikeBtn.tag = indexPath.row
            usersCommentsTableViewCell.usersDislikeBtn.tag = indexPath.row
            usersCommentsTableViewCell.readMoreBtn.tag = indexPath.row
            usersCommentsTableViewCell.viewCommentsBtn.tag = indexPath.row
            usersCommentsTableViewCell.replyCommentBtn.tag = indexPath.row
            
            
            
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
            
            usersCommentsTableViewCell.usersLikeBtn.addTarget(self, action: #selector(usersLikeBtnClick), for: UIControlEvents.touchUpInside)
            usersCommentsTableViewCell.usersDislikeBtn.addTarget(self, action: #selector(usersDislikeBtnClick), for: UIControlEvents.touchUpInside)
            usersCommentsTableViewCell.replyCommentBtn.addTarget(self, action: #selector(replyCommentBtnClick), for: UIControlEvents.touchUpInside)
            
            usersCommentsTableViewCell.viewCommentsBtn.addTarget(self, action: #selector(viewAllCommentBtnClick), for: UIControlEvents.touchUpInside)
            
            usersCommentsTableViewCell.readMoreBtn.addTarget(self, action: #selector(readmoreClicked), for: .touchUpInside)
            
            if self.ID == self.loginUseridsArray[indexPath.row]{
            
            usersCommentsTableViewCell.editCommentBn.isHidden = false
            usersCommentsTableViewCell.editCommentBn.addTarget(self, action: #selector(editCommentBnClicked), for: .touchUpInside)
            
            }
            else{
               usersCommentsTableViewCell.buttonImgOutLet.isHidden = true
                
            }
            usersCommentsTableViewCell.buttonImgOutLet.isHidden = false
            
            return usersCommentsTableViewCell
            
            }
        }
        
        return UITableViewCell()
    }
    
    
    func commentTWBtnClicked(){
        
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if tableView == repliesTableView {
            
            
        }
            
        else {
            activeLblNumberofLines = 3
        }
        
    }
    
//MARK: -   users Like Btn Click
    
    func usersLikeBtnClick(sender : UIButton){
        
        if !(self.userID == 0) {
            
            if usersLikeClick == false {
                
                usersLikeClick = true
                UsersDisLikeClick = false
                
            }
                
            else{
                
                usersLikeClick = false
                UsersDisLikeClick = false
                
                
            }
            
            let indexPath = IndexPath(item: sender.tag, section: 3)
            self.eventDetailsTableView.reloadRows(at: [indexPath], with: .automatic)
            
        }
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Like".localize(), clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
        
        
    }
    
//MARK: -   users Dislike Btn Click
    
   func usersDislikeBtnClick(sender : UIButton){
        
        if !(self.userID == 0) {
            
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
            self.eventDetailsTableView.reloadRows(at: [indexPath], with: .automatic)
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Unlike".localize(), clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
    }
    
    func readmoreClicked(sender : UIButton){
        
        
        readMoreBtnIsHidden = false
        activeLblNumberofLines = 0
        
        let indexPath = IndexPath(item: sender.tag, section: 3)
        self.eventDetailsTableView.reloadRows(at: [indexPath], with: .automatic)
        
        
    }
    
//MARK: -   reply Comment Btn Click
    
    func replyCommentBtnClick(sender : UIButton){
        
        
        popupview.isHidden = false
        secondview.isHidden = false
        textviewOutLet.text = "Add a public comment...".localize()
        textviewOutLet.textColor = UIColor.lightGray
        
        self.parentCommentId = self.commentingIdArray[sender.tag]
                 
        self.comentId = 0
        
        if !(self.userID == 0) {
          
            
            let indexPath3 = IndexPath(item: 0, section: 2)
            
            
            self.eventDetailsTableView.scrollToRow(at: indexPath3, at: .top, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                if let commentsCell = self.eventDetailsTableView.cellForRow(at: indexPath3) as? CommentsCell {
                    
                //    commentsCell.commentTexView.becomeFirstResponder()
                    
                }

            })
            
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Reply".localize(), clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
    }
    
//MARK: -   view All Comment Btn Click
    
    func viewAllCommentBtnClick(sender : UIButton){
        
        if !(self.userID == 0) {
            
            let indexPath = IndexPath(item: sender.tag, section: 3)
            var commentIdNum = 0
            
            if let usersCommentsTableViewCell = eventDetailsTableView.cellForRow(at: indexPath) as? UsersCommentsTableViewCell {
                
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
            self.eventDetailsTableView.endEditing(true)
            self.repliesTableView.reloadData()
            
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {() -> Void in
                
    self.repliesTableView.frame = CGRect(x: 0, y: 300, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 300)
            
                
            }, completion: {(_ finished: Bool) -> Void in
             
               //  self.repliesTableView.isScrollEnabled = true
            })
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Reply".localize(), clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
        }
    }
    
//MARK: -   replies Close Btn Clicked
    
    func repliesCloseBtnClicked(){
        
            self.repliesTableView.endEditing(true)
            self.eventDetailsTableView.endEditing(true)
            
         //   self.eventDetailsTableView.isScrollEnabled = true
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {() -> Void in
                
                self.repliesTableView.frame = CGRect(x: 0, y: self.eventDetailsTableView.frame.maxY, width: UIScreen.main.bounds.width, height: 0)
                
                
        }, completion: {(_ finished: Bool) -> Void in

        })
        
        
        
    }
   
//MARK: -   edit Comment Btn Clicked
    
    func editCommentBnClicked(sender : UIButton){
        
        if self.ID == self.loginUseridsArray[sender.tag]{

        self.editUserID = self.commentingIdArray[sender.tag]
        
        
    //    self.parentCommentId = self.parentCommentIdArray[sender.tag]
        
        self.comentId = self.commentingIdArray[sender.tag]
        
        let userCommentString = self.usersCommentsArray[sender.tag] as! String
   
            
            let actionSheet = UIAlertController(title: nil, message: "Select", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let edit = UIAlertAction(title: "Edit", style: .default, handler: { (alert: UIAlertAction!) -> Void in
                
            let indexPath3 = IndexPath(item: 0, section: 2)
                
        self.commentString = ""
        self.eventDetailsTableView.scrollToRow(at: indexPath3, at: .top, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            
        if let commentsCell = self.eventDetailsTableView.cellForRow(at: indexPath3) as? CommentsCell {
                        
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
    
//MARK: -   get View All Comments APICall
    
    func getViewAllCommentsAPICall(tag : Int){
        
        self.parentCommentIdArray.removeAll()
        self.commentingIdArray.removeAll()
        self.CommentIdArray.removeAll()
        self.repliesCountArray.removeAll()
        self.usersCommentsArray.removeAll()
        self.loginUseridsArray.removeAll()
        self.commentedByUserArray.removeAll()
        
        self.commentId = self.parentCommentId
        
        let getViewAllCommentsAPI = GETEVENTBYIDAPI  + String(eventID) + "/" + String(self.userID)
        
        print(getViewAllCommentsAPI)
        
        serviceController.getRequest(strURL: getViewAllCommentsAPI, success: { (result) in
            
            print(result)
            
            let responseVO : EventcommentrepliesVo = Mapper().map(JSONObject: result)!
            
            let isSuccess = responseVO.isSuccess
            
            if isSuccess == true {
                
            if responseVO.result != nil {
                
        if (responseVO.result?.commentDetails?.count)! > 0{
                        
            for commentDetails in (responseVO.result?.commentDetails!)!{
            self.usersCommentsArray.append(commentDetails.comment!)
            self.commentedByUserArray.append(commentDetails.commentByUser!)
            self.commentingIdArray.append(commentDetails.id!)
            self.loginUseridsArray.append(commentDetails.userId!)
                            
        //       self.parentCommentIdArray.append(commentDetails.parentCommentId!)
                            
        self.repliesCountArray.append(commentDetails.replyCount!)
                            
        self.CommentIdArray.append(commentDetails.eventId!)
                }
                
                    }
                    
        if (responseVO.result?.replyDetails?.count)! > 0{
        self.replyDetails = (responseVO.result?.replyDetails!)!
                  
            
                    }
        
        self.eventDetailsTableView.reloadData()
        self.repliesTableView.reloadData()
                    
                }
           
            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
        
        
    }
    
//MARK: -   delete Comments APICall
    
    func deleteCommentAPICall(tag : Int){
        
       if !(self.userID == 0) {
        
        Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Are You Sure Want To Delete".localize(), clickAction: {
            
        let deletePostID : Int  = self.CommentIdArray[tag]
          let deleteCommentID  : Int  = self.commentingIdArray[tag]
        
        
        let postParams = [
            "id": deleteCommentID,
            "eventId": deletePostID,
            "userId": self.ID,
            "churchId": ""
            ] as [String : Any]
        
        print("dic params \(postParams)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        serviceController.postRequest(strURL: EVENTDELETECOMMETAPI as NSString, postParams: postParams as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            let responseVO : DeletePostCommentVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = responseVO.isSuccess
            
            if isSuccess == true {
                
             self.comentId = 0
                self.parentCommentId = 0
              self.getViewAllCommentsAPICall(tag: 0)
                
                
            }
            
            self.eventDetailsTableView.reloadData()
            
            
        }) { (failureMessage) in
            
           }
            
            
        
        })
        
    }
        
       else {
        
        Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Delete".localize(), clickAction: {
            
            self.navigationController?.pushViewController(self.loginVC, animated: true)
            
        })
        }

        
    
}

 
    
//    func getrepliesforCommentsAPICall(tag : Int){
//        
//        
//        
//        
//    }
//
//    
 
//MARK: -  UITexview Delegate methods
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
       // self.eventDetailsTableView.isScrollEnabled = false
       // self.repliesTableView.isScrollEnabled = false
 
        
        if textView.text == "Add a public comment...".localize() {
            
            textView.text = ""
            
        }
        
        self.sendCommentClick = false
         self.readmoreCommentClick = false
        textView.textColor = UIColor.black
        
        
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        textView.resignFirstResponder()
        
    //    self.eventDetailsTableView.isScrollEnabled = true
    //    self.repliesTableView.isScrollEnabled = true

        
        self.commentString = textView.text
        self.commentedbyusername = textView.text
        
        if textView.text == "" {
            
            textView.text = "Add a public comment...".localize()
            textView.textColor = UIColor.lightGray
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let indexPath : IndexPath = IndexPath(row: 0, section: 2)
        
        if let commentsCell = self.eventDetailsTableView.cellForRow(at: indexPath) as? CommentsCell {
            
            let newString = (textView.text! as NSString).replacingCharacters(in: range, with: text)
            
            print(commentsCell.commentTexView.text.characters.count)
            
            self.commentString = commentsCell.commentTexView.text
            self.commentedbyusername = commentsCell.commentTexView.text
            
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

    
//MARK: -   Event Date Without Time
   
    func returnEventDateWithoutTim1(selectedDateString : String) -> String{
        var newDateStr = ""
        var newDateStr1 = ""
        
        if(selectedDateString != ""){
            let invDtArray = selectedDateString.components(separatedBy: "T")
            let dateString = invDtArray[0]
            let dateString1 = invDtArray[1]
            print(dateString1)
            let invDtArray2 = dateString1.components(separatedBy: ".")
            let dateString3 = invDtArray2[0]
            
            print(dateString1)
            
            if(dateString != "" || dateString != "."){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateFromString = dateFormatter.date(from: dateString)
                dateFormatter.dateFormat = "dd-MM-YYYY"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr = newDateString
                print(newDateStr)
            }
            if(dateString3 != "" || dateString != "."){
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.dateFormat = "HH:mm:ss"
                let dateFromString = dateFormatter.date(from: dateString3)
                dateFormatter.dateFormat = "hh:mm aa"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr1 = newDateString
                print(newDateStr1)
            }
        }
        return newDateStr + "," + newDateStr1
    }
    
//MARK: -    Back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
    
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        self.navigationController?.popViewController(animated: true)
        
        print("Back Button Clicked......")
        
    }
    
//MARK: -    Home Button Tapped


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
    
   //MARK: -   like Button Clicked
    
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
            
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Like".localize(), clickAction: {
                
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                
                self.navigationController?.pushViewController(loginVC!, animated: true)
                
            })
            
        }
        
    }
    
    //MARK: -  unlike Button Clicked
    
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
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Unlike".localize(), clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
            
        }
        
    }
    
    
//MARK: -   share Button Clicked
    
    func  shareButtonClick(_ sendre:UIButton) {
        
        if !(self.userID == 0) {
            
            let someText:String = "Hello want to share text also"
          //  let objectsToShare:URL = URL(string: "http://183.82.111.111/TeluguChurches/Web/")!
            let urlString  = EVENTSHARELINKURL + "" + eventShortTitle + "/" + String(eventID)
            
            let objectsToShare:URL = URL(string: urlString)!
            let sharedObjects:[AnyObject] = [objectsToShare as AnyObject]
            let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            //        activityViewController.excludedActivityTypes = [UIActivityType.airDrop,        UIActivityType.postToFacebook,UIActivityType.postToTwitter,UIActivityType.mail]
            
            activityViewController.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            
            self.present(activityViewController, animated: true, completion: nil)
            
            print("Share Clicked.............",urlString)
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Share".localize(), clickAction: {
                
                
               self.navigationController?.pushViewController(self.loginVC, animated: true)
            })
            
        }
    }
   
    //MARK: -   comment send Button Clicked

    func commentSendBtnClicked(){
        
       self.sendCommentClick = false
    
        
        self.eventDetailsTableView.endEditing(true)
        
        if !(self.userID == 0) {
            
            
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
    
    //MARK: -   comment Send Btn API Service
    
    func commentSendBtnAPIService(textComment : String){
        
        
        let  EVENTCOMMENTSAPISTR = EVENTCOMMENTAPI
        
        let params = ["id": comentId,
                      "eventId": eventID,
                      "description": textComment,
                      "parentCommentId": self.parentCommentId,
                      "userId": self.ID
            
            
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
                
                
                let  successMsg = respVO.endUserMessage
                let  createdComment = respVO.result
                
                self.commentString = "Add a public comment...".localize()
                self.comentId = 0
                self.parentCommentId = 0
                
                self.getViewAllCommentsAPICall(tag: 0)
                
            }
                
            else {
                
                let  failMsg = respVO.endUserMessage
                
                
                return
                
            }
            
            
        }) { (failureMessage) in
            
            
        }
    }
    
    
    
    @IBAction func cancleAction(_ sender: Any) {
        
        popupview.isHidden = true
        secondview.isHidden = true
        
        
    }
    
    
    @IBAction func okAction(_ sender: Any) {
        
       
        self.eventDetailsTableView.endEditing(true)
        self.sendCommentClick = false
        self.textviewOutLet.text = self.commentString
       
        popupview.isHidden = true
        secondview.isHidden = true
        
        if (self.commentString == "" || self.commentString == "Add a public comment...".localize()){
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Add Reply".localize(), clickAction: {
                
                
            })
            
            return
 
            
        }

        if !(self.userID == 0) {
            
            
            self.comentId = self.comentId != 0 ? self.comentId : 0
            self.parentCommentId = self.parentCommentId != 0 ? self.parentCommentId : 0
            
            commentSendBtnAPIService(textComment: self.commentString)
            
             self.textviewOutLet.text = ""
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Add Comment".localize(), clickAction: {
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
            
        }
        
        
    }
    

    
    
    
    
}

    
    
// Mark :- Collectionview  Delegate & DataSource methods
    
    extension EventDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
        
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.numberOfRows.count > 0 {
        
        let totalItems = self.numberOfRows["\(collectionView.tag)"] as? Int
        
        print("totalItems:\(String(describing: totalItems))")
        
        return totalItems!
            
        }
        
        return 0
        
        }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCategoriesCollectionCell", for: indexPath) as! homeCategoriesCollectionCell
        
        let imageTag = self.imagesArrayTag["\(collectionView.tag)"] as? NSArray
        
        let title = (imageTag?[indexPath.row] as? ImagesResultVo)?.title
        
        let postImgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
        let fileExtension = (imageTag?[indexPath.row] as? ImagesResultVo)?.fileExtention
        cell.nameLabel.text = title
    
        cell.collectionImgView.image = #imageLiteral(resourceName: "eventsdetails")
        
        if (fileExtension == ".png") || (fileExtension == ".jpeg") || (fileExtension == ".jpg") || (fileExtension == ".JPG"){
            
            let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            
            if newString != nil {
                
                let url = URL(string:newString!)
                
                
                let dataImg = try? Data(contentsOf: url!)
                
                if dataImg != nil {
                    
                    cell.collectionImgView.image = UIImage(data: dataImg!)
                }
                else {
                    
                    cell.collectionImgView.image = #imageLiteral(resourceName: "eventsdetails")
                }
            }
            else {
                
                cell.collectionImgView.image = #imageLiteral(resourceName: "eventsdetails")
            }
            
        }
            
        else if (fileExtension == ".pdf") || (fileExtension == ".docs") {
            
            
//            if let embededUrlImage =  postImgUrl {
//
//                let thumbnillImage : String = embededUrlImage
//
//
//                docsIDArray = thumbnillImage.components(separatedBy: "Document\\")
//                self.thumbnailImageURL = "http://192.168.1.171/TeluguChurchesRepository/FileRepository/2018/03/09/Post/Document//\(docsIDArray[1])"
//
//                let videothumb = URL(string: self.thumbnailImageURL)
//
//                if videothumb != nil{
//
//                    let request = URLRequest(url: videothumb!)
//
//                    let session = URLSession.shared
//
//                    let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
//
//                        DispatchQueue.main.async()
//                            {
//
//                                if data != nil {
//
//                                    cell.collectionImgView.image = UIImage(data: data!)
//                                }
//
//                                else{
//                                    cell.collectionImgView.image = #imageLiteral(resourceName: "defaultdocument")
//                                }
//
//                        }
//
//                    })
//
//                    dataTask.resume()
//
//                }
//
//                else{
//                    cell.collectionImgView.image = #imageLiteral(resourceName: "defaultdocument")
//                }
//            }
            
            cell.collectionImgView.image = #imageLiteral(resourceName: "defaultdocument")
        }
            
        else if (fileExtension == ".mp3") {
            
            cell.collectionImgView.contentMode = .scaleAspectFit
            cell.collectionImgView.image = #imageLiteral(resourceName: "audio3")
            
          
            
        }
        else if fileExtension == ".mp4" {
            
            
            if let embededUrlImage =  postImgUrl {
                
                let thumbnillImage : String = embededUrlImage
                
                
                self.audioIDArray = thumbnillImage.components(separatedBy: "embed/")
                
                self.thumbnailImageURL = "https://img.youtube.com/vi/\(self.audioIDArray[1])/default.jpg"
                
                let videothumb = URL(string: self.thumbnailImageURL)
                
                if videothumb != nil{
                    
                    let request = URLRequest(url: videothumb!)
                    
                    let session = URLSession.shared
                    
                    let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                        
                        DispatchQueue.main.async()
                            {
                                
                                if data != nil {
                                    
                                    cell.collectionImgView.image = UIImage(data: data!)
                                    
                                }
                                
                        }
                        
                    })
                    
                    dataTask.resume()
                    
                }
            }
        }
        
        
        return cell
        
    }

        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("You selected cell #\(indexPath.item)!")
        
        let imageTag = self.imagesArrayTag["\(collectionView.tag)"] as? NSArray
        
        let fileExtension = (imageTag?[indexPath.row] as? ImagesResultVo)?.fileExtention
        
        let postImgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
        
        
        if (fileExtension == ".png") || (fileExtension == ".jpeg") || (fileExtension == ".jpg") || (fileExtension == ".JPG"){
            
            print("images")
            
            let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            
            if newString != nil {
                
                let url = URL(string:newString!)
                
                
                let dataImg = try? Data(contentsOf: url!)
                
                if dataImg != nil {
                    
                    
                    imageView.image = UIImage(data: dataImg!)
                    imageView.frame = self.view.bounds
                    imageView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    imageView.contentMode = .scaleAspectFit
                    imageView.isUserInteractionEnabled = true
                    
                    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
                    imageView.addGestureRecognizer(tap)
                    
                    self.view.addSubview(imageView)
                }
                else {
                    
                    imageView.image = #imageLiteral(resourceName: "eventsdetails")
                }
            }
            else {
                
                imageView.image = #imageLiteral(resourceName: "eventsdetails")
                
            }
            
            
            
        }
            
        else if (fileExtension == ".pdf") || (fileExtension == ".docs") {
            
            print("Pdfs and docs")
            
            let imgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
            
            let embededUrlImage =  imgUrl
            let newString = embededUrlImage?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            
            if newString != nil {
                
                savePDFWithUrl(newString!)
                
                
            }
            
        }
            
        else if (fileExtension == ".mp3") {
            
            let postImgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
            let title = (imageTag?[indexPath.row] as? ImagesResultVo)?.title
            let categoryId = (imageTag?[indexPath.row] as? ImagesResultVo)?.categoryId
            
            
            let audioID = (imageTag?[indexPath.row] as? ImagesResultVo)?.id
            
            print(postImgUrl)
            
            let audioUrlImage =  postImgUrl
            print(audioUrlImage)
            
            let newString = audioUrlImage?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            print(newString)
            
            
            if newString != nil {
                
                
                let audioViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AudioViewController") as! AudioViewController
                
                audioViewController.audioIDArr = newString!
                audioViewController.audioIDNameArr = title!
                audioViewController.audioID = audioID!
                audioViewController.categoryID = categoryId ?? 0
                
                self.navigationController?.pushViewController(audioViewController, animated: true)
                
                
            }
            else {
                
            }
            
            
            
            
            print("audio")
            
        }
        else if fileExtension == ".mp4" {
            
            
            let postImgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
            let title = (imageTag?[indexPath.row] as? ImagesResultVo)?.title
            let categoryId = (imageTag?[indexPath.row] as? ImagesResultVo)?.categoryId
            
            let imgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
            
            let userID = (imageTag?[indexPath.row] as? ImagesResultVo)?.id
            
            if let embededUrlImage =  imgUrl {
                
                let thumbnillImage : String = embededUrlImage
                
                
                self.audioIDArray = thumbnillImage.components(separatedBy: "embed/")
                
                self.thumbnailImageURL = "https://img.youtube.com/vi/\(self.audioIDArray[1])/default.jpg"
                
                let videothumb = URL(string: self.thumbnailImageURL)
                
                if videothumb != nil{
                    
                    let request = URLRequest(url: videothumb!)
                    
                    let session = URLSession.shared
                    
                    let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                        
                        DispatchQueue.main.async()
                            {
                                
                                let  videosVC =  YoutubePlayerViewController(nibName: "YoutubePlayerViewController", bundle: nil)
                                
                                videosVC.videoEmbededIDStr = self.audioIDArray[1]
                                videosVC.videoNameStr = title!
                                
                                
                                kUserDefaults.set(categoryId, forKey: "categoryId")
                                kUserDefaults.set(userID, forKey: "userID")
                                kUserDefaults.synchronize()
                                self.navigationController?.pushViewController(videosVC, animated: true)
                        }
                        
                    })
                    
                    dataTask.resume()
                    
                }
            }
            
        }
        
        
        }
        
        

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         return CGSize(width: 140.0, height: 105.0)
    
        
    }
   
        func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
            sender.view?.removeFromSuperview()
        }
        
        private func openPDFinPDFReader() {
            
        }
        
        
        private func savePDFWithUrl(_ urlString: String) {
            
    var filePath : URL?
            
    DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                
    if let url = URL.init(string: urlString) {
                    
    let documentDirUrlString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
                    
    if let documentDirUrl = URL.init(string: documentDirUrlString) {
                        
    let pdfNameArray = urlString.characters.split(separator: "/").map(String.init)
                        
   if let pdfName = pdfNameArray.last {
                            
    let saveLocation = documentDirUrl.appendingPathComponent(pdfName)
    self.saveLocationString = saveLocation.absoluteString
    filePath = URL.init(fileURLWithPath: saveLocation.path)
    print( self.saveLocationString)
                            
    let fileExists = FileManager().fileExists(atPath: self.saveLocationString)
                            
    if fileExists {
                                
    if !self.isSavingPDF {
                                    
    DispatchQueue.main.async {
                                        
                                        
    self.openSelectedDocumentFromURL(documentURLString: self.saveLocationString)
    print( self.saveLocationString)
    print(  self.openSelectedDocumentFromURL)
                                        
                                        
    self.openPDFinPDFReader()
}
                                    
    } else {
                                    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                                        
    })
    }
                                
    } else {
                                
    do {
                                    
    self.isDownloadingOnProgress = true
                                    
    let imageData : Data? = try Data.init(contentsOf: url)
                                    
    if imageData == nil {
        
    self.isDownloadingOnProgress = false
                                        
    DispatchQueue.main.async {
        
    }
                                        
} else {
                                        
   do {
                                            
    try imageData?.write(to: filePath!, options: Data.WritingOptions.withoutOverwriting)
                                            
    if !self.isSavingPDF {
                                                
    self.isDownloadingOnProgress = false
                                                
    DispatchQueue.main.async {
                                                    
    self.openPDFinPDFReader()
    }
                                                
                                                
} else {
                                                
    self.isDownloadingOnProgress = false
                                                
    DispatchQueue.main.async {
                                                    
        
    }
}
                                            
} catch let error {
                                            
    self.isDownloadingOnProgress = false
                                            
    DispatchQueue.main.async {
                                                
        
        }
    }
}
                                    
} catch let error {
                                    
    print(error.localizedDescription)
                                    
    self.isDownloadingOnProgress = false
                                    
DispatchQueue.main.async {
                                        
        }
      }
    }
   }
  }
}
}
            
}
        
func openSelectedDocumentFromURL(documentURLString: String) {
    
            let documentURL: NSURL = NSURL(fileURLWithPath: documentURLString)
            documentController = UIDocumentInteractionController(url: documentURL as URL)
            documentController.delegate = self
            documentController.presentPreview(animated: true)
        }

        func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
            return self
        }
    
    }
    
    
extension EventDetailsViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(AudioViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        
      //  self.eventDetailsTableView.isScrollEnabled = true
     //   self.repliesTableView.isScrollEnabled = true
        view.endEditing(true)
        
        
    }
}

    
    
    
    
    
    
    

