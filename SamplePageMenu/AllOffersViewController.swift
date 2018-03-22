//
//  AllOffersViewController.swift
//  OffersScreen
//
//  Created by Mac OS on 21/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import IQKeyboardManagerSwift


class AllOffersViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource,UIScrollViewDelegate,YTPlayerViewDelegate,UITextViewDelegate{

    var serviceController = ServiceController()
    @IBOutlet weak var allOffersTableView: UITableView!
 //   var delegate: changeSubtitleOfIndexDelegate?
    
    @IBOutlet weak var player: YTPlayerView!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var skipButton: UIButton!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!

    @IBOutlet weak var loadingImg: UIImageView!
    
    var appVersion          : String = ""
    
    var showNav = false
    var videoNameStr = ""
    var categoryName = ""

    var commentString : String = "Add a public comment..."
    
//    var likeCount : String = "0"
//    var disLikeCount : String = "0"
    
    var likeClick = false
    var disLikeClick = false
    var likesCount = 0
    var disLikesCount = 0
    var sendCommentClick = false
    
    var usersCommentsArray = ["Drag these project", "Drag these files and folders into your project Drag these files and folders into your project", "Drag these files"," folders into your project","123456 1233 draag"]

    // var authorDetailsArray  : [VideoSongsResultVo] = Array<VideoSongsResultVo>()
    
    // var embedLinksAry : Array<String> = Array()
    var embedLinksAry : [VideoSongsResultVo] = Array<VideoSongsResultVo>()
    var churchNameAry : Array<String> = Array()
    var splitArray : Array<String> = Array()
    var strrrr : Array<String> = Array()
    
    var videoIDArray : Array<String> = Array()
    
    var videoEmbededIDStr = String()
    
    var gggg = String()
    
    var thumbnailImageURL = String()
    let sectionTitleArray = ["","Comments"]
    let imageView = ["bible1","bible2","bible3","images.jpeg","7c26c4322705738c08d90691d32ff29b-brown-bible","bible9","bible8","bible7","bible6"]
    
    
    let imageView1 = ["bible6","bible7","bible8","bible9","images.jpeg","bible3","bible8","bible2","bible1"]
    
    var playerVars = Dictionary<String, Any>()
    var name = ["calvarychurch","calvarychurch1","calvarychurch","calvarychurch1","calvarychurch","calvarychurch1"]
    
    //  var videosIDArray = ["knaCsR6dr58?modestbranding=0","SG-G0lgEtMY?modestbranding=0","yvhrORy4x30?modestbranding=0","knaCsR6dr58?modestbranding=0","SG-G0lgEtMY?modestbranding=0","yvhrORy4x30?modestbranding=0"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboard()
        allOffersTableView.allowsSelection = false
        allOffersTableView.delegate = self
        allOffersTableView.dataSource = self
        allOffersTableView.separatorStyle = .none
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        
       
        
        
        // UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        //  UserDefaults.standard.synchronize()
        
        
        
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
        
        
        
        registerTableViewCells()
        
//        getVideosAPICall()
        
        print(videoIDArray)
       
         self.player.load(withVideoId: videoEmbededIDStr,playerVars: self.playerVars)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        
        print(showNav)
        
     //   self.navigationController?.navigationBar.isHidden = false
        
        
        Utilities.setVideosViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: videoNameStr, backTitle: videoNameStr, rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        //   self.navigationItem.hidesBackButton = false
        
        //        Utilities.setSignUpViewControllerNavBarColorInCntrWithColor(backImage: "icons8-hand_right_filled-1", cntr:self, titleView: nil, withText: "", backTitle: " InspectionPro", rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        //
        //        //navigationItem.leftBarButtonItems = []
        
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
        
        
        
//        
//        let nibName1  = UINib(nibName: "VideoTableViewCell" , bundle: nil)
//        allOffersTableView.register(nibName1, forCellReuseIdentifier: "VideoTableViewCell")
//        
        
        let nibName1  = UINib(nibName: "youtubeCLDSSCell" , bundle: nil)
        allOffersTableView.register(nibName1, forCellReuseIdentifier: "youtubeCLDSSCell")
        
        
        let nibName2  = UINib(nibName: "SubscribCell" , bundle: nil)
        allOffersTableView.register(nibName2, forCellReuseIdentifier: "SubscribCell")
        
