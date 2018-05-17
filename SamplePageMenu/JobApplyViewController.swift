//
//  JobApplyViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 15/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class JobApplyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    
    @IBOutlet weak var jobApplyTableView: UITableView!
    
    
    @IBOutlet weak var applyBtnOutLet: UIButton!

     var activeTextField = UITextField()
      var appVersion          : String = ""
    
     let utillites =  Utilities()
    
    var jobtitle    :String = ""
    var firstname     :String = ""
    var middlename   :String = ""
    var lastname      :String = ""
    var email           : String = ""
    var mobileNumber     : String = ""
    var qualification       : String = ""
    var yearofexperience       : String = ""
    var currentorganization   : String = ""
    var currentsalary         :String = ""
    var expectedsalary        :String = ""
    
    var isActive:Bool = true
    var createdByUserId:Int = 1
    var createdDate : String = "2018-05-14T11:15:41.9952665+05:30"
    var updatedByUserId : Int = 1
    var updatedDate:String =  "2018-05-14T11:15:41.9952665+05:30"
    

    
    
  var alertTag = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobApplyTableView.delegate = self
        jobApplyTableView.dataSource = self
        
        activeTextField.delegate = self
        
        let categorieHomeCell  = UINib(nibName: "JobApplyTableViewCell" , bundle: nil)
        jobApplyTableView.register(categorieHomeCell, forCellReuseIdentifier: "JobApplyTableViewCell")

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Apply", backTitle: " " , rightImage: "home icon", secondRightImage: "Up", thirdRightImage: "Up")
        
        
        
    }
    
    
    //MARK:- textField Should End Editing
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        activeTextField = textField
        
        textField.autocorrectionType = .no
        
        
        if activeTextField.tag == 0 {
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .default
        }
        else if activeTextField.tag == 1 {
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .default
        }
        else if activeTextField.tag == 2 {
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .default
        }
        else if activeTextField.tag == 3 {
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .default
        }
            
        else if activeTextField.tag == 4{
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .emailAddress
            
        }
            
        else if activeTextField.tag == 5{
            
            textField.maxLengthTextField = 10
            textField.keyboardType = .phonePad
            
        }
        else if activeTextField.tag == 6{
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .default
            
            
        }
        else if activeTextField.tag == 7{
            
            textField.maxLengthTextField = 10
            textField.clearButtonMode = .never
            textField.keyboardType = .default
            
            
        }
        
        else if activeTextField.tag == 8{
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .default
            
            
        }
        
        else if activeTextField.tag == 9{
            
            textField.maxLengthTextField = 7
            textField.clearButtonMode = .never
            textField.keyboardType = .default
            
            
        }
       
        else if activeTextField.tag == 10{
            
            textField.maxLengthTextField = 7
            textField.clearButtonMode = .never
            textField.keyboardType = .default
            
            
        }

    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        activeTextField = textField
        
        return true
        
    }
      //MARK:- textField Should Should End Editing
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        
        
        
        if let newRegCell : JobApplyTableViewCell = textField.superview?.superview as? JobApplyTableViewCell {
            
            
            
        }
        return true
    }
    
    
    
    
    //MARK:- textField Did End Editing
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        activeTextField = textField
        
        
        if activeTextField.tag == 0{
            
            jobtitle = textField.text!
            
        }
        else if activeTextField.tag == 1{
            
            firstname = textField.text!
            
        }
        else if activeTextField.tag == 2{
            
            middlename = textField.text!
            
        }
        else if activeTextField.tag == 3{
            
            lastname = textField.text!
            
        }
            
        else if activeTextField.tag == 4 {
            
            email = textField.text!
            
        }
            
        else if activeTextField.tag == 5{
            
            mobileNumber = textField.text!
            
        }
        else if activeTextField.tag == 6{
            
            qualification = textField.text!
            
            
        }
            
        else if activeTextField.tag == 7{
            
            
            yearofexperience = textField.text!
            
            
        }
        
        
        else if activeTextField.tag == 8{
            
            
            currentorganization = textField.text!
            
            
        }

        else if activeTextField.tag == 9{
            
            
            currentsalary = textField.text!
            
            
        }
        else if activeTextField.tag == 10{
            
            
            expectedsalary = textField.text!
            
            
        }

        
    }
    
 
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
    
        
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
        
        
        
        
            let signUPCell = tableView.dequeueReusableCell(withIdentifier: "JobApplyTableViewCell", for: indexPath) as! JobApplyTableViewCell
            
        signUPCell.jobApplyTF.delegate = self
         signUPCell.jobApplyTF.tag = indexPath.row
        
            
            if indexPath.row == 0{
                
            signUPCell.jobApplyTF.placeholder = "Job Title"
            signUPCell.jobApplyTF.text = jobtitle
                
            }
            else if indexPath.row == 1{
                
                signUPCell.jobApplyTF.placeholder = "First Name"
                signUPCell.jobApplyTF.text = firstname
            }
            else if indexPath.row == 2{
                
                signUPCell.jobApplyTF.placeholder = "Middle Name(Optional)"
                signUPCell.jobApplyTF.text = middlename
                
            }
            else if indexPath.row == 3{
                
                
            signUPCell.jobApplyTF.placeholder = "Last Name"
             signUPCell.jobApplyTF.text = lastname
                
            }
            else if indexPath.row == 4{
                
            signUPCell.jobApplyTF.placeholder = "Email"
              signUPCell.jobApplyTF.text = email
                
            }
            else if indexPath.row == 5{
                
            signUPCell.jobApplyTF.placeholder = "Mobile Number"
              signUPCell.jobApplyTF.text = mobileNumber
                
            }
            else if indexPath.row == 6{
                
            signUPCell.jobApplyTF.placeholder = "Qualification"
                
             signUPCell.jobApplyTF.text = qualification
            }
            else if indexPath.row == 7{
                
            signUPCell.jobApplyTF.placeholder = "Year Of Experience"
            signUPCell.jobApplyTF.text = yearofexperience
                
            }
            else if indexPath.row == 8{
                
                    
        signUPCell.jobApplyTF.placeholder = "Current Organization"
              signUPCell.jobApplyTF.text = currentorganization
                
            }
            else if indexPath.row == 9{
                
                signUPCell.jobApplyTF.placeholder = "Current Salary"
                
                signUPCell.jobApplyTF.text = currentsalary
            }
        
            else if indexPath.row == 10{
                
                signUPCell.jobApplyTF.placeholder = "Expected Salary"
                signUPCell.jobApplyTF.text = expectedsalary
                
        }
        
        
            return signUPCell
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
   
    
    func showAlertViewWithTitle(_ title:String,message:String,buttonTitle:String)
        
    {
        let alertView:UIAlertView = UIAlertView();
        alertView.title=title
        alertView.message=message
        alertView.addButton(withTitle: buttonTitle)
        alertView.show()
    }

  
  
    
    
    //MARK:- validateAllFields
    
    func validateAllFields() -> Bool
    {
        
        var errorMessage:NSString?
        let jobtitleStr:NSString = jobtitle as NSString
        let firstnameStr:NSString = firstname as NSString
        let middlenameStr:NSString =  middlename  as NSString
        
        let lastnameStr:NSString = lastname as NSString
        let emailStr:NSString = email as NSString
        let mobileNumberStr:NSString =  mobileNumber  as NSString
        let qualificationStr:NSString = qualification   as NSString
        let yearofexperienceStr:NSString =  yearofexperience  as NSString
        let currentorganizationStr:NSString =  currentorganization  as NSString
        let currentsalaryStr:NSString = currentsalary   as NSString
        let expectedsalaryStr:NSString =  expectedsalary  as NSString
        
        
        if (jobtitleStr.length <= 2){
            
            alertTag = 0
            
            errorMessage=GlobalSupportingClass.blankjobtitleErrorMessage() as String as String as NSString?
            
        }
            
        else if (firstnameStr.length <= 0){
            
            alertTag = 1
            
            errorMessage=GlobalSupportingClass.blankFirstNameErrorMessage() as String as String as NSString?
            
        }
            
        else if (lastnameStr.length <= 2){
            
            alertTag = 3
            
            errorMessage=GlobalSupportingClass.blankLastNameErrorMessage() as String as String as NSString?
            
        }
            
            
        else if (emailStr.length<=0) {
            
            alertTag = 4
            
            errorMessage=GlobalSupportingClass.blankEmailIDErrorMessage() as String as String as NSString?
        }
            
        else  if (emailStr.length < 5) {
            
            alertTag = 4
            
            errorMessage=GlobalSupportingClass.miniCharEmailIDErrorMessage() as String as String as NSString?
        }
        else  if(!GlobalSupportingClass.isValidEmail(emailStr as NSString))
        {
            errorMessage=GlobalSupportingClass.invalidEmaildIDFormatErrorMessage() as String as String as NSString?
        }
            
        else if (mobileNumberStr.length <= 0){
            alertTag = 5
            
            
            errorMessage=GlobalSupportingClass.blankMobilenumberErrorMessage() as String as String as NSString?
            
        }
        else if (mobileNumberStr.length <= 9) {
            alertTag = 5
            
            
            errorMessage=GlobalSupportingClass.invalidMobilenumberErrorMessage() as String as String as NSString?
        }
            
        else if (qualificationStr.length <= 0){
            
            alertTag = 6
            
            errorMessage=GlobalSupportingClass.blankqualificationErrorMessage() as String as String as NSString?
            
        }
            
        else if (yearofexperienceStr.length <= 2){
            
            alertTag = 7
            
            errorMessage=GlobalSupportingClass.blankyearofexperienceErrorMessage() as String as String as NSString?
            
        }
    
        else if (currentorganizationStr.length <= 0){
            
            alertTag = 8
            
            errorMessage=GlobalSupportingClass.blankcurrentorganizationErrorMessage() as String as String as NSString?
            
        }
            
        else if (currentsalaryStr.length <= 2){
            
            alertTag = 9
            
            errorMessage=GlobalSupportingClass.blankcurrentsalaryErrorMessage() as String as String as NSString?
            
        }

        else if (expectedsalaryStr.length <= 2){
            
            alertTag = 10
            
            errorMessage=GlobalSupportingClass.blankexpectedsalaryErrorMessage() as String as String as NSString?
            
        }
        
        
        
        
        if let errorMsg = errorMessage{
            
            
            alertWithTitle(title: "Alert".localize(), message: errorMsg as String, ViewController: self, toFocus: activeTextField)
            return false
        }
        return true
    }
    
    
    
    
