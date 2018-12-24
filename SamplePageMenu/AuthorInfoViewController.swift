 //
//  AuthorInfoViewController.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 13/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class AuthorInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var authorInfoTableView: UITableView!
    
    @IBOutlet weak var norecordsfoundLbl: UILabel!
    
    //MARK: -  variable declaration

    
    var delegate: authorChangeSubtitleOfIndexDelegate?
    var authorDetailsArray  : [AuthorDetailsListResultVO] = Array<AuthorDetailsListResultVO>()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var userId :  Int = 0
    var uid : Int = 0
    var authorID : Int = 0
    var isSubscribed = 0
    var subscribeClick = 0
    var subscribe : Bool = true
    var loginVC = LoginViewController()
    
    //MARK: -   View DidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
        self.norecordsfoundLbl.isHidden = false

        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            
            self.userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
            
        }

        
        print(isSubscribed)
        
        self.authorInfoTableView.delegate = self
        self.authorInfoTableView.dataSource = self
        
        let nibName1  = UINib(nibName: "HeadImgTableViewCell" , bundle: nil)
        authorInfoTableView.register(nibName1, forCellReuseIdentifier: "HeadImgTableViewCell")
        let nibName2  = UINib(nibName: "InformationTableViewCell" , bundle: nil)
        authorInfoTableView.register(nibName2, forCellReuseIdentifier: "InformationTableViewCell")
        let nibName3  = UINib(nibName: "InfoMapTableViewCell" , bundle: nil)
        authorInfoTableView.register(nibName3, forCellReuseIdentifier: "InfoMapTableViewCell")
        let nibName4  = UINib(nibName: "AboutInfoTableViewCell" , bundle: nil)
        authorInfoTableView.register(nibName4, forCellReuseIdentifier: "AboutInfoTableViewCell")
        
        let nibName5  = UINib(nibName: "InfoHeaderCell" , bundle: nil)
        authorInfoTableView.register(nibName5, forCellReuseIdentifier: "InfoHeaderCell")
        
        authorInfoTableView.isHidden = true
        
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        self.loginVC = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as!LoginViewController
        
        self.loginVC.showNav = true
        self.loginVC.navigationString = "authorInfoString"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -   View WillAppear

    
    override func viewWillAppear(_ animated: Bool) {
        
      self.getAuthorDetailsAPICall()
        
        self.norecordsfoundLbl.isHidden = true
    }
    
//MARK: -   Get Author Details API Call

    func getAuthorDetailsAPICall(){
        
        
        let authorDetailsAPI = AUTHORDETAILS + String(authorID) + "/" + String(userId)
        
        serviceController.getRequest(strURL: authorDetailsAPI, success: { (result) in
            
            if result.count > 0 {
                
                print(result)
                
                let respVO:AuthorDetailsVO = Mapper().map(JSONObject: result)!
                
                let isSuccess = respVO.isSuccess
                
                if isSuccess == true {
                    
            let  listResult = respVO.listResult!
                    
            if listResult.count > 0 {
                        
                self.norecordsfoundLbl.isHidden = true
                self.authorInfoTableView.isHidden = false
                self.authorDetailsArray = respVO.listResult!
                        
                self.isSubscribed = self.authorDetailsArray[0].isSubscribed!
                self.authorInfoTableView.reloadData()
                    }
            else {
                        
            self.norecordsfoundLbl.isHidden = false
            self.authorInfoTableView.isHidden = true
                    }
                    
                }
                else {
                    
            self.norecordsfoundLbl.isHidden = false
            self.authorInfoTableView.isHidden = true
                }
                
            }
            
            else{
            
            }
            
            
     }) { (failureMassege) in
            
        
        }
        
        
    }
    
