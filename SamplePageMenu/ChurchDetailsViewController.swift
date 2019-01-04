//
//  ChurchDetailsViewController.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 19/02/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import SDWebImage
import IQKeyboardManagerSwift

class ChurchDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating {

    @IBOutlet weak var churchDetailsTableView: UITableView!
    
    @IBOutlet weak var noRecordLabel: UILabel!
    
//MARK: -  variable declaration
 
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    var searchController: UISearchController!
    var searchActive : Bool = false
    var filteredData: [String]!
    var bibleInt = Int()
    var filtered:[ChurchDetailsListResultVO] = []
    var churchID            : Int = 0
    var appVersion          : String = ""
    var sortbyColumnName : String = ""
    var loginVC = LoginViewController()
    var data = Array<String>()
    var showNav = false
    var searchTextStr:String = ""
    var listResultArray = Array<Any>()
    var churchNamesArray:[ChurchDetailsListResultVO] = Array<ChurchDetailsListResultVO>()
    var churchIDArray = Array<Int>()
    var villageNamesArray = Array<String>()
    var phoneNoArray = Array<String>()
    var updatedDateArray = Array<String>()
    var addressArray = Array<String>()
    var churchImageArray = Array<String>()
    var churchArray = Array<String>()
    var userId = Int()
    var uid : Int = 0
    var PageIndex = 1
    var totalPages : Int? = 0
    var totalRecords : Int? = 0
    var isSubscribed = Int()
    var subscribe : Bool = true
    
    var imageArray = [UIImage(named:"7"),UIImage(named:"5"),UIImage(named:"4"),UIImage(named:"7"),UIImage(named:"5"),UIImage(named:"4"),UIImage(named:"7"),UIImage(named:"4")]
    
    var AreanamesArray = ["Kukatpally","Uppal","Ameerpet","JNTU","MGPS","PUNG","KPHP","MYP"]
    
   
    var TimingsArray = ["OPEN5AM Close5PM ","OPEN6AM Close5PM","OPEN7AM Close8PM","OPEN8AM Close5PM","OPEN9AM Close4PM","OPEN5AM Close5PM","OPEN7AM Close5PM","OPEN6AM Close5PM"]
    
 
//MARK: -   View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            
            self.userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
            
        }
        
        self.churchDetailsTableView.delegate = self
        self.churchDetailsTableView.dataSource = self
        
        self.noRecordLabel.isHidden = true
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.tintColor = UIColor.black
        searchBar.delegate = self
        searchBar.placeholder = "Search by Church Name".localize()
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.titleView = searchBar
        searchController.searchBar.setValue("New Title", forKey: "cancelButtonText")

        // Registring tableview cells
        
        churchDetailsTableView.register(UINib.init(nibName: "ChurchDetailsTableViewCell", bundle: nil),forCellReuseIdentifier: "ChurchDetailsTableViewCell")
        churchDetailsTableView.register(UINib.init(nibName: "InfoHeaderCell", bundle: nil), forCellReuseIdentifier: "InfoHeaderCell")

        self.navigationController?.isNavigationBarHidden = false
        self.searchController.searchBar.delegate = self
        definesPresentationContext = true
   
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: -  View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)

        self.churchDetailsTableView.tableFooterView = UIView()
        
        Utilities.setChurchuDetailViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: " ".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        searchBar.text = ""
        PageIndex = 1
        totalPages = 0
        self.churchNamesArray.removeAll()
        self.getAllActiveChurchSearchAPIService(string: searchBar.text!)
        
        if #available(iOS 11.0, *) {
            searchBar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        }
        
    }
    
//MARK: -  View Did Appear
    override func viewDidAppear(_ animated: Bool) {
        churchDetailsTableView.isHidden = false
    }
    
//MARK: -  View Will DisAppear
    
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        searchController.searchBar.resignFirstResponder()
        
        self.searchController.isActive = false
    }
    
