//
//  AdminDetailsViewController.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 13/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize
import IQKeyboardManagerSwift

protocol authorChangeSubtitleOfIndexDelegate {
    func nameOfItem(indexNumber: Int, countText : String)
}

class AuthorDetailsViewController: UIViewController,CAPSPageMenuDelegate,authorChangeSubtitleOfIndexDelegate {
    
//MARK: -  variable declaration
    
    var pageMenu : CAPSPageMenu?
    
    var authorInfoVC   : AuthorInfoViewController?
    var authorEventsVC : AuthorEventsViewController?
    var authorPostsVC  : AuthorPostsViewController?
    private var controllersArray: [UIViewController] = []
    var viewTitle = ""
    var catgoryName:String = ""
    var churchName = ""
    var isFromChruch = false
    var authorID : Int = 0
    var churchName1 : String = ""
    var appVersion  : String = ""
    var isSubscribed = Int()
    var isFromNotification = false
    var pageName = ""
    
//MARK: -   View DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        createPageMenu()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
//MARK: -   View WillAppear
  

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

   Utilities.authorDetailsViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr: self, titleView: nil, withText: churchName1, backTitle: " ", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
        
    
    }

    
//MARK: -    Create Page Menu

    private func createPageMenu() {

        authorInfoVC = AuthorInfoViewController(nibName: "AuthorInfoViewController", bundle: nil)
        authorInfoVC?.title = "Information".localize()
        authorInfoVC?.delegate  = self
        authorInfoVC?.authorID = authorID
        authorInfoVC?.isSubscribed = isSubscribed
        
        authorEventsVC = AuthorEventsViewController(nibName: "AuthorEventsViewController", bundle: nil)
        authorEventsVC?.title = "Events".localize()
        authorEventsVC?.authorID = authorID
        authorEventsVC?.delegate  = self
        
        authorPostsVC = AuthorPostsViewController(nibName: "AuthorPostsViewController", bundle: nil)
        authorPostsVC?.title = "Posts".localize()
        authorPostsVC?.authorID = authorID
        authorPostsVC?.isFromChruch = isFromChruch
        //authorPostsVC?.delegate  = self
        
        controllersArray.append(authorInfoVC!)
        controllersArray.append(authorEventsVC!)
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
        if(isFromNotification == true){
            if(pageName == "Posts"){
                pageMenu?.moveToPage(2)
            }else if(pageName == "Events"){
                pageMenu?.moveToPage(1)
            }
  
        }
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
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.synchronize()
        
        
        self.navigationController?.popViewController(animated: true)
        

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
    
    

    
    
}
