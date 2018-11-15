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
    
    var notificationsArray = [getNotificationVO]()
    
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
        
        let getNotificationAPI = GETREADNOTIFICATIONAPI
        
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
//                let eventViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
//
//                eventViewController.churchID = self.notificationsArray[indexPath.row].churchId!
//
//                self.navigationController?.pushViewController(eventViewController, animated: true)
                    
                    
                        let eventViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChurchesInformaationViewControllers") as! ChurchesInformaationViewControllers
                    
                            eventViewController.isFromNotification = true
                            eventViewController.pageName = "Events"
                            eventViewController.churchID = self.notificationsArray[indexPath.row].churchId!
                    
                            self.navigationController?.pushViewController(eventViewController, animated: true)
                    
                    
                    
                }
                
                else if postId != 0 {
                    
//                   let authorPostVC = AuthorPostsViewController(nibName: "AuthorPostsViewController", bundle: nil)
//
//                    self.navigationController?.pushViewController(authorPostVC, animated: true)
                    
                    
                    
                    let authorPostVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChurchesInformaationViewControllers") as! ChurchesInformaationViewControllers
                    
                    authorPostVC.isFromNotification = true
                    authorPostVC.pageName = "Posts"
                    self.navigationController?.pushViewController(authorPostVC, animated: true)
                    
                }
                
            }
                
            else if authorId != 0{
                
              if eventId != 0 {
                
//                let authorEventsVC = AuthorEventsViewController(nibName: "AuthorEventsViewController", bundle: nil)
//
//                authorEventsVC.authorID = self.notificationsArray[indexPath.row].authorId!
//
//
//                self.navigationController?.pushViewController(authorEventsVC, animated: true)
                
                let authorEventsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthorDetailsViewController") as! AuthorDetailsViewController
                
                     authorEventsVC.isFromNotification = true
                     authorEventsVC.pageName = "Events"
                     authorEventsVC.authorID = self.notificationsArray[indexPath.row].authorId!
                
                
                self.navigationController?.pushViewController(authorEventsVC, animated: true)
                
                }
                
                
                
               else if postId != 0 {
                
//                let authorPostVC = AuthorPostsViewController(nibName: "AuthorPostsViewController", bundle: nil)
//                
//                self.navigationController?.pushViewController(authorPostVC, animated: true)
                
                let authorPostVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthorDetailsViewController") as! AuthorDetailsViewController
                     authorPostVC.isFromNotification = true
                     authorPostVC.pageName = "Posts"
                
                self.navigationController?.pushViewController(authorPostVC, animated: true)
                
                }
          
              //  AuthorDetailsViewController
            }
            
            
            
        }) { (failure) in
            
            
        }
        
    }
    
    

}
