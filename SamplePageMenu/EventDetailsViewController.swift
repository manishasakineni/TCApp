//
//  EventDetailsViewController.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 19/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var eventDetailsTableView: UITableView!
    
    var eventsDetailsArray:[EventDetailsListResultVO] = Array<EventDetailsListResultVO>()
  //  EventDetailsListResultVO
    
    var eventID = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventDetailsTableView.delegate = self
        eventDetailsTableView.dataSource = self
        
        let headImgTableViewCell = UINib(nibName: "HeadImgTableViewCell", bundle: nil)
        eventDetailsTableView.register(headImgTableViewCell, forCellReuseIdentifier: "HeadImgTableViewCell")
        
        let informationTableViewCell  = UINib(nibName: "InformationTableViewCell" , bundle: nil)
        eventDetailsTableView.register(informationTableViewCell, forCellReuseIdentifier: "InformationTableViewCell")
        
        getEventDetailsByIdApiCall()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getEventDetailsByIdApiCall(){
    
     let getEventDetailsByIdApi = GETEVENTDETAILSBYID + String(eventID)
        
        serviceController.getRequest(strURL: getEventDetailsByIdApi, success: { (result) in
            
            if result.count > 0{
            
                let responseVO:EventDetailsVO = Mapper().map(JSONObject: result)!
                
                let isSuccess = responseVO.isSuccess
                print("StatusCode:\(String(describing: isSuccess))")
                
                if isSuccess == true{
                    
                    
                    self.eventsDetailsArray = (responseVO.listResult)!
                    
                    print(self.eventsDetailsArray)
                
                }
                
                
                else{
                
                
                
                }
                
            
            }
            
            else{
            
            
                print(" No result Found ")
            
            }
            self.eventDetailsTableView.reloadData()
            
        }) { (failureMessege) in
            
            print(failureMessege)
            
        }
    
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.row == 0{
            
            return 140
        
        }
        
        else{
        
            return UITableViewAutomaticDimension
        
        }
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if eventsDetailsArray.count > 0 {
            
            let eventList: EventDetailsListResultVO = self.eventsDetailsArray[0]
        
        if indexPath.row == 0{
        
        let headImgTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HeadImgTableViewCell", for: indexPath) as! HeadImgTableViewCell
        
        headImgTableViewCell.churchNameLabel.text = eventList.title
        
        
        return headImgTableViewCell
        
        }
        
        else{
        
        let informationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell", for: indexPath) as! InformationTableViewCell
            
            if indexPath.row == 1 {
            
                informationTableViewCell.infoLabel.text = "Contact Name"
                
                informationTableViewCell.addressLabel.text =  eventList.churchName
            
            }
            
            if indexPath.row == 2 {
                
                informationTableViewCell.infoLabel.text = "Registration Number"
                
                informationTableViewCell.addressLabel.text =  eventList.registrationNumber
                
            }
            
            if indexPath.row == 3 {
                
                informationTableViewCell.infoLabel.text = "Event Name"
                
                informationTableViewCell.addressLabel.text =  eventList.title
                
            }
            
            if indexPath.row == 4 {
                
                informationTableViewCell.infoLabel.text = "Contact Number"
                
                informationTableViewCell.addressLabel.text =  eventList.contactNumber
                
            }

            
            if indexPath.row == 5 {
                
                informationTableViewCell.infoLabel.text = "Start Date"
                
                informationTableViewCell.addressLabel.text =  eventList.startDate! + "reeyrut iuyiuyiuyiu  iiiuoiuoi  uoiuj "

            }
            
            if indexPath.row == 6 {
                
                informationTableViewCell.infoLabel.text = "End Date"
                
                informationTableViewCell.addressLabel.text =  eventList.endDate! + "reeyrut iuyiuyiuyiu  iiiuoiuoi  uoiuj "
                
                
            }
            
            return informationTableViewCell
        }
            
        }
        
        
        return UITableViewCell()
        
    }

    
}