        let nibName3  = UINib(nibName: "CommentsCell" , bundle: nil)
        allOffersTableView.register(nibName3, forCellReuseIdentifier: "CommentsCell")
        
        let usersCommentsTableViewCell  = UINib(nibName: "UsersCommentsTableViewCell" , bundle: nil)
        allOffersTableView.register(usersCommentsTableViewCell, forCellReuseIdentifier: "UsersCommentsTableViewCell")
        

        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
       // return sectionTitleArray.count
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        if section == 0 {
            
            return 2
        }
       // return self.embedLinksAry.count
        if section == 1 {
            
            return 1
        }
                else{
            
        return usersCommentsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if indexPath.section == 0 {
            
           if indexPath.row == 0 {
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
            else{
                
               
                youtubeCLDSSCell.unlikeButton.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                
            }
            
            
           
            youtubeCLDSSCell.videoTitleName.text = videoNameStr
            
                        
            youtubeCLDSSCell.likeButton.addTarget(self, action: #selector(likeButtonClick(_:)), for: UIControlEvents.touchUpInside)
            youtubeCLDSSCell.unlikeButton.addTarget(self, action: #selector(unLikeButtonClick(_:)), for: UIControlEvents.touchUpInside)
            youtubeCLDSSCell.shareButton.addTarget(self, action: #selector(shareButtonClick(_:)), for: UIControlEvents.touchUpInside)

            return youtubeCLDSSCell
           }
           
           else {
            
            let subscribCell = tableView.dequeueReusableCell(withIdentifier: "SubscribCell", for: indexPath) as! SubscribCell
            
            
            subscribCell.subscribnameLbl.text = "Channel Name"
            
            return subscribCell
            
            }
        
        }
        
        if indexPath.section == 1 {
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
        
        if indexPath.section == 2 {
            
            let usersCommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersCommentsTableViewCell", for: indexPath) as! UsersCommentsTableViewCell
            
            usersCommentsTableViewCell.usersCommentLbl.text = usersCommentsArray[indexPath.row]
            
            
            return usersCommentsTableViewCell
            
        }
        
        
    
//      //  let churchIdMonthYearList:VideoSongsResultVo = self.embedLinksAry[indexPath.row]
//        
//        let allOffersCell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
//        
//        //        allOffersCell.label.text = churchNameAry[indexPath.row]
//        //
//        //        let str : String = self.embedLinksAry[indexPath.row]
//        //
//        //
//        //        videoIDArray = str.components(separatedBy: "=")
//        
//        //        let name    = videoIDArray[0]
//        //        let surname = videoIDArray[1]
//        
//        
//        
//        
//        if let title =  churchIdMonthYearList.title {
//            allOffersCell.label.text = "Church Name:" + " " + title
//        }else{
//            allOffersCell.label.text = "church Name:"
//        }
//        
//        if let embedLink =  churchIdMonthYearList.embededUrl {
//            let str : String = embedLink
//            
//            
//            videoIDArray = str.components(separatedBy: "embed/")
//            
//            allOffersCell.label.text = "Video Name:" + " " + videoIDArray[1]
//        }else{
//            allOffersCell.label.text = "Video Name:"
//        }
//        //  print(videoIDArray[1])
//        
//        if let embededUrlImage =  churchIdMonthYearList.embededUrl {
//            
//            let thumbnillImage : String = embededUrlImage
//            
//            
//            videoIDArray = thumbnillImage.components(separatedBy: "embed/")
//            
//            self.thumbnailImageURL = "https://img.youtube.com/vi/\(videoIDArray[1])/1.jpg"
//            
//            let videothumb = URL(string: self.thumbnailImageURL)
//            
//            if videothumb != nil{
//                
//                let request = URLRequest(url: videothumb!)
//                
//                let session = URLSession.shared
//                
//                let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
//                    
//                    DispatchQueue.main.async()
//                        {
//                            
//                            allOffersCell.thumbnailImageView.image = UIImage(data: data!)
//                            
//                    }
//                    
//                })
//                
//                dataTask.resume()
//                
//            }
//        }else{
//            
//        }
//        
        
        
        
        
        return UITableViewCell()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        
//        let churchIdMonthYearList:VideoSongsResultVo = self.embedLinksAry[indexPath.row]
//        
//        
//        
//        
//        let embedLink =  churchIdMonthYearList.embededUrl
//        let str : String = embedLink!
//        videoIDArray = str.components(separatedBy: "embed/")
//        
//        self.player.load(withVideoId: videoIDArray[1],playerVars: self.playerVars)
//        
        //
        //        if let embededUrl =  churchIdMonthYearList.embededUrl {
        //
        //            self.thumbnailImageURL = "https://img.youtube.com/vi/\(embededUrl)/1.jpg"
        //
        //            let videothumb = URL(string: self.thumbnailImageURL)
        //
        //            if videothumb != nil{
        //
        //                let request = URLRequest(url: videothumb!)
        //
        //                let session = URLSession.shared
        //
        //                let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
        //
        //                    DispatchQueue.main.async()
        //                        {
        //
        //                          //  allOffersCell.thumbnailImageView.image = UIImage(data: data!)
        //                            self.player.load(withVideoId: embededUrl,playerVars: self.playerVars)
        //
        //
        //                    }
        //
        //                })
        //
        //                dataTask.resume()
        //
        //            }
        //        }
    }
    
    
    //    open func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    //
    //        let url = request.url
    //
    //        // Check if ytplayer event and, if so, pass to handleJSEvent
    //        if let url = url, url.scheme == "ytplayer"
    //
    //
    //
    //        if navigationType == UIWebViewNavigationType.linkClicked {
    //            UIApplication.sharedApplication.openURL(request.URL)
    //            return false
    //        }
    //        return true
    //    }
    //
    
    
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
        
        if textView.text == "Add a public comment..." {
            
            textView.text = ""
            
        }
//        self.allOffersTableView.reloadSections(IndexSet(integersIn: 1...1), with: UITableViewRowAnimation.top)
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
        
        let indexPath : IndexPath = IndexPath(row: 0, section: 1)
        
        if let commentsCell = self.allOffersTableView.cellForRow(at: indexPath) as? CommentsCell {
            
            
            
            print(commentsCell.commentTexView.text.characters.count)
            
            self.commentString = commentsCell.commentTexView.text
            
            if (commentsCell.commentTexView.text.characters.count) > 0 {
                
                
                
                print(self.commentString)
                
                commentsCell.sendBtn.isHidden = false
            
            }
            
            else{
            
                commentsCell.sendBtn.isHidden = false
            
            }
        }
        
        
        return true
        
    }
    
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        
        
        UserDefaults.standard.removeObject(forKey: kuserId)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
                
        self.navigationController?.popViewController(animated: true)
        
        
        print("Back Button Clicked......")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    func  likeButtonClick(_ sendre:UIButton) {
        
        if likeClick == false {
        
        likeClick = true
        disLikeClick = false
        
            
        }
        
        else{
            
        likeClick = false
        disLikeClick = false
    
        
        }
        
        
        
        let indexPath = IndexPath(item: 0, section: 0)
        self.allOffersTableView.reloadRows(at: [indexPath], with: .automatic)
        
     //   self.allOffersTableView.reloadData()
        
      print("Like Clicked.............")
    }
    
    func  unLikeButtonClick(_ sendre:UIButton) {
        
        if disLikeClick == false {
            
            disLikeClick = true
            likeClick = false
 
        }
            
        else{
            disLikeClick = false
            likeClick = false
          
            
        }
        
        print("UnLike Clicked.............")
        
        let indexPath = IndexPath(item: 0, section: 0)
        self.allOffersTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func  shareButtonClick(_ sendre:UIButton) {
        
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
    
    func commentSendBtnClicked(){
     
    self.sendCommentClick = false
    
     self.allOffersTableView.endEditing(true)
    
    print(self.commentString)
    
   // self.usersCommentsArray.append(self.commentString)
        
    self.usersCommentsArray.insert(self.commentString, at: 0)
        
    self.commentString = "Add a public comment..."
    self.allOffersTableView.reloadSections(IndexSet(integersIn: 1...2), with: UITableViewRowAnimation.top)
   
    
        
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

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
