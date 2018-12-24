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
    
    var churchImageArrayString = ""

    var appVersion          : String = ""

    var pageMenu : CAPSPageMenu?

    var allOffersVC : InfoChurchViewControllers?
    var eventInfoVC : EventViewController?
    var detAndBillsVC : DetAndBillsViewController?
    private var controllersArray: [UIViewController] = []
    
    var pasterUserId          : Int = 0

    var churchID:Int = 0
    
    var nameStr          : String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
    print("churchID:\(churchID)")
        
       createPageMenu()
        
        
        
       
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: nameStr.localize(), backTitle: nameStr.localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        
        
    }
    

//    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
//        
//        //   navigationItem.leftBarButtonItems = []
//        //   let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
////        
//        print("Back Button Clicked......")
//        
//    }

    
    private func createPageMenu() {
        
        
        allOffersVC = InfoChurchViewControllers(nibName: "InfoChurchViewControllers", bundle: nil)
        allOffersVC?.title = "Information".localize()
        allOffersVC?.delegate  = self
        allOffersVC?.churchID = churchID
        allOffersVC?.churchName = nameStr

        
//        eventInfoVC = EventInfoViewController(nibName: "EventViewController",
//                                              bundle: nil)
        
        eventInfoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
        eventInfoVC?.title = "Events".localize()
        eventInfoVC?.delegate  = self
        eventInfoVC?.pasterUserId = pasterUserId
        eventInfoVC?.churchID = churchID
        eventInfoVC?.churcgname = nameStr


        detAndBillsVC = DetAndBillsViewController(nibName: "DetAndBillsViewController",
                                                  bundle: nil)
        detAndBillsVC?.title = "Posts".localize()
        detAndBillsVC?.delegate  = self
        
         controllersArray.append(allOffersVC!)
         controllersArray.append(eventInfoVC!)
         controllersArray.append(detAndBillsVC!)
        
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
    
    
    func nameOfItem(indexNumber: Int, countText :String ){
        let menuItem = pageMenu?.menuItems[indexNumber]
        menuItem?.subtitleLabel?.text = "  " + countText + "  "
        menuItem?.subtitleLabel?.textAlignment = .left
        menuItem?.subtitleLabel?.sizeToFit()
        menuItem?.subtitleLabel?.center = CGPoint(x: (menuItem?.bounds.midX)!, y: (menuItem?.bounds.midY)! + 8)
        
    }
    

    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
//        UserDefaults.standard.removeObject(forKey: "1")
//        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
//        UserDefaults.standard.synchronize()
//        
        
        
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
      //  self.navigationController?.popViewController(animated: true)
        

        
           let churchDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChurchDetailsViewController") as! ChurchDetailsViewController
        
        //
        //        UserDefaults.standard.set("1", forKey: "1")
        //        UserDefaults.standard.synchronize()
        //
                self.navigationController?.popViewController(animated: true)
        //
        //
        print("Back Button Clicked......")
        
    }

    
    
    
    
    
}
