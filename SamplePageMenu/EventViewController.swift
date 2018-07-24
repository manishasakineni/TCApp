//
//  ViewController.swift
//  CustomCalender
//
//  Created by praveen dole on 2/15/18.
//  Copyright © 2018 praveen dole. All rights reserved.
//

import UIKit
import FSCalendar
import Localize


class EventViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {

    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var eventTableView: UITableView!
    
   //MARK: -  variable declaration
    
    var pasterUserId      : Int = 0
    var currentMonth = 0
    var delegate: churchChangeSubtitleOfIndexDelegate?
    var appVersion          : String = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var listResultArray = Array<Any>()
    var eventDateArray = Array<String>()
    var eventsCountsArray = Array<Int>()
    var eventTitleArray = Array<String>()
    var eventStartDateArray = Array<String>()
    var eventEndDateArray = Array<String>()
    
    var previousMonthString = "0"
    var isDateExists = false
    var currentMonthDataArray = Array<String>()
    var churchIdMonthYearArray:[GetEventByUserIdMonthYearResultVo] = Array<GetEventByUserIdMonthYearResultVo>()
    var churchID:Int = 0
    var churcgname          : String = ""
    var PageIndex = 1
    var totalPages : Int? = 0
    var totalRecords : Int? = 0
    var datesWithMultipleEvents = ["2018-01-08", "2018-01-16", "2018-01-20", "2018-01-28"]

    var feb = ""
    var numberEvent = ["AAA", "BBB", "CCC", "DDD"]
    var febEvent = ["Steve", "Jobs", "Pall", "Iphone"]
    var selectedDateString = ""
    var holidays:  [Date] = []
    let events:    [Date] = []
    let birthdays: [Date] = []
    var somedays : Array = [String]()
    var calendarEvents : [FSCalendar] = []
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter1 = DateFormatter()
    
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "GMT+5:30") //Current time zone

        return formatter
    }()
    
    let codedLabel:UILabel = UILabel()

    //MARK: -  view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendar.dataSource = self
        calendar.delegate = self
        
        eventTableView.dataSource = self
        eventTableView.delegate = self
        
        
        let nibName  = UINib(nibName: "ListOfMonthEventCell" , bundle: nil)
        eventTableView.register(nibName, forCellReuseIdentifier: "ListOfMonthEventCell")
        
        
        eventTableView.register(UINib.init(nibName: "AllEventHeaderCell", bundle: nil),
                                forCellReuseIdentifier: "AllEventHeaderCell")
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "M"
        monthFormatter.timeZone = NSTimeZone.local
        let monthString = monthFormatter.string(from: calendar.currentPage)
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        let yearString = yearFormatter.string(from: calendar.currentPage)
        
        self.getEventByUserIdMonthYearAPIService(_monthStr: monthString, _yearStr: yearString)

        calendarColor()
        
    }
    
 //MARK: -  view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
