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
import IQKeyboardManagerSwift


class EventViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {

    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var eventTableView: UITableView!
    
//MARK: - variable declaration
    
    var utilities = Utilities()
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
    var churchEventsArray:[ChurchEventsListVO] = Array<ChurchEventsListVO>()
    
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
    var lastContentOffset: CGFloat = 0
    
//MARK: -  DateFormatter  declaration
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "GMT+5:30") //Current time zone

        return formatter
    }()
    
//MARK: -  Programmatically  UILabel declaration
    let codedLabel:UILabel = UILabel()

//MARK: -  view Did Load
    
 override func viewDidLoad() {
    
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()

        calendar.dataSource = self
        calendar.delegate = self
        calendar.placeholderType = .none
        
        eventTableView.dataSource = self
        eventTableView.delegate = self
        
//MARK: -  Register the Custom DataCell
    
        let nibName  = UINib(nibName: "ListOfMonthEventCell" , bundle: nil)
        eventTableView.register(nibName, forCellReuseIdentifier: "ListOfMonthEventCell")
    
        eventTableView.register(UINib.init(nibName: "AllEventHeaderCell", bundle: nil),
                                forCellReuseIdentifier: "AllEventHeaderCell")
    
//MARK: -  Initializing DateFormatter
    
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "M"
        monthFormatter.timeZone = NSTimeZone.local
        let monthString = monthFormatter.string(from: calendar.currentPage)
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        let yearString = yearFormatter.string(from: calendar.currentPage)
    
//MARK: - Here calling method of EventByUserIdMonthYear AND ChurchEventsGetEventDetailsInfoByChurchIdMonthYear API-Service's AND CalenderColor Method"
        self.getEventByUserIdMonthYearAPIService(_monthStr: monthString, _yearStr: yearString)
        self.getChurchEventsGetEventDetailsInfoByChurchIdMonthYearApiCall(_monthStr: monthString, _yearStr: yearString)
    

        calendarColor()
    
        
    }
    
//MARK: -  view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        
        //First Call Super
        super.viewDidAppear(true)
      
    }

//MARK: -  Set Calendar Color
    
    func calendarColor(){
        calendar.scope = .month
        calendar.appearance.weekdayTextColor = UIColor.red
        calendar.appearance.headerTitleColor = UIColor.red
        calendar.appearance.selectionColor = UIColor(red: 113.0/255.0, green: 173.0/255.0, blue: 208.0/255.0, alpha: 1.0)
        calendar.appearance.todayColor = UIColor.orange
        calendar.appearance.todaySelectionColor = UIColor.black

        //calendar.allowsMultipleSelection = true
    
    }
    
//MARK: - Calendar Delegate Methods
    
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
        self.churchEventsArray.removeAll()
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
             churchEventsArray.removeAll()
            
//MARK: - Here calling method of EventByUserIdMonthYear AND ChurchEventsGetEventDetailsInfoByChurchIdMonthYear API-Service's" when user can change current page(MONTH) to next page(NEXT MONTH) below API's are called.
            
            getEventByUserIdMonthYearAPIService(_monthStr: monthString, _yearStr: yearString)
            getChurchEventsGetEventDetailsInfoByChurchIdMonthYearApiCall(_monthStr: monthString, _yearStr: yearString)
        }
        print("this is the current Month \(currentMonth)")
        
        calendar.appearance.todayColor = UIColor.orange
    }


   func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.view.layoutIfNeeded()
    }
    
//MARK: - Here calling GETEVENTBYDATEANDUSERID API-Service
//MARK: - When user can select the date it will show information above the selected date
    
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
                self.eventStartDateArray.append(self.returnEventDateWithoutTim1(selectedDateString: eventStartDate!))
                let eventEndDate = eventsTitleList.endDate
                self.eventEndDateArray.append(self.returnEventDateWithoutTim1(selectedDateString: eventEndDate!))
                print( self.eventEndDateArray)
        }
        print(self.eventTitleArray)
        print(self.eventStartDateArray)
        print(self.eventEndDateArray)
            
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
 
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateString = self.dateFormatter2.string(from: date)
        
        if self.eventDateArray.contains(dateString)
        {
            if self.gregorian.isDateInToday(date) {
               
              return UIColor.orange
            }
            else{
                
              return UIColor.cyan
            }
        }
        else{
            
            return nil
        }
    }
    


    
