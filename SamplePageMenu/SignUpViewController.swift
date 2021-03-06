//
//  SignUpViewController.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 24/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import TextFieldEffects
import IQKeyboardManagerSwift

class SignUpViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var signUpTableView: UITableView!
    @IBOutlet weak var signeUpOutLet: UIButton!
    @IBOutlet weak var allreadyhaveanAccount: UILabel!
    
//MARK: -  variable declaration
    
    let utillites =  Utilities()
    var appVersion          : String = ""
    var toolBar = UIToolbar()
    var activeTextField = UITextField()
    var alertTag = Int()
    var showNav = false
    var id:Int = 0
    var userId:String = ""
    var firstName:String = ""
    var middleName:String = ""
    var lastName:String = ""
    var contactNumber:String = "2457561545"
    var mobileNumber  : String = ""
    var userName     : String = ""
    var password       : String = ""
    var confirmpassword       : String = ""
    var roleId   : Int = 3
    var email:String = ""
    var isActive:Bool = true
    var createdByUserId:Int = 89
    var createdDate : String = "2018-01-31T10:43:28.8319786+05:30"
    var updatedByUserId : Int = 89
    var updatedDate:String =  "2018-01-31T10:43:28.8329795+05:30"
    var gender : String = ""
    var male = true
    var female = false
    var genderTypeID:Int = 27
    let datepicker = UIDatePicker()
    var dateofBirth:String = ""
    let dateFormatter = DateFormatter()
    var selectedDate : String = ""
    var DOB       : Int = 27
    var btneditClick = false
    var isEyeClicked = Bool()
    var sectionsTitle : [String] = [" "]
    var signUpTFPlaceholdersArray = ["FirstNam".localize(),"MiddleName".localize(),"LastName".localize(),"UserName".localize(),"E-Mail".localize(),"MobileNumber".localize(),"Password".localize(),"Confirm Password".localize()]
    
    
//MARK: -   View Did Load

    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        signeUpOutLet.setTitle("Submit".localize(), for: .normal)
        allreadyhaveanAccount.text = "all ready have an Account?".localize()
        signeUpOutLet.layer.borderWidth = 1.0
        signeUpOutLet.layer.cornerRadius = 6.0
        signeUpOutLet.layer.borderColor = UIColor(red: 122.0/255.0, green: 186.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        signUpTableView.delegate = self
        signUpTableView.dataSource = self
        activeTextField.delegate = self
        registerTableViewCells()
        
        //Registering Tableview Cell

        let nibName3  = UINib(nibName: "GenderTableViewCell" , bundle: nil)
        signUpTableView.register(nibName3, forCellReuseIdentifier: "GenderTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func registerTableViewCells() {

        let nibName1  = UINib(nibName: "SignUPTableViewCell" , bundle: nil)
        signUpTableView.register(nibName1, forCellReuseIdentifier: "SignUPTableViewCell")
    }
    
//MARK: -   View Will Appear
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Utilities.setSignUpViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Registration".localize(), backTitle: " ", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
    }


//MARK: - Create date Picker Controller
    
    func CreatedatePicker(){
        
        datepicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done".localize(), style: UIBarButtonItemStyle.bordered, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        activeTextField.inputAccessoryView = toolbar
        activeTextField.inputView = datepicker
    }
    
    
//MARK: -  done Pressed
    
    func donePressed(){
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateofBirth = dateFormatter.string(from: datepicker.date)
        selectedDate = dateFormatter.string(from: datepicker.date)
        activeTextField.text = selectedDate
        print(selectedDate)
        print(dateofBirth)
        self.view.endEditing(true)
        signUpTableView.reloadData()
    }

    
