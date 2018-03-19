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
            
            
            
            }
            
            else{
            
            
            
            
            }
            self.eventDetailsTableView.reloadData()
            
        }) { (failureMessege) in
            
            
            
        }
    
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.row == 0{
            
            return 140
        
        }
        
        else{
        
            return UITableViewAutomaticDimension
        
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        if indexPath.row == 0{
        
        let headImgTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HeadImgTableViewCell", for: indexPath) as! HeadImgTableViewCell
        
        headImgTableViewCell.churchNameLabel.isHidden  = true
        
        
        
        return headImgTableViewCell
        
        }
        
        else{
        
        let informationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell", for: indexPath) as! InformationTableViewCell
            
            
            informationTableViewCell.infoLabel.text = "Author Name".localize()
            
          //  informationTableViewCell.addressLabel.text = authorDetails.authorName
        
        return informationTableViewCell
    }

    }
}
