//
//  AddNewAddressViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 05/06/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AddNewAddressViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var addNewAddressTableView: UITableView!
    
    var showNav = false
    var isFromEdit = false
    var userId :  Int = 0
    
    var fullName:String = ""
    var flatNo:String = ""
    var area:String = ""
    var pincode:String = ""
    var landmark:String = ""
    
    var mobileNumber  : String = ""
    var state  : String = ""
    var country  : String = ""
    
    var isActive:Bool = true
    var createdByUserId:Int = 1
    var createdDate : String = "2018-06-05"
    var updatedByUserId : Int = 1
    var updatedDate:String =  "2018-06-05"
    
    var stateID : Int = 1
    var countryID : Int = 1
    
     var alertTag = Int()
    
    var selectedData : String = ""
    
      var selectNameType : Array = Array<String>()
    
    var pickerData = Array<String>()

    var myPickerView: UIPickerView!
    
    var stateDetails : [String] = Array<String>()
    
    var countryDetails : [String] = Array<String>()
    
    var stateInfoDetails : [StateInfoResultVO] = Array<StateInfoResultVO>()
    
    var countryInfoDetails : [CountryInfoResultVO] = Array<CountryInfoResultVO>()
    
     var filtered:[UpdatedeliveryAddressInfoResultVO] = Array<UpdatedeliveryAddressInfoResultVO>()
    
     var addressInfo:[EditAddressInfoResultVO] = Array<EditAddressInfoResultVO>()
    
    var addressTFPlaceholdersArray = ["FullName".localize(),"Flat,House No,Building,Company,Apartment".localize(),"Area,Colony,Street,Sector,Village".localize(),"PinCode".localize(),"Landmark".localize()]

    
 var activeTextField = UITextField()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let nibName1  = UINib(nibName: "AddnewAddressTableViewCell" , bundle: nil)
        addNewAddressTableView.register(nibName1, forCellReuseIdentifier: "AddnewAddressTableViewCell")
        
        let nibName2  = UINib(nibName: "statecountryTableViewCell" , bundle: nil)
        addNewAddressTableView.register(nibName2, forCellReuseIdentifier: "statecountryTableViewCell")
        
        addNewAddressTableView.dataSource = self
        addNewAddressTableView.delegate = self
        activeTextField.delegate = self
        
        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            
            userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
            
        }
    
        getallstateAPICall()

        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Address".localize(), backTitle: " " , rightImage: "home icon", secondRightImage: "Up", thirdRightImage: "Up")
        
        
        
    }
    
    
    
    //MARK:- textField Should End Editing
    
    
    
    
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
            
            textField.maxLengthTextField = 10
            textField.clearButtonMode = .never
            textField.keyboardType = .numberPad
        }
            
        else if activeTextField.tag == 4{
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .default
            
        }
        
        
        else if activeTextField.tag == 5{
           
             //for states
            
                self.pickerUp(textField)
                pickerData = stateDetails
                myPickerView.reloadAllComponents()
                myPickerView.selectRow(0, inComponent: 0, animated: false)
            
            
           
                
            }
        
        else if activeTextField.tag == 6{
            
            //for states
            
            self.pickerUp(textField)
            pickerData = countryDetails
            myPickerView.reloadAllComponents()
            myPickerView.selectRow(0, inComponent: 0, animated: false)
            
            
        }
        
        else if activeTextField.tag == 7{
            
            textField.maxLengthTextField = 10
            textField.clearButtonMode = .never
            textField.keyboardType = .phonePad
        
        }
    
    }
    //MARK:- textField Should Should End Editing
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        
        if let newRegCell : SignUPTableViewCell = textField.superview?.superview as? SignUPTableViewCell {
            
            
            
        }
        return true
    }
    
    
    
    
    //MARK:- textField Did End Editing
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        activeTextField = textField
        
        
        if activeTextField.tag == 0{
            
            fullName = textField.text!
            
        }
        else if activeTextField.tag == 1{
            
            flatNo = textField.text!
            
        }
        else if activeTextField.tag == 2{
            
            area = textField.text!
            
        }
        else if activeTextField.tag == 3{
            
            pincode = textField.text!
            
        }
            
        else if activeTextField.tag == 4 {
            
            landmark = textField.text!
            
        }
        
        
        else if activeTextField.tag == 5 {
            
           // state = textField.text!
            
        }
        
        else if activeTextField.tag == 6 {
            
            //country = textField.text!
            
        }
        else if activeTextField.tag == 7 {
            
            mobileNumber = textField.text!
            
        }
        
    }
    
  
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return addressTFPlaceholdersArray.count
        }
            
        else if section == 1 {
            
            
            return 1
            
        }
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0 {
        
                
                return 124
            }
            
        else if indexPath.section == 1{
            
            return UITableViewAutomaticDimension
        }
        

        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableViewAutomaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddnewAddressTableViewCell", for: indexPath) as! AddnewAddressTableViewCell
        
        
        cell.addNewAddressTF.delegate = self
        
        cell.addNewAddressTF.tag = indexPath.row
        
       
        
        
        if indexPath.row == 0{
            
            cell.addNewAddressTF.placeholder = "Full Name".localize()
            cell.addNewAddressTF.text = fullName
           
            
            
        }
        else if indexPath.row == 1{
            
            cell.addNewAddressTF.placeholder = "Flat,House No,Building,Company,Apartment".localize()
            cell.addNewAddressTF.text = flatNo
            
            
            
            
        }
        else if indexPath.row == 2{
            
            cell.addNewAddressTF.placeholder = "Area,Colony,Street,Sector,Village".localize()
            cell.addNewAddressTF.text = area
            
            
            
            
        }
            
        else if indexPath.row == 3{
            
            cell.addNewAddressTF.placeholder = "Pin Code".localize()
            cell.addNewAddressTF.text = pincode
          
            
            
            
        }
            
        else if indexPath.row == 4{
            
            cell.addNewAddressTF.text = landmark
            cell.addNewAddressTF.placeholder = "Landmark".localize()
           
            
            
            
        }
            
         return cell
            
        }
        
     else   if (indexPath.section == 1) {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "statecountryTableViewCell", for: indexPath) as! statecountryTableViewCell
            
            
           
            
          
                cell.stateTF.placeholder = "State".localize()
                cell.stateTF.text = state
                cell.stateTF.tag = 5
                cell.stateTF.delegate = self
                
                cell.countryTF.placeholder = "Country".localize()
                cell.countryTF.text = country
                cell.countryTF.tag = 6
                cell.countryTF.delegate = self

                
        
                
                cell.mobileNoTF.placeholder = "Mobile Number".localize()
                cell.mobileNoTF.text = mobileNumber
                cell.mobileNoTF.tag = 7
                cell.mobileNoTF.delegate = self
                
                
                
            

            return cell
            
            
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
    
    
    func done() {
        
        if(activeTextField.tag == 5){
            
            for eachDetail in stateInfoDetails{
                if(selectedData == eachDetail.name!){
                    let stateID = eachDetail.id!
                }
            }
            
            state = selectedData

        }
        else if(activeTextField.tag == 6){
            for eachDetail in countryInfoDetails{
                if(selectedData == eachDetail.name!){
                    let countryID = eachDetail.id!
                }
            }
                country = selectedData
            
        }
        activeTextField.resignFirstResponder()
        addNewAddressTableView.endEditing(true)
    addNewAddressTableView.reloadData()
        
    }
    
    //MARK:- cancel Clicked
    
    func cancel(){
        
        activeTextField.resignFirstResponder()
        addNewAddressTableView.endEditing(true)
        
    }
    
    func pickerUp(_ textField : UITextField){
        
        // UIPickerView
        
        if(self.myPickerView == nil){
            self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        }
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        self.myPickerView.tag = textField.tag
        textField.inputView = self.myPickerView
        
        // ToolBar
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerData.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedData = pickerData[row]
    }

    func getallstateAPICall() {
        
           serviceController.getRequest(strURL: GETSTATESAPI , success: { (result) in
            
            self.getallCountryAPICall()
            
            let respVO:StateInfoVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            
            
            if isSuccess == true {
                
                let listArr = respVO.listResult!
                self.stateInfoDetails = respVO.listResult!
                
                for eachArray in listArr{
                    
                    self.stateDetails.append(eachArray.name!)
                    
                   
                    
                }
                
                self.addNewAddressTableView.reloadData()
                
            }
            else {
                
                
                
            }
            
           }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }

            
            
    }

    func getallCountryAPICall() {
        
        serviceController.getRequest(strURL: GETCOUNTRYSAPI , success: { (result) in
            
            
            let respVO:CountryInfoVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            
            
            if isSuccess == true {
                
                let listArr = respVO.listResult!
                 self.countryInfoDetails = respVO.listResult!
                
                for eachArray in listArr{
                    
                    self.countryDetails.append(eachArray.name!)
                    
                    if(self.country == eachArray.name!){
                        let countryID = eachArray.id!
                        
                    }
                    
                }
                if(self.isFromEdit == true){
                    self.readDataSource()
                }
                self.addNewAddressTableView.reloadData()
                
            }
            else {
                
                
                
            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
    }
    
    func saveaddressAPICall(){
        
        let paramsDict = [ 	"id": 0,
                           	"fullName": fullName,
                           	"mobileNumber": mobileNumber,
                           	"addressLine1": flatNo,
                           	"addressLine2": area,
                           	"pinCode": pincode,
                           	"userId": userId,
                           	"landmark": landmark,
                           	"stateId": stateID,
                           	"countryId": countryID,
                           	"isActive": isActive,
                           	"createdByUserId": userId,
                           	"createdDate": createdDate,
                           	"updatedByUserId": userId,
                           	"updatedDate": updatedDate
            
            ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: GETALLADDRESSAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            let respVO:UpdatedeliveryAddressInfoVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            
            
            if isSuccess == true {
                
                let listArr = respVO.listResult!
                
                for eachArray in listArr{
                    self.filtered.append(eachArray)
                }
                
                self.addNewAddressTableView.reloadData()
                
            }
                
            else {
                
                
                
            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
    }
    
    
    
    
 
    

    
    @IBAction func saveAction(_ sender: Any) {
        addNewAddressTableView.endEditing(true)
        if(appDelegate.checkInternetConnectivity()){
            
            if self.validateAllFields()
            {
                
                
                saveaddressAPICall()
            }
        }
               
        print("Submit Button Clicked......")
        

        
   
        
    }
    
func readDataSource(){
        
        if(addressInfo.count > 0){
            
            let model = addressInfo[0]
            fullName = model.fullName!
            flatNo = model.addressLine1!
            area = model.addressLine2!
            pincode = "\(model.pinCode!)"
            landmark = model.landmark!
            state = model.stateName!
            country = model.countryName!
            mobileNumber = model.mobileNumber!
            
            
            
        }
    }
    

    //MARK:- validateAllFields
    
    func validateAllFields() -> Bool
    {
        
        var errorMessage:NSString?
        let fullNameStr:NSString = fullName as NSString
        let flatNoStr:NSString = flatNo as NSString
        let areaStr:NSString =  area  as NSString
        
        let pincodeStr:NSString = pincode as NSString
        let landmarkStr:NSString = landmark as NSString
       
        let stateStr:NSString = state   as NSString
        let countryStr:NSString =  country  as NSString
         let mobileNumberStr:NSString =  mobileNumber  as NSString
        
        
        if (fullNameStr.length <= 2){
            
      
            
            errorMessage=GlobalSupportingClass.blankFullNameErrorMessage() as String as String as NSString?
            
        }
            
        else if (flatNoStr.length <= 0){
            
      
            
            errorMessage=GlobalSupportingClass.blankFlatnoErrorMessage() as String as String as NSString?
            
        }
            
        else if (areaStr.length <= 2){
            
        
            
            errorMessage=GlobalSupportingClass.blankAreaErrorMessage() as String as String as NSString?
            
        }
            
            
        else if (pincodeStr.length <= 0){
            
         
            
            errorMessage=GlobalSupportingClass.blankPinCodeErrorMessage() as String as String as NSString?
            
        }
            
        else if (landmarkStr.length <= 2){
            
      
            
            errorMessage=GlobalSupportingClass.blankLandmarkErrorMessage() as String as String as NSString?
            
        }
        else if (stateStr.length <= 0){
            
          
            
            errorMessage=GlobalSupportingClass.blankStateErrorMessage() as String as String as NSString?
            
        }
            
        else if (countryStr.length <= 0){
            
        
            
            errorMessage=GlobalSupportingClass.blankCountryErrorMessage() as String as String as NSString?
            
        }
            
            
            
        else if (mobileNumberStr.length <= 0){
      
            
            
            errorMessage=GlobalSupportingClass.blankMobilenumberErrorMessage() as String as String as NSString?
            
        }
        else if (mobileNumberStr.length <= 9) {
         
            
            
            errorMessage=GlobalSupportingClass.invalidMobilenumberErrorMessage() as String as String as NSString?
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
            
            self.addNewAddressTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
            if let cell = self.addNewAddressTableView.cellForRow(at: indexPath) as? SignUPTableViewCell {
                
                cell.registrationTextfield.becomeFirstResponder()
            }
            
            
        });
        alert.addAction(action)
        ViewController.present(alert, animated: true, completion:nil)
    }
    
   
    
    
    

}