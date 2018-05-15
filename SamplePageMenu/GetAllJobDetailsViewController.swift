//
//  GetAllJobDetailsViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 14/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class GetAllJobDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var getAllJobDetailsTableView: UITableView!
    
      var showNav = false
      var totalPages : Int? = 0
    
     var appVersion          : String = ""
    
    var jobDetailsArray:[GetAllJobDetailsListResultVO] = Array<GetAllJobDetailsListResultVO>()

     var filtered:[GetAllJobDetailsListResultVO] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllJobDetailsTableView.dataSource = self
        getAllJobDetailsTableView.delegate = self

        
        
        let nibName1  = UINib(nibName: "GetAllJobDetailsTableViewCell" , bundle: nil)
        getAllJobDetailsTableView.register(nibName1, forCellReuseIdentifier: "GetAllJobDetailsTableViewCell")
       getjobdetailsAPICall()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.setChurchuAdminInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Careers", backTitle: " " , rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        
        
    }

    
    
    
    //MARK: -  churchDetails TableView delegate & DataSource  methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filtered.count > 0 {
            
            return filtered.count
            
        }
        
        return jobDetailsArray.count
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableViewAutomaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GetAllJobDetailsTableViewCell", for: indexPath) as! GetAllJobDetailsTableViewCell
        

        let listStr:GetAllJobDetailsListResultVO = filtered[indexPath.row]
        
        cell.jobtitleLabel.text = listStr.jobTitle
        
        cell.qualificationLabel.text = listStr.qualification
        
        cell.churchNameLabel.text = listStr.churchName
        
        cell.cintactNumberLabel.text = listStr.contactNumber
        
        cell.lastdateToApplyLabel.text = listStr.lastDateToApply

        
        
        if(listStr.lastDateToApply! != ""){
            let dobStringArray = listStr.lastDateToApply?.components(separatedBy: "T")
            let dateString = dobStringArray?[0]
            cell.lastdateToApplyLabel.text  = dateString!
        }else{
            cell.lastdateToApplyLabel.text  = ""
        }
        

        
            return cell
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "GetJobByIDViewController") as! GetJobByIDViewController
            
     
        self.navigationController?.pushViewController(jobIDViewController, animated: true)
        
    }

    
    
    
    
    func getjobdetailsAPICall(){
        
        let paramsDict = [ "userId": 0,
                           "pageIndex": 1,
                           "pageSize": 200,
                           "sortbyColumnName": "LastdateToApply",
                           "sortDirection": "desc",
                           "searchName": ""
    
            ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: GETALLJOBDETAILSAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            let respVO:GetAllJobDetailsVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            

            if isSuccess == true {
                
                let listArr = respVO.listResult!
                
                for eachArray in listArr{
                    self.jobDetailsArray.append(eachArray)
                }
                
                
                print(self.jobDetailsArray.count)
                self.filtered = self.jobDetailsArray

                
                let pageCout  = (respVO.totalRecords)! / 10
                
                let remander = (respVO.totalRecords)! % 10
                
                self.totalPages = pageCout
                
                print(pageCout)
                
                if remander != 0 {
                    
                    self.totalPages = self.totalPages! + 1
                    
                }
                
                self.getAllJobDetailsTableView.reloadData()
                
            }
                
            else {
                
                
                
            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
    }

   
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        
        
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