//MARK: -  Search function delegate methods
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
         self.searchBar.showsCancelButton = true
        
         searchActive = false
         PageIndex = 1
         totalPages = 0
         setSearchButtonText(text: "Cancel".localize(), searchBar: searchBar)
         self.churchNamesArray.removeAll()
         self.getAllActiveChurchSearchAPIService(string: searchBar.text!)
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
         searchActive = false
         searchBar.resignFirstResponder()
    }
    
    func setSearchButtonText(text:String,searchBar:UISearchBar) {
        
        for subview in searchBar.subviews {
            for innerSubViews in subview.subviews {
                if let cancelButton = innerSubViews as? UIButton {
                    cancelButton.setTitleColor(UIColor.white, for: .normal)
                    cancelButton.setTitle(text, for: .normal)
                }
            }
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        PageIndex = 1
        totalPages = 0
        self.churchNamesArray.removeAll()
        self.getAllActiveChurchSearchAPIService(string: searchBar.text!)
        
        if(filtered.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
        self.churchDetailsTableView.reloadData()

        searchBar.resignFirstResponder()
    }
    
    @objc(searchBarBookmarkButtonClicked:) func searchBarBookmarkButtonClicked(_ rchBar: UISearchBar) {
        searchActive = false
 
        print(sortbyColumnName)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
   
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchActive = false
        searchBar.resignFirstResponder()
        
        PageIndex = 1
        totalPages = 0
        
        self.churchNamesArray.removeAll()
        self.getAllActiveChurchSearchAPIService(string: searchBar.text!)
        self.churchDetailsTableView.reloadData()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text! == "" {
            
           sortbyColumnName = ""
            
        }
        else {
          sortbyColumnName = searchController.searchBar.text!
            
        }
        
    }

//MARK: -  Get All Active Church Search API Service
    
    
    func getAllActiveChurchSearchAPIService(string:String){
        
        let paramsDict = [
            
            "userId": 1,
            "pageIndex": PageIndex,
            "pageSize": 10,
            "sortbyColumnName": "UpdatedDate",
            "sortDirection": "desc",
            "searchName": string
            
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
                    
                    self.churchDetailsTableView.isHidden = false
                    
                    self.noRecordLabel.isHidden = true
                    
                    for eachArray in listArr{
                        
                        self.churchNamesArray.append(eachArray)
                        
                        print("eachArray.churchImage",eachArray.churchImage)
                    }

                    self.filtered = self.churchNamesArray
                    
                    let pageCout  = (respVO.totalRecords)! / 10
                    
                    let remander = (respVO.totalRecords)! % 10
                    
                    self.totalPages = pageCout
                    
                    if remander != 0 {
                        self.totalPages = self.totalPages! + 1
                    }

                    self.churchDetailsTableView.reloadData()
                    
                }
                else {
                    
                    self.noRecordLabel.isHidden = false
                    self.churchDetailsTableView.isHidden = true
  
                }
            }
                
            else {
                
                self.noRecordLabel.isHidden = false
                self.churchDetailsTableView.isHidden = true
            }
            
            
        })
        { (failureMessage) in

            print(failureMessage)
            
        }
        
    }
    
