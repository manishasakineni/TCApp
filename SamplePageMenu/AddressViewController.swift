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

    
     var showNav = false
     var userId :  Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName1  = UINib(nibName: "AddressTableViewCell" , bundle: nil)
        addressTableview.register(nibName1, forCellReuseIdentifier: "AddressTableViewCell")
        
        addressTableview.dataSource = self
        addressTableview.delegate = self
        
        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            
            userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
            
        }
        
        addressAPICall()
        
        
        

        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Address", backTitle: " " , rightImage: "home icon", secondRightImage: "Up", thirdRightImage: "Up")
        
        
        
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
        
        cell.addresslineLbl.text = listStr.addressLine1! + listStr.addressLine2!
        cell.statecountryLbl.text = listStr.countryName! + listStr.stateName!
        
        cell.pincodeLbl.text = "\(listStr.pinCode!)"
        cell.mobileNoLbl.text = "\(listStr.mobileNumber!)"

        
        
        
        return cell
        
        
        
    }
    

    @IBAction func addNewAddressAction(_ sender: Any) {
        

//        
        let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController
        
        
        self.navigationController?.pushViewController(jobIDViewController, animated: true)

        
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
                
                let listArr = respVO.listResult!
                
                for eachArray in listArr{
                    self.filtered.append(eachArray)
                }
                
                self.addressTableview.reloadData()
                
            }
                
            else {
                
                
                
            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
    }
    
    

    
    

}
