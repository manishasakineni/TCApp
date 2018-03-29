//
//  ProfileViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/2/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var appVersion          : String = ""
    
    var selectedDate : String = ""
    
    var base64String : String = ""
    
    var alertTag = Int()

    var showNav = false
    let isActive : Bool = true
    
    let dateFormatter = DateFormatter()
    
    
    
    @IBOutlet weak var editProfileTableView: UITableView!
    
    
    
    let utillites =  Utilities()
    
    
    var linksA = [String]()
    
    var streamLink : String!
    
    var first : String!
    
    var secend : String!
    

    
    
    
    var placeholdersAry  = ["FirstName".localize(),"MiddleName".localize(),"LastName".localize(),"Mobile Number".localize(),"E-mail".localize(),"Dob".localize()]
    
    var firstName   : String = ""
    var middleName  : String = ""
    var lastName    : String = ""
    var mobileNumber    : String = ""
    var email       : String = ""
    var DOB       : String = ""
    
    var loginid      : Int = 0
    var password       : String = ""
    
    var activeTextField = UITextField()
    
    let picker = UIImagePickerController()
    
    var isImageSave:Bool = false
    var sectionsTitle : [String] = [""]
    
    var imgVW = UIImageView()
    
    var profileimage:UIImage = UIImage()
    
    var imageString = String()
    var pickerData : Array<String> = Array()
    
    var selectedtitleTypeStr  = ""
    var titletypeIdAry = Array<String>()
    var titleTypeID    : Int    = 0
    
    let datepicker = UIDatePicker()
    var dateofBirth:String = ""
    var gender : String = ""
    var male = true
    var female = false
    var genderTypeID:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let myURLString = "https://drive.google.com/open?id=1KXYJ4Q4EgWM17GAp1jQjIJZmvNmBWIzz"
        
        if let myURL = NSURL(string: myURLString) {
            
            do {
                let myHTMLString = try String(contentsOf:(myURL as NSURL) as URL, encoding: .utf8)
                
                let t = myHTMLString
                
                if let rangeOfZero = t.range(of: "[\"fmt_stream_map\"", options: NSString.CompareOptions.backwards, range: nil, locale: nil) {
                
                    
//                rangeOfString("[\"fmt_stream_map\"", options: NSString.CompareOptions.BackwardsSearch) {
                
                    let suffix = String(t.characters.suffix(from: rangeOfZero.lowerBound))
                        
//                        characters.suffixFrom(rangeOfZero.endIndex))
                    
                    first = suffix
                    
                    //  print(suffix)
                    if let rangeOne = first.range(of: ",[\"fmt_list\"", options: NSString.CompareOptions.backwards, range: nil, locale: nil) {
                        
//                        .rangeOfString(",[\"fmt_list\"", options: NSString.CompareOptions.BackwardsSearch) {
                        let endffix = String(first.characters.prefix(upTo: rangeOne.lowerBound))
                            
//                            characters.prefixUpTo(rangeOne.startIndex))
                        
                        
                        
                        let v = endffix.replacingOccurrences(of: "\"", with: "")
                        
//                        stringByReplacingOccurrencesOfString("\"", withString: "")
                        
                        let x = v.replacingOccurrences(of: "]", with: "")
                        
//                        stringByReplacingOccurrencesOfString("]", withString: "")
                        
                        
                        secend = x
                        
                        print(x)
                        
                    }
                    
                    theLink()
                    
                } else {
                    print("noooo")
                }
            } catch {
                print("Error : \(error)")
            }
        } else {
            print("Error: \(myURLString) doesn't  URL")
        }
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        let nibName  = UINib(nibName: "EditProfileTableViewCell" , bundle: nil)
        editProfileTableView.register(nibName, forCellReuseIdentifier: "EditProfileTableViewCell")
        
        let nibName1  = UINib(nibName: "menuTableViewCell" , bundle: nil)
        editProfileTableView.register(nibName1, forCellReuseIdentifier: "menuTableViewCell")
        
        let nibName2  = UINib(nibName: "HeaderProfileCell" , bundle: nil)
        editProfileTableView.register(nibName2, forCellReuseIdentifier: "HeaderProfileCell")
        
        
        
        self.loginid = UserDefaults.standard.value(forKey: kLoginId) as! Int
        
        UserDefaults.standard.synchronize()
        
        print(self.loginid)
        
        
        editProfileTableView.dataSource = self
        editProfileTableView.delegate = self
        activeTextField.delegate = self
        
        getProfileInfoAPIService()
        
        //   CreatedatePicker()
        
        
        
    }
    
    
    func getProfileInfoAPIService(){
        
        if(appDelegate.checkInternetConnectivity()){
            
            
            
            let strUrl = PROFILEGETINFO + "" +  "\(loginid)"
            
            
            serviceController.getRequest(strURL:strUrl, success:{(result) in
                DispatchQueue.main.async()
                    {
                        
                        //  let respVO:LoginVo = Mapper().map(JSONObject: result)!
                        
                        print("result:\(result)")
                        
                        let respVO:GetProfileResultInfoVO = Mapper().map(JSONObject: result)!
                        
                        print("responseString = \(respVO)")
                        
                        let listArr = respVO.listResult
                        
                        if (listArr?.count)! > 0 {
                            
                            let statusCode = respVO.isSuccess
                            
                            print("StatusCode:\(String(describing: statusCode))")
                            
                            self.firstName = (respVO.listResult?[0].FirstName)!
                            self.middleName = (respVO.listResult?[0].MiddleName)!
                            self.lastName = (respVO.listResult?[0].Lastname)!
                            self.mobileNumber = (respVO.listResult?[0].MobileNumber)!
                            self.email = (respVO.listResult?[0].Email)!
                            
                            var userImgURL : String = ""
                            userImgURL = (respVO.listResult?[0].userImage == nil ? "" : respVO.listResult?[0].userImage)!
                            
                            
                            let newString = userImgURL.replacingOccurrences(of: "\\", with: "/", options: .backwards, range: nil)
                            
                            if newString != "" {
                                
                                
                                let url = URL(string:newString)
                                
                                if let data = try? Data(contentsOf: url!)
                                {
                                    let image: UIImage = UIImage(data: data)!
                                }
                                
                                let dataImg = try? Data(contentsOf: url!)
                                
                                if dataImg != nil {
                                    
                                    self.profileimage = UIImage(data: dataImg!)!
                                }
                                else {
                                    
                                    self.profileimage = #imageLiteral(resourceName: "churchLogoo")
                                }
                            }
                            else {
                                
                                self.profileimage = #imageLiteral(resourceName: "churchLogoo")
                            }
                            
                            self.dateofBirth = (respVO.listResult?[0].dob == nil ? "" : respVO.listResult?[0].dob)!
                            
                            if self.dateofBirth != "" {
                                
                                self.selectedDate = self.formattedDateFromString(dateString: self.dateofBirth, withFormat: "MMM dd, yyyy")!
                            }
                            
                            
                            
                            //                        let fff = (IDInfo?.DOB)!
                            //
                            //                        let stringB = self.formattedDateFromString(dateString: fff, withFormat: "MMM dd, yyyy")
                            //
                            //                        if stringB != nil {
                            //
                            //                            self.selectedDOBStr = stringB!
                            //
                            //                        }
                            
                            
                            if let gender = respVO.listResult?[0].genderTypeId {
                                self.genderTypeID = (gender)
                            }
                            else{
                                self.genderTypeID = 0
                            }
                            
                            
                            self.editProfileTableView.reloadData()
                            
                            if statusCode == true
                            {
                                
                                
                                let successMsg = respVO.endUserMessage
                                
                                
                                
                                let signUpVc  : LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                                
                                
                            }
                            else {
                                
                                let failMsg = respVO.endUserMessage
                                
                                self.showAlertViewWithTitle("Alert".localize(), message: failMsg!, buttonTitle: "Ok".localize())
                                
                                return
                                
                            }
                        }
                        
                        
                        
                        
                }
            }, failure:  {(error) in
                
                print(error)
                
                if(error == "unAuthorized"){
                    
                    
                    self.showAlertViewWithTitle("Alert".localize(), message: error, buttonTitle: "Ok".localize())
                    
                    
                }
                
                
                
            })
            
        }
        else {
            
      //      appDelegate.window?.makeToast(kNetworkStatusMessage, duration:kToastDuration, position:CSToastPositionCenter)
            return
        }
        
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
      //  let inputFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let date = dateFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        
        print(showNav)
        
        self.navigationController?.navigationBar.isHidden = false
        
        
        Utilities.setProfileViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Edit Profile".localize(), backTitle: " Edit Profile".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
    }
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        activeTextField = textField
        
        
        
        if activeTextField.tag == 0 {
            
            textField.maxLengthTextField = 20
            textField.clearButtonMode = .never
            textField.keyboardType = .alphabet
    
        }
            
        else if activeTextField.tag == 1{
            
            textField.maxLengthTextField = 20
            textField.clearButtonMode = .never
            textField.keyboardType = .alphabet
            
        }
            
        else if activeTextField.tag == 2{
            
            textField.maxLengthTextField = 20
            textField.clearButtonMode = .never
            textField.keyboardType = .default
            
        }
        else if activeTextField.tag == 3{
            
            textField.maxLengthTextField = 10
            textField.clearButtonMode = .never
            textField.keyboardType = .numberPad
            
        }
        else if activeTextField.tag == 4{
            
            textField.maxLengthTextField = 40
            textField.clearButtonMode = .never
            textField.keyboardType = .emailAddress
            
        }
        else if activeTextField.tag == 5{
            
            textField.inputView = datepicker
            
            textField.clearButtonMode = .never
            textField.inputView = datepicker
            
            let todayDate = NSDate()
            self.datepicker.maximumDate = todayDate as Date
            datepicker.datePickerMode = .date
            let toolBar = UIToolbar()
            toolBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
            
            toolBar.setItems([doneButton], animated: true)
            
            textField.inputAccessoryView = toolBar
            
            activeTextField.text = selectedDate
            
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
                return newLength <= 50 && unwantedStr.characters.count == 0
            }
            
        }
        
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if let newRegCell : EditProfileTableViewCell = textField.superview?.superview as? EditProfileTableViewCell {
            
            
            
        }
        return true
    }
    
    
    
    //MARK:- textFieldDidEndEditing
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        activeTextField = textField
        
        
        if activeTextField.tag == 0{
            
            firstName = textField.text!
            
        }
            
        else if activeTextField.tag == 1 {
            
            middleName = textField.text!
            
        }
            
        else if activeTextField.tag == 2{
            
            lastName = textField.text!
            
        }
        else if activeTextField.tag == 3{
            
            mobileNumber = textField.text!
            
            
        }
            
        else if activeTextField.tag == 4{
            
            
            email = textField.text!
            
            
        }
        else if activeTextField.tag == 5{
            
            
            // DOB = textField.text!
            DOB = textField.text!
            
            
        }
        
        
        
    }
    
    func CreatedatePicker(){
        
        datepicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebutton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: "donedatePicker")
        
        toolbar.setItems([doneButton], animated: false)
        
        activeTextField.inputAccessoryView = toolbar
        
        activeTextField.inputView = datepicker
        
        
        
    }
    
    //    func donepresseed(){
    //
    //
    //        //For date formate
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "dd/MM/yyyy"
    //        activeTextField.text = formatter.string(from: datepicker.date)
    //        print(activeTextField.text)
    //        //dismiss date picker dialog
    //        self.view.endEditing(true)
    //
    //
    //
    //       //// activeTextField.text = "\(datepicker.date)"
    //       // self.view.endEditing(true)
    //
    //
    //    }
    
    
    
    
    
    //MARK:- UITableView Delegate & DataSource
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        return 7
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitle[section]
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.section == 0 {
            
            let profileCell = tableView.dequeueReusableCell(withIdentifier: "menuTableViewCell", for: indexPath) as! menuTableViewCell
            
            profileCell.selectionStyle = .none
            
            if indexPath.row == 0{
                
                profileCell.cameraOutLet.addTarget(self, action: #selector(self.editBtnClicked), for: .touchDown)
                
                
                profileCell.progileImageView.layer.cornerRadius = profileCell.progileImageView.frame.size.height/2;
                
                profileCell.progileImageView.layer.borderColor = UIColor.gray.cgColor
                profileCell.progileImageView.layer.borderWidth = 1
                profileCell.progileImageView.clipsToBounds = true
                
                profileCell.progileImageView.image = profileimage
                
                
                
            }
            
            return profileCell
            
        } else{
            
            
            
            let signUPCell = tableView.dequeueReusableCell(withIdentifier: "EditProfileTableViewCell", for: indexPath) as! EditProfileTableViewCell
            
            signUPCell.editProfileTF.delegate = self
            
            signUPCell.editProfileTF.tag = indexPath.row
            
            
            
            
            if indexPath.row == 0{
                
                signUPCell.editProfileTF.placeholder = "First Name".localize()
                signUPCell.editProfileTF.text = self.firstName
                
                
            }
                
            else if indexPath.row == 1{
                
                
                signUPCell.editProfileTF.placeholder = "Middle Name".localize()
                signUPCell.editProfileTF.text = self.middleName
                
                
                
            }
            else if indexPath.row == 2{
                
                
                signUPCell.editProfileTF.placeholder = "Last Name".localize()
                signUPCell.editProfileTF.text = self.lastName
                
                
                
            }
            else if indexPath.row == 3{
                
                signUPCell.editProfileTF.placeholder = "Mobile Number".localize()
                signUPCell.editProfileTF.isUserInteractionEnabled = false
                signUPCell.editProfileTF.textColor = UIColor.lightGray
                signUPCell.editProfileTF.text = self.mobileNumber
                
                
                
            }
                
            else if indexPath.row == 4{
                
                signUPCell.editProfileTF.placeholder = "E-mail".localize()
                signUPCell.editProfileTF.text = self.email
                
                
            }
                
            else if indexPath.row == 5{
                
                signUPCell.editProfileTF.placeholder = "Date Of Birth".localize()
                signUPCell.editProfileTF.text = selectedDate
                
                
            }
                
            else if indexPath.row == 6{
                
                let signUPCell = Bundle.main.loadNibNamed("GenderTableViewCell", owner: self, options: nil)?.first as! GenderTableViewCell
                
                
//signUPCell.genderLabel.placeholder = "Gender".localize()

                signUPCell.selectionStyle = .none
                signUPCell.femaleUnCheck.tintColor = #colorLiteral(red: 0.5568627451, green: 0.1254901961, blue: 0.1647058824, alpha: 1)
                signUPCell.maleUnCheckBtn.tintColor = #colorLiteral(red: 0.5568627451, green: 0.1254901961, blue: 0.1647058824, alpha: 1)
                
                if genderTypeID == 2 {
                    
                    signUPCell.femaleUnCheck.image = UIImage(named:"checked_83366")
                    
                    signUPCell.maleUnCheckBtn.image = UIImage(named:"icons8-Unchecked Circle-50")
                    
                }
                else {
                    
                    
                    signUPCell.maleUnCheckBtn.image = UIImage(named:"checked_83366")
                    
                    signUPCell.femaleUnCheck.image = UIImage(named:"icons8-Unchecked Circle-50")
                }
                
                signUPCell.maleBtn.addTarget(self, action: #selector(self.maleBtnClicked), for: .touchUpInside)
                
                signUPCell.maleBtn.tag = 1
                
                
                signUPCell.femaleBtn.addTarget(self, action: #selector(self.femaleBtnClicked), for: .touchUpInside)
                
                signUPCell.femaleBtn.tag = 2
                
                
                
                return signUPCell
                
            }
            
            
            
            
            return signUPCell
        }
        
    }
    
    
    func editBtnClicked(_ sender: UIButton?)  {
        
        print("I Clicked a button")
        
        
        let alert:UIAlertController=UIAlertController(title: "ChoosemenuImgView", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "FromCamera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "FromGallery", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        // Present the controller
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        dismiss(animated: true, completion: nil)
        profileimage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        
        print(profileimage)
        
        let resizeImg = resizeImage(image: profileimage, newWidth: 150)
        
       var imageData = UIImagePNGRepresentation(resizeImg)
        var imageUIImage: UIImage = UIImage(data: imageData!)!
        
        print(imageUIImage)
   // let base64String = imageData.base64EncodedStringWithOptions(NSData.Base64EncodingOptions.fromRaw(0)!)
        
        base64String = (imageData?.base64EncodedString())!
        
        print(base64String)
        
        
        editProfileTableView.reloadData()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        if section == 1 {
            
            let headerProfileCell = tableView.dequeueReusableCell(withIdentifier: "HeaderProfileCell") as! HeaderProfileCell
            
            
            return headerProfileCell
            
        }
        return nil
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return 0.0
        }
        
        return 44.0
        
    }
    
    
    func saveProfileAPICall(){
        
        
        let  updateProfileAPI : String = EDITPROFILEURL
    
        
        let null = NSNull()
        
        let updateProfiledictParams = [
            
            "imageString": base64String,
            "id": self.loginid,
            "userId":null,
            "firstName": self.firstName,
            "lastname": self.lastName,
            "middleName": self.middleName,
            "mobileNumber": self.mobileNumber,
            "genderTypeId": self.genderTypeID,
            "dob": self.dateofBirth,
            "userName": null,
            "password": null,
            "roleId": 1,
            "email": self.email,
            "fileLocation": null,
            "fileName": null,
            "fileExtention": ".jpg",
            "isActive": true,
            "createdByUserId": 1,
            "createdDate": "2018-03-05",
            "updatedByUserId": 1,
            "updatedDate": "2018-03-05"
            
            
            ] as [String : Any]
        
        print(updateProfiledictParams)
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: updateProfileAPI as NSString, postParams: updateProfiledictParams as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            DispatchQueue.main.async()
                {
                    
                    print("result:\(result)")
                    
                    let respVO:RegisterResultVo = Mapper().map(JSONObject: result)!
                    
                    
                    print("responseString = \(respVO)")
                    
                    
                    let statusCode = respVO.isSuccess
                    
                    print("StatusCode:\(String(describing: statusCode))")
                    
                    
                    
                    if statusCode == true
                    {
                        
                        
                        let successMsg = respVO.endUserMessage
                        
                        
                        
                        
                        self.editProfileTableView.reloadData()
                        
                        
                        self.utillites.alertWithOkButtonAction(vc: self, alertTitle: "Success", messege: successMsg!, clickAction: {
                            
                            let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                            
                            self.appDelegate.window?.rootViewController = rootController
                            
                        })
                        
                        
                    }
                    else {
                        
                        let failMsg = respVO.endUserMessage
                        
                        self.showAlertViewWithTitle("Alert", message: failMsg!, buttonTitle: "Ok")
                        
                        return
                        
                    }
                    
                    
                    
                    
            }
            
        }, failureHandler: {(error) in
            
            
            
            
            
        })
        
    }
    
    
    
    
    
    @IBAction func saveBtnAction(_ sender: Any) {
        
        //https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
        
//         print(streamLink)
//        
//        let videoURL = URL(string: streamLink)
//        let player = AVPlayer(url: videoURL!)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        self.present(playerViewController, animated: true) {
//            playerViewController.player!.play()
//        }
        
        if self.validateAllFields()
        {
            
            saveProfileAPICall()
            
        }
        else {
            
            print("biscute Code")
            
            return
            
        }
        
        print("Submit Button Clicked......")
        
        
    }
    
  

