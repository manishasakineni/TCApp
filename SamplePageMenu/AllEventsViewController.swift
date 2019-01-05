//
//  AllEventsViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize
import IQKeyboardManagerSwift

class AllEventsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate {

    @IBOutlet weak var allEventTableView: UITableView!
    @IBOutlet weak var noRecordsLbl: UILabel!
    @IBOutlet weak var searchBarText: UISearchBar!
    
//MARK: -  variable declaration 
    
    var churchIdMonthYearArray:[GetEventInfoByChurchIdMonthYearResultVo] = Array<GetEventInfoByChurchIdMonthYearResultVo>()
    let searchController = UISearchController(searchResultsController: nil)
    var searchActive : Bool = false
    var isSearch: Bool = false
    var filteredData: [String]!
    var filtered:[GetEventInfoByChurchIdMonthYearResultVo] = []
    var delegate: eventinfoSubtitleOfIndexDelegate?
    var null = NSNull()
    var listResultArray = Array<Any>()
    var previousMonthString = "0"
    var isDateExists = false
    var currentMonthDataArray = Array<String>()
    var churchID:Int = 0
    var PageIndex = 1
    var totalPages : Int? = 0
    var totalRecords : Int? = 0
    var filteredTableData = [GetEventInfoByChurchIdMonthYearResultVo]()
    var resultSearchController = UISearchController()
   
//MARK: -  view Did Load
    
  override func viewDidLoad() {
        super.viewDidLoad()
    
    IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
    allEventTableView.rowHeight = UITableViewAutomaticDimension
    allEventTableView.estimatedRowHeight = 44
    allEventTableView.reloadData()
    searchBarText.delegate = self
    searchBarText.placeholder = "Search by Event Name".localize()
  
    let monthFormatter = DateFormatter()
    monthFormatter.dateFormat = "M"
    monthFormatter.timeZone = NSTimeZone.local
    let monthString = monthFormatter.string(from: Date())
        
    let yearFormatter = DateFormatter()
    yearFormatter.dateFormat = "YYYY"
    yearFormatter.timeZone = NSTimeZone.local
    let yearString = yearFormatter.string(from: Date())

    self.resultSearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.dimsBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        self.searchBarText = controller.searchBar
        return controller
    })()
    
    // Registering Tableview Cell
        
    let nibName  = UINib(nibName: "AllEventsTableViewCell" , bundle: nil)
    allEventTableView.register(nibName, forCellReuseIdentifier: "AllEventsTableViewCell")
    allEventTableView.delegate = self
    allEventTableView.dataSource = self
    }
    
 override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//MARK: -   view Will Appear
    
 override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "M"
        monthFormatter.timeZone = NSTimeZone.local
        let monthString = monthFormatter.string(from: Date())
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        let yearString = yearFormatter.string(from: Date())
        
        PageIndex = 1
        totalPages = 0
    
        GetEventInfoByChurchIdMonthYearAPIService(monthString,yearString, searchBarText.text!)
    }
    
    
//MARK: UISearchbar delegate

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = false;
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "M"
        monthFormatter.timeZone = NSTimeZone.local
        let monthString = monthFormatter.string(from: Date())
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        let yearString = yearFormatter.string(from: Date())
        
        PageIndex = 1
        totalPages = 0
        
    self.churchIdMonthYearArray.removeAll()
    self.GetEventInfoByChurchIdMonthYearAPIService(monthString,yearString, searchBarText.text!)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    
        searchBar.resignFirstResponder()
        isSearch = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    searchBar.resignFirstResponder()
    isSearch = false;
        
    let monthFormatter = DateFormatter()
    monthFormatter.dateFormat = "M"
    monthFormatter.timeZone = NSTimeZone.local
    let monthString = monthFormatter.string(from: Date())
        
    let yearFormatter = DateFormatter()
    yearFormatter.dateFormat = "YYYY"
    yearFormatter.timeZone = NSTimeZone.local
    let yearString = yearFormatter.string(from: Date())
        
    PageIndex  = 1
    totalPages = 0
        
    self.churchIdMonthYearArray.removeAll()
    self.GetEventInfoByChurchIdMonthYearAPIService(monthString,yearString, searchBar.text!)
    allEventTableView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""
        {
            searchBar.perform(#selector(self.resignFirstResponder), with: nil, afterDelay: 0.1)
        }
    }
    
    
