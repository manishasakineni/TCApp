//
//  NotificationsViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 13/06/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class NotificationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CAPSPageMenuDelegate {
    
    @IBOutlet weak var notificationsTableView: UITableView!
   
//MARK: -  variable declaration
    
    var allitemsArray:[NotificationResultVO] = Array<NotificationResultVO>()
    var filtered:[NotificationResultVO] = []
    var userId :  Int = 0
    var showNav = false
    var appVersion          : String = ""
    var IDs : String = ""
    var pageMenu : CAPSPageMenu?
    var viewNotificationVC : ViewNotificationViewController?
    var readNotificationVC : ReadNotificationViewController?
    private var controllersArray: [UIViewController] = []
    
//MARK: -   view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
        // Registering Tableview Cell
        
        let nibName1  = UINib(nibName: "notificationsTableViewCell" , bundle: nil)
        notificationsTableView.register(nibName1, forCellReuseIdentifier: "notificationsTableViewCell")
        notificationsTableView.dataSource = self
        notificationsTableView.delegate = self

        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
        }
        
        // Calling Functions
       
        createPageMenu()
        notificationAPICall()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
//MARK: -   view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Notifications".localize(), backTitle: " ", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
           }
    
//Crearting Page Menu
    
    private func createPageMenu() {
        
        viewNotificationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewNotificationViewController") as? ViewNotificationViewController
        viewNotificationVC?.title = "Unread".localize()
        readNotificationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReadNotificationViewController") as? ReadNotificationViewController
        readNotificationVC?.title = "Read".localize()
        controllersArray.append(viewNotificationVC!)
        controllersArray.append(readNotificationVC!)
        
        let parameters : [CAPSPageMenuOption] = [CAPSPageMenuOption.scrollMenuBackgroundColor(UIColor.clear),
                                                 CAPSPageMenuOption.viewBackgroundColor(UIColor.clear),
                                                 CAPSPageMenuOption.bottomMenuHairlineColor(UIColor(red: 103.0/255.0, green: 171.0/255.0, blue: 208.0/255.0, alpha: 1.0)),
                                                 CAPSPageMenuOption.menuItemFont( UIFont(name: "HelveticaNeue", size: 11.0)!),
                                                 CAPSPageMenuOption.menuHeight(36),
                                                 CAPSPageMenuOption.centerMenuItems(true),
                                                 CAPSPageMenuOption.selectedMenuItemLabelColor(UIColor.black),
                                                 CAPSPageMenuOption.unselectedMenuItemLabelColor(UIColor.lightGray),
                                                 CAPSPageMenuOption.selectionIndicatorHeight(2.5),
                                                 CAPSPageMenuOption.menuItemMargin(0.0),
                                                 CAPSPageMenuOption.useMenuLikeSegmentedControl(true),
                                                 CAPSPageMenuOption.menuItemSeparatorWidth(0.0),
                                                 CAPSPageMenuOption.menuItemSeparatorColor(UIColor.white),
                                                 CAPSPageMenuOption.enableHorizontalBounce(false),
                                                 CAPSPageMenuOption.addBottomMenuHairline(true),
                                                 CAPSPageMenuOption.menuItemWidthBasedOnTitleTextWidth(false),CAPSPageMenuOption.hideSubTitle(false)]

        pageMenu = CAPSPageMenu(viewControllers: controllersArray,
                                frame: CGRect.init(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height),
                                pageMenuOptions: parameters)
        pageMenu?.delegate = self
        self.addChildViewController(pageMenu!)
        view.addSubview((pageMenu?.view)!)
        pageMenu?.didMove(toParentViewController: self)
    }
    