// MARK: - Private functions
    
    private func configureVisibleCells() {
        
        calendar.visibleCells().forEach { (cell) in
        let date = calendar.date(for: cell)
        let position = calendar.monthPosition(for: cell)
            
        }
    }
    
// MARK: - Here initializing method of EventByUserIdMonthYear API-Service
func getEventByUserIdMonthYearAPIService(_monthStr : String, _yearStr: String){
    
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
    
// MARK: - Here initializing method of ChurchEventsGetEventDetailsInfoByChurchIdMonthYear API-Service
    func getChurchEventsGetEventDetailsInfoByChurchIdMonthYearApiCall(_monthStr : String, _yearStr: String){
        let getChurchEventsAPI = CHURCHEVENTSAPI + "" + "\(churchID)" + "/" + "\(_monthStr)" + "/" + "\(_yearStr)"
            serviceController.getRequest(strURL: getChurchEventsAPI, success: { (result) in
                if result.count > 0 {
                    let responseVO:ChurchEventsVO = Mapper().map(JSONObject: result)!
                    let isSuccess = responseVO.isSuccess
                    if isSuccess == true  {
                        if responseVO.listResult!.count > 0{
                            self.churchEventsArray = responseVO.listResult!
                        }
                        else{
                            self.churchEventsArray.removeAll()
                      }
                    self.eventTableView.reloadData()
                }
            }
            
        }) { (failureMessage) in
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
    
//MARK: -  Convert date and Time format
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
        
        
        return self.churchEventsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  136
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let allEventHeaderCell = tableView.dequeueReusableCell(withIdentifier: "AllEventHeaderCell") as! AllEventHeaderCell     
        
        return allEventHeaderCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40.0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if(self.churchEventsArray.count > indexPath.row ){
            
            let churchIdMonthYearList:ChurchEventsListVO = self.churchEventsArray[indexPath.row]
            let listOfMonthEventCell = tableView.dequeueReusableCell(withIdentifier: "ListOfMonthEventCell", for: indexPath) as! ListOfMonthEventCell
            if let eventName =  churchIdMonthYearList.title {
                listOfMonthEventCell.eventTitle.text = eventName
            }else{
            }
            if let contactNumber =  churchIdMonthYearList.contactNumber {
                listOfMonthEventCell.contactNumber.text =  contactNumber
            }else{
            }
            let eventStartDate = returnEventDateWithoutTim1(selectedDateString: churchIdMonthYearList.startDate!)
            if eventStartDate != "" {
                listOfMonthEventCell.churchName.text = eventStartDate
            }else{
                listOfMonthEventCell.churchName.text = ""
            }
            let eventEndDate = returnEventDateWithoutTim1(selectedDateString: churchIdMonthYearList.endDate!)
            if eventStartDate != "" {
                listOfMonthEventCell.eventStartEndDate.text = eventEndDate
            }else{
                listOfMonthEventCell.eventStartEndDate.text = ""
            }
            return listOfMonthEventCell
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == churchEventsArray.count - 1 {
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
                
              //Here calling EventInfoByChurchIdMonthYear API-Service
                GetEventInfoByChurchIdMonthYearAPIService(monthString,yearString)
     
            }
        }
        
    }

//MARK: -  Convert date and Time format(Modified Event Date Without Time)
    func returnEventDateWithoutTim1(selectedDateString : String) -> String{
        var newDateStr  = ""
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
               //  dateFormatter.dateFormat = "dd-MM-yyyy"
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

