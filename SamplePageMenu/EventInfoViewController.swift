//
//  EventInfoViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/21/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import FSCalendar


class EventInfoViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {

    @IBOutlet weak var calendar: FSCalendar!
    
    //MARK: -  variable declaration
    
    var delegate: churchChangeSubtitleOfIndexDelegate?
    var febDatesWithEvent = ["2018-02-03", "2018-02-06", "2018-02-12", "2018-02-25"]
    var datesWithMultipleEvents = ["2018-01-08", "2018-01-16", "2018-01-20", "2018-01-28","2018-02-07", "2018-02-08", "2018-02-14", "2018-02-01", "2018-02-12", "2018-02-25"]
    
    var event = ""
    var feb = ""
    var numberEvent = ["AAA", "BBB", "CCC", "DDD"]
    var febEvent = ["Steve", "Jobs", "Pall", "Iphone"]
    var holidays:  [Date] = []
    let events:    [Date] = []
    let birthdays: [Date] = []
    var somedays : Array = [String]()
    var calendarEvents : [FSCalendar] = []

    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    let codedLabel:UILabel = UILabel()
    
//MARK: -  view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        event = "\(numberEvent.count)"
       
        calendar.dataSource = self
        calendar.delegate = self
        
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        color()
        
    }
    
    //MARK: -  view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
    }
    //MARK: -  view Did Appear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
    }
    //MARK: -  color

    
    func color(){
        
        calendar.scope = .month
        calendar.appearance.weekdayTextColor = UIColor.red
        calendar.appearance.headerTitleColor = UIColor.red
        // calendar.appearance.eventColor = UIColor.green
        calendar.appearance.selectionColor = UIColor.lightGray
        calendar.appearance.todayColor = UIColor.orange
        calendar.appearance.todaySelectionColor = UIColor.black
        
        calendar.allowsMultipleSelection = true
        calendar.firstWeekday = 2
        
        // calendar.appearance.borderRadius = 0
        
    }
    
 //MARK: -  calendar
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        
        let dateString = self.dateFormatter2.string(from: date)
        
        
        if self.datesWithMultipleEvents.contains(dateString) {
            
            return self.event
        }
        return nil
    }
    
    
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.view.layoutIfNeeded()
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter2.string(from: date))")
        
        let selectedDateString = self.dateFormatter2.string(from: date)
        
        if(datesWithMultipleEvents.contains(selectedDateString)){
            
            let reOrderPopOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DatePopUpViewController") as! DatePopUpViewController
            
            reOrderPopOverVC.eventsLisrArray = self.numberEvent
            reOrderPopOverVC.eventsDateString = selectedDateString
            
            self.addChildViewController(reOrderPopOverVC)
            
            reOrderPopOverVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
            self.view.addSubview(reOrderPopOverVC.view)
            
            reOrderPopOverVC.didMove(toParentViewController: self)
            
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
    
    
    
       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
