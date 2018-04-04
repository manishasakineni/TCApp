//
//  AllEventsAndUpComingEventsViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize


protocol eventinfoSubtitleOfIndexDelegate {
    func nameOfItem(indexNumber: Int, countText : String)
}


class AllEventsAndUpComingEventsViewController: UIViewController,CAPSPageMenuDelegate,eventinfoSubtitleOfIndexDelegate {

    
    var churchImageArrayString = ""
    
    var appVersion          : String = ""
    var showNav = false

    var pageMenu : CAPSPageMenu?
    
    var upConingEventInfoVC : UpConingEventInfoViewController?
    var allEventsVC : AllEventsViewController?
    private var controllersArray: [UIViewController] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        createPageMenu()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        Utilities.UpComingAndEventViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: "  Events".localize(), rightImage: "home icon", secondRightImage: "Up", thirdRightImage: "Up")

      
        
        
    }
    private func createPageMenu() {
        
    
        
        upConingEventInfoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpConingEventInfoViewController") as! UpConingEventInfoViewController
        upConingEventInfoVC?.title = "UpComing Events".localize()
        upConingEventInfoVC?.delegate  = self
    
        
        
        allEventsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllEventsViewController") as! AllEventsViewController
        
//        allEventsVC = AllEventsViewController(nibName: "AllEventsViewController",
//                                                  bundle: nil)
        allEventsVC?.title = "ALL EVENTS".localize()
        allEventsVC?.delegate  = self
        
        controllersArray.append(upConingEventInfoVC!)
        controllersArray.append(allEventsVC!)
        
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
        
        
        //   // revealViewController().addChildViewController(pageMenu!)
        //     //   pageMenu?.delegate = self
        //  //  self.view.addSubview((pageMenu?.view)!)
        //        pageMenu = CAPSPageMenu(viewControllers: controllersArray, frame: CGRect(x:0.0, y:64.0, width:self.view.frame.width, height:self.view.frame.height), pageMenuOptions: parameters)
        //
        //        // Lastly add page menu as subview of base view controller view
        //        // or use pageMenu controller in you view hierachy as desired
        //        self.view.addSubview(pageMenu!.view)
        //    //pageMenu?.didMove(toParentViewController: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        

        
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        print("Back Button Clicked......")
        
    }
    
    
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
