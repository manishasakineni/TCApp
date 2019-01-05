//
//  HomeViewController.swift
//  SamplePageMenu
//
//  Created by Mac OS on 05/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize
import IQKeyboardManagerSwift


//MARK: -  Custom Protocol Delegate Methods

protocol SttingPopOverHomeDelegate {
    func helpClicked()
    func aboutUS()
    func notificationClicked()
}

var cagegoriesArray:[CategoriesResultVo] = Array<CategoriesResultVo>()


class HomeViewController: UIViewController ,UIPopoverPresentationControllerDelegate,SttingPopOverHomeDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating,UIScrollViewDelegate  {
    
    @IBOutlet weak var categorieTableView: UITableView!
    
    @IBOutlet weak var bannerScrollView: UIScrollView!
    
    @IBOutlet weak var bannerScrollHeight: NSLayoutConstraint!
    
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    @IBOutlet weak var cartbtn: UIBarButtonItem!
    
    @IBOutlet weak var notificationBtn: UIBarButtonItem!
    @IBOutlet weak var settingsBarButton: UIBarButtonItem!
    
    @IBOutlet weak var transpView: UIView!
    
    @IBOutlet weak var popupsView: UIView!
    
    @IBOutlet weak var toolPopupImgVW: UIImageView!
    @IBOutlet weak var toolPopupLbl: UILabel!
    
    @IBOutlet weak var toolOk: UIButton!
    
    @IBOutlet weak var gifImage: UIImageView!

    @IBOutlet weak var imagetrillingConstrant: NSLayoutConstraint!
    
    var churchDetailsArray:[ChurchDetailsListResultVO] = Array<ChurchDetailsListResultVO>()
    var morecategories = UIButton()
    
    
    var okbtnTag = 0
    
//MARK: -  variable declaration
    
    var visibleIndexPath: IndexPath? = nil
    var offSet: CGFloat = 0
    var counter = 0
    var seconds = 60
    
    var viewTitle = ""
    
    var lastXAxis = Int()
    var contentOffset = Int()
    
    var eventImage = String()
    var eventImageArray = Array<String>()
    
    var x = 0
    
    var y = 1
    
    var z = 1
    
    var loginVC = LoginViewController()
    
    var userId :  Int = 0
  
    var timer: Timer = Timer.init()
    
    var count = 0
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    
    var filteredData: [String]!
    
    var searchController: UISearchController!
    
    var searchActive : Bool = false
    var data = ["Upcoming Events".localize(),"Categories".localize(),"Churches".localize()]
    var filtered:[String] = []
    
    var cagegoriesArray:[CategoriesResultVo] = Array<CategoriesResultVo>()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var pageMenu : CAPSPageMenu?
    
    
    var appVersion: String = ""
    
    var loginStatusString = String()
    
    var timerForCollectionView: Timer!
    
    var bibleNav = false
    
    var sectionTittles = ["Church","Latest Posts","Categories".localize(),"Event Posts"]
    
    var photosUrlArray = ["A_Photographer.jpg","A_Song_of_Ice_and_Fire.jpg","Another_Rockaway_Sunset.jpg","Antelope_Butte.jpg"]
    
    var imageArray = [UIImage(named:"Holy bible"),UIImage(named:"Bible apps"),UIImage(named:"Bible study"),UIImage(named:"Book shop"),UIImage(named:"Images"),UIImage(named:"Testimonial"),UIImage(named:"Holy bible"),UIImage(named:"Bible apps"),UIImage(named:"Bible study")]
    var imageNameArray = ["Holy bible","Bible apps","Bible study","Book shop","Images","Testimonial","Holy bible","Bible apps","Bible study"]
    
    var imageArray2 = [UIImage(named:"ic_admin"),UIImage(named:"Doubts"),UIImage(named:"Gospel messages"),UIImage(named:"Quatation"),UIImage(named:"Scientific"),UIImage(named:"Suggestion"),UIImage(named:"Sunday school"),UIImage(named:"Testimonial"),UIImage(named:"Languages"),UIImage(named:"Login")]
    var imageNameArray2 = ["Admin","Doubts","Gospel messages","Quatation","Scientific","Suggestion","Sunday school","Testimonial","Languages","Login"]
    
    var arrImages = Array<UIImage>()
    
    
    var imageArray3 = [UIImage(named:"Events"),UIImage(named:"UpComelogo"),UIImage(named:"film"),UIImage(named:"help"),UIImage(named:"Map"),UIImage(named:"Donation"),UIImage(named:"Movies"),UIImage(named:"Songs"),UIImage(named:"Videos"),UIImage(named:"Donation"),UIImage(named:"pamphlet")]
    var imageNameArray3 = ["Events","UpComingEvents","film","help","Map","Donation","Movies","Songs","Videos","Donation","pamphlet"]

    var namesarra1 = ["Holy Bible","Audio Bible","Bible Study","Songs","Scientific Proofs","Gospel Messages","Short Messages","Images","Login id Creation","Help to develop the small churches","Book Shop","Movies","Daily Quotations","Video Songs","Testimonials","Quotations","Sunday School","Cell numbers for daily messages(Bulk sms)","Bible Apps","Short Films","Jobs","Route maps buds numbers","Events","Donation","Live","Doubts","Suggetions","Pamplets","languages(Tel/Eng)","Admin can add multiple menu pages"]
    
