//
//  GetJobByIDViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 15/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class GetJobByIDViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var getJobByIDTableView: UITableView!
    
    
    //MARK: -  variable declaration
    
    var userDetails : GetJobByIDListResultVO?
    var appVersion          : String = ""
    var jobTitle:String = ""
    var vacencies : String = ""
    var Qualification:String = ""
    var jobdescription:String = ""
    var contactperson : String = ""
    var contactnumber:String = ""
    
    var salary:String = ""
    var lastdatetoapply : String = ""
    var adminname:String = ""
    var churchname:String = ""
    var selectNameType : Array = Array<String>()
    let utillites =  Utilities()
    var jobId : Int = 0
    var churchId : Int = 0
    var authorId : Int = 0
    var eventId : Int = 0
    var postId : Int = 0
    var createdByUserId : Int = 0
    var upDatedByUserId : Int = 0
 //MARK: -  view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
        getJobByIDTableView.rowHeight = UITableViewAutomaticDimension
        getJobByIDTableView.estimatedRowHeight = 44
        getJobByIDTableView.reloadData()

       
        getJobByIDTableView.dataSource = self
        getJobByIDTableView.delegate = self
        
        getJobIDAPIService()
        
        let jobIdCell  = UINib(nibName: "GetJobidHeaderTableViewCell" , bundle: nil)
        getJobByIDTableView.register(jobIdCell, forCellReuseIdentifier: "GetJobidHeaderTableViewCell")
        
        let categorieHomeCell  = UINib(nibName: "GetJobByIDTableViewCell" , bundle: nil)
        getJobByIDTableView.register(categorieHomeCell, forCellReuseIdentifier: "GetJobByIDTableViewCell")

        // Do any additional setup after loading the view.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
   //MARK: -  view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Job Details".localize(), backTitle: " " , rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
        
        
    }
    
    //MARK: -  UITable view delegate and datasource methods

    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0 {
        
         return 1
        }
        
        
        
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            // Ipad
            return UITableViewAutomaticDimension;
        }
        else
        {
            // Iphone
            return UITableViewAutomaticDimension
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
      
        
        if indexPath.section == 0 {
            let signUPCell = tableView.dequeueReusableCell(withIdentifier: "GetJobidHeaderTableViewCell", for: indexPath) as! GetJobidHeaderTableViewCell
           
            
        let emailTap = UITapGestureRecognizer(target: self, action: #selector(self.financehistoryDetailClicked))
            
            signUPCell.applyButton.isUserInteractionEnabled = true
            signUPCell.applyButton.addGestureRecognizer(emailTap)
            
            return signUPCell
            

        }
         if indexPath.section == 1 {
            
            let signUPCell = tableView.dequeueReusableCell(withIdentifier: "GetJobByIDTableViewCell", for: indexPath) as! GetJobByIDTableViewCell

            if indexPath.row == 0{
                
                if !jobTitle.isEmpty {
                    
                    signUPCell.jobIDDetailsLabel.text = jobTitle
                    
                    signUPCell.jobIDNameLabel.text = "Job Title".localize()
                }
               
                
            }
            else if indexPath.row == 1{
                
                signUPCell.jobIDDetailsLabel.text = vacencies
                signUPCell.jobIDNameLabel.text = "Vacancies".localize()
                
            }
            else if indexPath.row == 2{
                
                signUPCell.jobIDDetailsLabel.text = Qualification
                signUPCell.jobIDNameLabel.text = "Qualification".localize()
                
            }
            else if indexPath.row == 3{
                
                signUPCell.jobIDDetailsLabel.text = jobdescription
                signUPCell.jobIDDetailsLabel.numberOfLines = 0
                
                
                signUPCell.jobIDNameLabel.text = "Job Description".localize()
                
                
            }
            else if indexPath.row == 4{
                
                signUPCell.jobIDDetailsLabel.text = contactperson
                signUPCell.jobIDNameLabel.text = "Contact Person".localize()
                
                
                
            }
            else if indexPath.row == 5{
                
                signUPCell.jobIDDetailsLabel.text = contactnumber
                signUPCell.jobIDNameLabel.text = "Contact Number".localize()
                
                
            }
            else if indexPath.row == 6{
                
                signUPCell.jobIDDetailsLabel.text = salary
                signUPCell.jobIDNameLabel.text = "Salary".localize()
                
                
            }
            else if indexPath.row == 7{
                
                signUPCell.jobIDDetailsLabel.text = returnEventDateWithoutTim1(selectedDateString: lastdatetoapply)
                signUPCell.jobIDNameLabel.text = "Last Date To Apply".localize()

                
                if(lastdatetoapply != ""){
                    
                    let dobStringArray = lastdatetoapply.components(separatedBy: "T")
                    let dateString = dobStringArray[0]
                    signUPCell.jobIDDetailsLabel.text  = returnEventDateWithoutTim1(selectedDateString: dateString)
                    
                }else{
                    signUPCell.jobIDDetailsLabel.text  = ""
                }

                
            }
            else if indexPath.row == 8{
                
                // if !adminname.isEmpty {
                    
                    
                signUPCell.jobIDDetailsLabel.text = adminname
                signUPCell.jobIDNameLabel.text = "Admin Name".localize()
                
     //   }
            }
            else if indexPath.row == 9{
                
                signUPCell.jobIDDetailsLabel.text = churchname
                signUPCell.jobIDNameLabel.text = "Church Name".localize()
                
                
            }
                
        
        return signUPCell
    }
        
   return UITableViewCell()
        
    }
    
 //MARK: -  get Job ID API Service
    
    func getJobIDAPIService(){

        let strUrl = GETJOBBYIDAPI  + "\(jobId)"
        
            serviceController.getRequest(strURL: strUrl, success: { (result) in
                
                
            let respVO:GetJobByIDVO = Mapper().map(JSONObject: result)!
                
            self.userDetails = respVO.result
                
                if respVO.result != nil {
                    
                    let obj = respVO.result!
                    
                    
                    self.jobTitle = (obj.jobTitle)!
                    self.vacencies = String(obj.vacencies!)
                    self.Qualification = (obj.qualification!)
                    self.jobdescription = (obj.jobDesc!)
                    self.contactperson = (obj.contactPerson)!
                    self.contactnumber = (obj.contactNumber)!
                    
                    self.salary = "\(String(describing: obj.salary!))"
                   self.lastdatetoapply = (obj.lastDateToApply)!
                   self.createdByUserId = obj.createdByUserId!
                    self.upDatedByUserId = obj.updatedByUserId!
                    if obj.adminName != nil {
                        
                self.adminname = (obj.adminName)!
                        
                    }
                    if obj.churchName != nil {
                        
                        self.churchname = (obj.churchName)!
                        
                    }
  
                    
                //    self.adminname = (obj.adminName)!
              //      self.churchname = (obj.churchName)!
                    
                    
                }
                
        
                    self.getJobByIDTableView.reloadData()
                
                
            }) { (failureMessage) in
                
            }
            
        }
 
    //MARK: - back Left Button Tapped
    
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
    
    func showAlertViewWithTitle(_ title:String,message:String,buttonTitle:String)
        
    {
        let alertView:UIAlertView = UIAlertView();
        alertView.title=title
        alertView.message=message
        alertView.addButton(withTitle: buttonTitle)
        alertView.show()
    }
  
    func  financehistoryDetailClicked( sender:UIGestureRecognizer){
        
        
            let historyViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JobApplyViewController") as! JobApplyViewController
        historyViewController.jobtitle = jobTitle
        historyViewController.createdByUserId = createdByUserId
        historyViewController.updatedByUserId = upDatedByUserId
        
        historyViewController.jobId = jobId

            self.navigationController?.pushViewController(historyViewController, animated: true)
        
        
    }
    
    //MARK: -   Event Date Without Time  2019-01-15T00:00:00
    
    func returnEventDateWithoutTim1(selectedDateString : String) -> String{
        var newDateStr = ""
        var newDateStr1 = ""
        
        if(selectedDateString != ""){
            let invDtArray = selectedDateString.components(separatedBy: "T")
            let dateString = invDtArray[0]

            if(dateString != "" || dateString != "."){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateFromString = dateFormatter.date(from: dateString)
                dateFormatter.dateFormat = "dd-MM-YYY"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr = newDateString
                print(newDateStr)
            }
            //            if(dateString3 != "" || dateString != "."){
            //
            //                let dateFormatter = DateFormatter()
            //                dateFormatter.dateStyle = .medium
            //                dateFormatter.dateFormat = "HH:mm:ss"
            //                let dateFromString = dateFormatter.date(from: dateString3)
            //                dateFormatter.dateFormat = "hh:mm aa"
            //                let newDateString = dateFormatter.string(from: dateFromString!)
            //                newDateStr1 = newDateString
            //                print(newDateStr1)
            //            }
        }
        return newDateStr
    }
    

}