//MARK:- textField delegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeTextField = textField
        textField.autocorrectionType = .no
        
        if activeTextField.tag == 0 {
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .alphabet
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
            textField.maxLengthTextField = 25
            textField.clearButtonMode = .never
            textField.keyboardType = .default
            textField.isSecureTextEntry = true
        }
            
        else if activeTextField.tag == 7{
            textField.maxLengthTextField = 25
            textField.clearButtonMode = .never
            textField.keyboardType = .default
            textField.isSecureTextEntry = true
        }
            
        else if activeTextField.tag == 8{
            CreatedatePicker()
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        activeTextField = textField
        
        if activeTextField.tag == 0 || activeTextField.tag == 1 || activeTextField.tag == 2{
            
            if string.characters.count > 0 {
                let currentCharacterCount = textField.text?.characters.count ?? 0
                if (range.length + range.location > currentCharacterCount){
                    return false
                }
                let newLength = currentCharacterCount + string.characters.count - range.length
                let allowedCharacters = CharacterSet.letters
                let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
                
                let space = CharacterSet.init(charactersIn: " ")
                let spacestr = string.trimmingCharacters(in: space)
                return newLength <= 50 && unwantedStr.characters.count == 0 ||  spacestr.characters.count == 0
            }
        }
            
        else if activeTextField.tag == 3 {
          
            if string.characters.count > 0 {
                let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
                let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                return (string == filtered)
            }
        }
            else if activeTextField.tag == 5 {
            
                if string.characters.count > 0 {
                    let currentCharacterCount = textField.text?.characters.count ?? 0
                    if (range.length + range.location > currentCharacterCount){
                    return false
                    }
                    let newLength = currentCharacterCount + string.characters.count - range.length
                    
                    let allowedCharacters = CharacterSet.decimalDigits
                    let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
                    return newLength <= 50 && unwantedStr.characters.count == 0
                }
            }
        
        else if activeTextField.tag == 6 || activeTextField.tag == 7{
            
            let indexPath = IndexPath.init(row: textField.tag, section: 0)
            
            if let forgotPasswordCell = signUpTableView.cellForRow(at: indexPath) as? SignUPTableViewCell {
                forgotPasswordCell.eyeButtonOutlet.isHidden = false
                
                if let text = activeTextField.text,
                    let textRange = Range(range, in: text) {
                    let updatedText = text.replacingCharacters(in: textRange, with: string)
                    
                    if updatedText.count == 0 {
                        forgotPasswordCell.eyeButtonOutlet.isHidden = true
                    }
                }
            }
        }
        return true
    }
  
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if let newRegCell : SignUPTableViewCell = textField.superview?.superview as? SignUPTableViewCell {
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        activeTextField = textField

        if activeTextField.tag == 0{
            firstName = textField.text!
        }
       else if activeTextField.tag == 1{
            middleName = textField.text!
        }
       else if activeTextField.tag == 2{
            lastName = textField.text!
        }
       else if activeTextField.tag == 3{
            userName = textField.text!
        }
        else if activeTextField.tag == 4 {
            email = textField.text!
        }
        else if activeTextField.tag == 5{
            mobileNumber = textField.text!
        }
        else if activeTextField.tag == 6{
            password = textField.text!
        }
        else if activeTextField.tag == 7{
            confirmpassword = textField.text!
        }
    }
  
    
