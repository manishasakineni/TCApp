//
//  AllEventsViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize

class AllEventsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate {

    @IBOutlet weak var allEventTableView: UITableView!
    
//    @IBOutlet weak var allEventTableView: UITableView!
    var churchIdMonthYearArray:[GetEventInfoByChurchIdMonthYearResultVo] = Array<GetEventInfoByChurchIdMonthYearResultVo>()
    
    @IBOutlet weak var noRecordsLbl: UILabel!
    
    @IBOutlet weak var searchBarText: UISearchBar!
    

//    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchActive : Bool = false
    
    var isSearch: Bool = false
    
    var filteredData: [String]!
    
    var filtered:[GetEventInfoByChurchIdMonthYearResultVo] = []
    
     var delegate: eventinfoSubtitleOfIndexDelegate?
    
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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        allEventTableView.rowHeight = UITableViewAutomaticDimension
        allEventTableView.estimatedRowHeight = 44
        allEventTableView.reloadData()
        
        
        searchBarText.delegate = self

        searchBarText.placeholder = "Search by Event"
        self.noRecordsLbl.isHidden = true
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "M"
        monthFormatter.timeZone = NSTimeZone.local
        let monthString = monthFormatter.string(from: Date())
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        let yearString = yearFormatter.string(from: Date())
        
        GetEventInfoByChurchIdMonthYearAPIService(monthString,yearString, searchBarText.text!)
        
        
        
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.searchBarText = controller.searchBar
            
//            self.allEventTableView.tableHeaderView = controller.searchBar
            
        
            return controller
        })()
        
        
        let nibName  = UINib(nibName: "AllEventsTableViewCell" , bundle: nil)
        allEventTableView.register(nibName, forCellReuseIdentifier: "AllEventsTableViewCell")

        
        allEventTableView.delegate = self
        allEventTableView.dataSource = self
        
        
        
       

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
        
         self.churchIdMonthYearArray.removeAll()
        
        GetEventInfoByChurchIdMonthYearAPIService(monthString,yearString, searchBarText.text!)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        searchController.searchBar.resignFirstResponder()
        
        self.searchController.isActive = false
        
        
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
        
        PageIndex = 1
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
        
//        if searchText.characters.count == 0 {
//            isSearch = false;
//            self.allEventTableView.reloadData()
//        } else {
        
//            filteredTableData = churchIdMonthYearArray.filter({ (text) -> Bool in
//                let tmp = text
//                let range = ((tmp.churchName?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)) != nil) || ((tmp.contactNumber?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)) != nil)
//                
//                
//                return range
//            })
            
