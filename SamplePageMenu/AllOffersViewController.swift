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

    
     var embedLinksAry : Array<String> = Array()
     var churchNameAry : Array<String> = Array()
    var splitArray : Array<String> = Array()
    var strrrr : Array<String> = Array()

    var videoIDArray : Array<String> = Array()
    
    var gggg = String()
    
    var thumbnailImageURL = String()

    let imageView = ["bible1","bible2","bible3","images.jpeg","7c26c4322705738c08d90691d32ff29b-brown-bible","bible9","bible8","bible7","bible6"]
    
    
    let imageView1 = ["bible6","bible7","bible8","bible9","images.jpeg","bible3","bible8","bible2","bible1"]
    
var playerVars = Dictionary<String, Any>()
    var name = ["calvarychurch","calvarychurch1","calvarychurch","calvarychurch1","calvarychurch","calvarychurch1"]
    
//    var videosIDArray = ["knaCsR6dr58?modestbranding=0","SG-G0lgEtMY?modestbranding=0","yvhrORy4x30?modestbranding=0","knaCsR6dr58?modestbranding=0","SG-G0lgEtMY?modestbranding=0","yvhrORy4x30?modestbranding=0"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        allOffersTableView.delegate = self
        allOffersTableView.dataSource = self
        
        
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
        
       getVideosAPICall()
        
      
 
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        
        print(showNav)
        
        self.navigationController?.navigationBar.isHidden = false
        
        
        Utilities.setVideosViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Bible apps", backTitle: "Bible apps", rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        //   self.navigationItem.hidesBackButton = false
        
        //        Utilities.setSignUpViewControllerNavBarColorInCntrWithColor(backImage: "icons8-hand_right_filled-1", cntr:self, titleView: nil, withText: "", backTitle: " InspectionPro", rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        //
        //        //navigationItem.leftBarButtonItems = []
        
    }
    
   
   

    func getVideosAPICall(){
    
    serviceController.getRequest(strURL: videosURL, success: { (json) in
        
        DispatchQueue.main.async()
            {
                
             //   let respVO:VideosVO = Mapper().map(JSONObject: json)!
                
                let respVO = Mapper<VideosVO>().mapArray(JSONObject: json)
                
               
                self.embedLinksAry.removeAll()
                
                for i in respVO!{
       

                self.embedLinksAry.append(i.EmbedLink!)
                self.churchNameAry.append(i.ChurchName!)
                
                }
                
                
                
                
                self.gggg = self.embedLinksAry[0]
                
                
                
                self.splitArray = self.gggg.components(separatedBy: "=")
                
                print(self.splitArray[1])

                self.allOffersTableView.reloadData()
                
               self.player.load(withVideoId: self.splitArray[1],playerVars: self.playerVars)
                
//                var imageView : UIImageView
//                imageView  = UIImageView(frame:CGRect(x:10, y:50, width:100, height:300))
//                imageView.image = UIImage(named:"bible9.png")
//                
//            
//                self.view.addSubview(imageView)
//                
        }
        
        
        
    }) { (failureMessage) in
        
        
        
        
        }
    
    
    }
    
    private func registerTableViewCells() {
        

        
        let nibName1  = UINib(nibName: "VideoTableViewCell" , bundle: nil)
        allOffersTableView.register(nibName1, forCellReuseIdentifier: "VideoTableViewCell")
   
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return self.embedLinksAry.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let allOffersCell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        allOffersCell.label.text = churchNameAry[indexPath.row]
    
        let str : String = self.embedLinksAry[indexPath.row]
        
        
        videoIDArray = str.components(separatedBy: "=")
        
//        let name    = videoIDArray[0]
//        let surname = videoIDArray[1]
        
        

        allOffersCell.IdLabel.text = videoIDArray[1]
        
        print(videoIDArray[1])
        
       self.thumbnailImageURL = "https://img.youtube.com/vi/\(videoIDArray[1])/1.jpg"
        
        let videothumb = URL(string: self.thumbnailImageURL)
        
        if videothumb != nil{
        
        let request = URLRequest(url: videothumb!)
            
         let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                
                DispatchQueue.main.async()
                    {
            
             allOffersCell.thumbnailImageView.image = UIImage(data: data!)
                        
                }
                
         })
            
            dataTask.resume()
            
        }
        
        
        
        
        
        return allOffersCell
        
    }
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        self.player.load(withVideoId: self.videoIDArray[1],playerVars: playerVars)
        
        
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
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        
        print("Back Button Clicked......")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    

}
