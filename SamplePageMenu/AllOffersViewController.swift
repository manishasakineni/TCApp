//
//  AllOffersViewController.swift
//  OffersScreen
//
//  Created by Mac OS on 21/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit
import youtube_ios_player_helper


class AllOffersViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource,UIScrollViewDelegate,YTPlayerViewDelegate{

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
    var videoIDNameArr = ""
    var categoryName = ""

    

    // var authorDetailsArray  : [VideoSongsResultVo] = Array<VideoSongsResultVo>()
    
    // var embedLinksAry : Array<String> = Array()
    var embedLinksAry : [VideoSongsResultVo] = Array<VideoSongsResultVo>()
    var churchNameAry : Array<String> = Array()
    var splitArray : Array<String> = Array()
    var strrrr : Array<String> = Array()
    
    var videoIDArray : Array<String> = Array()
    
    var gggg = String()
    
    var thumbnailImageURL = String()
    let sectionTitleArray = ["","Comments"]
    let imageView = ["bible1","bible2","bible3","images.jpeg","7c26c4322705738c08d90691d32ff29b-brown-bible","bible9","bible8","bible7","bible6"]
    
    
    let imageView1 = ["bible6","bible7","bible8","bible9","images.jpeg","bible3","bible8","bible2","bible1"]
    
    var playerVars = Dictionary<String, Any>()
    var name = ["calvarychurch","calvarychurch1","calvarychurch","calvarychurch1","calvarychurch","calvarychurch1"]
    
    //    var videosIDArray = ["knaCsR6dr58?modestbranding=0","SG-G0lgEtMY?modestbranding=0","yvhrORy4x30?modestbranding=0","knaCsR6dr58?modestbranding=0","SG-G0lgEtMY?modestbranding=0","yvhrORy4x30?modestbranding=0"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allOffersTableView.delegate = self
        allOffersTableView.dataSource = self
        
        
        self.player.load(withVideoId: videoIDArray[1],playerVars: self.playerVars)
        
        
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
            "modestbranding" : 1
            
            
            
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
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        
        print(showNav)
        
     //   self.navigationController?.navigationBar.isHidden = false
        
        
        Utilities.setVideosViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: " \(videoIDNameArr)", rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
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
        

        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return sectionTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        if section == 0 {
            
            return 2
        }
       // return self.embedLinksAry.count
        return 1

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
            
            
            youtubeCLDSSCell.videoTitleName.text = categoryName
            youtubeCLDSSCell.likeButton.addTarget(self, action: #selector(likeButtonClick(_:)), for: UIControlEvents.touchUpInside)
            youtubeCLDSSCell.unlikeButton.addTarget(self, action: #selector(unLikeButtonClick(_:)), for: UIControlEvents.touchUpInside)
            youtubeCLDSSCell.shareButton.addTarget(self, action: #selector(shareButtonClick(_:)), for: UIControlEvents.touchUpInside)

            return youtubeCLDSSCell
           }else{
            
            let subscribCell = tableView.dequeueReusableCell(withIdentifier: "SubscribCell", for: indexPath) as! SubscribCell
            
            
            subscribCell.subscribnameLbl.text = "Click Subscrib Button"
                      return subscribCell
            }
        }
         let commentsCell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
        
        
       //
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
        
        
        
        
        return commentsCell
        
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
    
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        UserDefaults.standard.removeObject(forKey: kuserId)
        UserDefaults.standard.synchronize()
        
        //   navigationItem.leftBarButtonItems = []
//        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
//        
//        appDelegate.window?.rootViewController = rootController
        
        self.navigationController?.popViewController(animated: true)
        
        
        print("Back Button Clicked......")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    func  likeButtonClick(_ sendre:UIButton) {
        
      print("Like Clicked.............")
    }
    func  unLikeButtonClick(_ sendre:UIButton) {
        
        print("UnLike Clicked.............")
    }
    func  shareButtonClick(_ sendre:UIButton) {
        
        print("Share Clicked.............")
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
