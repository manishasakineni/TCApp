//
//  ReadNotificationViewController.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 09/11/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class ReadNotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var ReadNotificationsTableView: UITableView!
    
    var userId :  Int = 0
    
    var notificationNamesArray = NSMutableArray()   /// Objective C Array
    
    var notificationDescriptionArray = Array<String>()   /// Swift array
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName  = UINib(nibName: "NotificationTableViewCell" , bundle: nil)
        ReadNotificationsTableView.register(nibName, forCellReuseIdentifier: "NotificationTableViewCell")
        
        ReadNotificationsTableView.delegate = self
        ReadNotificationsTableView.dataSource = self
        
        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            
            userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
            
        }
        
        getNotificationCount()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNotificationCount() {
        
        self.notificationNamesArray.removeAllObjects()
        self.notificationDescriptionArray.removeAll()
        
        let getNotificationAPI = GETNOTIFICATIONAPI
        
        let parameters = [
            "sortDirection":"desc",
            "sortbyColumnName":"UpdatedDate",
            "userId":self.userId,
            "pageIndex": 1,
            "pageSize": 100
            ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        serviceController.postRequest(strURL: getNotificationAPI as NSString, postParams: parameters as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            let respVO:getNotificationResultVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            
            if isSuccess == true{
                
                if ((respVO.result?.notificationsList) != nil)  {
                    
                    for i in 0..<((respVO.result?.notificationsList)!)!.count {
                        
                        if let notificationdetails = respVO.result?.notificationsList![i] {
                            
                            if notificationdetails.isRead == true
                            {
                                self.notificationNamesArray.add(notificationdetails.name!)
                                self.notificationDescriptionArray.append(notificationdetails.desc!)
                                
                            }
                            
                            
                        }
                    }
                    
                    self.ReadNotificationsTableView.reloadData()
                }
                
            }
            
        }) { (failure) in
            
            
        }
        
    }
    
    
    // MARK: - Uitableview delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.notificationNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        
        
        cell.notificationNameLbl.text = self.notificationNamesArray[indexPath.row] as? String
        cell.notificationDescLbl.text = self.notificationDescriptionArray[indexPath.row]
        
        return cell
        
    }
    
    

}
