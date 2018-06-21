//
//  ChurchesInformaationViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 20/02/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize

protocol churchChangeSubtitleOfIndexDelegate {
    func nameOfItem(indexNumber: Int, countText : String)
}

class ChurchesInformaationViewControllers: UIViewController,CAPSPageMenuDelegate,churchChangeSubtitleOfIndexDelegate {
    
//MARK: -  variable declaration
    
    var churchImageArrayString = ""

    var appVersion          : String = ""

    var pageMenu : CAPSPageMenu?

    var allOffersVC : InfoChurchViewControllers?
    var eventInfoVC : EventViewController?
    var authorPostsVC  : AuthorPostsViewController?
    
    private var controllersArray: [UIViewController] = []
    
    var pasterUserId          : Int = 0

    var churchID:Int = 0
    
    var nameStr          : String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
    print("churchID:\(churchID)")
        
       createPageMenu()
        
        
        
       
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: nameStr.localize(), backTitle: nameStr.localize(), rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   //MARK: -  view Will Appear

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        
        
    }
   //MARK: - create Page Menu
    
    private func createPageMenu() {
        
        
        allOffersVC = InfoChurchViewControllers(nibName: "InfoChurchViewControllers", bundle: nil)
        allOffersVC?.title = "Information".localize()
        allOffersVC?.delegate  = self
        allOffersVC?.churchID = churchID
        allOffersVC?.churchName = nameStr

    
        eventInfoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventViewController") as? EventViewController
        eventInfoVC?.title = "Events".localize()
        eventInfoVC?.delegate  = self
        eventInfoVC?.pasterUserId = pasterUserId
        eventInfoVC?.churchID = churchID
        eventInfoVC?.churcgname = nameStr


        
        authorPostsVC = AuthorPostsViewController(nibName: "AuthorPostsViewController", bundle: nil)
        authorPostsVC?.title = "Posts".localize()

        
         controllersArray.append(allOffersVC!)
         controllersArray.append(eventInfoVC!)
        controllersArray.append(authorPostsVC!)

        
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
    
//MARK: -    Back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        
        
        UserDefaults.standard.removeObject(forKey: "1")
                
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        

        
    let churchDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChurchDetailsViewController") as! ChurchDetailsViewController
        
        self.navigationController?.popViewController(animated: true)
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

    
    
    
    
}
