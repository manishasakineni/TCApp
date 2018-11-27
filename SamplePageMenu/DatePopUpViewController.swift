//
//  DatePopUpViewController.swift
//  CustomCalender
//
//  Created by praveen dole on 2/16/18.
//  Copyright © 2018 praveen dole. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class DatePopUpViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var datePopUpTableView: UITableView!

    var eventsLisrArray = Array<String>()
    var eventStartDateLisrArray = Array<String>()
    var eventEndDateLisrArray = Array<String>()

    var febEventsLisrArray = Array<String>()

    var eventsDateString : String = ""


    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
        datePopUpTableView.delegate = self
        datePopUpTableView.dataSource = self
        
        let nibName1  = UINib(nibName: "EventInformationCell" , bundle: nil)
        datePopUpTableView.register(nibName1, forCellReuseIdentifier: "EventInformationCell")
        datePopUpTableView.register(UINib.init(nibName: "EventHeaderCell", bundle: nil),
        forCellReuseIdentifier: "EventHeaderCell")

        
        
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if section == 0{
            
            return eventsLisrArray.count

        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let eventHeaderCell = tableView.dequeueReusableCell(withIdentifier: "EventHeaderCell") as! EventHeaderCell
        
        eventHeaderCell.eventDate.text = "Date".localize() + ":-"  + self.eventsDateString
        eventHeaderCell.eventName.text = "EventName".localize()
        eventHeaderCell.eventStartDate.text = "EventStartDate".localize()
        eventHeaderCell.eventEndDate.text = "EventEndDate".localize()

        
       
        
        return eventHeaderCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 81
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
            let eventInformationCell = tableView.dequeueReusableCell(withIdentifier: "EventInformationCell", for: indexPath) as! EventInformationCell
        
             eventInformationCell.eventType.text = self.eventsLisrArray[indexPath.row]
             eventInformationCell.eventStartDateLabel.text = self.eventStartDateLisrArray[indexPath.row]
             eventInformationCell.eventEndDateLabel.text = self.eventEndDateLisrArray[indexPath.row]
 
            return eventInformationCell
       
    }
    
    
    @IBAction func okButtonAction(_ sender: UIButton) {
        
        removeAnimate()
        
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        
        removeAnimate()
        
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }


}