    var PageIndex = 1
    var totalPages : Int? = 0
    var totalRecords : Int? = 0
    
    
    var bannerImageScrollArray:[BannerImageScrollResultVo] = Array<BannerImageScrollResultVo>()
    
    var bannerImageArr = Array<URL>()
    
    var upComingEventsArray:[UpcomingEventsResultVO] = Array<UpcomingEventsResultVO>()
    var vedioEventsArray:[EventDetailsListResultVO] = Array<EventDetailsListResultVO>()
    
    var eventsImages = ""
    
     var paramsDict: [String: Any] = [:]
    
    var isAppAlreadyLaunchedOnce = Bool()
    var defaults = UserDefaults.standard
    
    //MARK: -   View DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
        let apppDelegate = UIApplication.shared.delegate as! AppDelegate
    
        if let expireTime = kUserDefaults.string(forKey: kExpires_in) {
            
            if(apppDelegate.isFirstTime == true){
                
                apppDelegate.isFirstTime = false
                timer.invalidate()
                
                let timeInt = Double(expireTime)!
                
                timer = Timer.scheduledTimer(timeInterval: timeInt, target: self, selector: #selector(self.BackgroundTimerCall), userInfo: nil, repeats: true)
            }
        }
        
        // Register Custom TableviewCell
        let categorieHomeCell  = UINib(nibName: "CategorieHomeCell" , bundle: nil)
        categorieTableView.register(categorieHomeCell, forCellReuseIdentifier: "CategorieHomeCell")
        
        let scrollImagesCell  = UINib(nibName: "ScrollImagesCell" , bundle: nil)
        categorieTableView.register(scrollImagesCell, forCellReuseIdentifier: "ScrollImagesCell")
        
        let autoScrollImagesCell  = UINib(nibName: "AutoScrollImagesCell" , bundle: nil)
        categorieTableView.register(autoScrollImagesCell, forCellReuseIdentifier: "AutoScrollImagesCell")

  
        print(kLoginSucessStatus)

        if let loginSucess = defaults.string(forKey: kLoginSucessStatus) {
            print(loginSucess)
            //      self.appDelegate.window?.makeToast(loginSucess, duration:kToastDuration, position:CSToastPositionCenter)
            
            print("defaults savedString: \(loginSucess)")
            
        }
        
        categorieTableView.dataSource = self
        categorieTableView.delegate = self
        bannerScrollView.delegate = self
        
        sideMenu()
        
        definesPresentationContext = true
        
        offSet = 0
        
        pageController.tintColor = Utilities.appColor
        pageController.numberOfPages = 0
        
        self.toolOk.addTarget(self, action: #selector(toolOkClicked(_:)), for: UIControlEvents.touchUpInside)
        
        popupsView.layer.cornerRadius =  toolPopupImgVW.frame.size.height/2
      
       cartbtn.isEnabled = false
      
    }
    
//MARK: -   View WillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if #available(iOS 11.0, *) {
            
            searchBar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        }
       // Set navigationController with title
        self.navigationController?.navigationBar.barTintColor = Utilities.appColor
        self.navigationItem.title = "Telugu Churches".localize()
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let textAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            
            userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
            
        }
        
        self.navigationController?.isNavigationBarHidden = false
        
        if(UIDevice.current.userInterfaceIdiom == .phone){
            
            self.bannerScrollHeight.constant = 200
        }
            
        else{
            
            self.bannerScrollHeight.constant = 300
        }
        
        self.cagegoriesArray.removeAll()
        
        // Calling  All Categories AND All Churches API-Service
        self.getAllCategoriesAPICall()
        self.getChurchesAPICall()

       toolPopupLbl.text = "Click here for Menu"
       
        if let isAppAlreadLaunchedOnce = defaults.value(forKey: "isAppAlreadyLaunchedOnce") as? Bool{
        print("App already launched : \(isAppAlreadyLaunchedOnce)")
        
        if isAppAlreadLaunchedOnce == true {
            self.imagetrillingConstrant.constant = -30
            let imageURL = UIImage.gifImageWithName("RedUp")
            gifImage.image = imageURL
            transpView.isHidden = false
            defaults.set(false, forKey: "isAppAlreadyLaunchedOnce")
            defaults.synchronize()
            self.navigationController?.navigationBar.isUserInteractionEnabled = false
        }
        else{
            transpView.isHidden = true
            self.navigationController?.navigationBar.isUserInteractionEnabled = true
        }
    }
 }
    