//MARK: -  Get All Church Search API Service

    func getAllChurchSearchAPIService(string:String){
        
        let paramsDict = [ 
                           "pasterUserId": 0,
                           "pageIndex": PageIndex,
                           "pageSize": 10,
                           "sortbyColumnName": "UpdatedDate",
                           "sortDirection": "desc",
                           "searchName": string
            ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: GETALLCHURCHES as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
                    let respVO:ChurchDetailsJsonVO = Mapper().map(JSONObject: result)!
            
                    let isSuccess = respVO.isSuccess
            
                    print("StatusCode:\(String(describing: isSuccess))")
            
                     if isSuccess == true {
                
                
                        let listArr = respVO.listResult!
                
                        if listArr.count > 0 {
                    
                            self.churchDetailsTableView.isHidden = false
                    
                            self.noRecordLabel.isHidden = true
                    
                            for eachArray in listArr{
                        
                                self.churchNamesArray.append(eachArray)
                        
                                print("eachArray.churchImage",eachArray.churchImage)
                            }

            
                            self.filtered = self.churchNamesArray
                    
                            let pageCout  = (respVO.totalRecords)! / 10
                    
                            let remander = (respVO.totalRecords)! % 10
                    
                            self.totalPages = pageCout
                    
                            if remander != 0 {
                        
                                self.totalPages = self.totalPages! + 1
                        
                            }
  
                            print(self.churchNamesArray.count)
                    
                            self.churchDetailsTableView.reloadData()
                    
                        }
                        else {
                    
                            self.noRecordLabel.isHidden = false
                            self.churchDetailsTableView.isHidden = true
 
                        }
                }
                
                else {
                
                        self.noRecordLabel.isHidden = false
                        self.churchDetailsTableView.isHidden = true
               }
            
            
               })
            
               { (failureMessage) in
                  print(failureMessage)
            
        }

    }
    
//MARK: -  Church Details API Call
    
   func getChurchDetailsAPICall(){
    
      let paramsDict = [ "pasterUserId": 0,
                       "pageIndex": PageIndex,
                       "pageSize": 10,
                       "sortbyColumnName": "UpdatedDate",
                       "sortDirection": "desc",
                       "searchName": ""
                      ] as [String : Any]
    
      let dictHeaders = ["":"","":""] as NSDictionary
    
    
     serviceController.postRequest(strURL: GETALLCHURCHES as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
    
       print(result)
    
       let respVO:ChurchDetailsJsonVO = Mapper().map(JSONObject: result)!
        
        let isSuccess = respVO.isSuccess
        print("StatusCode:\(String(describing: isSuccess))")

        self.churchNamesArray.removeAll()

        if isSuccess == true {

            let listArr = respVO.listResult!
            
            for eachArray in listArr{
                self.churchNamesArray.append(eachArray)
                }
            
            print(self.churchNamesArray.count)

            let pageCout  = (respVO.totalRecords)! / 10
            
            let remander = (respVO.totalRecords)! % 10
            
            self.totalPages = pageCout
            
            print(pageCout)
            
            if remander != 0 {
                self.totalPages = self.totalPages! + 1
            }
            
            self.churchDetailsTableView.reloadData()
        
        }
        
        else {
        
        }
        
      }) { (failureMessage) in

            print(failureMessage)
    
      }
   }
    
//MARK: -   Get Active Churches API Call
   
    func getActiveChurchesAPICall() {
    
        let paramsDict = [ "pageIndex": 1,
                           "pageSize": 10,
                           "sortbyColumnName": sortbyColumnName,
                           "sortDirection": "Asc"
            ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
    
    
        
        serviceController.postRequest(strURL: GETACTIVECHURCHES as NSString , postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            
            let respVO:ChurchDetailsJsonVO = Mapper().map(JSONObject: result)!
          
            
            print(result)
            
            let isSuccess = respVO.isSuccess
            
            print("StatusCode:\(String(describing: isSuccess))")
  
            if isSuccess == true {
  
                
                let listArr = respVO.listResult!
                
                self.churchNamesArray.removeAll()
                
                for eachArray in listArr{
                   
                    self.churchNamesArray.append(eachArray)
                }
                print(self.churchNamesArray.count)

                let pageCout  = (respVO.totalRecords)! / 10
                
                let remander = (respVO.totalRecords)! % 10
                
                self.totalPages = pageCout
                
                if remander != 0 {
                    self.totalPages = self.totalPages! + 1
                }
                
                self.churchDetailsTableView.reloadData()
                
            }
                
            else {
  
            }
           
            
        }) { (failureMessage) in
            
             print(failureMessage)
        }
    
    }
 
    
