//
//  HomeViewController.swift
//  SamplePageMenu
//
//  Created by Mac OS on 05/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize

//protocol changeSubtitleOfIndexDelegate {
//    func nameOfItem(indexNumber: Int, countText : String)
//}

protocol SttingPopOverHomeDelegate {
    func helpClicked()
    func aboutUS()
    func notificationClicked()
}

var cagegoriesArray:[CategoriesResultVo] = Array<CategoriesResultVo>()

class HomeViewController: UIViewController ,UIPopoverPresentationControllerDelegate,SttingPopOverHomeDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating,UIScrollViewDelegate  {
    
    @IBOutlet weak var categorieTableView: UITableView!
    
    @IBOutlet weak var bannerScrollView: UIScrollView!

    
    var offSet: CGFloat = 0
    var timer : Timer!
    var counter = 0
    
    var eventImage = String()
    var eventImageArray = Array<String>()
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    @IBOutlet weak var settingsBarButton: UIBarButtonItem!
    
    var x = 0
//    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    
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
    
    var eventsImages = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bannerImageScrollAPICall()
        
        self.getAllCategoriesAPICall()
        
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        
        searchBar.delegate = self
        
        filteredData = sectionTittles
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchController.dimsBackgroundDuringPresentation = false
        
        let categorieHomeCell  = UINib(nibName: "CategorieHomeCell" , bundle: nil)
        categorieTableView.register(categorieHomeCell, forCellReuseIdentifier: "CategorieHomeCell")
        
        let scrollImagesCell  = UINib(nibName: "ScrollImagesCell" , bundle: nil)
        categorieTableView.register(scrollImagesCell, forCellReuseIdentifier: "ScrollImagesCell")
        
        let autoScrollImagesCell  = UINib(nibName: "AutoScrollImagesCell" , bundle: nil)
        categorieTableView.register(autoScrollImagesCell, forCellReuseIdentifier: "AutoScrollImagesCell")
        
        let bannerCollectionViewCell  = UINib(nibName: "BannerCollectionViewCell" , bundle: nil)
        
