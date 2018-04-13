//
//  EventDetailsViewController.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 19/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize

class EventDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate,UITextViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var eventDetailsTableView: UITableView!
    
    @IBOutlet weak var norecordsFoundLbl: UILabel!
    
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
    
      //MARK: -   View DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.norecordsFoundLbl.isHidden = true
        
        
        if kUserDefaults.value(forKey: kIdKey) as? Int != nil {
            
            self.userID = (kUserDefaults.value(forKey: kIdKey) as? Int )!
            
        }

//        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        self.loginVC = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        
//        self.loginVC.showNav = true
//        self.loginVC.navigationString = "eventNavigationString"
        
        
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
        

        let usersCommentsTableViewCell  = UINib(nibName: "UsersCommentsTableViewCell" , bundle: nil)
        eventDetailsTableView.register(usersCommentsTableViewCell, forCellReuseIdentifier: "UsersCommentsTableViewCell")
        
        getEventDetailsByIdApiCall()
        getVideosAPICall()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: -   View WillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        

        Utilities.authorDetailsnextViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr: self, titleView: nil, withText: self.eventName, backTitle: "  \(authorName)".localize(), rightImage: "home icon", secondRightImage: "Up", thirdRightImage: "Up")
        
//        if kUserDefaults.value(forKey: kuserIdKey) as? String != nil {
//            
//            self.userID = (kUserDefaults.value(forKey: kuserIdKey) as? String)!
//            
//        }
        
        if kUserDefaults.value(forKey: kIdKey) as? Int != nil {
            
            self.ID = (kUserDefaults.value(forKey: kIdKey) as? Int )!
            
        }
        
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
                        
                        self.norecordsFoundLbl.isHidden = true
                        
                        self.eventDetailsTableView.isHidden = false
                        
                        self.eventsDetailsArray = listResult!
                       
                       
                        
                        for commentDetails in commentDetailsVO! {
                        
                        self.usersCommentsArray.append(commentDetails.comment)
                        
                        }
                        
                        
                        self.likesCount = self.eventsDetailsArray[0].likeCount!
                        self.disLikesCount = self.eventsDetailsArray[0].disLikeCount!
                        
                        self.isLike = self.eventsDetailsArray[0].isLike!
                        self.isDisLike = self.eventsDetailsArray[0].isDisLike!
                        
                        print(self.eventsDetailsArray)
                        
                
                        
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
                            
                            self.numberOfRows.updateValue(imageList?.count, forKey: "\(i)")
                            
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
        
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {

        return 8
            
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
        
        if indexPath.section == 0 {
        
        if indexPath.row == 0 {
            
            return 140
        
        }
            
            if indexPath.row == 1 {
                
                return 90
                
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
         
        if eventsDetailsArray.count > 0 {
            
            let eventList: EventDetailsListResultVO = self.eventsDetailsArray[0]
            
            
        
        if indexPath.row == 0 {
        
        let headImgTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HeadImgTableViewCell", for: indexPath) as! HeadImgTableViewCell
        
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
            
                informationTableViewCell.infoLabel.text = "Church Name".localize()
                
                informationTableViewCell.addressLabel.text =  eventList.churchName
            
            }
            
            if indexPath.row == 3 {
                
                informationTableViewCell.infoLabel.text = "Registration Number".localize()
                
                informationTableViewCell.addressLabel.text =  eventList.registrationNumber
                
            }
            
            if indexPath.row == 4 {
                
                informationTableViewCell.infoLabel.text = "Event Name:".localize()
                
                informationTableViewCell.addressLabel.text =  eventList.title
                
            }
            
            if indexPath.row == 5 {
                
                informationTableViewCell.infoLabel.text = "Contact Number".localize()
                
                informationTableViewCell.addressLabel.text =  eventList.contactNumber
                
            }

            
            if indexPath.row == 6 {
                
                informationTableViewCell.infoLabel.text = "Start Date".localize()
                
                let startAndEndDate1 =   returnEventDateWithoutTim1(selectedDateString: eventList.startDate!)
                
                

                
                informationTableViewCell.addressLabel.text =  startAndEndDate1
            }
            
            if indexPath.row == 7 {
                
                informationTableViewCell.infoLabel.text = "End Date".localize()
                
                let startAndEndDate1 =   returnEventDateWithoutTim1(selectedDateString: eventList.endDate!)
                
                informationTableViewCell.addressLabel.text =  startAndEndDate1
                
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
            commentsCell.commentCountLab.text = String(usersCommentsArray.count)
            commentsCell.commentTexView.delegate = self
            
            commentsCell.sendBtn.addTarget(self, action: #selector(commentSendBtnClicked),for: .touchUpInside)
            
            if sendCommentClick == false{
                
                commentsCell.sendBtn.isHidden = true
                
            }
                
            else{
                
                commentsCell.sendBtn.isHidden = false
                
                
            }
            
            
            return commentsCell
            
            
        }
        
        if indexPath.section == 3 {
            
            let usersCommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersCommentsTableViewCell", for: indexPath) as! UsersCommentsTableViewCell
            
          //  let userComments =
            
            usersCommentsTableViewCell.usersCommentLbl.text = usersCommentsArray[indexPath.row] as! String
            
            return usersCommentsTableViewCell
            
            
        }
        
        return UITableViewCell()
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
        
        let indexPath : IndexPath = IndexPath(row: 0, section: 2)
        
        if let commentsCell = self.eventDetailsTableView.cellForRow(at: indexPath) as? CommentsCell {
            
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
                dateFormatter.dateFormat = "yyyy-MM-dd"
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
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
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
    

    func commentSendBtnClicked(){
        
       self.sendCommentClick = false
        
        self.eventDetailsTableView.endEditing(true)
        
        print(self.commentString)
        
        
        
        // self.usersCommentsArray.append(self.commentString)
        
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
                self.eventDetailsTableView.reloadSections(IndexSet(integersIn: 2...3), with: UITableViewRowAnimation.top)
                
                
                
                
                
            }
                
            else {
                
                let failMsg = respVO.endUserMessage
                
                
                return
                
                
                
            }
            
            
        }) { (failureMessage) in
            
            
            
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
    
        
        
        cell.collectionImgView.image = #imageLiteral(resourceName: "j4")
        
        if (fileExtension == ".png") || (fileExtension == ".jpeg") || (fileExtension == ".jpg") || (fileExtension == ".JPG"){
            
            let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            
            if newString != nil {
                
                let url = URL(string:newString!)
                
                
                let dataImg = try? Data(contentsOf: url!)
                
                if dataImg != nil {
                    
                    cell.collectionImgView.image = UIImage(data: dataImg!)
                }
                else {
                    
                    cell.collectionImgView.image = #imageLiteral(resourceName: "j4")
                }
            }
            else {
                
                cell.collectionImgView.image = #imageLiteral(resourceName: "j4")
            }
            
        }
            
        else if (fileExtension == ".pdf") || (fileExtension == ".docs") {
            
            
            if let embededUrlImage =  postImgUrl {
                
                let thumbnillImage : String = embededUrlImage
                
                
                docsIDArray = thumbnillImage.components(separatedBy: "Document\\")
                self.thumbnailImageURL = "http://192.168.1.171/TeluguChurchesRepository/FileRepository/2018/03/09/Post/Document//\(docsIDArray[1])"
                
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
            
        else if (fileExtension == ".mp3") {
            
            cell.collectionImgView.contentMode = .scaleAspectFit
            cell.collectionImgView.image = #imageLiteral(resourceName: "audio_music")
            
          
            
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
                    
                    imageView.image = #imageLiteral(resourceName: "j4")
                }
            }
            else {
                
                imageView.image = #imageLiteral(resourceName: "j4")
                
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
            
            
            print(postImgUrl)
            
            let audioUrlImage =  postImgUrl
            print(audioUrlImage)
            
            let newString = audioUrlImage?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            print(newString)
            
            
            if newString != nil {
                
                
                let audioViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AudioViewController") as! AudioViewController
                
                audioViewController.audioIDArr = newString!
                audioViewController.audioIDNameArr = title!
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
        
         return CGSize(width: 150.0, height: 130.0)
    
        
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
    
    
    
    
    
    
    
    
    
    