//            self.filteredTableData = self.churchIdMonthYearArray
//            
//            let monthFormatter = DateFormatter()
//            monthFormatter.dateFormat = "M"
//            monthFormatter.timeZone = NSTimeZone.local
//            let monthString = monthFormatter.string(from: Date())
//            
//            let yearFormatter = DateFormatter()
//            yearFormatter.dateFormat = "YYYY"
//            yearFormatter.timeZone = NSTimeZone.local
//            let yearString = yearFormatter.string(from: Date())
//            
//            self.GetEventInfoByChurchIdMonthYearAPIService(monthString,yearString, searchBar.text!)
//            
//            allEventTableView.reloadData()
//
//
//            if(filteredTableData.count == 0){
//                isSearch = false;
//            } else {
//                isSearch = true;
//            }
//            self.allEventTableView.reloadData()
//        }
    }
    
    
    
    func GetEventInfoByChurchIdMonthYearAPIService(_ month : String, _ year : String, _ str:String){
        
        
        let  strUrl = GETEVENTINFOBYCHURCHIDMONTHYEAR
        
        
        let dictParams = [
            "churchId": churchID,
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
                    
                    self.noRecordsLbl.isHidden = true
                    
                    self.listResultArray = respVO.listResult!
                    
                    
                    for church in respVO.listResult!{
                        
                        self.churchIdMonthYearArray.append(church)
                        
                    }
                    
                    
                    let pageCout  = (respVO.totalRecords)! / 10
                    
                    let remander = (respVO.totalRecords)! % 10
                    
                    self.totalPages = pageCout
                    
                    if remander != 0 {
                        
                        self.totalPages = self.totalPages! + 1
                        
                    }
                    
                    
                    
                    print("churchAdminArray", self.churchIdMonthYearArray)
                    
                    self.allEventTableView.reloadData()
                    
                }
                else {
                    
                    self.allEventTableView.isHidden = true
                    
                    self.noRecordsLbl.isHidden = false
                    
                }
                
                
            }
                
            else {
                
                self.allEventTableView.isHidden = true
                
                self.noRecordsLbl.isHidden = false
  
                
            }
            
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
        
        
    }
    
    
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
                
                
                
                
                if let churchName =  churchIdMonthYearList.churchName {
                    
                    listOfMonthEventCell.churchName.text = churchName
                    
                }else{

                }
                
                if let eventName =  churchIdMonthYearList.title {
                    
                    listOfMonthEventCell.eventTitle.text = eventName
                    
                }else{

                }
                
                if let contactNumber =  churchIdMonthYearList.contactNumber {
                    
                    listOfMonthEventCell.contactNumber.text = contactNumber
                    
                }else{
                    
                }
                
                let startDate =   returnEventDateWithoutTim1(selectedDateString: churchIdMonthYearList.startDate!)
                
                if startDate != "" {
                    
                    listOfMonthEventCell.startDate.text = startDate
                    
                }else{
                  //  listOfMonthEventCell.startDate.text = "Start Date".localize()
                }
                let endDate =   returnEventDateWithoutTim1(selectedDateString: churchIdMonthYearList.endDate!)
                if endDate != "" {
                    listOfMonthEventCell.endDate.text = endDate
                }else{
                  //  listOfMonthEventCell.endDate.text = "End Date".localize()
                }
                //  listOfMonthEventCell.churchName.text =
                
                
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
                        
                        listOfMonthEventCell.eventImage.image = #imageLiteral(resourceName: "Church-logo")
                    }
                }
                else {
                    
                    listOfMonthEventCell.eventImage.image = #imageLiteral(resourceName: "Church-logo")
                }
            
        }
        }
        else {
//            cell.textLabel?.text = tableData[indexPath.row]
            
            
                if(self.churchIdMonthYearArray.count > indexPath.row ){
                    
                    let churchIdMonthYearList:GetEventInfoByChurchIdMonthYearResultVo = self.churchIdMonthYearArray[indexPath.row]
                    
                    
                    
                    
                    if let churchName =  churchIdMonthYearList.churchName {
                        listOfMonthEventCell.churchName.text = churchName
                    }else{
        //  listOfMonthEventCell.churchName.text = "Church Name".localize()
                    }
                    
                    if let eventName =  churchIdMonthYearList.title {
                        listOfMonthEventCell.eventTitle.text = eventName
                    }else{
                      //  listOfMonthEventCell.eventTitle.text = "Event Name".localize()
                    }
                    
                    if let contactNumber =  churchIdMonthYearList.contactNumber {
                        listOfMonthEventCell.contactNumber.text = contactNumber
                    }else{
                        listOfMonthEventCell.contactNumber.text = "Contact Number".localize()
                    }
                    
                    let startDate =   returnEventDateWithoutTim1(selectedDateString: churchIdMonthYearList.startDate!)
                    if startDate != "" {
                        listOfMonthEventCell.startDate.text = startDate
                    }else{
                      //  listOfMonthEventCell.startDate.text = "Start Date".localize()
                    }
                    let endDate =   returnEventDateWithoutTim1(selectedDateString: churchIdMonthYearList.endDate!)
                    if endDate != "" {
                        listOfMonthEventCell.endDate.text = endDate
                    }else{
                      //  listOfMonthEventCell.endDate.text = "End Date".localize()
                    }
                    //  listOfMonthEventCell.churchName.text =
                    
                    
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
                            
                            listOfMonthEventCell.eventImage.image = #imageLiteral(resourceName: "Church-logo")
                        }
                    }
                    else {
                        
                        listOfMonthEventCell.eventImage.image = #imageLiteral(resourceName: "Church-logo")
                    }
            
           
        }
            
        
            }
        
            

        return listOfMonthEventCell
        
        
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == filteredTableData.count - 1 {
            
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
    
 func updateSearchResults(for searchController: UISearchController)
    {
        
        if searchController.searchBar.text! == "" {
                    self.allEventTableView.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
                    self.view.addSubview(self.allEventTableView)
            
                    self.navigationController?.isNavigationBarHidden = false

            filteredTableData = churchIdMonthYearArray
        } else {
            // Filter the results
            
            
        filteredTableData = churchIdMonthYearArray.filter { $0.churchName!.lowercased().contains(searchController.searchBar.text!.lowercased()) || ($0.contactNumber?.contains(searchController.searchBar.text!))!}
            
            
        }
        

        
        self.allEventTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
//        self.allEventTableView.frame = CGRect(x: self.view.frame.origin.x, y: 130, width: self.view.frame.size.width, height: self.view.frame.size.height)
//        
//        self.view.addSubview(self.allEventTableView)
//        
//        self.navigationController?.isNavigationBarHidden = true
        
        PageIndex = 1
        totalPages = 0
        self.filteredTableData.removeAll()
        self.churchIdMonthYearArray.removeAll()
                let monthFormatter = DateFormatter()
                monthFormatter.dateFormat = "M"
                monthFormatter.timeZone = NSTimeZone.local
                let monthString = monthFormatter.string(from: Date())
        
                let yearFormatter = DateFormatter()
                yearFormatter.dateFormat = "YYYY"
                yearFormatter.timeZone = NSTimeZone.local
                let yearString = yearFormatter.string(from: Date())
        self.GetEventInfoByChurchIdMonthYearAPIService(monthString,yearString, searchBarText.text!)
        
        
    }

    
    
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
            //   let timeString = invDtArray[1]
            //  print(timeString)
            
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

    
}