//MARK: - Get Event Info By Church Id Month Year API Service
    
    func GetEventInfoByChurchIdMonthYearAPIService(_ month : String, _ year : String, _ str:String) {
    
        self.churchIdMonthYearArray.removeAll()
        let  strUrl = GETEVENTINFOBYCHURCHIDMONTHYEAR
        let dictParams = [
            "month": month,
            "year": year,
            "pageIndex": PageIndex,
            "pageSize": 10,
            "sortbyColumnName": "UpdatedDate",
            "sortDirection": "desc",
            "searchName": str
            ] as [String : Any]
        print("dic params \(dictParams)")
        let dictHeaders = ["":"","":""] as NSDictionary
        print("dictHeader:\(dictHeaders)")
        serviceController.postRequest(strURL: strUrl as NSString, postParams: dictParams as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
                print(result)
                let respVO:GetEventInfoByChurchIdMonthYearVo = Mapper().map(JSONObject: result)!
                let isSuccess = respVO.isSuccess
                let listArr = respVO.listResult
                if isSuccess == true {
                    if (listArr?.count)! > 0 {
                        self.allEventTableView.isHidden = false
                        self.listResultArray = respVO.listResult!
                        for church in respVO.listResult!{
                            self.churchIdMonthYearArray.append(church)
                        }
                        let pageCout  = (respVO.totalRecords)! / 10
                        let remander  = (respVO.totalRecords)! % 10
                        self.totalPages = pageCout
                        if remander != 0 {
                            self.totalPages = self.totalPages! + 1
                        }
                        print("churchAdminArray", self.churchIdMonthYearArray)
                        self.allEventTableView.reloadData()
                    }
                    else {
                        if self.isSearch == false{
                            self.allEventTableView.isHidden = true
                        }
                    }
                }
                else {
                    self.allEventTableView.isHidden = true
                }
            }) { (failureMessage) in
                    print(failureMessage)
                    self.allEventTableView.isHidden = true
                }
    }
    
