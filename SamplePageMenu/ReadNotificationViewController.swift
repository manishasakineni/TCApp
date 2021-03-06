//
//  ReadNotificationViewController.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 09/11/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ReadNotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var ReadNotificationsTableView: UITableView!
    @IBOutlet weak var noRecordsLbl: UILabel!
    
//MARK: - Variable Declaration

    var userId :  Int = 0
    var notificationNamesArray = NSMutableArray()   /// Objective C Array
    var notificationDescriptionArray = Array<String>()   /// Swift array
    var notificationsArray = [getNotificationVO]()
    
    
//MARK: - View Did Load

    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        let nibName  = UINib(nibName: "NotificationTableViewCell" , bundle: nil)
        ReadNotificationsTableView.register(nibName, forCellReuseIdentifier: "NotificationTableViewCell")
        ReadNotificationsTableView.delegate = self
        ReadNotificationsTableView.dataSource = self
        
        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
        }
    }
    
//MARK: - View Will Appear

    override func viewWillAppear(_ animated: Bool) {
        
        getNotificationCount()
        self.noRecordsLbl.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - Notification Count API
    
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
                    self.ReadNotificationsTableView.isHidden = false
                    self.noRecordsLbl.isHidden = true
                    
                    if ((respVO.result?.notificationsList) != nil )  {
                        self.notificationsArray = (respVO.result?.notificationsList)!
                    
                        if self.notificationsArray.count > 0 {
                            for i in 0..<((respVO.result?.notificationsList)!)!.count {
                        
                                if let notificationdetails = respVO.result?.notificationsList![i] {
                            
                                    if notificationdetails.isRead == true {
                                            self.notificationNamesArray.add(notificationdetails.name!)
                                            self.notificationDescriptionArray.append(notificationdetails.desc!)
                                    }
                                }
                            }
                            self.ReadNotificationsTableView.reloadData()
                        }
                        else{
                            self.ReadNotificationsTableView.isHidden = true
                            self.noRecordsLbl.isHidden = false
                        }
                    
                    }
                
                else{
                    self.ReadNotificationsTableView.isHidden = true
                    self.noRecordsLbl.isHidden = false
                }
            }
            
        }) { (failure) in
            self.ReadNotificationsTableView.isHidden = true
            self.noRecordsLbl.isHidden = false
        }
    }
    
    
// MARK: - UITableview delegate methods
    
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
                    let eventViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChurchesInformaationViewControllers") as! ChurchesInformaationViewControllers
                            eventViewController.isFromNotification = true
                            eventViewController.pageName = "Events"
                            eventViewController.isFromChruch = false
                            eventViewController.churchID = self.notificationsArray[indexPath.row].churchId!
                            self.navigationController?.pushViewController(eventViewController, animated: true)
                }
                else if postId != 0 {
                    let authorPostVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChurchesInformaationViewControllers") as! ChurchesInformaationViewControllers
                    authorPostVC.isFromNotification = true
                    authorPostVC.pageName = "Posts"
                    authorPostVC.isFromChruch = false
                     authorPostVC.churchID = self.notificationsArray[indexPath.row].churchId!
                    self.navigationController?.pushViewController(authorPostVC, animated: true)
                }
            }
            else if authorId != 0{
              if eventId != 0 {
                let authorEventsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthorDetailsViewController") as! AuthorDetailsViewController
                     authorEventsVC.isFromNotification = true
                     authorEventsVC.pageName = "Events"
                     authorEventsVC.isFromChruch = true
                     authorEventsVC.authorID = self.notificationsArray[indexPath.row].authorId!
                    self.navigationController?.pushViewController(authorEventsVC, animated: true)
                }
               else if postId != 0 {
                let authorPostVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthorDetailsViewController") as! AuthorDetailsViewController
                     authorPostVC.isFromNotification = true
                     authorPostVC.pageName = "Posts"
                     authorPostVC.isFromChruch = true
                     authorPostVC.authorID = self.notificationsArray[indexPath.row].authorId!
                    self.navigationController?.pushViewController(authorPostVC, animated: true)
                }
            }
            else {
                let nullNotificationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NullNotificationViewController") as! NullNotificationViewController
                    nullNotificationVC.titleString = self.notificationsArray[indexPath.row].name!
                    nullNotificationVC.descriptionString = self.notificationsArray[indexPath.row].desc!
                        if self.notificationsArray[indexPath.row].createdDate != nil {
                            nullNotificationVC.generatedOn =  self.returnEventDateWithoutTim1(selectedDateString: self.notificationsArray[indexPath.row].createdDate!)
                        }
                    nullNotificationVC.generatedBy = self.notificationsArray[indexPath.row].createdBy!
                
                    self.addChildViewController(nullNotificationVC)
                    nullNotificationVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                    self.view.addSubview(nullNotificationVC.view)
                    nullNotificationVC.didMove(toParentViewController: self)
            }
        }) { (failure) in
        }
    }
    
// MARK :- Convert DateString Format
    
    func returnEventDateWithoutTim1(selectedDateString : String) -> String{
        
        var newDateStr = ""
        var newDateStr1 = ""
            if(selectedDateString != ""){
                let invDtArray = selectedDateString.components(separatedBy: "T")
                let dateString = invDtArray[0]
                let dateString1 = invDtArray[1]
                print(dateString1)
                let invDtArray2 = dateString1.components(separatedBy: ".")
                var dateString3 = invDtArray2[0]
                print(dateString1)
                
                if(dateString != "" || dateString != "."){
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let dateFromString = dateFormatter.date(from: dateString)
                    dateFormatter.dateFormat = "dd-MM-YYYY"
                    let newDateString = dateFormatter.string(from: dateFromString!)
                    newDateStr = newDateString
                    print(newDateStr)
                }
                
            if(dateString3 != "" || dateString != "."){
                dateString3 = dateString3.components(separatedBy: "-")[0]
                dateString3 = dateString3.components(separatedBy: "+")[0]
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
        return newDateStr + " , " + newDateStr1
    }
}
