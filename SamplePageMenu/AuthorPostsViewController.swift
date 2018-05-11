//
//  AuthorPostsViewController.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 13/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

protocol AuthorPostsViewControllerDelegate {
    func nameOfItem(indexNumber: Int, countText : String)
}


class AuthorPostsViewController: UIViewController,CAPSPageMenuDelegate,AuthorPostsViewControllerDelegate {
    
    @IBOutlet weak var authorpostTableView: UITableView!
    
    
     var mediaTypeID : Int = 0
    var PageIndex = 1

    
    var eventID = Int()
    
    var loginVC = LoginViewController()
    
    var eventChurchName = ""
    
    var eventName = ""
    
    var catgoryID:Int = 0
    var churchName1 : String = ""
    var navigationStr = String()
    
    
    var pageMenu : CAPSPageMenu?
    
    
    var eventImageArrayString = ""
    
    var audioEventDetailsVC : authorAudioaViewController?
    var vedioDetailsVC : authorVedioViewController?
    var imagesEventDetailsVC : authorImagesViewController?
    var documentEventDetailsVC : authorDocumentsViewController?

    
    
    private var controllersArray: [UIViewController] = []
    var authorName : String = ""
    var nameStr          : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPageMenu()
        
   //     authorAPIService()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    //MARK: - create Page Menu
    
    private func createPageMenu() {
        
        audioEventDetailsVC = authorAudioaViewController(nibName: "authorAudioaViewController", bundle: nil)
        audioEventDetailsVC?.title = "Audio"
        

        
        vedioDetailsVC = authorVedioViewController(nibName: "authorVedioViewController", bundle: nil)
        vedioDetailsVC?.title = "Video"
        
        
        
        imagesEventDetailsVC = authorImagesViewController(nibName: "authorImagesViewController", bundle: nil)
        imagesEventDetailsVC?.title = "Image"
        
        
        
        
        documentEventDetailsVC = authorDocumentsViewController(nibName: "authorDocumentsViewController", bundle: nil)
        documentEventDetailsVC?.title = "Document"
        
        controllersArray.append(audioEventDetailsVC!)
        controllersArray.append(vedioDetailsVC!)
        controllersArray.append(imagesEventDetailsVC!)
        controllersArray.append(documentEventDetailsVC!)
  
      
        
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
                                frame: CGRect.init(x: 0.0, y: 0.0, width: super.view.frame.size.width, height: super.view.frame.size.height),
                                pageMenuOptions: parameters)
        
        pageMenu?.delegate = self
        self.addChildViewController(pageMenu!)
        
        super.view.addSubview((pageMenu?.view)!)
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
        
        
        print("Back Button Clicked......")
        
    }
    
//MARK: -    Home Left Button Tapped
    
    @IBAction func homeButtonTapped(_ sender:UIButton) {
        
        

//        
    }
    

    
   func authorAPIService(){
    
        
        
    
        let params = ["pageIndex": PageIndex,
                      "pageSize": 100,
                      "sortbyColumnName": "UpdatedDate",
                      "sortDirection": "desc",
                      "authorId": 2,
                      "mediaTypeId": ""
            
            
            ] as [String : Any]
    
    print("dic params \(params)")
    
    let dictHeaders = ["":"","":""] as NSDictionary
    
    
    serviceController.postRequest(strURL: GETPOSTBYAUTHORIDAPI as NSString, postParams: params as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
        
        
        print("\(result)")
        
        let respVO:PostByAutorIdVO = Mapper().map(JSONObject: result)!
        
        print("responseString = \(respVO)")
        
        
        let statusCode = respVO.isSuccess
        
        print("StatusCode:\(String(describing: statusCode))")
        
        
        
        
    }) { (failureMessage) in
        
        
        
    }
    }
    
    
    
}