//MARK: -  TableView delegate & DataSource  methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if (isSearch) {
            if !filteredTableData.isEmpty{
                return self.filteredTableData.count
            }
        }
        else {
            if !churchIdMonthYearArray.isEmpty {
                return self.churchIdMonthYearArray.count
            }
        }
        return 0
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
    }
   

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
    let listOfMonthEventCell = tableView.dequeueReusableCell(withIdentifier: "AllEventsTableViewCell", for: indexPath) as! AllEventsTableViewCell
    if (isSearch) {
        if(self.filteredTableData.count > indexPath.row ){
            let churchIdMonthYearList:GetEventInfoByChurchIdMonthYearResultVo = self.filteredTableData[indexPath.row]
            if churchIdMonthYearList.churchName != nil {
                if let churchName =  churchIdMonthYearList.churchName {
                listOfMonthEventCell.churchName.text = churchName
                }
                else{
                listOfMonthEventCell.churchName.text = ""
                }
            }
            else if churchIdMonthYearList.authorName != nil {
                if let authorName =  churchIdMonthYearList.authorName {
                    listOfMonthEventCell.churchName.text = authorName
                }
                else{
                    listOfMonthEventCell.churchName.text = ""
                }
            }
            else {
                listOfMonthEventCell.churchName.text = ""
            }
            listOfMonthEventCell.churchName.text = churchIdMonthYearList.churchName == "" ? "" :  churchIdMonthYearList.churchName
            listOfMonthEventCell.authorName.text = churchIdMonthYearList.authorName == "" ? "" :  churchIdMonthYearList.authorName
            if let eventName =  churchIdMonthYearList.title {
                listOfMonthEventCell.eventTitle.text = eventName
            }
            else{
                listOfMonthEventCell.eventTitle.text = ""
            }
            if let contactNumber =  churchIdMonthYearList.contactNumber {
                listOfMonthEventCell.contactNumber.text = contactNumber
            }
            else{
                listOfMonthEventCell.contactNumber.text = ""
            }
                
            let startDate =   returnEventDateWithoutTim1(selectedDateString: churchIdMonthYearList.startDate!)
                if startDate != "" {
                    listOfMonthEventCell.startDate.text = startDate
                }
                else{
                    listOfMonthEventCell.startDate.text = ""
                }
            let endDate =   returnEventDateWithoutTim1(selectedDateString: churchIdMonthYearList.endDate!)
                    if endDate != "" {
                        listOfMonthEventCell.endDate.text = endDate
                    }
                    else{
                        listOfMonthEventCell.endDate.text = ""
                    }
            let imgUrl = churchIdMonthYearList.eventImage
            let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            print("filteredUrlString:\(newString)")
            if newString != nil {
                let url = URL(string:newString!)
                let dataImg = try? Data(contentsOf: url!)
                if dataImg != nil {
                    listOfMonthEventCell.eventImage.image = UIImage(data: dataImg!)
                }
                else {
                    listOfMonthEventCell.eventImage.image = #imageLiteral(resourceName: "church12")
                }
            }
            else {
                listOfMonthEventCell.eventImage.image = #imageLiteral(resourceName: "church12")
            }
        }
    }
    else {
    if(self.churchIdMonthYearArray.count > indexPath.row ){
    let churchIdMonthYearList:GetEventInfoByChurchIdMonthYearResultVo = self.churchIdMonthYearArray[indexPath.row]
        if churchIdMonthYearList.churchName  != nil {
            if let churchName = churchIdMonthYearList.churchName {
                listOfMonthEventCell.churchName.text = churchName
                listOfMonthEventCell.infoChurchName.text = "Church Name".localize()
            }
            else{
                listOfMonthEventCell.churchName.text = ""
            }
        }
        else if churchIdMonthYearList.authorName != nil {
            if let authorName =  churchIdMonthYearList.authorName {
                listOfMonthEventCell.churchName.text = authorName
                listOfMonthEventCell.infoChurchName.text = "Pastor Name".localize()
            }
            else{
                listOfMonthEventCell.churchName.text = ""
            }
        }
        else{
            listOfMonthEventCell.churchName.text = ""
        }
        
        if  churchIdMonthYearList.title != nil {
            if let eventName =  churchIdMonthYearList.title {
                listOfMonthEventCell.eventTitle.text = eventName
            }
            else{
                listOfMonthEventCell.eventTitle.text = ""
            }
        }
        else{
               listOfMonthEventCell.eventTitle.text = ""
        }
    
         if  churchIdMonthYearList.contactNumber != nil {
            if let contactNumber =  churchIdMonthYearList.contactNumber {
                listOfMonthEventCell.contactNumber.text = contactNumber
            }else{
                listOfMonthEventCell.contactNumber.text = ""
            }
         }else{
            listOfMonthEventCell.contactNumber.text = ""
        }
    let startDate =   returnEventDateWithoutTim1(selectedDateString: churchIdMonthYearList.startDate!)
        if startDate != "" {
            listOfMonthEventCell.startDate.text = startDate
        }
        else{
            listOfMonthEventCell.startDate.text = ""
    }
    let endDate =   returnEventDateWithoutTim1(selectedDateString: churchIdMonthYearList.endDate!)
        if endDate != "" {
            listOfMonthEventCell.endDate.text = endDate
        }
        else{
            listOfMonthEventCell.endDate.text = ""
        }
    let imgUrl = churchIdMonthYearList.eventImage
    let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
    print("filteredUrlString:\(newString)")
    if newString != nil {
        let range = newString?.rangeOfCharacter(from: .whitespaces)
        if range != nil {
            print("whitespace found")
            listOfMonthEventCell.eventImage.image = #imageLiteral(resourceName: "church12")
         }
        else{
            let url = URL(string:newString!)
            let dataImg = try? Data(contentsOf: url!)
            if dataImg != nil {
                listOfMonthEventCell.eventImage.image = UIImage(data: dataImg!)
            }
        }
    }
    else {
    listOfMonthEventCell.eventImage.image = #imageLiteral(resourceName: "church12")
    }
   }
 }
   return listOfMonthEventCell
}

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    if indexPath.row == churchIdMonthYearArray.count - 1 {
        if(self.totalPages! > PageIndex){
            PageIndex = PageIndex + 1
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "M"
            monthFormatter.timeZone = NSTimeZone.local
            let monthString = monthFormatter.string(from: Date())
                
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "YYYY"
            yearFormatter.timeZone = NSTimeZone.local
            let yearString = yearFormatter.string(from: Date())
        
            GetEventInfoByChurchIdMonthYearAPIService(monthString,yearString, searchBarText.text!)
        }
    }
    
 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let listStr:GetEventInfoByChurchIdMonthYearResultVo = churchIdMonthYearArray[indexPath.row]
        let eventDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailsAndEventPostDetailsViewController") as! EventDetailsAndEventPostDetailsViewController
        eventDetailsViewController.eventID = listStr.id == nil ? 0 :  listStr.id!
        eventDetailsViewController.eventChurchName = listStr.churchName == nil ? "" :  listStr.churchName!
        eventDetailsViewController.eventName = listStr.title == nil ? "" :  listStr.title!
        eventDetailsViewController.catgoryID = listStr.churchId == nil ? 0 :  listStr.churchId!
        eventDetailsViewController.navigationStr = "navigationStr"
        if listStr.eventImage != nil {
            
            eventDetailsViewController.eventImageArrayString = listStr.eventImage!
        }       
        self.navigationController?.pushViewController(eventDetailsViewController, animated: true)
    }

//MARK: -   Search Bar
    
 func updateSearchResults(for searchController: UISearchController){
        
    if searchController.searchBar.text! == "" {
        self.allEventTableView.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.addSubview(self.allEventTableView)
        self.navigationController?.isNavigationBarHidden = false
        filteredTableData = churchIdMonthYearArray
    }
    else {
    filteredTableData = churchIdMonthYearArray.filter { $0.churchName!.lowercased().contains(searchController.searchBar.text!.lowercased()) || ($0.contactNumber?.contains(searchController.searchBar.text!))!}
    }
    self.allEventTableView.reloadData()
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
}
