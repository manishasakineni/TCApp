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
  
    var authorID : Int = 0
    
    var todayDate = NSDate()
    
    
    var PageIndex = 1
    var totalPages : Int? = 0
    var totalRecords : Int? = 0
    
    var month = String()
    var year = String()
    
    var previousMonthString = "0"
    var isDateExists = false
    var currentMonthDataArray = Array<String>()
    var currentMonth = 0

    
    
    var authorDetailsArray  : [AuthorEventsListResultInfoVO] = Array<AuthorEventsListResultInfoVO>()
    
    
    var authorDetailsCountArray  : [AuthorEventDateCountInfoVO] = Array<AuthorEventDateCountInfoVO>()

    var delegate: authorChangeSubtitleOfIndexDelegate?
    
    var eventDateArray = Array<String>()
    
    var eventsCountsArray = Array<Int>()
    
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
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        
        return formatter
    }()
    
//MARK: -   View DidLoad


    override func viewDidLoad() {
        super.viewDidLoad()
 
        print(authorID)
        
        print(todayDate)

        let calendars = Calendar.current
        
        
        year  = String(calendars.component(.year, from: todayDate as Date))
        month = String(calendars.component(.month, from: todayDate as Date))
        
        
        let listOfMonthEventCell = UINib(nibName: "AdminMonthEventListCell" , bundle: nil)
        authorEventsTableView.register(listOfMonthEventCell, forCellReuseIdentifier: "AdminMonthEventListCell")
        
        let authorEventsCalenderTableViewCell  = UINib(nibName: "AuthorEventsCalenderTableViewCell" , bundle: nil)
        authorEventsTableView.register(authorEventsCalenderTableViewCell, forCellReuseIdentifier: "AuthorEventsCalenderTableViewCell")
        
        authorEventsTableView.delegate = self
        authorEventsTableView.dataSource = self
        
        
        calendar.delegate = self
        calendar.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: -   View WillAppear
 
    override func viewWillAppear(_ animated: Bool) {
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "M"
        monthFormatter.timeZone = NSTimeZone.local
        let monthString = monthFormatter.string(from: calendar.currentPage)
        
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        let yearString = yearFormatter.string(from: calendar.currentPage)
        

     getAthorEventsApiCall (monthString,yearString)
              color()
        
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
    
    //MARK: -   Get Author Events API Call
   
    func getAthorEventsApiCall(_ month : String, _ year : String){
    
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "M"
        monthFormatter.timeZone = NSTimeZone.local
        let monthString = monthFormatter.string(from: calendar.currentPage)
        
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        let yearString = yearFormatter.string(from: calendar.currentPage)
        
        print(monthString,yearString)
        
        

        if(appDelegate.checkInternetConnectivity()){

      let athorEventsAPIString = GETAUTHOREVENTSBYMONTHYEAR  + "\(authorID)" +  "/" + "\(monthString)" + "/" + "\(yearString)"
        
        print(athorEventsAPIString)
    
       
        getAthorEventsCountApiCall(monthString, yearString)
        
        
        serviceController.getRequest(strURL: athorEventsAPIString, success: { (result) in
            
            print(result)
            
            if result.count > 0 {
                
            let responseVO : AuthorEventsResultVO = Mapper().map(JSONObject: result)!
            
            
            let isSuccess = responseVO.isSuccess
            
            
            if isSuccess == true{
            
                
                self.authorDetailsArray = responseVO.listResult!
    
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
    
//MARK: -   Calendar Current Page Did Change
 
  
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
            authorDetailsArray.removeAll()
            getAthorEventsApiCall (monthString,yearString)

        }
        print("this is the current Month \(currentMonth)")
    }

    
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
    
//MARK: -   Get Author Events Count API Call
   

    func getAthorEventsCountApiCall(_ month : String, _ year : String){
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "M"
        monthFormatter.timeZone = NSTimeZone.local
        let monthString = monthFormatter.string(from: calendar.currentPage)
        
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        let yearString = yearFormatter.string(from: calendar.currentPage)
        
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
                    
                    for authorDetailsCount in responseVO.listResult! {
                        
                        let dateString = self.returnDateWithoutTime(selectedDateString: authorDetailsCount.eventDate!)
                        
                        self.eventDateArray.append(dateString)
                        self.eventsCountsArray.append(authorDetailsCount.eventsCount!)
                        
                        
                    }
                    
                    self.calendar.reloadData()
                }
                    
                    
                else{
                   
                }
                
            }
          
        })
            
        { (failureMessage) in
            
            
            print(failureMessage)
            
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
        

    return 148
       

        
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
    

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        if(authorDetailsArray.count > 0){
            
       let authorDetails = authorDetailsArray[indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: "AdminMonthEventListCell", for: indexPath) as! AdminMonthEventListCell
            
            if authorDetails.churchName != nil {
                
                 cell.churchName.text = authorDetails.churchName!
            }
            
            if authorDetails.title != nil {
               
                 cell.eventName.text = authorDetails.title
            }
            
            if authorDetails.startDate != nil {
                
                cell.fromDate.text =  self.returnEventDateWithoutTim1(selectedDateString: String(describing: authorDetails.startDate!))
            }
            
            if authorDetails.endDate != nil {
                
                cell.toDate.text =  self.returnEventDateWithoutTim1(selectedDateString: String(describing: authorDetails.endDate!))
            }
           
            return cell
            }
    
        
        self.authorEventsTableView.reloadData()
        
       return UITableViewCell()
    
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
