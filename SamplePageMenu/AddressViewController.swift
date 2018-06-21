//
//  AddressViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 04/06/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var addressTableview: UITableView!
    
    var allitemsArray:[AddressInfoResultVO] = Array<AddressInfoResultVO>()
    
    var filtered:[AddressInfoResultVO] = []

    var editaddress:[EditAddressInfoResultVO] = []
    
     var showNav = false
     var userId :  Int = 0
     var Id :  Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName1  = UINib(nibName: "AddressTableViewCell" , bundle: nil)
        addressTableview.register(nibName1, forCellReuseIdentifier: "AddressTableViewCell")
        
        addressTableview.dataSource = self
        addressTableview.delegate = self
        
        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            
            userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
            
        }
        
       // addressAPICall()
        
        
        

        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        addressAPICall()
        
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Address".localize(), backTitle: " " , rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
        
        
    }

    
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
        
        
        let listStr:AddressInfoResultVO = filtered[indexPath.row]
        
        cell.fullNameLbl.text = listStr.fullName
        
        cell.addresslineLbl.text = listStr.addressLine1! + ", " + listStr.addressLine2!
        cell.statecountryLbl.text = listStr.stateName! + ", " + listStr.countryName!
     
        
        
        cell.pincodeLbl.text = "\(listStr.pinCode!)"
        cell.mobileNoLbl.text = "\(listStr.mobileNumber!)"
        
       ///////  delete  ///////
        

        
        cell.deleteBtn.addTarget(self, action: #selector(self.deleteaddressAPICall(_:)), for: UIControlEvents.touchUpInside)
        cell.deleteBtn.tag = indexPath.row
        
        
        ///////  edit ////
        
    
        let editTap = UITapGestureRecognizer(target: self, action: #selector(self.editaddressClicked))
        
        cell.editBtn.isUserInteractionEnabled = true
        cell.editBtn.addGestureRecognizer(editTap)
        cell.editBtn.tag = indexPath.row
        
        
        return cell
        
        
        
    }
    

    @IBAction func addNewAddressAction(_ sender: Any) {
        

        
        let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController
        
        
        self.navigationController?.pushViewController(jobIDViewController, animated: true)

        
    }
    
    
func  editaddressClicked( sender:UIGestureRecognizer){
        
      self.editaddressAPICall(filtered[(sender.view?.tag)!].id!)
        
        
    }

    
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
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
                    
                    for eachArray in listArr{
                        
                        self.filtered.append(eachArray)
                        
                    }
                    
                    self.addressTableview.reloadData()
                    
                }else{
                    
                }
               
                
            }
                
            else {
                
                
                
            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
    }
    
   
    
func deleteaddressAPICall(_ sender : UIButton){
        
  
    
    
    Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Are You Sure Want To Delete".localize(), clickAction: {
        
        self.deleteAddressForIndex(sender.tag)
        
        
        
        
    })

    }
    
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
                    
                }
                    
                else {
                    
                    
                    
                }
                
            }) { (failureMessage) in
                
                
                print(failureMessage)
                
            }
        }
    }
    

//EditaddressAPICall
    
    
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
