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
    
    var notificationsArray = [getNotificationVO]()
    
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
                    
                    self.notificationsArray = (respVO.result?.notificationsList)!
                    
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
        
      //  var cccc = respVO.result?.notificationsList[indexPath.row]
        
        let id = notificationsArray[indexPath.row].Id!
        
        let churchId = notificationsArray[indexPath.row].churchId ?? 0
        
        let authorId = notificationsArray[indexPath.row].authorId ?? 0
        
        let eventId = notificationsArray[indexPath.row].eventId ?? 0
        
        let postId = notificationsArray[indexPath.row].postId ?? 0
        
        let readNotificationApi = READNOTIFICATIONAPI
        
        let parameters = [ "roleIds": "",
                           "userId": userId,
                           "id": id ,
                           "name": "",
                           "desc": "",
                           "htmlDesc": "",
                           "eventId": 0,
                           "postId": 0,
                           "notificationTypeId": 0,
                           "createdByUserId": 1,
                           "createdDate": "2018-10-30T17:13:09.9372877+05:30",
                           "updatedByUserId": 1,
                           "updatedDate": "2018-10-30T17:13:09.952913+05:30",
                           "serverUpdatedStatus": true ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: readNotificationApi as NSString, postParams: parameters as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            if churchId != 0{
                
                
                if eventId != 0 {
                    let eventViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
                    
                    eventViewController.churchID = self.notificationsArray[indexPath.row].churchId!
                    
                    self.navigationController?.pushViewController(eventViewController, animated: true)
                    
                }
                    
                else if postId != 0 {
                    
                    let authorPostVC = AuthorPostsViewController(nibName: "AuthorPostsViewController", bundle: nil)
                    
                    self.navigationController?.pushViewController(authorPostVC, animated: true)
                }
                
            }
                
            else if authorId != 0{
                
                if eventId != 0 {
                    
                    let authorEventsVC = AuthorEventsViewController(nibName: "AuthorEventsViewController", bundle: nil)
                    
                    authorEventsVC.authorID = self.notificationsArray[indexPath.row].authorId!
                    
                    
                    self.navigationController?.pushViewController(authorEventsVC, animated: true)
                    
                }
                    
                else if postId != 0 {
                    
                    let authorPostVC = AuthorPostsViewController(nibName: "AuthorPostsViewController", bundle: nil)
                    
                    self.navigationController?.pushViewController(authorPostVC, animated: true)
                    
                }
                
            }
            
            
            
        }) { (failure) in
            
            
        }
        
        
        
    }
    



}