func theLink() {
    
    
    /// /[u]00../g
    
    
    //   let firstElement = linksA.first
    
    let firstElement = secend
    
    let t = firstElement!.replacingOccurrences(of: ",35", with: "")
    
//    stringByReplacingOccurrencesOfString(",35", withString: "")
    
    let deUrl = t.characters.split{$0 == "|"}.map(String.init)
    
    let link = deUrl[1]
    
    // let link = deUrl[0] for high
    // let link = deUrl[2] for low
    
    // the link needs to be decoded
    
    let i = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
    
//    cString(using: .utf8)
    
//    stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    
    
    let p = i!.replacingOccurrences(of: "%5Cu", with: "")
    
//    stringByReplacingOccurrencesOfString("%5Cu", withString: "")
    
    
    // you can see how the link should look like here :
    // http://ddecode.com/hexdecoder/?results=d82d4e564eccc1a6b96ee7c5c1e1c3b2
    
    // %252C : ,
    // 003d : =
    // 0026 : &
    
//    let re = i.replacingOccurrences(of: ",35", with: "")
    
//    stringByReplacingOccurrencesOfString("003d", withString: "=")
    
    let w =  p.replacingOccurrences(of: "0026", with: "&")
    
//    stringByReplacingOccurrencesOfString("0026", withString: "&")
    
    let c = w.replacingOccurrences(of: "%252C", with: ",")
    
//    stringByReplacingOccurrencesOfString("%252C", withString: ",")
    
    print(c)
    
    let r = c
    
    streamLink = r
    
    
}

    //MARK:- validateAllFields

    func validateAllFields() -> Bool
    {
        
        var errorMessage:NSString?
        
        let firstName:NSString = self.firstName   as NSString
        
        let middleName:NSString =  self.middleName  as NSString
        
        let lastName:NSString =  self.lastName  as NSString
        
        let mobileNumber:NSString =  self.mobileNumber  as NSString
        
        let emailID:NSString = self.email as NSString
        
//        let dateOfbirth:NSString = self.DOB as NSString
//        let gender:NSString = self.gender as NSString
//
//        
        
        
        
        if (firstName.length <= 2){
            
            alertTag = 0

            errorMessage=GlobalSupportingClass.blankFirstNameErrorMessage() as String as String as NSString?
            
        }
            
            //        else if (middleName.length<=2) {
            //            errorMessage=GlobalSupportingClass.blankMiddleNameErrorMessage() as String as String as NSString?
            //        }
        else  if (lastName.length <= 0){
            
            alertTag = 2

            errorMessage=GlobalSupportingClass.blankLastNameErrorMessage() as String as String as NSString?
            
        }
            //        else if (mobileNumber.length <= 0){
            //
            //            errorMessage=GlobalSupportingClass.blankMobileNumberErrorMessage() as String as String as NSString?
            //
            //        }
            //        else if (mobileNumber.length <= 9) {
            //
            //            errorMessage=GlobalSupportingClass.invalidMobileNumberErrorMessage() as String as String as NSString?
            //        }
            
        else if (emailID.length<=0) {
            
            alertTag = 4

            errorMessage=GlobalSupportingClass.blankEmailIDErrorMessage() as String as String as NSString?
        }
            
        else  if (emailID.length<=4) {
            
            alertTag = 4

            errorMessage=GlobalSupportingClass.miniCharEmailIDErrorMessage() as String as String as NSString?
        }
        else  if(!GlobalSupportingClass.isValidEmail(emailID as NSString))
        {
            errorMessage=GlobalSupportingClass.invalidEmaildIDFormatErrorMessage() as String as String as NSString?
        }
        
        
        
//                else  if (dateOfbirth.length <= 2){
//            alertTag = 5
//
//                    errorMessage=GlobalSupportingClass.blankDOBErrorMessage() as String as String as NSString?
//        
//                }
//        else  if (dateOfbirth.length <= 2){
//            alertTag = 5
//            
//            errorMessage=GlobalSupportingClass.blankDOBErrorMessage() as String as String as NSString?
//            
//        }
        
        
        
        if let errorMsg = errorMessage{
            
            alertWithTitle(title: "Alert".localize(), message: errorMsg as String, ViewController: self, toFocus: activeTextField)

            
          //  self.showAlertViewWithTitle("Alert", message: errorMsg as String, buttonTitle: "Retry")
            return false;
        }
        return true
    }
    
    
    func alertWithTitle(title: String!, message: String, ViewController: UIViewController, toFocus:UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok".localize(), style: UIAlertActionStyle.cancel,handler: {_ in
            
            
            let indexPath : IndexPath = IndexPath(row: self.alertTag, section: 1)
            
            self.editProfileTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
            if let cell = self.editProfileTableView.cellForRow(at: indexPath) as? EditProfileTableViewCell {
                
                cell.editProfileTF.becomeFirstResponder()
            }
            
            
        });
        alert.addAction(action)
        // alert.view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ViewController.present(alert, animated: true, completion:nil)
    }

    
    
    func donePressed(){
        
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateofBirth = dateFormatter.string(from: datepicker.date)
        
      
        
        
        //  dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        selectedDate = dateFormatter.string(from: datepicker.date)
        print(selectedDate)
        
        print(dateofBirth)
        
        self.view.endEditing(true)
        
        editProfileTableView.reloadData()
    }
    
    func showAlertViewWithTitle(_ title:String,message:String,buttonTitle:String)
    {
        let alertView:UIAlertView = UIAlertView();
        alertView.title=title
        alertView.message=message
        alertView.addButton(withTitle: buttonTitle)
        alertView.show()
    }
    
    
    @IBAction func imgBtnAction(_ sender: Any) {
    }
    
    //MARK:- openCamera
    
    
    func openCamera() {
        picker.allowsEditing = true
        
        
        
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
        
        
    }
    
    //MARK:- openGallary
    
    
    func openGallary() {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    
    //MARK:- saveImage
    
    
    func saveImage (_ image: UIImage, path: String ) -> Bool{
        
        isImageSave = true
        
        let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        let result = (try? jpgImageData!.write(to: URL(fileURLWithPath: path), options: [.atomic])) != nil
        
        return result
    }
    
    
    
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        //   navigationItem.leftBarButtonItems = []
        
        
        
        UserDefaults.standard.set("1", forKey: "1")

        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.synchronize()
        
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        
        print("Back Button Clicked......")
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func maleBtnClicked(_ sender: UIButton) {
        
        
        let indexPath:IndexPath = IndexPath(row: 6, section: 1)
        
        
        if let cell : GenderTableViewCell = self.editProfileTableView.cellForRow(at: indexPath) as? GenderTableViewCell {
            
            if (male == true)
            {
                
                cell.maleUnCheckBtn.image = UIImage(named:"checked_83366")
                
                cell.femaleUnCheck.image = UIImage(named:"icons8-Unchecked Circle-50")
                
                male = false
                
            }
            else
            {
                cell.maleUnCheckBtn.image = UIImage(named:"icons8-Unchecked Circle-50")
                
                cell.femaleUnCheck.image = UIImage(named:"checked_83366")
                
                male = true
            }
            
        }
        
        genderTypeID = sender.tag
        
        print(genderTypeID)
        
        editProfileTableView.reloadRows(at: [indexPath], with: .fade)
        
        editProfileTableView.reloadData()
        
        
    }
    
    //MARK:- femaleBtnClicked
    
    
    func femaleBtnClicked(_ sender: UIButton){
        
        let indexPath:IndexPath = IndexPath(row: 6, section: 1)
        
        
        if let cell : GenderTableViewCell = self.editProfileTableView.cellForRow(at: indexPath) as? GenderTableViewCell {
            
            if (male == true)
            {
                
                cell.maleUnCheckBtn.image = UIImage(named:"icons8-Unchecked Circle-50")
                
                cell.femaleUnCheck.image = UIImage(named:"checked_83366")
                
                male = false
                
            }
            else
            {
                cell.maleUnCheckBtn.image = UIImage(named:"checked_83366")
                
                cell.femaleUnCheck.image = UIImage(named:"icons8-Unchecked Circle-50")
                
                male = true
            }
            
        }
        
        
        genderTypeID = sender.tag
        
        print(genderTypeID)
        
        
        editProfileTableView.reloadRows(at: [indexPath], with: .fade)
        
        editProfileTableView.reloadData()
        
    }
    
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        
        image.draw(in: CGRect(x: 0, y: 0,width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
}