//MARK: -  UITable view delegate & data source methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filtered.count > 0 {
            return filtered.count
        }
        return allitemsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationsTableViewCell", for: indexPath) as! notificationsTableViewCell
        let listStr:NotificationResultVO = filtered[indexPath.row]
        cell.nameLbl.text = "\(listStr.name!)"
        cell.descriptionLbl.text = "\(listStr.desc!)"
        return cell
    }

   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if filtered.count > indexPath.row {
            let listStr:NotificationResultVO = filtered[indexPath.row]
            
            if(listStr.authorId != nil){
        
                if(listStr.eventId != nil){
                    let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "AuthorDetailsViewController") as! AuthorDetailsViewController
                        jobIDViewController.isFromNotification = true
                        jobIDViewController.pageName = "Events"
                        jobIDViewController.authorID = (listStr.authorId == nil) ? 0 : listStr.authorId!
                        self.navigationController?.pushViewController(jobIDViewController, animated: true)
                }
                    
                else if (listStr.postId != nil){
                    let holyBibleViewController = self.storyboard?.instantiateViewController(withIdentifier: "AuthorDetailsViewController") as! AuthorDetailsViewController
                        holyBibleViewController.isFromNotification = true
                        holyBibleViewController.pageName = "Posts"
                        holyBibleViewController.authorID = (listStr.authorId == nil) ? 0 : listStr.authorId!
                        self.navigationController?.pushViewController(holyBibleViewController, animated: true)
                }
                    
                else  if (listStr.jobId != nil) {
                    let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "GetJobByIDViewController") as! GetJobByIDViewController
                        jobIDViewController.churchId = (listStr.churchId == nil) ? 0 : listStr.churchId!
                        jobIDViewController.authorId = (listStr.authorId == nil) ? 0 : listStr.authorId!
                        jobIDViewController.eventId = (listStr.eventId == nil) ? 0 : listStr.eventId!
                        jobIDViewController.postId = (listStr.postId == nil) ? 0 : listStr.postId!
                        jobIDViewController.jobId = (listStr.jobId == nil) ? 0 : listStr.jobId!
                        self.navigationController?.pushViewController(jobIDViewController, animated: true)
                }
            }
            else{
            if(listStr.eventId != nil){
                let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChurchesInformaationViewControllers") as! ChurchesInformaationViewControllers
                jobIDViewController.isFromNotification = true
                jobIDViewController.isFromChruch = true
                jobIDViewController.pageName = "Events"
                jobIDViewController.churchID = (listStr.churchId == nil) ? 0 : listStr.churchId!
                self.navigationController?.pushViewController(jobIDViewController, animated: true)
            }
                
            else if (listStr.postId != nil){
                let holyBibleViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChurchesInformaationViewControllers") as! ChurchesInformaationViewControllers
                holyBibleViewController.isFromChruch = true
                holyBibleViewController.isFromNotification = true
                holyBibleViewController.pageName = "Posts"
                holyBibleViewController.churchID = (listStr.churchId == nil) ? 0 : listStr.churchId!
                self.navigationController?.pushViewController(holyBibleViewController, animated: true)
            }
                
            else  if(listStr.jobId != nil){
                let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "GetJobByIDViewController") as! GetJobByIDViewController
                jobIDViewController.churchId = (listStr.churchId == nil) ? 0 : listStr.churchId!
                jobIDViewController.authorId = (listStr.authorId == nil) ? 0 : listStr.authorId!
                jobIDViewController.eventId  = (listStr.eventId == nil) ? 0 : listStr.eventId!
                jobIDViewController.postId   = (listStr.postId == nil) ? 0 : listStr.postId!
                jobIDViewController.jobId    = (listStr.jobId == nil) ? 0 : listStr.jobId!
                self.navigationController?.pushViewController(jobIDViewController, animated: true)
            }
            }
        }
    }
  
    
//MARK: -  back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        self.navigationController?.popViewController(animated: true)
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        appDelegate.window?.rootViewController = rootController
        print("Back Button Clicked......")
    }
    
    
//MARK: -    Home Button Tapped
    
    @IBAction func homeButtonTapped(_ sender:UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        self.navigationController?.popViewController(animated: true)
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        appDelegate.window?.rootViewController = rootController
        print("Home Button Clicked......")
    }
    
//MARK: - notification API Call
    
    func notificationAPICall(){

        let paramsDict = [ "sortDirection": "desc",
                           "sortbyColumnName": "UpdatedDate",
                           "userId": userId,
                           "pageindex" : 1,
                           "pagesize" : 10  ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        serviceController.postRequest(strURL: NOTIFICATIONSAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            print(result)
            let respVO:NotificationInfoVO = Mapper().map(JSONObject: result)!
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            
            if isSuccess == true {
                
                if respVO.listResult != nil{
                    let listArr = respVO.listResult!
                    
                    for eachArray in listArr{
                        self.filtered.append(eachArray)
                    }
                    self.notificationsTableView.reloadData()
                }
            }
                
            else {
            }
            
        }) { (failureMessage) in
            print(failureMessage)
        }
    }  
}