//MARK: -   TableView Delegate & DataSource Methods

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
        }
        
        else if section == 1 {
            
            
            return 12
            
            
            
        }else if section == 2 {
            
            return 8
            
        }
      
        return 1
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0 {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
                
                return 300
            }
            else {
                
                return 124
            }
            
        }else if indexPath.section == 1{
            
            return UITableViewAutomaticDimension
        }
            
        else if indexPath.section == 2{
            
            return UITableViewAutomaticDimension
            
        }
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(authorDetailsArray.count > 0){
            let authorDetails:AuthorDetailsListResultVO = authorDetailsArray[0]
            
            if (indexPath.section == 0) {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeadImgTableViewCell", for: indexPath) as! HeadImgTableViewCell
                
                
                var  churchImageLogoString = authorDetails.userImage == nil ? "authordetails.jpg" : authorDetails.userImage
                
                churchImageLogoString = churchImageLogoString?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
         
                if(authorDetailsArray.count >= indexPath.section){
                    
                    cell.churchNameLabel.text = authorDetails.authorName
                    
                    if let url = URL(string:churchImageLogoString!) {
                        
                        
                cell.churchImage.sd_setImage(with:url , placeholderImage: #imageLiteral(resourceName: "authordetails"))
                        
                        
                      }
                    else {
                        
                    cell.churchImage.image = #imageLiteral(resourceName: "authordetails")
                        }
                                    
                    
                    return cell
                    
                }
                
                
                return cell
                
            }
                
                
            else if (indexPath.section == 1){
                
                let cell2 = tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell", for: indexPath) as! InformationTableViewCell
                
                if indexPath.row == 0 {
                    
                    cell2.infoLabel.text = "Author Name".localize()
                    
                    cell2.addressLabel.text = authorDetails.authorName
                    
                    
                } else if indexPath.row == 1 {
                    
                    cell2.infoLabel.text = "User Name".localize()
                    
                    cell2.addressLabel.text =  authorDetails.userName
                    
                    
                } else if indexPath.row == 2 {
                    
                    cell2.infoLabel.text = "Contact Number".localize()
                    
                    cell2.addressLabel.text =  authorDetails.authorContactNumbar
                    
                    
                }else if indexPath.row == 3 {
                    
                    cell2.infoLabel.text = "Author Email".localize()
                    
                    cell2.addressLabel.text =  authorDetails.authorEmail
                    
                    
                }else if indexPath.row == 4 {
                    
                    cell2.infoLabel.text = "Date Of Birth".localize()
                    
                    if authorDetails.dob != nil {
                     let startAndEndDate1 =   returnEventDateWithoutTim1(selectedDateString: authorDetails.dob!)
                    
                    cell2.addressLabel.text = startAndEndDate1
                    
                    
                        }
                    else {
                    
                     cell2.addressLabel.text = ""
                    }
                    
                }
                
                else if indexPath.row == 5 {
                    
                    cell2.infoLabel.text = "Gender".localize()
                    
                    cell2.addressLabel.text = authorDetails.gender
                    
                }
                else if indexPath.row == 6 {
                    
                    cell2.infoLabel.text = "Village".localize()
                    
                    cell2.addressLabel.text = authorDetails.villageName
                    
                }
                else if indexPath.row == 7 {
                    
                    cell2.infoLabel.text = "Mandal".localize()
                    
                    cell2.addressLabel.text = authorDetails.mandalName
                    
                }
                else if indexPath.row == 8 {
                    
                    cell2.infoLabel.text = "District".localize()
                    
                    cell2.addressLabel.text = authorDetails.districtName
                    
                }
                else if indexPath.row == 9 {
                    
                    cell2.infoLabel.text = "State".localize()
                    
                    cell2.addressLabel.text = authorDetails.stateName
                    
                }
                else if indexPath.row == 10 {
                    
                    cell2.infoLabel.text = "Pin Code".localize()
                
                    cell2.addressLabel.text = "\(String(describing: authorDetails.pinCode!))"
                    
                }
                else if indexPath.row == 11 {
                    
                    cell2.infoLabel.text = "Country".localize()
                    
                    cell2.addressLabel.text = authorDetails.countryName
                    
                }
                return cell2
                
            }
                
                
            else if (indexPath.section == 2){
                
                let cell3 = tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell", for: indexPath) as! InformationTableViewCell
                
                if indexPath.row == 0 {
                    
                    cell3.infoLabel.text = "Church".localize()
                    
                    cell3.addressLabel.text = authorDetails.churchName
                    
                } else if indexPath.row == 1 {
                    
                    cell3.infoLabel.text = "Church Registration Number".localize()
                    
                    cell3.addressLabel.text =  authorDetails.registrationNumber
                    
                    
                } else if indexPath.row == 2 {
                    
                    cell3.infoLabel.text = "State".localize()
                    
                    cell3.addressLabel.text =  authorDetails.stateName
                    
                    
                }else if indexPath.row == 3 {
                    
                    cell3.infoLabel.text = "District".localize()
                    
                    
                    cell3.addressLabel.text = authorDetails.districtName
                    
                }else if indexPath.row == 4 {
                    
                    cell3.infoLabel.text = "Mandal".localize()
                    
                    
                    cell3.addressLabel.text = authorDetails.mandalName
                    
                }
                else if indexPath.row == 5 {
                    
                    cell3.infoLabel.text = "Village".localize()
                    
                    cell3.addressLabel.text = authorDetails.villageName
                    
                }
                else if indexPath.row == 6 {
                    
                    cell3.infoLabel.text = "Pin Code".localize()
                    
                    if authorDetails.pinCode != nil {
                        
                        cell3.addressLabel.text = String(describing: authorDetails.pinCode!)
                        
                    }
                    else {
                        
                         cell3.addressLabel.text = ""
                        
                    }
                    
                }
                else if indexPath.row == 7 {
                    
                    cell3.infoLabel.text = "Country".localize()
                    
                    
                    cell3.addressLabel.text = authorDetails.countryName
                    
                    }
                
                return cell3
                
                
            }
            
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "AboutInfoTableViewCell", for: indexPath) as! AboutInfoTableViewCell
            
            //    cell3.aboutLabel.text = descriptionString
            
            return cell3
            

        }
        return UITableViewCell()
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let infoHeaderCell = tableView.dequeueReusableCell(withIdentifier: "InfoHeaderCell") as! InfoHeaderCell
        
        if section == 1 {
            
            
            infoHeaderCell.subscribeBtn.isHidden = false
            infoHeaderCell.headerLabel.text = "Pastor Information".localize()
            
            if self.isSubscribed == 0{
                
                infoHeaderCell.subscribeBtn.setTitle("Subscribe".localize(),for: .normal)
            }
                
            else{
                
                infoHeaderCell.subscribeBtn.setTitle("Unsubscribe".localize(),for: .normal)
                
            }
            
            infoHeaderCell.subscribeBtn.addTarget(self, action: #selector(subscribeBtnClicked), for: .touchUpInside)
            
            
            return infoHeaderCell
            
        }else if section == 2 {
            
            
            infoHeaderCell.subscribeBtn.isHidden = true
            infoHeaderCell.headerLabel.text = "Church Details".localize()
            return infoHeaderCell
            
        }
        
      
        return nil
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return 0.0
        }
        
        return 44.0
        
    }
    