//MARK: -   View WillDisappear
    
    override func viewWillDisappear(_ animated: Bool) {
        if(timerForCollectionView != nil){
          timerForCollectionView.invalidate()
        }
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//MARK: - Suggestion Method (ToolTip-Method)
    
    func toolOkClicked(_ sender : UIButton) {
        
        popupsView.isHidden = true

        switch sender.tag {
        case 0:
            print("1 clicked ")
            sender.tag = okbtnTag + 1
            
           // popupsView.frame = CGRect(x: self.bannerScrollView.frame.maxX - 111, y: 70, width: 111, height: 96)
            
            self.imagetrillingConstrant.constant = 40
             popupsView.frame = CGRect(x: transpView.frame.maxX - 125, y: 75, width: 111, height: 96)
            popupsView.isHidden = false
            toolPopupLbl.text = "Click here for Notifications"

        case 1:
            print("3 clicked")
            sender.tag = sender.tag + 1
            
            if(UIDevice.current.userInterfaceIdiom == .phone){
                popupsView.frame = CGRect(x: transpView.frame.maxX - 150, y: self.categorieTableView.frame.minY + 30, width: 111, height: 96)
            }else{
                
                popupsView.frame = CGRect(x: transpView.frame.maxX - 150, y: 550, width: 111, height: 96)
            }
            popupsView.isHidden = false
            toolPopupLbl.text = "Click here for more Churches"
            
        default:
            print(okbtnTag)
            transpView.isHidden = true
            self.navigationController?.navigationBar.isUserInteractionEnabled = true
        }
        
    }

//MARK: - BackgroundTimer Call
    
    @objc func BackgroundTimerCall()
    {
        DispatchQueue.global(qos: .background).async {
            print("Refresh token API call running in background queue")
            
            if(self.appDelegate.checkInternetConnectivity()){
                
                 self.refreshTokenAPICall()
                
            }
            else {
                
                print("no internet connection")
            }
            
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")

                
            }
        }
    }
    
//MARK: -  Refresh Token API Call
    
    func refreshTokenAPICall(){
        
        if let rToken = kUserDefaults.string(forKey: kRefreshToken) {
            
            //            refreshToken = rToken
            
            paramsDict = [
                "client_id"     : "ConsoleApp",
                "client_secret" : "abc@123",
                "refresh_token" : rToken
                
                ] as [String : Any]
            
            
            let dictHeaders = ["":"","":""] as NSDictionary
            
            
            serviceController.refreshPostRequest(strURL: REFRESHTOKENAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
                
                print(result)
                
              
               let respVO:TokenVo = Mapper().map(JSONObject: result)!
                
                let isSuccess = respVO.isSuccess
                print("StatusCode:\(String(describing: isSuccess))")
                
                let endUserMsg = respVO.endUserMessage
                
                if isSuccess == true {
                    
                    
                    let acessToken = respVO.result?.access_token
                    let refToken = respVO.result?.refresh_token
                    let tokenType = respVO.result?.token_type
                    
                    kUserDefaults.set(acessToken, forKey: kAccess_token)
                    kUserDefaults.set(tokenType, forKey: kTokenType)
                    //                kUserDefaults.set(clientId, forKey: kClient_id)
                    kUserDefaults.set(refToken, forKey: kRefreshToken)
                    //                kUserDefaults.set(userid, forKey: kuserIdKey)
                    kUserDefaults.synchronize()
                    
                    NotificationCenter.default.post(name: Notification.Name("RefreshTokenIn"), object: nil)
                    
                }
                else{
                    //self.showAlertViewWithTitle("Alert".localize(), message: endUserMsg!, buttonTitle: "Ok".localize())
                }
                
            }) { (failureMessage) in
                
                
                print(failureMessage)
                
                self.refreshTokenAPICall()
                
            }
        }
    }
    
//MARK: - ShowAlertView for end user message
    
    func showAlertViewWithTitle(_ title:String,message:String,buttonTitle:String)
    {
        let alertView:UIAlertView = UIAlertView();
        alertView.title=title
        alertView.message=message
        alertView.addButton(withTitle: buttonTitle)
        alertView.show()
    }
    
//MARK: -   Banner Image Scroll APICall
    
    func bannerImageScrollAPICall(){

        let strUrl = BANNERIMAGESURL + "" + "null"
        
        print(strUrl)
        
        serviceController.getRequest(strURL:strUrl, success:{(result) in
            DispatchQueue.main.async()
                {
                    print(result)
                    
                    let respVO:BannerImageScrollVo = Mapper().map(JSONObject: result)!
                    
                    let isSuccess = respVO.isSuccess
                    print("StatusCode:\(String(describing: isSuccess))")
                    
                    if isSuccess == true {
                        
                        let listArr = respVO.listResult!
                        
                        for eachArray in listArr{
                            
                            let imgUrl = eachArray.bannerImage ?? "https://salemnet.vo.llnwd.net/media/cms/CW/faith/42359-church-ThinkstockPhotos-139605937.1200w.tn.jpg"
                            
                            let newString = imgUrl.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
                            
                            print("filteredUrlString:\(String(describing: newString))")
                            
                            
                            let url = URL(string:newString)
                            
                            
                            if url != nil {
                                
                                self.bannerImageArr.append(url!)
                            }
                        }
                        if self.bannerImageArr.count > 0 {
                            self.pageController.numberOfPages = self.bannerImageArr.count
                            self.bannerScrollView.isPagingEnabled = true
                            self.bannerScrollView.contentSize.height = 180
                            self.bannerScrollView.backgroundColor = UIColor.white
                            self.bannerScrollView.contentSize.width = UIScreen.main.bounds.size.width * CGFloat(self.bannerImageArr.count)
                            self.bannerScrollView.showsHorizontalScrollIndicator = false
                            self.bannerScrollView.delegate = self
                            for (index, _) in self.bannerImageArr.enumerated() {
                                let imageView = UIImageView()
                                imageView.contentMode = .scaleToFill
                                imageView.backgroundColor = UIColor.blue
                                imageView.frame = self.bannerScrollView.frame
                                imageView.frame.origin.x = CGFloat(index) * UIScreen.main.bounds.size.width
                                print(UIScreen.main.bounds.size.width)
                                imageView.sd_setImage(with:self.bannerImageArr[index] , placeholderImage: #imageLiteral(resourceName: "Church-logo"))
                                self.bannerScrollView.addSubview(imageView)
                            }
                        }
                        else{
                            self.arrImages += [UIImage(named:"j1")!,UIImage(named: "j2")!, UIImage(named: "jesues")!, UIImage(named: "skyJSU")!, UIImage(named: "j3")!, UIImage(named: "j4")!, UIImage(named: "j6")!, UIImage(named: "jesues")!]
                            self.categorieTableView.reloadData()
                        }
                        print(self.bannerImageArr)
                        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.bannerAnimation), userInfo: nil, repeats: true)
                    }
            }
            
        }) { (failureMessage) in
            
            print(failureMessage)
        }
        self.eventImageArray.removeAll()
        
     //Here calling Up Comming Events API-Service
        self.upcommingEventsAPICall()
        self.categorieTableView.reloadData()
    }
    