//     Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Notifications".localize(), backTitle: "Categories".localize(), rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")   
//        
//        
    }

       //MARK: -  color
    
    func calendarColor(){
        
        
        calendar.scope = .month
        calendar.appearance.weekdayTextColor = UIColor.red
        calendar.appearance.headerTitleColor = UIColor.red
        calendar.appearance.selectionColor = UIColor(red: 113.0/255.0, green: 173.0/255.0, blue: 208.0/255.0, alpha: 1.0)
        calendar.appearance.todayColor = UIColor.orange
        calendar.appearance.todaySelectionColor = UIColor.black

        calendar.allowsMultipleSelection = true
    
    }
    
   //MARK: -   Event calendar  
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        
        let dateString = self.dateFormatter2.string(from: date)
        
        if self.eventDateArray.contains(dateString) {
            
            var event = ""
            
            if let i = self.eventDateArray.index(of: dateString) {
                          print("Jason is at index \(i)")
                           let prevEventCount = self.eventsCountsArray[i]
                               event = "\(prevEventCount)"
                      }
            
            return event
        }
        return nil
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        
        print("gdfgdfgdfgdfg",calendar.currentPage)
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "M"
        monthFormatter.timeZone = NSTimeZone.local
        let monthString = monthFormatter.string(from: calendar.currentPage)
        
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        let yearString = yearFormatter.string(from: calendar.currentPage)
        
         print(monthString,yearString)
      
        if(previousMonthString != "\(monthString)" || previousMonthString != "\(yearString)"){
             churchIdMonthYearArray.removeAll()
            getEventByUserIdMonthYearAPIService(_monthStr: monthString, _yearStr: yearString)
        }
        print("this is the current Month \(currentMonth)")
    }


   func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.view.layoutIfNeeded()
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    print("did select date \(self.dateFormatter2.string(from: date))")
     let selectedDateString = self.dateFormatter2.string(from: date)
       
    if(eventDateArray.contains(selectedDateString)){
            
    if(appDelegate.checkInternetConnectivity()){
                
        let strUrl = GETEVENTBYDATEANDUSERID + "" + "\(selectedDateString)" + "/" + "\(churchID)"
                
        print(strUrl)
        serviceController.getRequest(strURL:strUrl, success:{(result) in
        DispatchQueue.main.async()
        {
            
            print("result:\(result)")
                            
                            
            let respVO:GetEventByDateAndUserIdVo = Mapper().map(JSONObject: result)!
                            
         let isSuccess = respVO.isSuccess
        print("StatusCode:\(String(describing: isSuccess))")
                            
        self.eventTitleArray.removeAll()
        self.eventStartDateArray.removeAll()
        self.eventEndDateArray.removeAll()

        if isSuccess == true {
                                
        let successMsg = respVO.endUserMessage
                                
        for eventsTitleList in respVO.listResult!{
                                    
        let eventTitle = eventsTitleList.eventTitle
        self.eventTitleArray.append(eventTitle!)
        let eventStartDate = eventsTitleList.startDate
        self.eventStartDateArray.append(self.returnEventDateWithoutTime(selectedDateString:eventStartDate!))
        let eventEndDate = eventsTitleList.endDate
        self.eventEndDateArray.append(self.returnEventDateWithoutTime(selectedDateString:eventEndDate!))


        print( self.eventEndDateArray)

    }
                                
        print(self.eventTitleArray)
        print(self.eventStartDateArray)
       print( self.eventEndDateArray)
            
    let reOrderPopOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DatePopUpViewController") as! DatePopUpViewController
                                
    var params : Dictionary = Dictionary<String,Any>()
    params.updateValue(self.eventTitleArray, forKey: selectedDateString)
    params.updateValue(self.eventStartDateArray, forKey: selectedDateString)
    params.updateValue(self.eventEndDateArray, forKey: selectedDateString)

   print(params)
                                
    reOrderPopOverVC.eventsLisrArray = self.eventTitleArray
    reOrderPopOverVC.eventStartDateLisrArray = self.eventStartDateArray
    reOrderPopOverVC.eventEndDateLisrArray = self.eventEndDateArray
            
    reOrderPopOverVC.eventsDateString = selectedDateString
    self.addChildViewController(reOrderPopOverVC)
    reOrderPopOverVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    self.view.addSubview(reOrderPopOverVC.view)
    reOrderPopOverVC.didMove(toParentViewController: self)
                                
    self.calendar.reloadData()
            
    }
                            
}
}, failure:  {(error) in
                    
    print(error)
                    
  if(error == "unAuthorized"){
                        
    }
    
    })
                
    }
else {
                
    return
    }
        
    print(numberEvent)
        
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        print("did deselect date \(self.dateFormatter2.string(from: date))")
        self.configureVisibleCells()
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if self.gregorian.isDateInToday(date) {
            return [UIColor.orange]
        }
        return [appearance.eventDefaultColor]
    }
    
