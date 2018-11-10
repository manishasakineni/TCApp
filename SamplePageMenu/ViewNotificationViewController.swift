//
//  ViewNotificationViewController.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 09/11/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class ViewNotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var viewNotificationsTableView: UITableView!
    
    var userId :  Int = 0
    
    var notificationNamesArray = NSMutableArray()   /// Objective C Array
    
    var notificationDescriptionArray = Array<String>()   /// Swift array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName  = UINib(nibName: "NotificationTableViewCell" , bundle: nil)
        viewNotificationsTableView.register(nibName, forCellReuseIdentifier: "NotificationTableViewCell")
        
        viewNotificationsTableView.delegate = self
        viewNotificationsTableView.dataSource = self
        
        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            
            userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
            
        }
        
        getNotificationCount()

        // Do any additional setup after loading the view.
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
                            
                   if notificationdetails.isRead == false
                   {
                    self.notificationNamesArray.add(notificationdetails.name!)
                    self.notificationDescriptionArray.append(notificationdetails.desc!)
                    
                            }
 
                        
                    }
                }

                    self.viewNotificationsTableView.reloadData()
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
    
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    



}