//MARK: -  Get All Categories API Call
    
    func getAllCategoriesAPICall(){
        
        let paramsDict = [  "active": 1,
                            "pageIndex": PageIndex,
                            "pageSize": 30,
                            "sortbyColumnName": "UpdatedDate",
                            "sortDirection": "desc",
                            "searchName": ""
            ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: GETALLCATEGORIES as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            print(result)
            let respVO:GetAllCategoriesVo = Mapper().map(JSONObject: result)!
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            
            if isSuccess == true {
                
                let listArr = respVO.listResult!
                
                for eachArray in listArr{
                    
                    self.cagegoriesArray.append(eachArray)
                }
                
                let pageCout  = (respVO.totalRecords)! / 15
                let remander = (respVO.totalRecords)! % 15
                self.totalPages = pageCout
                if remander != 0 {
                    self.totalPages = self.totalPages! + 1
                }
                self.categorieTableView.reloadData()
            }
            else{
            }
            
        }) { (failureMessage) in
            
            print(failureMessage)
        }
        self.bannerImageArr.removeAll()
        
      // Here calling BannerImageScrollI API-Service
        self.bannerImageScrollAPICall()
        self.categorieTableView.reloadData()
    }
    
    
//MARK: -   upComming Events APICall
    
    func upcommingEventsAPICall(){
        
        let date =  (Calendar.current as NSCalendar).date(byAdding: .day, value: 7, to: Date(), options: [])
        
        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = "dd"
        fromDateFormatter.timeZone = NSTimeZone.local
        let fromDateString = fromDateFormatter.string(from: Date())
        let toDateString = fromDateFormatter.string(from: date!)
        print("fromDateString And toDateString",fromDateString,toDateString)
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        monthFormatter.timeZone = NSTimeZone.local
        let fromMonthString = monthFormatter.string(from: Date())
        let toMonthString = monthFormatter.string(from: date!)
        print("fromMonthString and toMonthString",fromMonthString,toMonthString)
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        let fromYearString = yearFormatter.string(from: Date())
        let toYearString = yearFormatter.string(from: date!)
        print("fromYearString And toYearString",fromYearString,toYearString)
        
     // Parameters Passing
        let parameters = [
            "fromDate": "\(fromYearString)" + "-" + "\(fromMonthString)" + "-" + "\(fromDateString)",
            "toDate": "\(toYearString)" + "-" + "\(toMonthString)" + "-" + "\(toDateString)",
            ] as [String : Any]
        
        
        print("dic params \(parameters)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        serviceController.postRequest(strURL: UPCOMMINGEVENTS as NSString, postParams: parameters as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            let respVO:UpcomingEventsInfoVO = Mapper().map(JSONObject: result)!
            
            print("responseString = \(respVO)")
            
            let statusCode = respVO.isSuccess
            
            if statusCode == true
            {
                self.eventImageArray.removeAll()
                for churchDetails in respVO.listResult!{
                    self.eventImage = churchDetails.eventImage ?? "https://salemnet.vo.llnwd.net/media/cms/CW/faith/42359-church-ThinkstockPhotos-139605937.1200w.tn.jpg"
                    self.eventImage = (churchDetails.eventImage == nil ? "" : churchDetails.eventImage!.replacingOccurrences(of: "\\", with: "//"))
                    self.eventImageArray.append(self.eventImage)
                    self.upComingEventsArray.append(churchDetails)
                }
                if self.eventImageArray.count > 0{
                   self.timerForCollectionView = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
                    RunLoop.current.add(self.timerForCollectionView, forMode: RunLoopMode.defaultRunLoopMode)
                }
                self.categorieTableView.reloadData()
            }
            else {
            }
            
        }) { (failure) in
    }
        var userId = 0
        
        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
        }
        if(userId != 0){
            getUserCartCount(userId)
            getNotificationCount()
            
        }
        else{
            
        }
    }

