//
//  ChurchDetailsViewController.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 19/02/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import SDWebImage


class ChurchDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating {

    @IBOutlet weak var churchDetailsTableView: UITableView!
    
    @IBOutlet weak var noRecordLabel: UILabel!
    
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    var searchController: UISearchController!
    
    var searchActive : Bool = false
    
    var filteredData: [String]!
    var bibleInt = Int()

    var filtered:[ChurchDetailsListResultVO] = []
    
    var appVersion          : String = ""
    
    var sortbyColumnName : String = ""
    
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
    
    var imageArray = [UIImage(named:"7"),UIImage(named:"5"),UIImage(named:"4"),UIImage(named:"7"),UIImage(named:"5"),UIImage(named:"4"),UIImage(named:"7"),UIImage(named:"4")]
    
    var AreanamesArray = ["Kukatpally","Uppal","Ameerpet","JNTU","MGPS","PUNG","KPHP","MYP"]
    
   
    var TimingsArray = ["OPEN5AM Close5PM ","OPEN6AM Close5PM","OPEN7AM Close8PM","OPEN8AM Close5PM","OPEN9AM Close4PM","OPEN5AM Close5PM","OPEN7AM Close5PM","OPEN6AM Close5PM"]
    
    var userId = Int()
    var uid : Int = 0
    var PageIndex = 1
    var totalPages : Int? = 0
    var totalRecords : Int? = 0
    
    var isSubscribed = Int()
    
    var subscribe : Bool = true
//    var noRecordlbl = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: kLoginId) != nil {
            
            self.userId = UserDefaults.standard.value(forKey: kLoginId) as! Int
            
        }
        
        self.getAllChurchSearchAPIService(string: searchBar.text!)
        
        self.churchDetailsTableView.delegate = self
        self.churchDetailsTableView.dataSource = self
        
        self.noRecordLabel.isHidden = true
        
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        
        searchBar.tintColor = UIColor.black
        
        searchBar.delegate = self
        
        searchBar.placeholder = "Search by Church".localize()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchController.dimsBackgroundDuringPresentation = false
        
        navigationItem.titleView = searchBar
        

        churchDetailsTableView.register(UINib.init(nibName: "ChurchDetailsTableViewCell", bundle: nil),
                              forCellReuseIdentifier: "ChurchDetailsTableViewCell")
        
        self.navigationController?.isNavigationBarHidden = false

        
       self.searchController.searchBar.delegate = self
        
        definesPresentationContext = true

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)

        
        Utilities.setChurchuDetailViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: "Categories".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        searchBar.text = ""
        
       
        //navigationItem.leftBarButtonItems = []

        PageIndex = 1
        totalPages = 0
        
        self.churchNamesArray.removeAll()
        
        self.getAllChurchSearchAPIService(string: searchBar.text!)
        


//       churchDetailsTableView.isHidden = true
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        churchDetailsTableView.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        searchController.searchBar.resignFirstResponder()
        
        self.searchController.isActive = false
        
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        
        searchActive = false
        
        PageIndex = 1
        totalPages = 0
        
        self.churchNamesArray.removeAll()
        self.getAllChurchSearchAPIService(string: searchBar.text!)
//        self.churchDetailsTableView.reloadData()
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchActive = false
        searchBar.resignFirstResponder()
        
//        self.churchNamesArray.removeAll()
//        self.getAllChurchSearchAPIService(string: searchBar.text!)
//        self.churchDetailsTableView.reloadData()
        
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
//        searchActive = false
        

        PageIndex = 1
        totalPages = 0
        
        self.churchNamesArray.removeAll()
        
        self.getAllChurchSearchAPIService(string: searchBar.text!)
        
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
        
//        self.searchTextStr = searchText
 
        

        
        
//        if searchText == "" {
        
//            filtered = churchNamesArray
            
//            filtered = churchNamesArray.filter({ (text) -> Bool in
//                let tmp = text
//                let range = ((tmp.name?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)) != nil) || ((tmp.contactNumber?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)) != nil)
//            
//            
//                        return range
//                    })
        
//        }
//            else {
        
            
//            self.getAllChurchSearchAPIService(string: searchText)
//        }
        
//        if searchText.characters.count == 0 {
//            searchActive = false;
//            self.churchDetailsTableView.reloadData()
//            
//        } else {
        