        bannerCollectionView.register(bannerCollectionViewCell, forCellWithReuseIdentifier: "BannerCollectionViewCell")
        
        
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4039215686, green: 0.6705882353, blue: 0.8156862745, alpha: 1)
        self.navigationItem.title = "Telugu Churches".localize()
        
        
        searchBar.placeholder = "Telugu Churches"
        
        self.searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        // definesPresentationContext = true
        //        navigationItem.titleView  = searchController.searchBar
        
        navigationItem.titleView = searchBar
        
        
        print(kLoginSucessStatus)
        
        
        let defaults = UserDefaults.standard
        
        if let loginSucess = defaults.string(forKey: kLoginSucessStatus) {
            print(loginSucess)
            self.appDelegate.window?.makeToast(loginSucess, duration:kToastDuration, position:CSToastPositionCenter)
            
            print("defaults savedString: \(loginSucess)")
            
        }
        
        categorieTableView.dataSource = self
        categorieTableView.delegate = self
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        bannerScrollView.delegate = self
        
        sideMenu()
        
        //  self.navigationController?.isNavigationBarHidden = true
        
        definesPresentationContext = true
        
        
        
        offSet = 0
        
        
        
    }
    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getAllCategoriesAPICall()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        searchController.searchBar.resignFirstResponder()
        
        self.searchController.isActive = false
        
        
    }
    
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
                    
                    
                    //      self.churchNamesArray.removeAll()
                    
                    
                    if isSuccess == true {
                        
                        //self.listResultArray = respVO.listResult!
                        
                        let listArr = respVO.listResult!
                        
                        
                        for eachArray in listArr{
                            //  print(self.churchNamesArray)
                            // print(eachArray)
                            
                            //  let imgUrl = eachArray.bannerImage
                            
                            let imgUrl = eachArray.bannerImage ?? "https://salemnet.vo.llnwd.net/media/cms/CW/faith/42359-church-ThinkstockPhotos-139605937.1200w.tn.jpg"
                            
                            //  let newString = (imgUrl == nil ? "" : imgUrl.replacingOccurrences(of: "\\", with: "//"))
                            let newString = imgUrl.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
                            
                            print("filteredUrlString:\(String(describing: newString))")
                            
                            
                            let url = URL(string:newString)
                            
                            
                            let dataImg = try? Data(contentsOf: url!)
                            
                            if dataImg != nil {
                                
                                self.bannerImageArr.append(UIImage(data: dataImg!)!)
                            }
                            
                            print(self.bannerImageArr)
                            print(self.bannerImageArr.count)
                            
                            
                            
                            self.bannerCollectionView.reloadData()
                            
                            
                            
                            
                        }
                        
                    }
                    
                    
                    
            }
            
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
        
        self.categorieTableView.reloadData()
        self.upcommingEventsAPICall()
        
        
    }
    
    //MARK: -  Get All Categories API Call
    
    func getAllCategoriesAPICall(){
        
        let paramsDict = ["pageIndex": 1,
                            "pageSize": 15,
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
                
                
                
                print(self.cagegoriesArray.count)
                
                
                
                let pageCout  = (respVO.totalRecords)! / 10
                
                let remander = (respVO.totalRecords)! % 10
                
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
        
        
        
        
        //        let paramsDict = [
        //            "fromDate": "\(fromYearString)" + "-" + "\(fromMonthString)" + "-" + "\(fromDateString)",
        //            "toDate": "\(toYearString)" + "-" + "\(toMonthString)" + "-" + "\(toDateString)",
        //            ] as [String : Any]
        
        
        let paramsDict = [
            "fromDate": "2018-03-09T16:23:17.9129341+05:30",
            "toDate": "2018-03-09T16:23:17.9129341+05:30"
            ] as [String : Any]
        
        print("dic params \(paramsDict)")
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: UPCOMMINGEVENTS as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            
            let respVO:UpcomingEventsInfoVO = Mapper().map(JSONObject: result)!
            
            
            print("responseString = \(respVO)")
            
            
            let statusCode = respVO.isSuccess
            
            if statusCode == true
            {
                
                let successMsg = respVO.endUserMessage
                
                print(respVO.listResult)
                
                self.eventImageArray.removeAll()
                
                for churchDetails in respVO.listResult!{
                    
                    self.eventImage = churchDetails.eventImage ?? "https://salemnet.vo.llnwd.net/media/cms/CW/faith/42359-church-ThinkstockPhotos-139605937.1200w.tn.jpg"
                    
                    self.eventImage = (churchDetails.eventImage == nil ? "" : churchDetails.eventImage!.replacingOccurrences(of: "\\", with: "//"))
                    
                    
                    self.eventImageArray.append(self.eventImage)
                    // imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
                    
                }
                
                print(self.eventImageArray.count)
                
                self.categorieTableView.reloadData()
                
                
                
                
                
            }
            else {
                
                
            }
            
            
        }) { (failure) in
            
            
            
        }
        
        
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        
        //        if let searchText = searchController.searchBar.text {
        //
        //            filteredData = searchText.isEmpty ? sectionTittles : sectionTittles.filter({(dataString: String) -> Bool in
        //
        //                return (dataString.range(of: searchText) != nil)
        //            })
        //
        //                        categorieTableView.reloadData()
        //        }
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
        //        if(filtered.count == 0){
        searchActive = false
        //        } else {
        //            searchActive = true;
        //        }
        self.categorieTableView.reloadData()
        searchBar.resignFirstResponder()
        
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        //    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            
            filteredData = searchText.isEmpty ? sectionTittles : sectionTittles.filter({(dataString: String) -> Bool in
                
                return (dataString.range(of: searchText) != nil)
            })
            
            //            categorieTableView.reloadData()
        }
    }
    
    func sideMenu(){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            if revealViewController() != nil{
                
                menuBarButton.target = revealViewController()
                menuBarButton.action = #selector(revealViewController().revealToggle(_:))
                
                revealViewController().rearViewRevealWidth = 330
                
                //    revealViewController().rightViewRevealWidth = 160
                
                
                
                
            }
        }else{
            
            
            if revealViewController() != nil{
                
                menuBarButton.target = revealViewController()
                menuBarButton.action = #selector(revealViewController().revealToggle(_:))
                
                revealViewController().rearViewRevealWidth = 270
                
                //    revealViewController().rightViewRevealWidth = 160
                
                
                
                
            }
            
        }
        
    }
    
    
    
    
    
    @IBAction func settingClicked(_ sender: UIBarButtonItem) {
        // hometableview.endEditing(true)
        let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        popController.delegate = self
        // set the presentation style
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        popController.preferredContentSize = CGSize(width: 120, height: 120)
        //  popController.delegate = self
        let popover = popController.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = .up
        popover.sourceView = self.navigationController?.view
        
        popover.sourceRect = CGRect(x: UIScreen.main.bounds.size.width - 5 , y: 25, width:20, height: 30)
        
        // present the popover
        self.present(popController, animated: true, completion: nil)
        //  hometableview.reloadData()
    }
    
    
    
    @IBAction func settingBarButtonTapped(_ sender: Any) {
        
        
        //  print("Setting Clicked........")
        
        //  let settingViewController:UIViewController =  (self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController)!
        
        //    self.navigationController?.pushViewController(settingViewController, animated: true)
        
        
    }
    
    // UIPopoverPresentationControllerDelegate method
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // return UIModalPresentationStyle.FullScreen
        return UIModalPresentationStyle.none
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        if(searchActive) {
            return filtered.count
        }
        else {
            
            return data.count
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            
            return 200.0
        }
        else {
            
            return 180.0
            
            
        }
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        // let listStr:BannerImageScrollResultVo = bannerImageScrollArray[indexPath.row]
        
        //        if indexPath.section == 0 {
        //
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollImagesCell", for: indexPath) as! ScrollImagesCell
        //
        //
        //            cell.offSet = 0
        //            cell.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(doSomeAnimation), userInfo: nil, repeats: true)
        //
        //            if bannerImageArr.count > 0 {
        //
        //                cell.pageController.numberOfPages = bannerImageArr.count
        //                cell.scrollView.isPagingEnabled = true
        //                cell.scrollView.contentSize.height = 200
        //                cell.scrollView.backgroundColor = UIColor.white
        //                cell.scrollView.contentSize.width = UIScreen.main.bounds.size.width * CGFloat(bannerImageArr.count)
        //                cell.scrollView.showsHorizontalScrollIndicator = false
        //
        //                cell.scrollView.delegate = self
        //
        //
        //
        //                for (index, image) in bannerImageArr.enumerated() {
        //                    let image = image
        //                    let imageView = UIImageView(image: image)
        //                    imageView.contentMode = .scaleToFill
        //
        //                    imageView.frame.size.width = UIScreen.main.bounds.size.width
        //                    imageView.backgroundColor = UIColor.blue
        //                    imageView.frame.size.height = 200
        //                    imageView.frame.origin.x = CGFloat(index) * UIScreen.main.bounds.size.width
        //                    print(UIScreen.main.bounds.size.width)
        //
        //                    cell.scrollView.addSubview(imageView)
        //                }
        //
        //            }
        //            else {
        //
        //               self.arrImages += [UIImage(named:"j1")!,UIImage(named: "j2")!, UIImage(named: "jesues")!, UIImage(named: "skyJSU")!, UIImage(named: "j3")!, UIImage(named: "j4")!, UIImage(named: "j6")!, UIImage(named: "jesues")!]
        //
        //                self.bannerImageArr = self.arrImages
        //
        //                self.categorieTableView.reloadData()
        //            }
        //
        //            return cell
        //        }
        
        
        
        
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "AutoScrollImagesCell", for: indexPath) as! AutoScrollImagesCell
        //
        //            cell.autoScrollCollectionView.register(UINib.init(nibName: "CategorieCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "CategorieCollectionViewCell")
        //
        //            cell.autoScrollCollectionView.reloadData()
        //
        //            cell.autoScrollCollectionView.delegate = self
        //            cell.autoScrollCollectionView.dataSource = self
        //
        //
        //
        //            return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategorieHomeCell", for: indexPath) as! CategorieHomeCell
        
        cell.homeCollectionView.register(UINib.init(nibName: "CategorieCollectionViewCell", bundle: nil),
                                         forCellWithReuseIdentifier: "CategorieCollectionViewCell")
        
        
        cell.homeCollectionView.tag = indexPath.row
        cell.homeCollectionView.collectionViewLayout.invalidateLayout()
        cell.homeCollectionView.delegate = self
        cell.homeCollectionView.dataSource = self
        cell.homeCollectionView.reloadData()
        
        if indexPath.row == 0 {
            
            
            
            cell.moreButton.isHidden = true
            
        }
        
        if indexPath.row == 1 {
            
            cell.moreButton.isHidden = false
            
            cell.moreButton.addTarget(self, action: #selector(categorieOneClicked(_:)), for: UIControlEvents.touchUpInside)
            
        }
        
        
//        if indexPath.row == 2 {
//            
//            
//            cell.moreButton.addTarget(self, action: #selector(categorieTwoClicked(_:)), for: UIControlEvents.touchUpInside)
//        }
//        if indexPath.row == 3 {
//            
//            cell.moreButton.addTarget(self, action: #selector(categorieThreeClicked(_:)), for: UIControlEvents.touchUpInside)
//        }
        
        //            cell.homeCollectionView.tag = indexPath.section
        //            cell.homeCollectionView.collectionViewLayout.invalidateLayout()
        //            cell.homeCollectionView.delegate = self
        //            cell.homeCollectionView.dataSource = self
        //            cell.moreButton.addTarget(self, action: #selector(categorieThreeClicked(_:)), for: UIControlEvents.touchUpInside)
        //        cell.categoriesNameLabel.text = "Event Posts"
        
        
        if(searchActive){
            cell.categoriesNameLabel?.text = filtered[indexPath.row]
        } else {
            cell.categoriesNameLabel?.text = data[indexPath.row];
        }
        
        
        return cell
    }
    
    
    
    
    func scrollAutomatically(_ timer1: Timer) {
        
        let indexPath : IndexPath = IndexPath(row: 0, section: 0)
        
        
        
        if let autoScrollImagesCell : CategorieHomeCell = self.categorieTableView.cellForRow(at: indexPath) as? CategorieHomeCell {
            
            // if let coll = autoScrollImagesCell.autoScrollCollectionView {
            // for cell in coll.visibleCells {
            // let indexPath: IndexPath? = coll.indexPath(for: cell)
            // if ((indexPath?.row)! < imageArray3.count - 1){
            // let indexPath1: IndexPath?
            // indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
            //
            // coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
            // }
            // else{
            // let indexPath1: IndexPath?
            // indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
            // coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
            // }
            //
            // }
            // }
            
            // let cellSize = CGSizeMake(self.view.frame.width, self.view.frame.height)
            
            // let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
            //
            // //get current content Offset of the Collection view
            // let contentOffset = autoScrollImagesCell.autoScrollCollectionView.contentOffset
            //
            // if autoScrollImagesCell.autoScrollCollectionView.contentSize.width <= autoScrollImagesCell.autoScrollCollectionView.contentOffset.x + cellSize.width
            // {
            // autoScrollImagesCell.autoScrollCollectionView.scrollRectToVisible(CGSize(0, contentOffset.y, cellSize.width, cellSize.height), animated: true)
            //
            // } else {
            //
            //
            // autoScrollImagesCell.autoScrollCollectionView.scrollRectToVisible(CGSize(width: contentOffset.x + cellSize.width, height: contentOffset.y, cellSize.width, cellSize.height), animated: true)
            //
            // autoScrollImagesCell.autoScrollCollectionView.scrollRectToVisible(CGRectMake(contentOffset.x + cellSize.width, contentOffset.y, cellSize.width, cellSize.height), animated: true)
            //
            // }
            
            
            if self.x < self.eventImageArray.count {
                
                let indexPath = IndexPath(item: x, section: 0)
                autoScrollImagesCell.homeCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                // self.x = self.x + 1
                
                x = (eventImageArray.count - 1 > x) ? (x + 1) : 0
            }
                
            else {
                self.x = 0
                autoScrollImagesCell.homeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
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
    
    func doSomeAnimation() {
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        
        if let cell = categorieTableView.cellForRow(at: indexPath) as? ScrollImagesCell {
            
            let imgsCount:CGFloat = CGFloat(bannerImageArr.count)
            let pageWidth:CGFloat = cell.scrollView.frame.width
            let maxWidth:CGFloat = pageWidth * imgsCount
            let contentOffset:CGFloat = cell.scrollView.contentOffset.x
            
            var slideToX = contentOffset + pageWidth
            
            if  contentOffset + pageWidth == maxWidth{
                slideToX = 0
            }
            let currentPage:CGFloat = slideToX / pageWidth
            
            // print(currentPage)
            // Change the indicator
            cell.pageController.currentPage = Int(currentPage)
            cell.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:cell.scrollView.frame.height), animated: true)
        }
    }
    
    
    
    func bannerAnimation() {
        
        
        
        let imgsCount:CGFloat = CGFloat(bannerImageArr.count)
        let pageWidth:CGFloat = bannerCollectionView.frame.width
        let maxWidth:CGFloat = pageWidth * imgsCount
        let contentOffset:CGFloat = bannerCollectionView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
        }
        let currentPage:CGFloat = slideToX / pageWidth
        
        
        //    print(currentPage)
        
        pageController.currentPage = Int(currentPage)
        
        pageController.numberOfPages = bannerImageArr.count
        
        
        
        if x < self.bannerImageArr.count {
            
            let indexPath = IndexPath(item: x, section: 0)
            bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            
            x = (x < bannerImageArr.count - 1) ? (x + 1) : 0
            
            
            //get cell size
            
            //            let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
            //            //get current content Offset of the Collection view
            //            let contentOffset = bannerCollectionView.contentOffset
            //
            //            //scroll to next cell
            //            bannerCollectionView.scrollRectToVisible(CGRect(x:contentOffset.x + cellSize.width, y: contentOffset.y, width:cellSize.width, height:cellSize.height), animated: true)
            
            
            //            if x < bannerImageArr.count - 1{
            //
            //            x = x+1
            //
            //            }
            //
            //            else{
            //
            //
            //            x = 0
            //
            //            }
            
            print(x)
            
            
        }
            
        else {
            x = 0
            bannerCollectionView.scrollToItem(at: IndexPath(item: x, section: 0), at: .centeredHorizontally, animated: true)
            
            // print(x)
        }
        
        
        
        
    }
    
    //MARK: UIScrollView Delegate
    
    //
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //
    //
    //
    //
    //        let pageWidth: CGFloat = bannerCollectionView.frame.size.width
    //        let currentPage = Float((bannerCollectionView.contentOffset.x / pageWidth))
    //        if 0.0 != fmodf(currentPage, 1.0) {
    //            pageController.currentPage = Int(currentPage + 1.0)
    //        }
    //        else {
    //            pageController.currentPage = Int(currentPage)
    //        }
    //        print("finishPage: \(pageController.currentPage)")
    //    }
    //
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //
    //        let indexPath = IndexPath.init(row: x, section: 0)
    //
    //        if let cell = categorieTableView.cellForRow(at: indexPath) as? ScrollImagesCell {
    //
    //        let viewWidth: CGFloat = cell.scrollView.frame.size.width
    //        // content offset - tells by how much the scroll view has scrolled.
    //        let pageNumber = floor((cell.scrollView.contentOffset.x - viewWidth / 50) / viewWidth) + 1
    //        cell.pageController.currentPage = Int(pageNumber)
    //    }
    //
    //        searchController.searchBar.resignFirstResponder()
    //    }
    //
    
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
        //churchDetailsViewController.bibleString = bibleNav
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
    
    //MARK: -  BannerImageScroll API Call
    
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == bannerCollectionView {
            
            return bannerImageArr.count
            
        }
            
        else {
            
            if  collectionView.tag == 0 {
                
                print(eventImageArray.count)
                
                return eventImageArray.count
                
            }
                
            else  {
                
                return cagegoriesArray.count
                
            }
                
//            else  if collectionView.tag  == 2 {
//                
//                return imageArray2.count
//                
//            }
//            else {
//                
//                return imageArray3.count
//            }
            
            
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == bannerCollectionView{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
            
            
            print(bannerImageArr.count)
            
            if bannerImageArr.count > 0{
                
                bannerCollectionView.delegate = self
                bannerCollectionView.dataSource = self
                
                
                cell.bannerImage.image = bannerImageArr[indexPath.row]
                
                
                var rowIndex = indexPath.item
                
                let numberofRecords : Int = self.bannerImageArr.count - 1
                
                //
                //                if rowIndex < numberofRecords{
                //
                //                rowIndex = (rowIndex + 1)
                //
                //                }
                //
                //                else{
                //
                //                rowIndex = 0
                //
                //                }
                
                self.x = 0
                Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.bannerAnimation), userInfo: nil, repeats: true)
            }
            return cell
            
        }
            
        else {
            
            if collectionView.tag  == 0 {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategorieCollectionViewCell", for: indexPath) as! CategorieCollectionViewCell
                
                let eventImageString = eventImageArray[indexPath.row]
                
                print(eventImageArray.count)
                if let url = URL(string:eventImageString) {
                    cell.collectionImgView.sd_setImage(with:url , placeholderImage: #imageLiteral(resourceName: "Church-logo"))
                }else{
                    cell.collectionImgView.image = #imageLiteral(resourceName: "Church-logo")
                }
                self.x = 0
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
                
                return cell
                
            }
                
            else {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategorieCollectionViewCell", for: indexPath) as! CategorieCollectionViewCell
                
                
                let categoryList:CategoriesResultVo = cagegoriesArray[indexPath.row]
                
//                cell.collectionImgView.image = imageArray[ indexPath.row]
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
                
                
                
                //   let nibName  = UINib(nibName: "CategorieHomeCell" , bundle: nil)
                
                return cell
                
                
            }
//            else if collectionView.tag  == 2 {
//                
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategorieCollectionViewCell", for: indexPath) as! CategorieCollectionViewCell
//                
//                cell.collectionImgView.image = imageArray2[ indexPath.row]
//                cell.nameLabel.text = imageNameArray2[indexPath.row]
//                
//                // let nibName  = UINib(nibName: "CategorieHomeCell" , bundle: nil)
//                
//                
//                return cell
//                
//            }
//            else  {
//                
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategorieCollectionViewCell", for: indexPath) as! CategorieCollectionViewCell
//                
//                cell.collectionImgView.image = imageArray3[ indexPath.row]
//                cell.nameLabel.text = imageNameArray3[indexPath.row]
//                
//                //  let nibName  = UINib(nibName: "CategorieHomeCell" , bundle: nil)
//                
//                
//                return cell
//            }
            
            //        else {
            //
            //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AutoScrollCollectionViewCell", for: indexPath) as! AutoScrollCollectionViewCell
            //
            //          //  cell.autoScrollImage.image = imageArray3[ indexPath.row]
            //
            //          //  let nibName  = UINib(nibName: "AutoScrollImagesCell" , bundle: nil)
            //
            //
            //            return cell
            //
            //        }
            
            
            
            
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            var cellsPerRow = 0
            if collectionView == bannerCollectionView{
                
                
                cellsPerRow = 1
            }
            else{
                
                cellsPerRow = 5
            }
            
            let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
            let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
            return CGSize(width: itemWidth, height: itemWidth)
        }
        else {
            
            
            var cellsPerRow = 0
            if collectionView == bannerCollectionView{
                
                
                cellsPerRow = 1
            }
            else{
                
                cellsPerRow = 3
            }
            
            
            let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
            let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // handle tap events
//        print("You selected cell #\(indexPath.item)!")
//        
//        //        if collectionView == bannerCollectionView{
//        //
//        //        }
//        //
//        //
//        //        else{
//        //
//        if collectionView.tag  == 1 {
//            
//            if indexPath.item == 0 {
//                
//                
//                let churchDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChurchDetailsViewController") as! ChurchDetailsViewController
//                churchDetailsViewController.appVersion = imageNameArray[indexPath.item]
//                self.navigationController?.pushViewController(churchDetailsViewController, animated: true)
//            }
//            if indexPath.item == 1 {
//                
//                
//                let churchAdminViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChurchAdminViewController") as! ChurchAdminViewController
//                churchAdminViewController.appVersion = imageNameArray2[indexPath.item]
//                
//                self.navigationController?.pushViewController(churchAdminViewController, animated: true)
//                
//                
//                
//                
//            }
//            
//            if indexPath.item == 2 {
//                
//                let allEventsAndUpComingEventsViewController = self.storyboard?.instantiateViewController(withIdentifier: "AllEventsAndUpComingEventsViewController") as! AllEventsAndUpComingEventsViewController
//                allEventsAndUpComingEventsViewController.appVersion = imageNameArray3[indexPath.item]
//                self.navigationController?.pushViewController(allEventsAndUpComingEventsViewController, animated: true)
//                
//                
//            }
//            
//        }
//        
//        
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}





