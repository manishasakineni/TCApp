//
//  JobApplyViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 15/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class JobApplyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var jobApplyTableView: UITableView!

    
      var appVersion          : String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobApplyTableView.delegate = self
        jobApplyTableView.dataSource = self
        
        let categorieHomeCell  = UINib(nibName: "JobApplyTableViewCell" , bundle: nil)
        jobApplyTableView.register(categorieHomeCell, forCellReuseIdentifier: "JobApplyTableViewCell")

        let jobApplicationCell  = UINib(nibName: "JobApplicationTableViewCell" , bundle: nil)
        jobApplyTableView.register(jobApplicationCell, forCellReuseIdentifier: "JobApplicationTableViewCell")
        

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.setChurchuAdminInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Apply", backTitle: " " , rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if section == 1 {
            
            return 1
        }
        
        
        
        return 11
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            // Ipad
            return 70;
        }
        else
        {
            // Iphone
            return 45;
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        
        if indexPath.section == 0{
            
            let signUPCell = tableView.dequeueReusableCell(withIdentifier: "JobApplyTableViewCell", for: indexPath) as! JobApplyTableViewCell
            
            
            
            
            if indexPath.row == 0{
                
            signUPCell.jobApplyTF.placeholder = "Job Title"
            
                
            }
            else if indexPath.row == 1{
                
                signUPCell.jobApplyTF.placeholder = "First Name"
                
            }
            else if indexPath.row == 2{
                
                signUPCell.jobApplyTF.placeholder = "Middle Name(Optional)"
                
            }
            else if indexPath.row == 3{
                
                
            signUPCell.jobApplyTF.placeholder = "Last Name"
                
            }
            else if indexPath.row == 4{
                
            signUPCell.jobApplyTF.placeholder = "Email"
                
                
            }
            else if indexPath.row == 5{
                
            signUPCell.jobApplyTF.placeholder = "Mobile Number"
                
                
            }
            else if indexPath.row == 6{
                
            signUPCell.jobApplyTF.placeholder = "Qualification"
                
                
            }
            else if indexPath.row == 7{
                
            signUPCell.jobApplyTF.placeholder = "Year Of Experience"
            
                
            }
            else if indexPath.row == 8{
                
                    
        signUPCell.jobApplyTF.placeholder = "Current Organization"
                    
                
            }
            else if indexPath.row == 9{
                
                signUPCell.jobApplyTF.placeholder = "Current Salary"
                
                
            }
        
            else if indexPath.row == 10{
                
                signUPCell.jobApplyTF.placeholder = "Expected Salary"
                
                
        }
        
        
            return signUPCell
        }
        if indexPath.section == 1{
          
            let signUPCell = tableView.dequeueReusableCell(withIdentifier: "JobApplicationTableViewCell", for: indexPath) as! JobApplicationTableViewCell
            
            
        return signUPCell
        
        }
    
        return UITableViewCell()
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
    
    
//    func getjobApplicationAPICall(){
//        
//        let paramsDict = [ "userId": 0,
//                           "pageIndex": 1,
//                           "pageSize": 200,
//                           "sortbyColumnName": "LastdateToApply",
//                           "sortDirection": "desc",
//                           "searchName": ""
//            
//            ] as [String : Any]
//        
//        let dictHeaders = ["":"","":""] as NSDictionary
//        
//        
//        serviceController.postRequest(strURL: GETALLJOBDETAILSAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
//            
//            print(result)
//            
//            let respVO:GetAllJobDetailsVO = Mapper().map(JSONObject: result)!
//            
//            let isSuccess = respVO.isSuccess
//            print("StatusCode:\(String(describing: isSuccess))")
//            
//            
//            if isSuccess == true {
//                
//                let listArr = respVO.listResult!
//                
//                for eachArray in listArr{
//                    self.jobDetailsArray.append(eachArray)
//                }
//                
//                
//                print(self.jobDetailsArray.count)
//                self.filtered = self.jobDetailsArray
//                
//                
//                let pageCout  = (respVO.totalRecords)! / 10
//                
//                let remander = (respVO.totalRecords)! % 10
//                
//                self.totalPages = pageCout
//                
//                print(pageCout)
//                
//                if remander != 0 {
//                    
//                    self.totalPages = self.totalPages! + 1
//                    
//                }
//                
//                self.getAllJobDetailsTableView.reloadData()
//                
//            }
//                
//            else {
//                
//                
//                
//            }
            
//        }) { (failureMessage) in
//            
//            
//            print(failureMessage)
//            
//        }
//    }
//


}