//MARK: -  churchDetails TableView delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            
            if filtered.count > 0 {
                return filtered.count
            }
            else {
                return 0
            }
        }
        else {
            
            if churchNamesArray.count > 0 {
                return churchNamesArray.count
            }
            else {
                return 0
            }
        }
   
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 140

    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        

        if indexPath.row == (churchNamesArray.count) - 1 {
            
            if(self.totalPages! > PageIndex){
                
                PageIndex = PageIndex + 1
                
                self.getAllActiveChurchSearchAPIService(string: searchBar.text!)
                
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChurchDetailsTableViewCell", for: indexPath) as! ChurchDetailsTableViewCell
        
            if(searchActive){
                
                if filtered.count > 0 {
            
                    let listStr:ChurchDetailsListResultVO = filtered[indexPath.row]
            
                    cell.churchNameLbl.text  = listStr.name  == nil ? "" :  listStr.name
                    cell.phNoLabel.text      = listStr.contactNumber == nil ? "" :  listStr.contactNumber
                    cell.addressLabel.text   = listStr.email == nil ? "" :  listStr.email
                    cell.stateLbl.text       = listStr.mandalName == nil ? "" :  listStr.mandalName
                    cell.mandalLbl.text      = listStr.stateName == nil ? "" :  listStr.stateName
                    cell.districtLbl.text    = listStr.districtName == nil ? "" :  listStr.districtName
                    cell.timeLabel.text      = listStr.openingTime! + " - " + listStr.closingTime!
            
                    let imgUrl = listStr.churchImage
            
                    let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
                    print("filteredUrlString:\(newString)")
            
                    if newString != nil {
                        let url = URL(string:newString!)
                
                        if url != nil {
                            cell.churchImage.sd_setImage(with:url , placeholderImage: #imageLiteral(resourceName: "Church-logo"))
                        }
                        else {
                    
                            cell.churchImage.image = #imageLiteral(resourceName: "church13")
                        }
                    }
                    else {
                
                        cell.churchImage.image = #imageLiteral(resourceName: "church13")
                    }
            }
        }
        
        else {
            
            if self.churchNamesArray.count > 0 {
                
               let listStr:ChurchDetailsListResultVO = churchNamesArray[indexPath.row]

                cell.churchNameLbl.text  = listStr.name  == nil ? "" :  listStr.name
                cell.phNoLabel.text      = listStr.contactNumber == nil ? "" :  listStr.contactNumber
                cell.addressLabel.text   = listStr.email == nil ? "" :  listStr.email
                cell.stateLbl.text       = listStr.mandalName == nil ? "" :  listStr.mandalName
                cell.mandalLbl.text      = listStr.stateName == nil ? "" :  listStr.stateName
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
        
                print("filteredUrlString:\(String(describing: newString))")
        
                if newString != nil {
            
                    let url = URL(string:newString!)
            
                    if url != nil {
                        let dataImg = try? Data(contentsOf: url!)
                
                        if dataImg != nil {
                            cell.churchImage.image = UIImage(data: dataImg!)
                        }
                        else{
                            cell.churchImage.image = #imageLiteral(resourceName: "church13")
                        }

                    }
                    else {
                        cell.churchImage.image = #imageLiteral(resourceName: "church13")
                    }
                }
                else {
                    cell.churchImage.image = #imageLiteral(resourceName: "church13")
                }

        }
       }

        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.churchNamesArray.count > 0 {
            let listStr:ChurchDetailsListResultVO = churchNamesArray[indexPath.row]

            let holyBibleViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChurchesInformaationViewControllers") as! ChurchesInformaationViewControllers

            holyBibleViewController.pasterUserId = listStr.pasterUserId ?? 0
            holyBibleViewController.churchID = listStr.Id!
            holyBibleViewController.isFromChruch = false
            holyBibleViewController.nameStr = listStr.name!

            self.navigationController?.pushViewController(holyBibleViewController, animated: true)
        
        }
        
        else {
        
        appDelegate.window?.makeToast(kNetworkStatusMessage,duration:kToastDuration,position:CSToastPositionBottom)
            
        }
    
    }
    
//MARK: -   Subscribe Buttton Clicked
  
    func subscribeButttonClicked(sender: UIButton){
 
        if self.userId != 0{
        
            let paramsDict = [ "isSubscribed": isSubscribed,
                               "userId": self.userId,
                               "churchId": "null",
                               "authorId": "null"
                                ] as [String : Any]
            
        let dictHeaders = ["":"","":""] as NSDictionary
            
            
            serviceController.postRequest(strURL: CHURCHAUTHORSUBSCIPTIONAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
                
                print(result)
                
                let respVO:ChurchAuthorSubscriptionVO = Mapper().map(JSONObject: result)!
                
                
                let isSuccess = respVO.isSuccess
                print("StatusCode:\(String(describing: isSuccess))")
                
                if isSuccess == true {
                    
                    let successMsg = respVO.endUserMessage
                    
                    let subscribe = respVO.isSuccess
            
                    let indexPath = IndexPath(item: sender.tag, section: 0)
                    self.churchDetailsTableView.reloadRows(at: [indexPath], with: .none)
  
                }
                    
                else {
                    
                }
                
            })
            { (failureMessage) in

                print(failureMessage)
                
            }
        
        }
            
        else {
        
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Subscribe".localize(), clickAction: {
    
            })
            
        }
        
    }
    
