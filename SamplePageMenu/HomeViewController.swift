//
//  HomeViewController.swift
//  SamplePageMenu
//
//  Created by Mac OS on 05/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize


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
    
    @IBOutlet weak var notificationbarBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var settingsBarButton: UIBarButtonItem!
   
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
    
    var loginVC = LoginViewController()

    var userId :  Int = 0

    
    var timer: Timer?
    
    var count = 0
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    
    var filteredData: [String]!
    
    var searchController: UISearchController!
    
    var searchActive : Bool = false
    var data = [" ","Categories".localize()]
    var filtered:[String] = []
    
    var cagegoriesArray:[CategoriesResultVo] = Array<CategoriesResultVo>()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var pageMenu : CAPSPageMenu?
    
    
    var appVersion          : String = ""
    
    var loginStatusString    =   String()
    
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
    
    var bannerImageArr = Array<UIImage>()
    
    var upComingEventsArray:[UpcomingEventsResultVO] = Array<UpcomingEventsResultVO>()
    var vedioEventsArray:[EventDetailsListResultVO] = Array<EventDetailsListResultVO>()

    var eventsImages = ""
    
    
//MARK: -   View DidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bannerImageScrollAPICall()
        
        
        let categorieHomeCell  = UINib(nibName: "CategorieHomeCell" , bundle: nil)
        categorieTableView.register(categorieHomeCell, forCellReuseIdentifier: "CategorieHomeCell")
        
        let scrollImagesCell  = UINib(nibName: "ScrollImagesCell" , bundle: nil)
        categorieTableView.register(scrollImagesCell, forCellReuseIdentifier: "ScrollImagesCell")
        
        let autoScrollImagesCell  = UINib(nibName: "AutoScrollImagesCell" , bundle: nil)
        categorieTableView.register(autoScrollImagesCell, forCellReuseIdentifier: "AutoScrollImagesCell")
   
        self.navigationController?.navigationBar.barTintColor = Utilities.appColor
        self.navigationItem.title = "Telugu Churches".localize()
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let textAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes

        
        
        print(kLoginSucessStatus)
        
        
        let defaults = UserDefaults.standard
        
        if let loginSucess = defaults.string(forKey: kLoginSucessStatus) {
            print(loginSucess)
            self.appDelegate.window?.makeToast(loginSucess, duration:kToastDuration, position:CSToastPositionCenter)
            
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
        
       // self.navigationItem.rightBarButtonItem?.badgeValue = "5";
        
    
        
       
  
        

        
    }
    
//MARK: -   View WillAppear

    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
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
        self.getAllCategoriesAPICall()
        
        
    }
    