//MARK: -   Event Date Without Time

    
    func returnEventDateWithoutTim1(selectedDateString : String) -> String{
        var newDateStr = ""
        var newDateStr1 = ""
        
        if(selectedDateString != ""){
            let invDtArray = selectedDateString.components(separatedBy: "T")
            let dateString = invDtArray[0]
            let dateString1 = invDtArray[1]
            print(dateString1)
            let invDtArray2 = dateString1.components(separatedBy: ".")
            let dateString3 = invDtArray2[0]
            
            print(dateString1)
            
            if(dateString != "" || dateString != "."){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateFromString = dateFormatter.date(from: dateString)
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr = newDateString
                print(newDateStr)
            }
            if(dateString3 != "" || dateString != "."){
                
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateStyle = .medium
//                dateFormatter.dateFormat = "HH:mm:ss"
//                let dateFromString = dateFormatter.date(from: dateString3)
//                dateFormatter.dateFormat = "hh:mm aa"
//                let newDateString = dateFormatter.string(from: dateFromString!)
//                newDateStr1 = newDateString
//                print(newDateStr1)
            }
        }
        return newDateStr + " " + newDateStr1
    }
    
    
    //MARK: -   SubScribe Button Clicked

    func subscribeBtnClicked(sender: UIButton){
        
        if self.userId != 0 {
            
            let paramsDict = [ "isSubscribed": isSubscribed,
                               "userId": self.userId,
                               "churchId": "null",
                               "authorId": authorID
                ] as [String : Any]
            
            let dictHeaders = ["":"","":""] as NSDictionary
            
            print(CHURCHAUTHORSUBSCIPTIONAPI)
            
            serviceController.postRequest(strURL: CHURCHAUTHORSUBSCIPTIONAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
                
                print(result)
                
                let respVO:ChurchAuthorSubscriptionVO = Mapper().map(JSONObject: result)!
                
                
                let isSuccess = respVO.isSuccess
                print("StatusCode:\(String(describing: isSuccess))")
                
                if isSuccess == true {
                    
                    let successMsg = respVO.endUserMessage
                    self.isSubscribed = (respVO.result?.isSubscribed!)!
                    
                    self.authorInfoTableView.reloadData()
                    
                    self.appDelegate.window?.makeToast(successMsg!, duration:kToastDuration, position:CSToastPositionCenter)
                    
                }
                    
                else {
                    
                  let endUserMessage = respVO.endUserMessage
                  self.appDelegate.window?.makeToast(endUserMessage!, duration:kToastDuration, position:CSToastPositionCenter)
                }
                
            }) { (failureMessage) in
                
                
                print(failureMessage)
                
            }
            
            
        }
            
            
        else {
            
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login To Subscribe".localize(), clickAction: { 
                
                self.navigationController?.pushViewController(self.loginVC, animated: true)
                
            })
            
        }
        
    }
   
}