//            self.churchNamesArray.removeAll()
        
//        self.getAllChurchSearchAPIService(string: searchBar.text!)
        
            
            
//                        filtered = churchNamesArray.filter({ (text) -> Bool in
//                            let tmp = text
//                            let range = ((tmp.name?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)) != nil) || ((tmp.contactNumber?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)) != nil)
//            
//            
//                                    return range
//                                })
            
//            self.filtered = self.churchNamesArray
            
//            self.churchDetailsTableView.reloadData()
        
//        if(filtered.count == 0){
//            searchActive = false
//        } else {
//            searchActive = true
//        }
//        self.churchDetailsTableView.reloadData()
//        
//    }
    
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchActive = false
        searchBar.resignFirstResponder()
        
        PageIndex = 1
        totalPages = 0
        
        self.churchNamesArray.removeAll()
        self.getAllChurchSearchAPIService(string: searchBar.text!)
        self.churchDetailsTableView.reloadData()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text! == "" {
            
            sortbyColumnName = ""
            
        } else {
            
        sortbyColumnName = searchController.searchBar.text!
            
        }
        
        
        }
    
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
                        //  print(self.churchNamesArray)
                        // print(eachArray)
                        self.churchNamesArray.append(eachArray)
                        //  print(self.churchNamesArray)
                    }
                    
                    self.filtered = self.churchNamesArray
                    
                    let pageCout  = (respVO.totalRecords)! / 10
                    
                    let remander = (respVO.totalRecords)! % 10
                    
                    self.totalPages = pageCout
                    
                    //                print(pageCout)
                    
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
            
            
        }) { (failureMessage) in
            
            
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
//        self.filtered.removeAll()

        if isSuccess == true {

            
            let listArr = respVO.listResult!
            
            
            for eachArray in listArr{
              //  print(self.churchNamesArray)
               // print(eachArray)
                self.churchNamesArray.append(eachArray)
              //  print(self.churchNamesArray)
            }
            
            

            print(self.churchNamesArray.count)

          
            
        let pageCout  = (respVO.totalRecords)! / 10
            
            let remander = (respVO.totalRecords)! % 10
            
           self.totalPages = pageCout
            
            print(pageCout)
            
            if remander != 0 {
            
            self.totalPages = self.totalPages! + 1
            
            }
            
            
           
//            for church in respVO.listResult!{
//                
//                self.churchNamesArray.append(church.name!)
//                self.phoneNoArray.append(church.contactNumber!)
//                self.churchIDArray.append(church.Id!)
//                self.updatedDateArray.append(self.returnDateWithoutTime(selectedDateString:church.updatedDate!))
//                self.addressArray.append(church.districtName == nil ? "" : church.districtName!)
//                
//                self.churchImageArray.append(church.churchImage == nil ? "" : church.churchImage!.replacingOccurrences(of: "\\", with: "//"))
//                
//            }
    
            
//            print(self.churchNamesArray)
//            print(self.churchImageArray)
//
            
            
            self.churchDetailsTableView.reloadData()
        
        }
        
        else {
        
        
        
        }
        
      }) { (failureMessage) in
    
    
       print(failureMessage)
    
      }
}
    
    
    func getActiveChurchesAPICall() {
    
        let paramsDict = [ "pageIndex": 1,
                           "pageSize": 10,
                           "sortbyColumnName": sortbyColumnName,
                           "sortDirection": "Asc"
            ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
    
    
        
        serviceController.postRequest(strURL: GETACTIVECHURCHES as NSString , postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            
            let respVO:ChurchDetailsJsonVO = Mapper().map(JSONObject: result)!
          
            
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
            
        }
    
    }
 
    
//MARK: -  churchDetailsTableView delegate methods
    
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
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
        
        return 180
        
        }
        
        else {
        
        return 140
        
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        

        if indexPath.row == (churchNamesArray.count) - 1 {
            
            if(self.totalPages! > PageIndex){
                
                PageIndex = PageIndex + 1


                
                self.getAllChurchSearchAPIService(string: searchBar.text!)
                
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChurchDetailsTableViewCell", for: indexPath) as! ChurchDetailsTableViewCell
        
        if(searchActive){
            
            let listStr:ChurchDetailsListResultVO = filtered[indexPath.row]
            
            cell.churchNameLbl.text = listStr.name
            
            cell.phNoLabel.text = listStr.contactNumber
            
            cell.addressLabel.text = listStr.address1
            
            
            let imgUrl = listStr.churchImage
            
            let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            print("filteredUrlString:\(newString)")
            
            if newString != nil {
                
                let url = URL(string:newString!)
                
                
                let dataImg = try? Data(contentsOf: url!)
                
                if dataImg != nil {
                    
                    cell.churchImage.image = UIImage(data: dataImg!)
                }
                else {
                    
                    cell.churchImage.image = #imageLiteral(resourceName: "j4")
                }
            }
            else {
                
                cell.churchImage.image = #imageLiteral(resourceName: "j4")
            }
            
            cell.SubscribeBtn.addTarget(self, action: #selector(subscribeButttonClicked), for: .touchUpInside)
            
            
            cell.SubscribeBtn.tag = indexPath.row
            
           
        }
        
        else {
            
            if self.churchNamesArray.count > 0 {
                
            
            
        let listStr:ChurchDetailsListResultVO = churchNamesArray[indexPath.row]
        
        
        cell.churchNameLbl.text = listStr.name
      //  cell.areaNameLabel.text = villageNamesArray[indexPath.row]

        cell.phNoLabel.text     = listStr.contactNumber
        
//        cell.timeLabel.text     = amAppend(str: "\(listStr.openingTime!)" + "-" + "\(listStr.closingTime!)" )

       // cell.timeLabel.text     = "\(listStr.openingTime!)" + "-" + "\(listStr.closingTime!)"
      //  cell.timeLabel.text     = String(String(describing: listStr.openingTime!) + "-" + String(describing: listStr.closingTime!))
        cell.addressLabel.text  = listStr.address1
        
        //cell.churchImage.image  = UIImage(named: churchImageArray[indexPath.row])
        
        let imgUrl = listStr.churchImage
        
        let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        
        print("filteredUrlString:\(newString)")
        
        if newString != nil {
            
            let url = URL(string:newString!)
            
            if url != nil {
                
                
                let dataImg = try? Data(contentsOf: url!)
                
                if dataImg != nil {
                    
                    cell.churchImage.image = UIImage(data: dataImg!)
            }
            
           
            }
            else {
                
                cell.churchImage.image = #imageLiteral(resourceName: "j4")
            }
        }
        else {
            
            cell.churchImage.image = #imageLiteral(resourceName: "j4")
        }
                
                cell.SubscribeBtn.addTarget(self, action: #selector(subscribeButttonClicked), for: .touchUpInside)
                
                
                cell.SubscribeBtn.tag = indexPath.row
       
        }
        
//        if let url = URL(string:listStr.churchImage!) {
//       cell.churchImage.sd_setImage(with:url , placeholderImage: #imageLiteral(resourceName: "Church-logo"))
//        }else{
//            cell.churchImage.image = #imageLiteral(resourceName: "Church-logo")
//        }
       
}
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let listStr:ChurchDetailsListResultVO = churchNamesArray[indexPath.row]
       
        let holyBibleViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChurchesInformaationViewControllers") as! ChurchesInformaationViewControllers
        
        holyBibleViewController.pasterUserId = listStr.pasterUserId!
        
        holyBibleViewController.churchID = listStr.Id!
        holyBibleViewController.nameStr = listStr.name!

        
        
        self.navigationController?.pushViewController(holyBibleViewController, animated: true)
        
    }
    
    
    
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
                    
                    self.appDelegate.window?.makeToast(successMsg!, duration:kToastDuration, position:CSToastPositionCenter)
                    
                }
                    
                else {
                    
                    
                    
                }
                
            }) { (failureMessage) in
                
                
                print(failureMessage)
                
            }
            
            
        }
            
            
        else {
            
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Subscribe", clickAction: {
                
                
                
            })
            
        }
        
    }
    
   
    
    
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        
        
        UserDefaults.standard.set("1", forKey: "1")

        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.synchronize()
        
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        

        
        //   navigationItem.leftBarButtonItems = []
        //   let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
//        
//        UserDefaults.standard.set("1", forKey: "1")
//        UserDefaults.standard.synchronize()
//        
        self.navigationController?.popViewController(animated: true)
        print("Back Button Clicked......")
        
    }
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