//MARK: - Here ChurchesAPI-Service
    
    func getChurchesAPICall(){
       
        self.churchDetailsArray.removeAll()
        
        let paramsDict = [
            
            "userId": 1,
            "pageIndex": 1,
            "pageSize": 50,
            "sortbyColumnName": "UpdatedDate",
            "sortDirection": "desc",
            "searchName": ""
            
            ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        serviceController.postRequest(strURL: GETALLACTIVECHURCHESAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            let respVO:ChurchDetailsJsonVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            
            print("StatusCode:\(String(describing: isSuccess))")
            
            if isSuccess == true {
                let listArr = respVO.listResult!
                if listArr.count > 0 {
                  
                    for eachArray in listArr{
                        
                        self.churchDetailsArray.append(eachArray)
                        
                        print("eachArray.churchImage",eachArray.churchImage ?? "")
                    }
                       self.categorieTableView.reloadData()
                }
            }
            
        }) { (failureMessage) in
            
            print(failureMessage)
            
        }

    }
    
//MARK: - Here CartCount API-Service
    func getUserCartCount( _ id : Int){
        
        let strUrl = GETCARTINFOAPI  + "\(id)"
        serviceController.getRequest(strURL: strUrl, success: { (result) in
            
            let respVO:GetCartInfoVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
   
            if isSuccess == true {
                
                let listArr = respVO.listResult!
                
                let cartCount = listArr.count
                    
            }
            
        }) { (failureMessage) in
            
    }
}
 
//MARK: - Here Notification Count API-Service
    func getNotificationCount() {
        
        let getNotificationAPI = GETUNREADNOTIFICATIONAPI
        
        let parameters = [
            "sortDirection":"desc",
            "sortbyColumnName":"UpdatedDate",
            "userId":self.userId,
            "pageIndex": 1,
            "pageSize": 10
            ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        serviceController.postRequest(strURL: getNotificationAPI as NSString, postParams: parameters as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
        let respVO:getNotificationResultVO = Mapper().map(JSONObject: result)!
            let isSuccess = respVO.isSuccess
            if isSuccess == true{
                let unreadNotificationCount = respVO.result?.unreadCount
                
                self.notificationBtn.badgeValue = "\(String(describing: unreadNotificationCount!))" == "" ? "0" : "\(String(describing: unreadNotificationCount!))"
            }
        }) { (failure) in
            
    }
        
}
    
//MARK: - Update Timer Count
    func updateTimer() {
        seconds -= 1
    }
    
    
           //::::::::::::::::::::::::::::::::::::::::::: Search Bar Delegate & DataSource Methods ::::::::::::::::::::::::::::::::::::::::::://
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    @objc(searchBarBookmarkButtonClicked:) func searchBarBookmarkButtonClicked(_ rchBar: UISearchBar) {
        searchActive = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
        self.categorieTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchActive = false
        self.categorieTableView.reloadData()
        searchBar.resignFirstResponder()
    }
    func updateSearchResults(for searchController: UISearchController) {
        
        
        if let searchText = searchController.searchBar.text {
            
            filteredData = searchText.isEmpty ? sectionTittles : sectionTittles.filter({(dataString: String) -> Bool in
                
                return (dataString.range(of: searchText) != nil)
            })
            
        }
    }
    
//MARK: -   Side Menu Method
    
    func sideMenu(){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            if revealViewController() != nil{
                menuBarButton.target = revealViewController()
                menuBarButton.action = #selector(revealViewController().revealToggle(_:))
                
                revealViewController().rearViewRevealWidth = 330
            }
        }else{
            if revealViewController() != nil{
                menuBarButton.target = revealViewController()
                menuBarButton.action = #selector(revealViewController().revealToggle(_:))
                revealViewController().rearViewRevealWidth = 270
            }
            
        }
        
    }
    
    