//MARK: -  subscribe Btn Clicked
    
    func subscribeBtnClicked(sender : UIButton){
        
        if self.userId != 0 {
  
            let paramsDict = [ "isSubscribed": isSubscribed,
                               "userId": self.userId,
                               "churchId": churchID,
                               "authorId": "null"
                ] as [String : Any]
            
            let dictHeaders = ["":"","":""] as NSDictionary
            
            serviceController.postRequest(strURL: CHURCHAUTHORSUBSCIPTIONAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
                
                print(result)
                
                let respVO:ChurchAuthorSubscriptionVO = Mapper().map(JSONObject: result)!
                
                
                let isSuccess = respVO.isSuccess
                print("StatusCode:\(String(describing: isSuccess))")
                
                if isSuccess == true {
                    let successMsg = respVO.endUserMessage
                    let subscribe = respVO.isSuccess
                    self.isSubscribed = (respVO.result?.isSubscribed!)!
                    self.churchDetailsTableView.reloadData()
                    self.appDelegate.window?.makeToast(successMsg!, duration:kToastDuration, position:CSToastPositionCenter)
                }
                    
                else {
                    let unSuccessMsg = respVO.endUserMessage
                    self.appDelegate.window?.makeToast(unSuccessMsg!, duration:kToastDuration, position:CSToastPositionCenter)
                }
                
            })
            { (failureMessage) in
                print(failureMessage)
            }
   
        }
        else {
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Subscribe".localize(), clickAction: {
                self.navigationController?.pushViewController(self.loginVC, animated: true)
            })
        }
    }
    
    
    
//MARK: -    Back Left Button Tapped
  
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.synchronize()

        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        self.navigationController?.popViewController(animated: true)
        print("Back Button Clicked......")
        
    }
    
//MARK: -   Event Date Without Time
  
    func amAppend(str:String) -> String{
        
        var newDateStr = ""
        var newDateStr1 = ""
        
        if(str != ""){
            let invDtArray = str.components(separatedBy: "-")
            let dateString1 = invDtArray[0]
            let dateString2 = invDtArray[1]
            
            if(dateString1 != ""){
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.dateFormat = "HH:mm:ss"
                let dateFromString = dateFormatter.date(from: dateString1)
                dateFormatter.dateFormat = "hh:mm aa"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr = newDateString
                print(newDateStr)
            }
            if(dateString2 != ""){
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.dateFormat = "HH:mm:ss"
                let dateFromString = dateFormatter.date(from: dateString2)
                dateFormatter.dateFormat = "hh:mm aa"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr1 = newDateString
                print(newDateStr1)
            }
        }
        return newDateStr + "-" + newDateStr1
    }

}