//MARK: -   TableView Delegate & DataSource Methods
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            
        return signUpTFPlaceholdersArray.count
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            
        let signUPCell = tableView.dequeueReusableCell(withIdentifier: "SignUPTableViewCell", for: indexPath) as! SignUPTableViewCell
        signUPCell.registrationTextfield.delegate = self
        signUPCell.registrationTextfield.tag = indexPath.row
        signUPCell.eyeButtonOutlet.tag = indexPath.row

        if indexPath.row == 0{
            signUPCell.registrationTextfield.placeholder = "First Name*".localize()
            signUPCell.registrationTextfield.text = firstName
            signUPCell.eyeButtonOutlet.isHidden = true
        }
            
        else if indexPath.row == 1{
            signUPCell.registrationTextfield.placeholder = "Middle Name".localize()
            signUPCell.registrationTextfield.text = middleName
            signUPCell.eyeButtonOutlet.isHidden = true
        }
            
        else if indexPath.row == 2{
            signUPCell.registrationTextfield.placeholder = "Last Name*".localize()
            signUPCell.registrationTextfield.text = lastName
            signUPCell.eyeButtonOutlet.isHidden = true
        }
        
       else if indexPath.row == 3{
            signUPCell.registrationTextfield.placeholder = "User Name*".localize()
            signUPCell.registrationTextfield.text = userName
            signUPCell.eyeButtonOutlet.isHidden = true
        }
            
        else if indexPath.row == 4{
            signUPCell.registrationTextfield.text = email
            signUPCell.registrationTextfield.placeholder = "E-mail*".localize()
            signUPCell.eyeButtonOutlet.isHidden = true
        }
            
        else if indexPath.row == 5{
            signUPCell.registrationTextfield.text = mobileNumber
            signUPCell.registrationTextfield.placeholder = "Mobile Number*".localize()
            signUPCell.eyeButtonOutlet.isHidden = true
        }
            
        else if indexPath.row == 6{
            signUPCell.registrationTextfield.text = password
            signUPCell.registrationTextfield.placeholder = "Password*".localize()
            signUPCell.eyeButtonOutlet.isHidden = false
            signUPCell.eyeButtonOutlet.addTarget(self, action: #selector(eyeButtonClicked(_:)), for: UIControlEvents.touchUpInside)
        }
      
        else if indexPath.row == 7{
            signUPCell.registrationTextfield.text = confirmpassword
            signUPCell.registrationTextfield.placeholder = "Confirm Password*".localize()
            signUPCell.eyeButtonOutlet.isHidden = false
            signUPCell.eyeButtonOutlet.addTarget(self, action: #selector(eyeButtonClicked(_:)), for: UIControlEvents.touchUpInside)
        }
        
            signUPCell.eyeButtonOutlet.isHidden = true
            return signUPCell
    }
    
//MARK: -   Eye Button Clicked

    
    func  eyeButtonClicked(_ sendre:UIButton) {
        
        let indexPath = IndexPath.init(row: sendre.tag, section: 0)
        
        if let forgotPasswordCell = signUpTableView.cellForRow(at: indexPath) as? SignUPTableViewCell {
            
                forgotPasswordCell.registrationTextfield.isSecureTextEntry = !forgotPasswordCell.registrationTextfield.isSecureTextEntry
            
            if isEyeClicked == true{
                forgotPasswordCell.eyeButtonOutlet.setImage(#imageLiteral(resourceName: "eyeclosed"), for: .normal)
                isEyeClicked = false
            }
                
            else{
                forgotPasswordCell.eyeButtonOutlet.setImage(#imageLiteral(resourceName: "eyeopen"), for: .normal)
                isEyeClicked = true
            }
        }
    }
    
    
//MARK:- Male Btn Clicked
    
    func maleBtnClicked(_ sender: UIButton) {
        
        let indexPath:IndexPath = IndexPath(row: 0, section: 1)
        
        if let cell : GenderTableViewCell = self.signUpTableView.cellForRow(at: indexPath) as? GenderTableViewCell {
            
            if (male == true){
                cell.maleUnCheckBtn.image = UIImage(named:"checked_83366")
                cell.femaleUnCheck.image = UIImage(named:"icons8-Unchecked Circle-50")
                male = false
            }
                
            else{
                cell.maleUnCheckBtn.image = UIImage(named:"icons8-Unchecked Circle-50")
                cell.femaleUnCheck.image = UIImage(named:"checked_83366")
                male = true
            }
        }
        genderTypeID = 27
        print(genderTypeID)
        signUpTableView.reloadRows(at: [indexPath], with: .fade)
    }
    

//MARK:- Female Btn Clicked
    
    
    func femaleBtnClicked(_ sender: UIButton){
        
        let indexPath:IndexPath = IndexPath(row: 0, section: 1)
        
        if let cell : GenderTableViewCell = self.signUpTableView.cellForRow(at: indexPath) as? GenderTableViewCell {
            
            if (male == true){
                cell.maleUnCheckBtn.image = UIImage(named:"icons8-Unchecked Circle-50")
                cell.femaleUnCheck.image = UIImage(named:"checked_83366")
                male = false
            }
                
            else{
                cell.maleUnCheckBtn.image = UIImage(named:"checked_83366")
                cell.femaleUnCheck.image = UIImage(named:"icons8-Unchecked Circle-50")
                male = true
            }
        }
        genderTypeID = 30
        print(genderTypeID)
        signUpTableView.reloadRows(at: [indexPath], with: .fade)
    }


//MARK: -    Back Left Button Tapped

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


//MARK: -    submit Button Clicked

    @IBAction func submitButtonClicked(_ sender: Any) {
        
        if(appDelegate.checkInternetConnectivity()){
            
            if self.validateAllFields()
            {
            signeUpAPIService()
            }
        }
        else {
            self.appDelegate.window?.makeToast(kNetworkStatusMessage, duration:kToastDuration, position:CSToastPositionCenter)
            return
        }
        print("Submit Button Clicked......")
    }

//MARK:- validateAllFields
    
    func validateAllFields() -> Bool {
        var errorMessage:NSString?
        let firstNameStr:NSString = firstName as NSString
        let middleNameStr:NSString = middleName as NSString
        let lastnameStr:NSString =  lastName  as NSString
        let userNameStr:NSString = userName as NSString
        let emailIDStr:NSString = email as NSString
        let mobileNumberStr:NSString =  mobileNumber  as NSString
        let passWord:NSString = password   as NSString
        let confirmPassWord:NSString =  confirmpassword  as NSString
        let dataOfBirth : NSString = dateofBirth as NSString
        
        if (firstNameStr.length <= 2){
            alertTag = 0
            errorMessage=GlobalSupportingClass.blankFirstNameErrorMessage() as String as String as NSString?
        }
           
        else if (lastnameStr.length <= 0){
            alertTag = 2
            errorMessage=GlobalSupportingClass.blankLastNameErrorMessage() as String as String as NSString?
        }
            
        else if (userNameStr.length <= 2){
            alertTag = 3
            errorMessage=GlobalSupportingClass.blankUserNameErrorMessage() as String as String as NSString?
        }
        
        else  if (emailIDStr.length < 1) && (emailIDStr.length < 5) {
            alertTag = 4
            errorMessage=GlobalSupportingClass.blankEmailIDErrorMessage() as String as String as NSString?
        }
            
        else  if (emailIDStr.length > 1) && (emailIDStr.length < 5) {
            alertTag = 4
            errorMessage=GlobalSupportingClass.miniCharEmailIDErrorMessage() as String as String as NSString?
        }
            
        else  if (emailIDStr.length > 1) && (!GlobalSupportingClass.isValidEmail(emailIDStr as NSString))
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
            
        else if (passWord.length<=0) {
            alertTag = 6
            errorMessage=GlobalSupportingClass.blankPswdErrorMessage() as String as String as NSString?
        }
            
        else if(!GlobalSupportingClass.capitalOnly(password: passWord as String)) {
            errorMessage=GlobalSupportingClass.pswdnumberMessage() as String as String as NSString?
        }

        else if (passWord.length < 8) {
            alertTag = 6
            errorMessage=GlobalSupportingClass.pswdnumberMessage() as String as String as NSString?
        }
            
        else if(confirmPassWord.length<=0){
            alertTag = 7
            errorMessage=GlobalSupportingClass.blankConfirmPasswordErrorMessage() as String as String as NSString?
        }
            
        else if(!confirmPassWord.isEqual(to: passWord as String)){
            errorMessage=GlobalSupportingClass.passwordMissMatchErrorMessage() as String as String as NSString?
        }
            
        else if(confirmPassWord.length < 8){
            alertTag = 7
            errorMessage=GlobalSupportingClass.passwordMissMatchErrorMessage() as String as String as NSString?
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
            self.signUpTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
            if let cell = self.signUpTableView.cellForRow(at: indexPath) as? SignUPTableViewCell {
                
                cell.registrationTextfield.becomeFirstResponder()
            }
        });
        alert.addAction(action)
        ViewController.present(alert, animated: true, completion:nil)
    }

    
// MARK :- SigneUp API Service
    
    func signeUpAPIService(){

        let  strUrl = SIGNEUPURL
        let null = NSNull()
        let dictParams = [
            "Id": id,
            "UserId": userId,
            "FirstName": firstName,
            "MiddleName": middleName,
            "LastName": lastName,
            "MobileNumber":mobileNumber,
            "UserName": userName,
            "Password": password,
            "RoleId": roleId,
            "Email": email,
            "IsActive": isActive,
            "CreatedByUserId": null,
            "CreatedDate": createdDate,
            "UpdatedByUserId": null,
            "UpdatedDate": updatedDate,
            "GenderTypeId" : "",
            "DOB" : "" ,
            "FileLocation" : null,
            "FileName" : null,
           "FileExtention" : ".jpg",
            "ImageString" : null,
            "Description" : null,
            "DeviceId" : null
       ] as [String : Any]
        
        print("dic params \(dictParams)")
        let dictHeaders = ["":"","":""] as NSDictionary
        print("dictHeader:\(dictHeaders)")

        serviceController.postRequest(strURL: strUrl as NSString, postParams: dictParams as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
            DispatchQueue.main.async()
                {
                    
            print("result:\(result)")
            let respVO:RegisterResultVo = Mapper().map(JSONObject: result)!
            print("responseString = \(respVO)")
            let statusCode = respVO.isSuccess
            print("StatusCode:\(String(describing: statusCode))")
                    
            if statusCode == true {
                let successMsg = respVO.endUserMessage
                self.utillites.alertWithOkButtonAction(vc: self, alertTitle: "Success".localize(), messege: successMsg!, clickAction: {
                        let signUpVc  : LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        signUpVc.showNav = true
                        self.navigationController?.pushViewController(signUpVc, animated: true)
                })
    }
            else {
                    let failMsg = respVO.endUserMessage
                    self.showAlertViewWithTitle("Alert".localize(), message: failMsg!, buttonTitle: "Ok".localize())
                    return
                }
            }
        }, failureHandler: {(error) in
        })
    }
    
// MARK :- login Clicked
  
    @IBAction func loginClicked(_ sender: Any) {
        
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        loginViewController.showNav = true
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
}