//MARK: -   Setting Button Action
    @IBAction func settingClicked(_ sender: UIBarButtonItem) {
        let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        popController.delegate = self
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        popController.preferredContentSize = CGSize(width: 120, height: 120)
        let popover = popController.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = .up
        popover.sourceView = self.navigationController?.view
        popover.sourceRect = CGRect(x: UIScreen.main.bounds.size.width - 5 , y: 25, width:20, height: 30)
        self.present(popController, animated: true, completion: nil)
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    //:::::::::::::::::::::::::::::::::::::::::::::::::::::  TableView Delegate & DataSource Methods ::::::::::::::::::::::::::::::::::::::::::::::::::::://
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
      
        return data.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            if indexPath.row == 0 {
                
             return 160
           }
            if indexPath.row == 1 {
              if eventImageArray.count > 0{
                    return 180.0
                }
                else
                   {
                   return 0.0
                }
            }
            else{
                return 150.0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        if indexPath.row == 0 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "AutoScrollImagesCell", for: indexPath) as! AutoScrollImagesCell
            
            cell.autoScrollCollectionView.register(UINib.init(nibName: "ChurchesCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "ChurchesCollectionViewCell")
            cell.upcomingEventsTitle.text = "Churches".localize()
            cell.moreBtn.isHidden = false
            cell.autoScrollCollectionView.tag = 0
            cell.autoScrollCollectionView.collectionViewLayout.invalidateLayout()
            cell.autoScrollCollectionView.delegate = self
            cell.autoScrollCollectionView.dataSource = self
            cell.autoScrollCollectionView.reloadData()
            cell.moreBtn.addTarget(self, action: #selector(categorieOneClicked(_:)), for: UIControlEvents.touchUpInside)
            self.morecategories.frame = cell.moreBtn.frame
            return cell
        }
        if indexPath.row == 1  {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AutoScrollImagesCell", for: indexPath) as! AutoScrollImagesCell
            cell.autoScrollCollectionView.register(UINib.init(nibName: "AutoScrollCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "AutoScrollCollectionViewCell")
            cell.upcomingEventsTitle.text = "Upcoming Events".localize()
            cell.moreBtn.isHidden = true
            cell.autoScrollCollectionView.tag = 1
            cell.autoScrollCollectionView.collectionViewLayout.invalidateLayout()
            cell.autoScrollCollectionView.delegate = self
            cell.autoScrollCollectionView.dataSource = self
            cell.autoScrollCollectionView.reloadData()
            
            if eventImageArray.count > 0{
                
                cell.upcomingEventsTitle.isHidden = false
            }
            else
            {
                cell.upcomingEventsTitle.isHidden = true
            }
            return cell
            
        }
        
        if indexPath.row == 2  {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategorieHomeCell", for: indexPath) as! CategorieHomeCell
            
            cell.homeCollectionView.register(UINib.init(nibName: "CategorieCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "CategorieCollectionViewCell")
            cell.homeCollectionView.tag = 2
            cell.homeCollectionView.collectionViewLayout.invalidateLayout()
            cell.homeCollectionView.delegate = self
            cell.homeCollectionView.dataSource = self
            cell.homeCollectionView.reloadData()
            cell.moreButton.addTarget(self, action: #selector(categorieTwoClicked(_:)), for: UIControlEvents.touchUpInside)
            self.morecategories.frame = cell.moreButton.frame
            
            return cell
        }
        return UITableViewCell()
        
    }
  
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == (cagegoriesArray.count) - 1 {
            
            if(self.totalPages! > PageIndex){
                
                PageIndex = PageIndex + 1
               
            }
        }
    }

  //MARK: - ScrollAutomatically Images or Records(Animation)
    
    func scrollAutomatically(_ timer1: Timer) {
        
        let indexPath : IndexPath = IndexPath(row: 1, section: 0)
        if let autoScrollImagesCell : AutoScrollImagesCell = self.categorieTableView.cellForRow(at: indexPath) as? AutoScrollImagesCell {
            if self.y < self.eventImageArray.count {
                let newIndexPath = IndexPath(item: y, section: 0)
                print("Test")
                print(y)
                print(self.eventImageArray.count)
                autoScrollImagesCell.autoScrollCollectionView.scrollToItem(at: newIndexPath, at: .left, animated: true)
                y = (eventImageArray.count - 1 > y) ? (y + 1) : 0
            }
            else{
                self.y = 0
                autoScrollImagesCell.autoScrollCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
            }
        }
        let indexPath0 : IndexPath = IndexPath(row: 0, section: 0)
        
        if let autoScrollImagesCell0 : AutoScrollImagesCell = self.categorieTableView.cellForRow(at: indexPath0) as? AutoScrollImagesCell {
            if self.z < self.churchDetailsArray.count {
                let newIndexPath0 = IndexPath(item: z, section: 0)
                print("Test")
                print(z)
                print(self.churchDetailsArray.count)
                autoScrollImagesCell0.autoScrollCollectionView.scrollToItem(at: newIndexPath0, at: .left, animated: true)
                z = (churchDetailsArray.count - 1 > z) ? (z + 1) : 0
            }
            else{
                self.z = 0
                autoScrollImagesCell0.autoScrollCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
            }
        }
    }
    
//MARK: -   Banner Animation
    func bannerAnimation() {
 
        let imgsCount:CGFloat = CGFloat(bannerImageArr.count)
        print("In bannerImageArr.count",bannerImageArr.count)
        let pageWidth:CGFloat = bannerScrollView.frame.width
        let maxWidth:CGFloat = pageWidth * imgsCount
        let contentOffset:CGFloat = bannerScrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
        }
        let currentPage:CGFloat = slideToX / pageWidth
        pageController.currentPage = Int(currentPage)
        bannerScrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:bannerScrollView.frame.height), animated: true)
          print("Out bannerImageArr.count",bannerImageArr.count)
    }
  
//MARK: Page tap action
    func pageChanged() {
        let indexPath = IndexPath.init(row: 1, section: 0)
        
        if let cell = categorieTableView.cellForRow(at: indexPath) as? ScrollImagesCell {
            
            let pageNumber = cell.pageController.currentPage
            var frame = cell.scrollView.frame
            frame.origin.x = frame.size.width * CGFloat(pageNumber)
            frame.origin.y = 0
            cell.scrollView.scrollRectToVisible(frame, animated: true)
        }
    }
    func helpClicked(){
        print("editProfileClicked")
    }
    
    func aboutUS(){
        print("changePassWordClicked")
    }
    func notificationClicked(){
        print("notificationClicked")
    }
    
//MARK: More Button Action it will show list of Churches related records or information
    func categorieOneClicked(_ sendre:UIButton) {
        let churchDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChurchDetailsViewController") as! ChurchDetailsViewController
        self.navigationController?.pushViewController(churchDetailsViewController, animated: true)
        print("Eye Button Clicked......")
    }
//MARK: More Button Action it will show list of Categorie related records or information
    func  categorieTwoClicked(_ sendre:UIButton) {
        let churchDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesHomeViewController") as! CategoriesHomeViewController
        churchDetailsViewController.categorieImageArray = self.imageArray as! Array<UIImage>
        churchDetailsViewController.categorieNamesArray = self.imageNameArray
        churchDetailsViewController.bibleInt = 10
        self.navigationController?.pushViewController(churchDetailsViewController, animated: true)
    }
    func  categorieThreeClicked(_ sendre:UIButton) {
        let churchDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesHomeViewController") as! CategoriesHomeViewController
        churchDetailsViewController.categorieImageArray = self.imageArray3 as! Array<UIImage>
        churchDetailsViewController.categorieNamesArray = self.imageNameArray3
        churchDetailsViewController.bibleInt = 12
        self.navigationController?.pushViewController(churchDetailsViewController, animated: true)
    }
    
 //MARK: Notification AND Cart Button Action
    @IBAction func notificationAndCartBtnAction(_ sender: UIBarButtonItem) {
        
        if self.userId != 0 {
            if sender.tag == 0 {
                let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddToCartViewController") as! AddToCartViewController
                self.navigationController?.pushViewController(jobIDViewController, animated: true)
            }
            else{
                let notificationVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
                self.navigationController?.pushViewController(notificationVC, animated: true)
            }
        }
        else{
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login".localize(), clickAction: {
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                self.loginVC = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as!LoginViewController
                self.loginVC.showNav = true
                self.loginVC.navigationString = "homeString"
                self.navigationController?.pushViewController(self.loginVC, animated: true)
            })
        }
    }
}

             //:::::::::::::::::::::::::::::::::::::::  CollectionView Delegate & DataSource Methods ::::::::::::::::::::::::::::::::::::::://

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if  collectionView.tag == 0 {
            print(churchDetailsArray.count)
            return churchDetailsArray.count
        }
        else if  collectionView.tag == 1 {
            print(eventImageArray.count)
            return eventImageArray.count
        }
        else {
            return cagegoriesArray.count
        }
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag  == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChurchesCollectionViewCell", for: indexPath) as! ChurchesCollectionViewCell
            let listStr:ChurchDetailsListResultVO = churchDetailsArray[indexPath.row]
            cell.churchNameLbl.text  = listStr.name  == nil ? "" :  listStr.name
            cell.phNoLabel.text      = listStr.contactNumber == nil ? "" :  listStr.contactNumber
            cell.addressLabel.text   = listStr.email == nil ? "" :  listStr.email
            cell.stateLbl.text       = listStr.stateName == nil ? "" :  listStr.stateName
            cell.mandalLbl.text      = listStr.mandalName == nil ? "" :  listStr.mandalName
            cell.districtLbl.text    = listStr.districtName == nil ? "" :  listStr.districtName
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss."
            let date = dateFormatter.date(from: listStr.openingTime!)
            // To convert the date into an HH:mm format
            dateFormatter.dateFormat = "hh:mm a" // or //h:mm a
            let dateString = dateFormatter.string(from: date!)
            print(dateString)
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "HH:mm:ss."
            let date1 = dateFormatter1.date(from: listStr.closingTime!)
            // To convert the date into an HH:mm format
            dateFormatter1.dateFormat = "hh:mm a" // or //h:mm a
            let dateString1 = dateFormatter1.string(from: date1!)
            print(dateString1)
            
            cell.timeLabel.text = dateString + " - " + dateString1
            let imgUrl = listStr.churchImage
            let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            if newString != nil {
                let url = URL(string:newString!)
                if url != nil {
                    cell.churchImage.sd_setImage(with:url , placeholderImage: #imageLiteral(resourceName: "Church-logo"))
                }
                else{
                    cell.churchImage.image = #imageLiteral(resourceName: "church13")
                }
            }
            else{
                cell.churchImage.image = #imageLiteral(resourceName: "church13")
            }
            return cell
        }
        if collectionView.tag  == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AutoScrollCollectionViewCell", for: indexPath) as! AutoScrollCollectionViewCell
            
            let eventImageString = eventImageArray[indexPath.row]
            
            let eventList: UpcomingEventsResultVO = upComingEventsArray[indexPath.row]
            if eventList.churchName  != nil {
                if let churchName = eventList.churchName {
                    cell.churchNameLabel.text = churchName
                    cell.churchName.text = "Church Name".localize()
                }else{
                    cell.churchName.text = ""
                }
            }
            else if eventList.authorName != nil {
                if let authorName =  eventList.authorName {
                    cell.churchNameLabel.text = authorName
                    // listOfMonthEventCell.churchANDAuthorName.text = "authorName"
                    cell.churchName.text = "Pastor Name".localize()
                }else{
                    cell.churchNameLabel.text = ""
                }
            }
            else{
                cell.churchNameLabel.text = ""
            }
            cell.eventNameLabel.text = eventList.title
            if eventList.contactNumber  != nil {
                if let contactNumber = eventList.contactNumber {
                    cell.mobileNoLabel.text = contactNumber
                    cell.mobileNumber.text = "Contact Number".localize()
                }else{
                    cell.mobileNoLabel.text = ""
                }
            }
            else if eventList.mobileNumber != nil {
                if let mobileNumber =  eventList.mobileNumber {
                    cell.mobileNoLabel.text = mobileNumber
                    cell.mobileNumber.text = "Mobile Number".localize()
                }else{
                    cell.mobileNoLabel.text = ""
                }
            }
            else{
                cell.mobileNoLabel.text = ""
            }
            let startAndEndDate1 =   returnEventDateWithoutTim1(selectedDateString: eventList.startDate!)
            cell.eventDateLabel.text = startAndEndDate1
            let startAndEndDate2 =   returnEventDateWithoutTim1(selectedDateString: eventList.endDate!)
            cell.eventToLbl.text = startAndEndDate2
            print(eventImageArray.count)
            if let url = URL(string:eventImageString) {
                cell.autoScrollImage.sd_setImage(with:url , placeholderImage: #imageLiteral(resourceName: "upcomingevents4"))
            }else{
                cell.autoScrollImage.image = #imageLiteral(resourceName: "upcomingevents4.jpg")
            }
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategorieCollectionViewCell", for: indexPath) as! CategorieCollectionViewCell
            let categoryList:CategoriesResultVo = cagegoriesArray[indexPath.row]
            cell.nameLabel.text = categoryList.categoryName
            let imgUrl = categoryList.categoryImage
            let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            if newString != nil {
                let url = URL(string:newString!)
                
                if url != nil {
                    
                    cell.collectionImgView.sd_setImage(with:url , placeholderImage: #imageLiteral(resourceName: "Church-logo"))
                }else{
                    cell.collectionImgView.image =  #imageLiteral(resourceName: "Church-logo")
                }
            }
            else{
                
                cell.collectionImgView.image =  #imageLiteral(resourceName: "Church-logo")
            }
            return cell
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        if collectionView.tag == 0{
            
            if self.churchDetailsArray.count > 0 {
                let listStr:ChurchDetailsListResultVO = churchDetailsArray[indexPath.row]
                
                let holyBibleViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChurchesInformaationViewControllers") as! ChurchesInformaationViewControllers
                holyBibleViewController.pasterUserId = listStr.pasterUserId ?? 0
                holyBibleViewController.churchID = listStr.Id!
                holyBibleViewController.isFromChruch = false
                holyBibleViewController.nameStr = listStr.name!
                self.navigationController?.pushViewController(holyBibleViewController, animated: true)
            }
        }
        if collectionView.tag == 1{
            
            if upComingEventsArray.count > 0{
                let eventList: UpcomingEventsResultVO = upComingEventsArray[indexPath.row]
                let eventDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailsViewController") as! EventDetailsViewController
                eventDetailsViewController.eventID = eventList.id!
                eventDetailsViewController.eventChurchName = eventList.churchName ?? "0"
                eventDetailsViewController.eventName = eventList.title!
                eventDetailsViewController.homeString = "homeString"
                eventDetailsViewController.catgoryID = eventList.churchId ?? 0
                
                self.navigationController?.pushViewController(eventDetailsViewController, animated: true)
            }
        }
        if collectionView.tag  == 2 {
            
            if cagegoriesArray.count > 0 {
                
                let categoryList:CategoriesResultVo = cagegoriesArray[indexPath.row]
                let categoryId = categoryList.id
                let catImg = categoryList.categoryImage
                let catName = categoryList.categoryName
                let textName = categoryList.categoryName
                let churchDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "VideoSongsViewController") as! VideoSongsViewController
                churchDetailsViewController.catgoryID = categoryId!
                churchDetailsViewController.catgoryName = catName!
                churchDetailsViewController.viewTitle = textName!
                
                if catImg != nil {
                    
                    churchDetailsViewController.catgoryImg = catImg!
                }
                
                self.navigationController?.pushViewController(churchDetailsViewController, animated: true)
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,willDisplay cell: UICollectionViewCell,forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag  == 0 {
            
            return CGSize(width: self.view.frame.size.width, height: 140)
        }
        else if collectionView.tag  == 1 {
            return CGSize(width: self.view.frame.size.width, height: 200)
        }
        else{
            return CGSize(width: 100, height: 100)
        }
        
    }
    
//MARK: - Convert Date and Time DateFormatter
    
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
    
//MARK: - Convert DateFormatFrom24Hto12H
    func dateFormatFrom24Hto12H(selectedString : String) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss."
        let date = dateFormatter.date(from: selectedString)
        // To convert the date into an HH:mm format
        dateFormatter.dateFormat = "hh:mm a" // or //h:mm a
        let dateString = dateFormatter.string(from: date!)
        print(dateString)
        
        return dateString
    }
}





