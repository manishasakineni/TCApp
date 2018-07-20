//
//  AothorEventsViewController.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 13/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import FSCalendar

class AuthorEventsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var authorEventsTableView: UITableView!
    
//MARK: -  variable declaration
    
   var monthString = ""
   var yearString = ""
    var authorID : Int = 0
    
    var todayDate = NSDate()
    
      var numberEvent = ["AAA", "BBB", "CCC", "DDD"]
    var PageIndex = 1
    var totalPages : Int? = 0
    var totalRecords : Int? = 0
    
    var month = String()
    var year = String()
    
    var previousMonthString = "0"
    var isDateExists = false
    var currentMonthDataArray = Array<String>()
    var currentMonth = 0

    
    
    var authorDetailsArray  : [AuthorEventDateCountInfoVO] = Array<AuthorEventDateCountInfoVO>()
    
    
   // var authorDetailsCountArray  : [AuthorEventDateCountInfoVO] = Array<AuthorEventDateCountInfoVO>()

    var delegate: authorChangeSubtitleOfIndexDelegate?
    
    var eventDateArray = Array<String>()
    
    var eventsCountsArray = Array<Int>()
    
    
    
  
    var eventTitleArray = Array<String>()
    var eventStartDateArray = Array<String>()
    var eventEndDateArray = Array<String>()

    
    
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        
        return formatter
    }()
    
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "GMT+5:30") //Current time zone
        
        return formatter
    }()
    
//MARK: -   View Did Load


    override func viewDidLoad() {
        super.viewDidLoad()
 
        print(authorID)
        
        print(todayDate)

        let calendars = Calendar.current
        
        
        year  = String(calendars.component(.year, from: todayDate as Date))
        month = String(calendars.component(.month, from: todayDate as Date))
        
        
        let listOfMonthEventCell = UINib(nibName: "AuthorleventTableViewCell" , bundle: nil)
        authorEventsTableView.register(listOfMonthEventCell, forCellReuseIdentifier: "AuthorleventTableViewCell")
        
        let authorEventsCalenderTableViewCell  = UINib(nibName: "AuthorEventsCalenderTableViewCell" , bundle: nil)
        authorEventsTableView.register(authorEventsCalenderTableViewCell, forCellReuseIdentifier: "AuthorEventsCalenderTableViewCell")
        
        
        
        authorEventsTableView.register(UINib.init(nibName: "AllEventHeaderCell", bundle: nil),
                                forCellReuseIdentifier: "AllEventHeaderCell")

        
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "M"
        monthFormatter.timeZone = NSTimeZone.local
        let monthString = monthFormatter.string(from: calendar.currentPage)
        
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        let yearString = yearFormatter.string(from: calendar.currentPage)
        
        
        
   //     self.getEventByUserIdMonthYearAPIService(_monthStr: monthString, _yearStr: yearString)
        
        calendarColor()

        
        authorEventsTableView.delegate = self
        authorEventsTableView.dataSource = self
        
        
        calendar.delegate = self
        calendar.dataSource = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: -   View Will Appear
 
    override func viewWillAppear(_ animated: Bool) {
        
        let monthFormatter = DateFormatter()
        
        monthFormatter.dateFormat = "M"
        monthFormatter.timeZone = NSTimeZone.local
        monthString = monthFormatter.string(from: calendar.currentPage)
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        yearString = yearFormatter.string(from: calendar.currentPage)
        

    
        
        getAthorEventsCountApiCall(monthString, yearString)
        
     
        
     color()
        
    }
    
    
    func calendarColor(){
        
        
        calendar.scope = .month
        calendar.appearance.weekdayTextColor = UIColor.red
        calendar.appearance.headerTitleColor = UIColor.red
        calendar.appearance.selectionColor = UIColor(red: 113.0/255.0, green: 173.0/255.0, blue: 208.0/255.0, alpha: 1.0)
        calendar.appearance.todayColor = UIColor.orange
        calendar.appearance.todaySelectionColor = UIColor.black
        
        calendar.allowsMultipleSelection = true
        
    }
    
    
//MARK: -   Border Colors
 
    func color(){
        
        calendar.scope = .month
        calendar.appearance.weekdayTextColor = UIColor.red
        calendar.appearance.headerTitleColor = UIColor.red
        calendar.appearance.selectionColor = UIColor(red: 113.0/255.0, green: 173.0/255.0, blue: 208.0/255.0, alpha: 1.0)
        calendar.appearance.todayColor = UIColor.orange
        calendar.appearance.todaySelectionColor = UIColor.black
        
        calendar.allowsMultipleSelection = true
        
    }
    
    
    
    //MARK: -   Get Author Events Count API Call
    
    
    func getAthorEventsCountApiCall(_ month : String, _ year : String){
        
        
        
        print(monthString,yearString)
        
        let athorEventsCountAPIString = GETAUTHOREVENTSCOUNTBYMONTH  + "\(authorID)" +  "/" + "\(monthString)" + "/" + "\(yearString)"
        
        print(athorEventsCountAPIString)
        
        serviceController.getRequest(strURL: athorEventsCountAPIString, success: { (result) in
            
            
            if result.count > 0 {
                
                let responseVO : AuthorEventDateCountResultVO = Mapper().map(JSONObject: result)!
                
                
                let isSuccess = responseVO.isSuccess
                
                
                if isSuccess == true{
                    
                    self.eventDateArray.removeAll()
                    self.eventsCountsArray.removeAll()
                    
                    self.authorDetailsArray = responseVO.listResult!
                    
                    
                    for authorDetailsCount in responseVO.listResult! {
                        
                        let dateString = self.returnDateWithoutTime(selectedDateString: authorDetailsCount.eventDate!)
                        
                        self.eventDateArray.append(dateString)
                        self.eventsCountsArray.append(authorDetailsCount.eventsCount!)
                        
                        
                    }
                    
                    
                    self.calendar.reloadData()
                    self.authorEventsTableView.reloadData()
                }
                    
                    
                else{
                    
                }
                
            }
            
            
        })
            
        { (failureMessage) in
            
            
            print(failureMessage)
            
        }
        
    }
  
    
//MARK: -   Calendar Current Page Did Change
 
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
        monthString = monthFormatter.string(from: calendar.currentPage)
        
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        yearString = yearFormatter.string(from: calendar.currentPage)
        
        print(monthString,yearString)
        
        if(previousMonthString != "\(monthString)" || previousMonthString != "\(yearString)"){
            
            authorDetailsArray.removeAll()
            
           //  self.authorEventsTableView.reloadData()
            
            getAthorEventsCountApiCall(monthString, yearString)
         

        }
        print("this is the current Month \(currentMonth)")
    }

    
    
    func getAthorEventsApiCall(_ month : String, _ year : String){
        
        
        self.authorDetailsArray.removeAll()
        
        //   print(monthString,yearString)
        
        
        
        if(appDelegate.checkInternetConnectivity()){
            
            let athorEventsAPIString = GETAUTHOREVENTSBYMONTHYEAR  + "\(authorID)" +  "/" + "\(monthString)" + "/" + "\(yearString)"
            
            print(athorEventsAPIString)
            
            serviceController.getRequest(strURL: athorEventsAPIString, success: { (result) in
                
                print(result)
                
                if result.count > 0 {
                    
                    let responseVO : AuthorEventsResultVO = Mapper().map(JSONObject: result)!
                    
                    
                    let isSuccess = responseVO.isSuccess
                    
                    
                    
                    if isSuccess == true{
                        
                        
                     //   self.authorDetailsArray = responseVO.listResult!
                        
                        self.authorEventsTableView.reloadData()
                    }
                        
                        
                    else{
                        
                        
                        
                    }
                    
                }
            }) { (failureMessage) in
                
                
                print(failureMessage)
                
            }
        }  else {
            
            return
        }
        
        
    }

    
