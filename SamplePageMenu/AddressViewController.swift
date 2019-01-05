//
//  AddressViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 04/06/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class AddressViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var addressTableview: UITableView!
    
    @IBOutlet weak var addNewAddressLbl: UILabel!
    
    //MARK:- variable declaration
    var allitemsArray:[AddressInfoResultVO] = Array<AddressInfoResultVO>()
    var filtered:[AddressInfoResultVO] = []
    var editaddress:[EditAddressInfoResultVO] = []
     var showNav = false
     var userId :  Int = 0
     var Id :  Int = 0
     var isAddressClicked = false
     var selectedArry = Array<Int>()
    
   //MARK:- view Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()

        // Register Custom TableviewCell
        let nibName1  = UINib(nibName: "AddressTableViewCell" , bundle: nil)
        addressTableview.register(nibName1, forCellReuseIdentifier: "AddressTableViewCell")
        
        addressTableview.dataSource = self
        addressTableview.delegate = self
        
        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
        }
      // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- view Will Appear
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        addressAPICall()
        addNewAddressLbl.isHidden = true
        
       // Set navigationBar and NavigationTitle with Back Button
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Address".localize(), backTitle: " " , rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
    }
    

 //MARK:-    :::::::::::::::::::::::::::::::::::::::::  Tableview DataSource And Delegate Methods ::::::::::::::::::::::::::::::::::::::::://
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
        
        cell.rediationBtn.tag = indexPath.row
        
        cell.rediationBtn.addTarget(self, action: #selector(selectBtnClicked), for: .touchUpInside)
        
        if selectedArry[indexPath.row] == 1 {
            
            cell.rediationBtn.setImage( #imageLiteral(resourceName: "icons8-checked_filled-1"), for: .normal)
        }
        else{
           cell.rediationBtn.setImage( #imageLiteral(resourceName: "icons8-unchecked_circle"), for: .normal)
        }
        let listStr:AddressInfoResultVO = filtered[indexPath.row]
        
        cell.fullNameLbl.text = listStr.fullName
        
        if listStr.address1 != nil && listStr.address2 != nil {
            cell.addresslineLbl.text = listStr.address1! + ", " + listStr.address2!
        }
         if listStr.stateName != nil && listStr.countryName != nil {
            
            cell.statecountryLbl.text = listStr.stateName! + ", " + listStr.countryName!
        }
        if listStr.pinCode != nil {
            cell.pincodeLbl.text = "\(listStr.pinCode!)"
        }
        else{
            cell.pincodeLbl.text = ""
        }
        
        cell.mobileNoLbl.text = "\(listStr.mobileNumber!)"
        
       ///////  delete  ///////
        cell.deleteBtn.addTarget(self, action: #selector(self.deleteaddressAPICall(_:)), for: UIControlEvents.touchUpInside)
        cell.deleteBtn.tag = indexPath.row
        
        
        ///////  edit ///////
        let editTap = UITapGestureRecognizer(target: self, action: #selector(self.editaddressClicked))
        cell.editBtn.isUserInteractionEnabled = true
        cell.editBtn.addGestureRecognizer(editTap)
        cell.editBtn.tag = indexPath.row
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        for i in  0..<selectedArry.count{
            selectedArry[i] = 0
        }
        let currentValue = selectedArry[indexPath.row] == 0 ? 1 : 0
        selectedArry[indexPath.row] = currentValue
        addressTableview.reloadData()
        
    }
    
    func selectBtnClicked(_ sender: UIButton?) {

        for i in  0..<selectedArry.count{
            selectedArry[i] = 0
        }
            let currentValue = selectedArry[(sender?.tag)!] == 0 ? 1 : 0
            selectedArry[(sender?.tag)!] = currentValue
            addressTableview.reloadData()
        
    }
    
  
//MARK:- add New Address Action

    @IBAction func addNewAddressAction(_ sender: Any) {
        
        let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController
    
        self.navigationController?.pushViewController(jobIDViewController, animated: true)
     
    }
    
//MARK:- edit Address clicked
    
func  editaddressClicked( sender:UIGestureRecognizer){
        
      self.editaddressAPICall(filtered[(sender.view?.tag)!].id!)
        
        
    }

//MARK:- back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
        print("Back Button Clicked......")
        
    }
    
    
//MARK: - Home Button Tapped
    
    
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
    
//MARK:- address API Call
    
    func addressAPICall(){
        
        self.filtered.removeAll()
        
        let paramsDict = [ 	"userId": userId,
                           	"pageIndex": 1,
                           	"pageSize": 50,
                           	"sortbyColumnName": "UpdatedDate",
                           	"sortDirection": "desc",
                           	"searchName": ""
            
            ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: GETALLDELIVERYADDRESSAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            let respVO:AddressInfoVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            
            
            if isSuccess == true {
                if(respVO.listResult != nil){
                    
                    let listArr = respVO.listResult!
                    
                        self.addNewAddressLbl.isHidden = true
                    
                    for eachArray in listArr{
                        self.filtered.append(eachArray)
                        self.selectedArry.append(0)
                    }
                    
                    self.addressTableview.reloadData()
                }
                else{
                    self.addNewAddressLbl.isHidden = false
                }
            }
            else{
                
            }
            
        }) { (failureMessage) in
            
            print(failureMessage)
            
        }
    }
    
//MARK:-  delete address API Call
    
func deleteaddressAPICall(_ sender : UIButton){
        
    Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Are You Sure Want To Delete".localize(), clickAction: {
        
//MARK:- Here calling DeleteAddress API-Service
        self.deleteAddressForIndex(sender.tag)
        
    })
}

//MARK:- Here DeleteAddress API-Service
    func deleteAddressForIndex( _ selectedIndex : Int){
        if(filtered.count > selectedIndex){
            
            let deleteAddressInfo  = filtered[selectedIndex]
            let paramsDict = [
                "id": deleteAddressInfo.id!,
                "userId": userId,
                ] as [String : Any]
            
            let dictHeaders = ["":"","":""] as NSDictionary
            
            serviceController.postRequest(strURL: DELETEADDRESSAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
                
                print(result)
                let respVO:DeleteAddressInfoVO = Mapper().map(JSONObject: result)!
                let isSuccess = respVO.isSuccess
                print("StatusCode:\(String(describing: isSuccess))")
                if isSuccess == true {
                    let listArr = respVO.endUserMessage!
                    self.addressAPICall()
                    self.addressTableview.reloadData()
                    self.addNewAddressLbl.isHidden = false
                }
                else{
                }
            }) { (failureMessage) in
                print(failureMessage)
            }
        }
    }

//MARK:-  edit address API Call
func editaddressAPICall( _ id : Int){
    
    serviceController.getRequest(strURL: EDITADDRESSAPI + "\(id)" , success: { (result) in

    let respVO:EditAddressInfoVO = Mapper().map(JSONObject: result)!
                
    let isSuccess = respVO.isSuccess
        
        print("StatusCode:\(String(describing: isSuccess))")
                
        if isSuccess == true {
                    
            let listArr = respVO.listResult!
            
            let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController
            
            jobIDViewController.isFromEdit = true
            jobIDViewController.addressInfo = listArr
            self.navigationController?.pushViewController(jobIDViewController, animated: true)
                    
                  }
              }) { (failureMessage) in
                print(failureMessage)
        }
    }
}