//MARK: -   View WillDisappear

    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
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
                            
                            
                            let dataImg = try? Data(contentsOf: url!)
                            
                            if dataImg != nil {
                                
                                self.bannerImageArr.append(UIImage(data: dataImg!)!)
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

                            for (index, image) in self.bannerImageArr.enumerated() {
                                let image = image
                                let imageView = UIImageView(image: image)
                                imageView.contentMode = .scaleToFill
                                imageView.backgroundColor = UIColor.blue
                                
                                imageView.frame = self.bannerScrollView.frame
                                imageView.frame.origin.x = CGFloat(index) * UIScreen.main.bounds.size.width
                                print(UIScreen.main.bounds.size.width)
                                self.bannerScrollView.addSubview(imageView)
                                
                                }
                        
                        }
                        else {
                        
                         self.arrImages += [UIImage(named:"j1")!,UIImage(named: "j2")!, UIImage(named: "jesues")!, UIImage(named: "skyJSU")!, UIImage(named: "j3")!, UIImage(named: "j4")!, UIImage(named: "j6")!, UIImage(named: "jesues")!]
                             self.bannerImageArr = self.arrImages
                             self.categorieTableView.reloadData()
                                    }
                        
                        print(self.bannerImageArr)
                        
                        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.bannerAnimation), userInfo: nil, repeats: true)

                    }
        
            }
             
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
        
        self.eventImageArray.removeAll()
        
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
                
            else {
                
                
                
            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
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
        
        
        
        
                let parameters = [
                    "fromDate": "\(fromYearString)" + "-" + "\(fromMonthString)" + "-" + "\(fromDateString)",
                    "toDate": "\(toYearString)" + "-" + "\(toMonthString)" + "-" + "\(toDateString)",
                    ] as [String : Any]
        
        
        print("dic params \(parameters)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: UPCOMMINGEVENTS as NSString, postParams: parameters as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            
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
                
                
                let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
                RunLoop.current.add(timer, forMode: RunLoopMode.defaultRunLoopMode)

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
        }else{
            self.navigationItem.rightBarButtonItem?.badgeValue = ""
        }
        
    }
    
    func getUserCartCount( _ id : Int){
        
        
        let strUrl = GETCARTINFOAPI  + "\(id)"
        
        serviceController.getRequest(strURL: strUrl, success: { (result) in
            
            
            let respVO:GetCartInfoVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            
            
            
            if isSuccess == true {
                
                let listArr = respVO.listResult!
                
                 self.count = listArr.count
                  
                self.navigationItem.rightBarButtonItem?.badgeValue = "\(self.count)"
                
            }
            
            
            
            
        }) { (failureMessage) in
            
        }
        
    }
    
    func updateTimer() {
        seconds -= 1
        
    }
    
    //MARK: -   Search Bar Delegate & DataSource Methods

    
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
    
    //MARK: -   TableView Delegate & DataSource Methods

    
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
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            if indexPath.row == 0{
            
                return 150.0
            }
            
            else {
            return 170.0
                
            }
        }
            
        else {
            
            if indexPath.row == 0{
                
                return 130.0
            }
            
            else{
            return 150.0
            
            }
        }
   
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
     
  
        if indexPath.row == 0 {
 
            let cell = tableView.dequeueReusableCell(withIdentifier: "AutoScrollImagesCell", for: indexPath) as! AutoScrollImagesCell
            
            cell.autoScrollCollectionView.register(UINib.init(nibName: "AutoScrollCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "AutoScrollCollectionViewCell")
            
            
            cell.autoScrollCollectionView.tag = 0
            cell.autoScrollCollectionView.collectionViewLayout.invalidateLayout()
            cell.autoScrollCollectionView.delegate = self
            cell.autoScrollCollectionView.dataSource = self
            cell.autoScrollCollectionView.reloadData()
  
            return cell
            
            
        }
        
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategorieHomeCell", for: indexPath) as! CategorieHomeCell
            
            cell.homeCollectionView.register(UINib.init(nibName: "CategorieCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "CategorieCollectionViewCell")
            
            
            cell.homeCollectionView.tag = 1
            cell.homeCollectionView.collectionViewLayout.invalidateLayout()
            cell.homeCollectionView.delegate = self
            cell.homeCollectionView.dataSource = self
            cell.homeCollectionView.reloadData()
            
            
            cell.moreButton.addTarget(self, action: #selector(categorieOneClicked(_:)), for: UIControlEvents.touchUpInside)
            
            return cell
            
        }
        
    }
    
    
    
    func scrollAutomatically(_ timer1: Timer) {
        
        let indexPath : IndexPath = IndexPath(row: 0, section: 0)
        
   
        if let autoScrollImagesCell : AutoScrollImagesCell = self.categorieTableView.cellForRow(at: indexPath) as? AutoScrollImagesCell {

            if self.y < self.eventImageArray.count {
                
                let indexPath = IndexPath(item: y, section: 0)
                autoScrollImagesCell.autoScrollCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
                
                y = (eventImageArray.count - 1 > y) ? (y + 1) : 0
            }
                
            else {
                
                self.y = 0
                autoScrollImagesCell.autoScrollCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            }
            
            
     
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
                if indexPath.row == (cagegoriesArray.count) - 1 {
        
                    if(self.totalPages! > PageIndex){
        
                        PageIndex = PageIndex + 1
        
                        getAllCategoriesAPICall()
        
        
        
                    }
                }
    }
    
//MARK: -   Banner Animation

    
    func bannerAnimation() {
        
    
            
            let imgsCount:CGFloat = CGFloat(bannerImageArr.count)
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
    
    
    func  categorieOneClicked(_ sendre:UIButton) {
        
        
        let churchDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesHomeViewController") as! CategoriesHomeViewController
        churchDetailsViewController.categorieImageArray = self.imageArray as! Array<UIImage>
        churchDetailsViewController.categorieNamesArray = self.imageNameArray
        churchDetailsViewController.bibleInt = 10
        self.navigationController?.pushViewController(churchDetailsViewController, animated: true)
        
        print("Eye Button Clicked......")
        
        
        
    }
    func  categorieTwoClicked(_ sendre:UIButton) {
        
        
        
        
        let churchDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesHomeViewController") as! CategoriesHomeViewController
        churchDetailsViewController.categorieImageArray = self.imageArray2 as! Array<UIImage>
        churchDetailsViewController.categorieNamesArray = self.imageNameArray2
        churchDetailsViewController.bibleInt = 11
        
        self.navigationController?.pushViewController(churchDetailsViewController, animated: true)
        
        
        
        
    }
    
    func  categorieThreeClicked(_ sendre:UIButton) {
        
        let churchDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesHomeViewController") as! CategoriesHomeViewController
        churchDetailsViewController.categorieImageArray = self.imageArray3 as! Array<UIImage>
        churchDetailsViewController.categorieNamesArray = self.imageNameArray3
        churchDetailsViewController.bibleInt = 12
        
        self.navigationController?.pushViewController(churchDetailsViewController, animated: true)
        
    }
    
    
    @IBAction func notificationBtnAction(_ sender: Any) {
        
        
        if(self.count > 0) {
            
            
            let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddToCartViewController") as! AddToCartViewController
            
            
            self.navigationController?.pushViewController(jobIDViewController, animated: true)
            
        }else{
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login", clickAction: {
                 let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                self.loginVC = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as!LoginViewController
                
                self.loginVC.showNav = true
                self.loginVC.navigationString = "homeString"
                    
            self.navigationController?.pushViewController(self.loginVC, animated: true)
            
                })
        }
        
       
        
    }
    
    
    
}

//MARK: -   CollectionView Delegate & DataSource Methods


extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            
            if  collectionView.tag == 0 {
                
                print(eventImageArray.count)
                
                return eventImageArray.count
                
            }
                
            else  {
                
                return cagegoriesArray.count
                
            }
                

        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            
            if collectionView.tag  == 0 {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AutoScrollCollectionViewCell", for: indexPath) as! AutoScrollCollectionViewCell
                
                let eventImageString = eventImageArray[indexPath.row]
                
                let eventList: UpcomingEventsResultVO = upComingEventsArray[indexPath.row]
                
                cell.churchNameLabel.text = eventList.churchName
                cell.eventNameLabel.text = eventList.title
                cell.mobileNoLabel.text = eventList.contactNumber
                
                let startAndEndDate1 =   returnEventDateWithoutTim1(selectedDateString: eventList.startDate!)
                
                cell.eventDateLabel.text = startAndEndDate1
                

                
                
                print(eventImageArray.count)
                if let url = URL(string:eventImageString) {
                    cell.autoScrollImage.sd_setImage(with:url , placeholderImage: #imageLiteral(resourceName: "Church-logo"))
                }else{
                    cell.autoScrollImage.image = #imageLiteral(resourceName: "j4")
                }
                
                
                return cell
                
            }
                
            else {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategorieCollectionViewCell", for: indexPath) as! CategorieCollectionViewCell
                
 
              let categoryList:CategoriesResultVo = cagegoriesArray[indexPath.row]

                cell.nameLabel.text = categoryList.categoryName
                
                let imgUrl = categoryList.categoryImage
                
                let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
                
                
                if newString != nil {
                    
                    let url = URL(string:newString!)
                    
                    if url != nil {
                        
                        let dataImg = try? Data(contentsOf: url!)
                        
                        if dataImg != nil {
                            
                            cell.collectionImgView.image = UIImage(data: dataImg!)
                        }
                        else {
                            
                            cell.collectionImgView.image =  #imageLiteral(resourceName: "Church-logo")
                        }
                    }
                    
                }
                    
                else {
                    
                    cell.collectionImgView.image =  #imageLiteral(resourceName: "Church-logo")
                }
                
                
                
                
                return cell
                
                
            }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        if collectionView.tag == 0{
            
            if upComingEventsArray.count > 0{
                
                
                let eventList: UpcomingEventsResultVO = upComingEventsArray[indexPath.row]
                
                
                let eventDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailsViewController") as! EventDetailsViewController
                
                eventDetailsViewController.eventID = eventList.id!
    //            eventDetailsViewController.eventChurchName = eventList.churchName!
                eventDetailsViewController.eventName = eventList.title!
                
      //          eventDetailsViewController.catgoryID = eventList.churchId!
                
                
                self.navigationController?.pushViewController(eventDetailsViewController, animated: true)
            }
            
        }
 
        if collectionView.tag  == 1 {
            
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
         if collectionView.tag  == 0 {
            
           return CGSize(width: 300, height: 200)
        }
         else {
            
            return CGSize(width: 100, height: 100)
        }
        
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
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}