// MARK: - Private functions
    
    private func configureVisibleCells() {
        
        calendar.visibleCells().forEach { (cell) in
        let date = calendar.date(for: cell)
        let position = calendar.monthPosition(for: cell)
            
        }
    }
    
    
    func getEventByUserIdMonthYearAPIService(_monthStr : String, _yearStr: String){
        
        if(appDelegate.checkInternetConnectivity()){
            
       // GetEventInfoByChurchIdMonthYearAPIService(_monthStr, _yearStr) pasterUserId
            
        let strUrl = GETEVENTBYUSERIDMONTHYEAR + "" + "\(churchID)" + "/" + "\(_monthStr)" + "/" + "\(_yearStr)"
            
        print(strUrl)
            
        serviceController.getRequest(strURL:strUrl, success:{(result) in
            
        DispatchQueue.main.async()
        {
                        
            
        print("result:\(result)")
                        
        let respVO:GetEventByUserIdMonthYearVo = Mapper().map(JSONObject: result)!
                        
      let isSuccess = respVO.isSuccess
            
      print("StatusCode:\(String(describing: isSuccess))")
            
     if isSuccess == true {
                            
    let successMsg = respVO.endUserMessage
                            
    if((respVO.listResult?.count)! > 0){
        
    for eventsList in respVO.listResult! {
                            
    let dateString = self.returnDateWithoutTime(selectedDateString: eventsList.eventDate!)
    self.eventDateArray.append(dateString)
    let eventsCountsString = eventsList.eventsCount
    self.eventsCountsArray.append(eventsCountsString!)
    self.currentMonthDataArray.append(dateString)
        
     self.churchIdMonthYearArray.append(eventsList)
        
    }
                            
    }
    else {
        
      self.currentMonthDataArray.removeAll()
    }
                            
    print("self.eventDateArray,Count", self.eventDateArray.count)
    print("self.eventsCountsArray", self.eventsCountsArray)
                            
                            
    self.calendar.reloadData()
    self.eventTableView.reloadData()

    }
                        
    }
            
     }, failure:  {(error) in
                
    print(error)
                
    if(error == "unAuthorized"){
                
                    
       }
                
      })
            
        }
        else {
            
        return
        }
        
    }
    
  //MARK: -   Event Date Without Time
    
    func returnDateWithoutTime(selectedDateString : String) -> String{
        var newDateStr = ""
        if(selectedDateString != ""){
            let invDtArray = selectedDateString.components(separatedBy: "T")
            let dateString = invDtArray[0]
            if(dateString != ""){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateFromString = dateFormatter.date(from: dateString)
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr = newDateString
                print(newDateStr)
            }

        }
        return newDateStr
    }
    
    
    func returnEventDateWithoutTime(selectedDateString : String) -> String{
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

  //MARK: -    Back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
    UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
    UserDefaults.standard.set("1", forKey: "1")
    UserDefaults.standard.removeObject(forKey: "1")
        
    UserDefaults.standard.synchronize()
    let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        print("Back Button Clicked......")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: -   TableView Delegate & DataSource Methods

extension EventViewController : UITableViewDelegate, UITableViewDataSource {
    
 //MARK: -   Get Event Info By Church Id Month Year API Service
    
    func GetEventInfoByChurchIdMonthYearAPIService(_ month : String, _ year : String){
        
        
        let  strUrl = GETEVENTINFOBYCHURCHIDMONTHYEAR
        
        
        let dictParams = [
            "churchId": churchID,
            "month": month,
            "year": year,
            "pageIndex": PageIndex,
            "pageSize": 10,
            "sortbyColumnName": "UpdatedDate",
            "sortDirection": "desc",
            "searchName": ""
            ] as [String : Any]
        
        print("dic params \(dictParams)")
        let dictHeaders = ["":"","":""] as NSDictionary
        
        print("dictHeader:\(dictHeaders)")
        
        
        serviceController.postRequest(strURL: strUrl as NSString, postParams: dictParams as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            let respVO:GetEventInfoByChurchIdMonthYearVo = Mapper().map(JSONObject: result)!
            
            
            let isSuccess = respVO.isSuccess
            
            if isSuccess == true {
                
                let successMsg = respVO.endUserMessage
                
                
                self.listResultArray = respVO.listResult!
                
                let pageCout  = (respVO.totalRecords)! / 10
                
                let remander = (respVO.totalRecords)! % 10
                
                self.totalPages = pageCout
                
                if remander != 0 {
                    
                    self.totalPages = self.totalPages! + 1
                    
                }
                
                for church in respVO.listResult!{
                    
                 //   self.churchIdMonthYearArray.append(church)
                    
                }
                
                
           //     print("churchAdminArray", self.churchIdMonthYearArray)
                
                
                self.eventTableView.reloadData()
                
                
            }
                
            else {
                
                
            }
            
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
        
        
    }

  //MARK: -   TableView Delegate & DataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return self.churchIdMonthYearArray.count
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let allEventHeaderCell = tableView.dequeueReusableCell(withIdentifier: "AllEventHeaderCell") as! AllEventHeaderCell
        
        
        
        return allEventHeaderCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40.0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if(self.churchIdMonthYearArray.count > indexPath.row ){
            
            let churchIdMonthYearList:GetEventByUserIdMonthYearResultVo = self.churchIdMonthYearArray[indexPath.row]
            
            
            let listOfMonthEventCell = tableView.dequeueReusableCell(withIdentifier: "ListOfMonthEventCell", for: indexPath) as! ListOfMonthEventCell
            
            if let churchName =  churchIdMonthYearList.churchName {
                listOfMonthEventCell.churchName.text = churchName
            }else{
            }
            
        
            if let contactNumber =  churchIdMonthYearList.contactNumber {
                listOfMonthEventCell.contactNumber.text =  contactNumber
            }else{
            }
            
            let startAndEndDate1 = returnEventDateWithoutTim1(selectedDateString: churchIdMonthYearList.eventDate!)
            
            if startAndEndDate1 != "" {
                listOfMonthEventCell.eventTitle.text = startAndEndDate1
            }else{
                
                listOfMonthEventCell.eventTitle.text = ""
            }
            
//            
//            if let startAndEndDate1 =  churchIdMonthYearList.eventDate {
//                listOfMonthEventCell.eventStartEndDate.text =  startAndEndDate1
//            }else{
//            }
            
            return listOfMonthEventCell
        }
        return UITableViewCell()
        

        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == churchIdMonthYearArray.count - 1 {
            
            if(self.totalPages! > PageIndex){
                
                
                PageIndex = PageIndex + 1
                
                let monthFormatter = DateFormatter()
                monthFormatter.dateFormat = "M"
                monthFormatter.timeZone = NSTimeZone.local
                let monthString = monthFormatter.string(from: calendar.currentPage)
                
                let yearFormatter = DateFormatter()
                yearFormatter.dateFormat = "YYYY"
                yearFormatter.timeZone = NSTimeZone.local
                let yearString = yearFormatter.string(from: calendar.currentPage)

                
          GetEventInfoByChurchIdMonthYearAPIService(monthString,yearString)
                
                
            }
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

   
}

