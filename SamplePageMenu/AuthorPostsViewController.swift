//
//  AuthorPostsViewController.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 13/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

protocol AuthorPostsViewControllerDelegate {
    func nameOfItem(indexNumber: Int, countText : String)
}

class AuthorPostsViewController: UIViewController,CAPSPageMenuDelegate,AuthorPostsViewControllerDelegate {
    
    @IBOutlet weak var authorpostTableView: UITableView!
    @IBOutlet weak var norecordsfoundLbl: UILabel!
   
//MARK: -  variable declaration
    
    var mediaTypeID : Int = 0
    var PageIndex = 1
    var audioResults : Array<PostByAutorIdResultInfoVO> = Array()
    var imageResults : Array<PostByAutorIdResultInfoVO> = Array()
    var videoResults : Array<PostByAutorIdResultInfoVO> = Array()
    var documentResults : Array<PostByAutorIdResultInfoVO> = Array()
    var authorID : Int = 0
    var churchID : Int = 0
    var eventID = Int()
    var loginVC = LoginViewController()
    var eventChurchName = ""
    var eventName = ""
    var catgoryID:Int = 0
    var churchName1 : String = ""
    var navigationStr = String()
    var isFromChruch = false
    var pageMenu : CAPSPageMenu?
    var eventImageArrayString = ""
    var audioEventDetailsVC : authorAudioaViewController?
    var vedioDetailsVC : authorVedioViewController?
    var imagesEventDetailsVC : authorImagesViewController?
    var documentEventDetailsVC : authorDocumentsViewController?
    private var controllersArray: [UIViewController] = []
    var authorName : String = ""
    var nameStr          : String = ""
    var audioArray = Array<Any>()
    

//MARK: -   view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        if(isFromChruch == false){
            
             churchAPIService()
        }else{
            
             authorAPIService()
        }
    }
    
    
//MARK: - create Page Menu
    
    private func createPageMenu() {
        
        //Registering Cells
        
        audioEventDetailsVC = authorAudioaViewController(nibName: "authorAudioaViewController", bundle: nil)
        audioEventDetailsVC?.title = "Audio".localize()
        audioEventDetailsVC?.audioResults = self.audioResults
        vedioDetailsVC = authorVedioViewController(nibName: "authorVedioViewController", bundle: nil)
        vedioDetailsVC?.title = "Video".localize()
        vedioDetailsVC?.videoResults = self.videoResults
        imagesEventDetailsVC = authorImagesViewController(nibName: "authorImagesViewController", bundle: nil)
        imagesEventDetailsVC?.title = "Images".localize()
        imagesEventDetailsVC?.imageResults = self.imageResults
        documentEventDetailsVC = authorDocumentsViewController(nibName: "authorDocumentsViewController", bundle: nil)
        documentEventDetailsVC?.title = "Document".localize()
        documentEventDetailsVC?.documentResults = self.documentResults
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
    
    
//MARK: -   author API Service

   func authorAPIService(){
    
        let params = ["pageIndex": PageIndex,
                      "pageSize": 100,
                      "sortbyColumnName": "UpdatedDate",
                      "sortDirection": "desc",
                      "authorId": authorID,
                      "mediaTypeId": ""
            ] as [String : Any]
    
    print("dic params \(params)")
    let dictHeaders = ["":"","":""] as NSDictionary
    
    serviceController.postRequest(strURL: GETPOSTBYAUTHORIDAPI as NSString, postParams: params as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
        
        print("\(result)")
        let respVO:PostByAutorIdVO = Mapper().map(JSONObject: result)!
        print("responseString = \(respVO)")
        let isSuccess = respVO.isSuccess
        
        if isSuccess == true{
                 for listResult in respVO.listResult!{
                    
                    if listResult.mediaType == "Audio"{
                        self.audioResults.append(listResult)
                    }
                    
                    if listResult.mediaType == "Image"{
                        self.imageResults.append(listResult)
                    }
            
                    if listResult.mediaType == "Video"{
                        self.videoResults.append(listResult)
                    }
            
                    if listResult.mediaType == "Document"{
                        self.documentResults.append(listResult)
                    }
                }
           self.createPageMenu()
            let statusCode = respVO.isSuccess
            print("StatusCode:\(String(describing: statusCode))")
        }
    }) { (failureMessage) in
    }
    }
    
//MARK: -   church API Service
   
    func churchAPIService(){
        
        let params = ["pageIndex": PageIndex,
                      "pageSize": 100,
                      "sortbyColumnName": "UpdatedDate",
                      "sortDirection": "desc",
                      "churchId": churchID,
                      "mediaTypeId": ""
           ] as [String : Any]
        
        print("dic params \(params)")
        let dictHeaders = ["":"","":""] as NSDictionary
        
        serviceController.postRequest(strURL: POSTBYCHURCHIDAPI as NSString, postParams: params as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print("\(result)")
            let respVO:PostByAutorIdVO = Mapper().map(JSONObject: result)!
            print("responseString = \(respVO)")
            let isSuccess = respVO.isSuccess
            
            if isSuccess == true{
                
                for listResult in respVO.listResult!{
                    
                    if listResult.mediaType == "Audio"{
                        self.audioResults.append(listResult)
                    }
                    
                    if listResult.mediaType == "Image"{
                        self.imageResults.append(listResult)
                    }
                    
                    if listResult.mediaType == "Video"{
                        self.videoResults.append(listResult)
                    }
                    
                    if listResult.mediaType == "Document"{
                        self.documentResults.append(listResult)
                    }
                  }
                self.createPageMenu()
                let statusCode = respVO.isSuccess
                print("StatusCode:\(String(describing: statusCode))")
            }
        }) { (failureMessage) in
        }
    }    
}