//MARK: -   TableView Delegate & DataSource Methods

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
  
        
        return self.authorDetailsArray.count
        
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        

    return 100
       

        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == authorDetailsArray.count - 1 {
            
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
                
                
                self.getAthorEventsCountApiCall(monthString,yearString)
                
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let allEventHeaderCell = tableView.dequeueReusableCell(withIdentifier: "AllEventHeaderCell") as! AllEventHeaderCell
        
        
        
        return allEventHeaderCell
        
    }

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        if(authorDetailsArray.count > 0){
            
       let authorDetails = authorDetailsArray[indexPath.row]
            
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorleventTableViewCell", for: indexPath) as! AuthorleventTableViewCell
            
            if authorDetails.authorName != nil {
                
                 cell.authornameLbl.text = authorDetails.authorName!
            }
            
            if authorDetails.mobileNumber != nil {
               
                 cell.phnoLbl.text = authorDetails.mobileNumber
            }
            
            if authorDetails.eventDate != nil {
                
                
                 cell.timeLbl.text =  self.returnEventDateWithoutTim1(selectedDateString: String(describing: authorDetails.eventDate!))
            }
           
            return cell
            }
        
        else {
        
            print("author Details array is empty")
        
        }
    
        
      //  self.authorEventsTableView.reloadData()
        
       return UITableViewCell()
    
            }
    
    
    
    
    
    //MARK: -   Event calendar
    
    
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.view.layoutIfNeeded()
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter2.string(from: date))")
        let selectedDateString = self.dateFormatter2.string(from: date)
        
        if(eventDateArray.contains(selectedDateString)){
            
            if(appDelegate.checkInternetConnectivity()){
                
                let strUrl = GETEVENTSBYMONTHYEAR + "" + "\(selectedDateString)" + "/" + "\(authorID)"
                
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
                                    self.eventStartDateArray.append(self.returnEventDateWithoutTim1(selectedDateString:eventStartDate!))
                                    
                                    let eventEndDate = eventsTitleList.endDate
                                    self.eventEndDateArray.append(self.returnEventDateWithoutTim1(selectedDateString:eventEndDate!))
                                    
                                    
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
    

    
    private func configureVisibleCells() {
        
        calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            
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

}