func alertWithTitle(title: String!, message: String, ViewController: UIViewController, toFocus:UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok".localize(), style: UIAlertActionStyle.cancel,handler: {_ in
            
            
            let indexPath : IndexPath = IndexPath(row: self.alertTag, section: 0)
            
            self.jobApplyTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
            if let cell = self.jobApplyTableView.cellForRow(at: indexPath) as? SignUPTableViewCell {
                
                cell.registrationTextfield.becomeFirstResponder()
            }
            
            
        });
        alert.addAction(action)
        ViewController.present(alert, animated: true, completion:nil)
    }
    
    

    @IBAction func applyBtnAction(_ sender: Any) {
        
        jobApplyTableView.endEditing(true)
        
        if(appDelegate.checkInternetConnectivity()){
            
            if self.validateAllFields()
            {
             getjobApplicationAPICall()
                
            }
        }
        else {
            
     //       self.appDelegate.window?.makeToast(kNetworkStatusMessage, duration:kToastDuration, position:CSToastPositionCenter)
            return
            
        }

        
        
        print("Submit Button Clicked......")
        

        
    }
    
func getjobApplicationAPICall(){
    
    let paramsDict = [
        
        
        "docString": "JVBERi0xLjMNCiXi48/TDQoNCjEgMCBvYmoNCjw8DQovVHlwZSAvQ2F0YWxvZw0KL091dGxpbmVzIDIgMCBSDQovUGFnZXMgMyAwIFINCj4+DQplbmRvYmoNCg0KMiAwIG9iag0KPDwNCi9UeXBlIC9PdXRsaW5lcw0KL0NvdW50IDANCj4+DQplbmRvYmoNCg0KMyAwIG9iag0KPDwNCi9UeXBlIC9QYWdlcw0KL0NvdW50IDINCi9LaWRzIFsgNCAwIFIgNiAwIFIgXSANCj4+DQplbmRvYmoNCg0KNCAwIG9iag0KPDwNCi9UeXBlIC9QYWdlDQovUGFyZW50IDMgMCBSDQovUmVzb3VyY2VzIDw8DQovRm9udCA8PA0KL0YxIDkgMCBSIA0KPj4NCi9Qcm9jU2V0IDggMCBSDQo+Pg0KL01lZGlhQm94IFswIDAgNjEyLjAwMDAgNzkyLjAwMDBdDQovQ29udGVudHMgNSAwIFINCj4+DQplbmRvYmoNCg0KNSAwIG9iag0KPDwgL0xlbmd0aCAxMDc0ID4+DQpzdHJlYW0NCjIgSg0KQlQNCjAgMCAwIHJnDQovRjEgMDAyNyBUZg0KNTcuMzc1MCA3MjIuMjgwMCBUZA0KKCBBIFNpbXBsZSBQREYgRmlsZSApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDY4OC42MDgwIFRkDQooIFRoaXMgaXMgYSBzbWFsbCBkZW1vbnN0cmF0aW9uIC5wZGYgZmlsZSAtICkgVGoNCkVUDQpCVA0KL0YxIDAwMTAgVGYNCjY5LjI1MDAgNjY0LjcwNDAgVGQNCigganVzdCBmb3IgdXNlIGluIHRoZSBWaXJ0dWFsIE1lY2hhbmljcyB0dXRvcmlhbHMuIE1vcmUgdGV4dC4gQW5kIG1vcmUgKSBUag0KRVQNCkJUDQovRjEgMDAxMCBUZg0KNjkuMjUwMCA2NTIuNzUyMCBUZA0KKCB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDYyOC44NDgwIFRkDQooIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlICkgVGoNCkVUDQpCVA0KL0YxIDAwMTAgVGYNCjY5LjI1MDAgNjE2Ljg5NjAgVGQNCiggdGV4dC4gQW5kIG1vcmUgdGV4dC4gQm9yaW5nLCB6enp6ei4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kICkgVGoNCkVUDQpCVA0KL0YxIDAwMTAgVGYNCjY5LjI1MDAgNjA0Ljk0NDAgVGQNCiggbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDU5Mi45OTIwIFRkDQooIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlIHRleHQuICkgVGoNCkVUDQpCVA0KL0YxIDAwMTAgVGYNCjY5LjI1MDAgNTY5LjA4ODAgVGQNCiggQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgKSBUag0KRVQNCkJUDQovRjEgMDAxMCBUZg0KNjkuMjUwMCA1NTcuMTM2MCBUZA0KKCB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBFdmVuIG1vcmUuIENvbnRpbnVlZCBvbiBwYWdlIDIgLi4uKSBUag0KRVQNCmVuZHN0cmVhbQ0KZW5kb2JqDQoNCjYgMCBvYmoNCjw8DQovVHlwZSAvUGFnZQ0KL1BhcmVudCAzIDAgUg0KL1Jlc291cmNlcyA8PA0KL0ZvbnQgPDwNCi9GMSA5IDAgUiANCj4+DQovUHJvY1NldCA4IDAgUg0KPj4NCi9NZWRpYUJveCBbMCAwIDYxMi4wMDAwIDc5Mi4wMDAwXQ0KL0NvbnRlbnRzIDcgMCBSDQo+Pg0KZW5kb2JqDQoNCjcgMCBvYmoNCjw8IC9MZW5ndGggNjc2ID4+DQpzdHJlYW0NCjIgSg0KQlQNCjAgMCAwIHJnDQovRjEgMDAyNyBUZg0KNTcuMzc1MCA3MjIuMjgwMCBUZA0KKCBTaW1wbGUgUERGIEZpbGUgMiApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDY4OC42MDgwIFRkDQooIC4uLmNvbnRpbnVlZCBmcm9tIHBhZ2UgMS4gWWV0IG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gKSBUag0KRVQNCkJUDQovRjEgMDAxMCBUZg0KNjkuMjUwMCA2NzYuNjU2MCBUZA0KKCBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDY2NC43MDQwIFRkDQooIHRleHQuIE9oLCBob3cgYm9yaW5nIHR5cGluZyB0aGlzIHN0dWZmLiBCdXQgbm90IGFzIGJvcmluZyBhcyB3YXRjaGluZyApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDY1Mi43NTIwIFRkDQooIHBhaW50IGRyeS4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gKSBUag0KRVQNCkJUDQovRjEgMDAxMCBUZg0KNjkuMjUwMCA2NDAuODAwMCBUZA0KKCBCb3JpbmcuICBNb3JlLCBhIGxpdHRsZSBtb3JlIHRleHQuIFRoZSBlbmQsIGFuZCBqdXN0IGFzIHdlbGwuICkgVGoNCkVUDQplbmRzdHJlYW0NCmVuZG9iag0KDQo4IDAgb2JqDQpbL1BERiAvVGV4dF0NCmVuZG9iag0KDQo5IDAgb2JqDQo8PA0KL1R5cGUgL0ZvbnQNCi9TdWJ0eXBlIC9UeXBlMQ0KL05hbWUgL0YxDQovQmFzZUZvbnQgL0hlbHZldGljYQ0KL0VuY29kaW5nIC9XaW5BbnNpRW5jb2RpbmcNCj4+DQplbmRvYmoNCg0KMTAgMCBvYmoNCjw8DQovQ3JlYXRvciAoUmF2ZSBcKGh0dHA6Ly93d3cubmV2cm9uYS5jb20vcmF2ZVwpKQ0KL1Byb2R1Y2VyIChOZXZyb25hIERlc2lnbnMpDQovQ3JlYXRpb25EYXRlIChEOjIwMDYwMzAxMDcyODI2KQ0KPj4NCmVuZG9iag0KDQp4cmVmDQowIDExDQowMDAwMDAwMDAwIDY1NTM1IGYNCjAwMDAwMDAwMTkgMDAwMDAgbg0KMDAwMDAwMDA5MyAwMDAwMCBuDQowMDAwMDAwMTQ3IDAwMDAwIG4NCjAwMDAwMDAyMjIgMDAwMDAgbg0KMDAwMDAwMDM5MCAwMDAwMCBuDQowMDAwMDAxNTIyIDAwMDAwIG4NCjAwMDAwMDE2OTAgMDAwMDAgbg0KMDAwMDAwMjQyMyAwMDAwMCBuDQowMDAwMDAyNDU2IDAwMDAwIG4NCjAwMDAwMDI1NzQgMDAwMDAgbg0KDQp0cmFpbGVyDQo8PA0KL1NpemUgMTENCi9Sb290IDEgMCBSDQovSW5mbyAxMCAwIFINCj4+DQoNCnN0YXJ0eHJlZg0KMjcxNA0KJSVFT0YNCg==",
        "id": 0,
        "jobId": 2,
        "firstName": firstname,
        "middleName": middlename,
        "lastName": lastname,
        "mobileNumber": mobileNumber,
        "email": email,
        "qualification": qualification,
        "applyingFor": "Accountant",
        "yearsofExp": yearofexperience,
        "fileName": "",
        "fileLocation": "",
        "fileExtention": ".pdf",
        "currentOrganization": currentorganization,
        "currentSalary": currentsalary,
        "expectedSalary": expectedsalary,
        "isActive": isActive,
        "createdByUserId": createdByUserId,
        "createdDate": createdDate,
        "updatedByUserId": updatedByUserId,
        "updatedDate": updatedDate
        
                        ] as [String : Any]
    
            let dictHeaders = ["":"","":""] as NSDictionary
    
    
            serviceController.postRequest(strURL: JOBAPPLYAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
    
                print(result)
    
                let respVO:JobApplyVO = Mapper().map(JSONObject: result)!
    
                 let statusMsg = respVO.endUserMessage!
                let isSuccess = respVO.isSuccess
                print("StatusCode:\(String(describing: isSuccess))")
    
    
                if isSuccess == true {
    
                    let listArr = respVO.listResult!
    
                    self.utillites.alertWithOkButtonAction(vc: self, alertTitle: "Success", messege:String( statusMsg), clickAction: {
                        
              //          let signUpVc  : ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        
                        
                        
            //self.navigationController?.pushViewController(signUpVc, animated: true)
                        
                        
                    })
                    
                    

    
        self.jobApplyTableView.reloadData()
    
                }
    
                else {
    
    
    
                }
    
            }) { (failureMessage) in
    
    
                print(failureMessage)
    
            }
        }
    
    
 
    
    
    
    
    

}
