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
    
    var authorID : Int = 0
    
    var todayDate = NSDate()
    
    
    
    var month = String()
    var year = String()
    
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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
 
        print(authorID)
        
        print(todayDate)

        let calendars = Calendar.current
        
        
        year  = String(calendars.component(.year, from: todayDate as Date))
        month = String(calendars.component(.month, from: todayDate as Date))
        
        
        let listOfMonthEventCell = UINib(nibName: "ListOfMonthEventCell" , bundle: nil)
        authorEventsTableView.register(listOfMonthEventCell, forCellReuseIdentifier: "ListOfMonthEventCell")
        
        let authorEventsCalenderTableViewCell  = UINib(nibName: "AuthorEventsCalenderTableViewCell" , bundle: nil)
        authorEventsTableView.register(authorEventsCalenderTableViewCell, forCellReuseIdentifier: "AuthorEventsCalenderTableViewCell")
        
        authorEventsTableView.delegate = self
        authorEventsTableView.dataSource = self
        
        
        calendar.delegate = self
        calendar.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
     getAthorEventsApiCall()
    getAthorEventsCountApiCall()
        
        color()
        
    }
    
    func color(){
        
        
        //  calendar.scope = .week
        calendar.scope = .month
        calendar.appearance.weekdayTextColor = UIColor.red
        calendar.appearance.headerTitleColor = UIColor.red
        // calendar.appearance.eventColor = UIColor.green
        calendar.appearance.selectionColor = UIColor(red: 113.0/255.0, green: 173.0/255.0, blue: 208.0/255.0, alpha: 1.0)
        calendar.appearance.todayColor = UIColor.orange
        calendar.appearance.todaySelectionColor = UIColor.black
        
        calendar.allowsMultipleSelection = true
        // calendar.firstWeekday = 2
        
        // calendar.appearance.borderRadius = 0
        
    }
    
    func getAthorEventsApiCall(){
    
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "M"
        monthFormatter.timeZone = NSTimeZone.local
        let monthString = monthFormatter.string(from: calendar.currentPage)
        
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        let yearString = yearFormatter.string(from: calendar.currentPage)
        
        print(monthString,yearString)
        

    
      let athorEventsAPIString = GETAUTHOREVENTSBYMONTHYEAR  + "\(authorID)" +  "/" + "\(monthString)" + "/" + "\(yearString)"
        
        print(athorEventsAPIString)
    
        
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
    
    
    
    }
    
    func getAthorEventsCountApiCall(){
        
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
                    
                    
                 //   self.authorDetailsCountArray = responseVO.listResult!
                   
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

    func returnDateWithoutTime(selectedDateString : String) -> String{
        var newDateStr = ""
        if(selectedDateString != ""){
            let invDtArray = selectedDateString.components(separatedBy: "T")
            let dateString = invDtArray[0]
            //   let timeString = invDtArray[1]
            //  print(timeString)
            
            if(dateString != ""){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateFromString = dateFormatter.date(from: dateString)
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr = newDateString
                print(newDateStr)
            }
            //            if(timeString != ""){
            //                let dateFormatter = DateFormatter()
            //                dateFormatter.dateStyle = .medium
            //                dateFormatter.dateFormat = "HH:mm:ss"
            //                let dateFromString = dateFormatter.date(from: timeString)
            //                dateFormatter.dateFormat = "hh:mm aa"
            //                let newDateString = dateFormatter.string(from: dateFromString!)
            //                newDateStr = newDateString
            //                print(newDateStr)
            //            }
        }
        return newDateStr
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
  
        
        return self.authorDetailsArray.count
        
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        

    return 125
       

        
    }
//    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return UITableViewAutomaticDimension
//        
//    }
//    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let authorDetails = authorDetailsArray[indexPath.row]
        
        if(authorDetailsArray.count > 0){
            

                let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfMonthEventCell", for: indexPath) as! ListOfMonthEventCell
            
            
            cell.churchName.text = "Church Name :" + " " + authorDetails.churchName!
            
            cell.eventTitle.text = authorDetails.title
            
            cell.contactNumber.text =  "Church Name :" + " " + authorDetails.churchName!
            
            cell.eventStartEndDate.text = "From :" + String(describing: authorDetails.startDate!) + " " + "To :" + String(describing: authorDetails.endDate!)
            
                
            return cell
            }
    
        
        self.authorEventsTableView.reloadData()
        
       return UITableViewCell()
    
            }
    
    
    

}
