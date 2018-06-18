//
//  EventDetailsAndEventPostDetailsViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 5/8/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit


protocol eventDetailsSubtitleOfIndexDelegate {
    func nameOfItem(indexNumber: Int, countText : String)
}


class EventDetailsAndEventPostDetailsViewController: UIViewController,CAPSPageMenuDelegate,eventDetailsSubtitleOfIndexDelegate {

    
    var eventID = Int()
    
    var loginVC = LoginViewController()
    
    var eventChurchName = ""
    
    var eventName = ""
    
    var catgoryID:Int = 0
    var churchName1 : String = ""
    var navigationStr = String()

    
    var pageMenu : CAPSPageMenu?

    
    var eventImageArrayString = ""

    var EventDetailsVC : EventDetailsViewController?
    var PostEventDetailsVC : PostEventDetailsViewController?
    private var controllersArray: [UIViewController] = []
    var authorName : String = ""
    var nameStr          : String = ""


    override func viewDidLoad() {
        super.viewDidLoad()

        createPageMenu()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: -   View WillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.eventDetailsAndEventPostDetailsViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: eventName, backTitle: eventName, rightImage: "home icon", secondRightImage: "Up", thirdRightImage: "Up")

        
    }
    
    
    
    
    //MARK: - create Page Menu
    
    private func createPageMenu() {
        
        
      
//        eventDetailsViewController.eventID = listStr.id!
//        eventDetailsViewController.eventChurchName = listStr.churchName!
//        eventDetailsViewController.eventName = listStr.title!
//        
//        eventDetailsViewController.catgoryID = listStr.churchId!
//        eventDetailsViewController.navigationStr = "navigationStr"
        
        
        EventDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventDetailsViewController") as? EventDetailsViewController
        EventDetailsVC?.title = "ChurchEventDetails".localize()
        EventDetailsVC?.delegate  = self
        EventDetailsVC?.eventID = eventID
        EventDetailsVC?.eventChurchName = eventChurchName
        EventDetailsVC?.eventName = eventName
        EventDetailsVC?.catgoryID = catgoryID
        EventDetailsVC?.navigationStr = navigationStr

        
        
        PostEventDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostEventDetailsViewController") as? PostEventDetailsViewController
        PostEventDetailsVC?.title = "Posts".localize()
        PostEventDetailsVC?.delegate  = self
        PostEventDetailsVC?.eventID = eventID
        PostEventDetailsVC?.catgoryImg = eventImageArrayString
        controllersArray.append(EventDetailsVC!)
        controllersArray.append(PostEventDetailsVC!)
        
        let parameters : [CAPSPageMenuOption] = [CAPSPageMenuOption.scrollMenuBackgroundColor(UIColor.clear),
                                                 CAPSPageMenuOption.viewBackgroundColor(UIColor.clear),
                                                 CAPSPageMenuOption.bottomMenuHairlineColor(UIColor(red: 103.0/255.0, green: 171.0/255.0, blue: 208.0/255.0, alpha: 1.0)),
                                                 CAPSPageMenuOption.menuItemFont( UIFont(name: "HelveticaNeue", size: 13.0)!),
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
    
    func nameOfItem(indexNumber: Int, countText :String ){
        let menuItem = pageMenu?.menuItems[indexNumber]
        menuItem?.subtitleLabel?.text = "  " + countText + "  "
        menuItem?.subtitleLabel?.textAlignment = .left
        menuItem?.subtitleLabel?.sizeToFit()
        menuItem?.subtitleLabel?.center = CGPoint(x: (menuItem?.bounds.midX)!, y: (menuItem?.bounds.midY)! + 8)
        
    }
    
    
    
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        UserDefaults.standard.removeObject(forKey: "1")
        
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        self.navigationController?.popViewController(animated: true)

        
//        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
//        
//        appDelegate.window?.rootViewController = rootController
        print("Back Button Clicked......")
        
    }
    
    //MARK: -    Home Left Button Tapped
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
