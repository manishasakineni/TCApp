//
//  ViewController.swift
//  SamplePageMenu
//
//  Created by Mac OS on 05/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import TextFieldEffects

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var mobileEmailTF: AkiraTextField!
    
    @IBOutlet weak var forgotPWDView: UIView!
    
    @IBOutlet weak var transparentView: UIView!
    
    @IBOutlet weak var passwordTF: AkiraTextField!

    @IBOutlet weak var remembermeBtn: UIButton!
    
    @IBOutlet weak var eyeBtnOutlet: UIButton!
    @IBOutlet weak var loginBtnOutLet: UIButton!
    
    @IBOutlet weak var forgotEmailTF: AkiraTextField!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var forgotBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var dontHaveAccountLbl: UILabel!
    
    //MARK: -  variable declaration

    var email : String? = ""
    var password : String? = ""
    var appVersion          : String = ""
    var navigationString : String = ""
    var showNav = false
    let utillites =  Utilities()
    var placeHolderName = ["User Name","Password"]
    var deviceId = ""
    
  //MARK: -   View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    //    self.deviceId  = kUserDefaults.value(forKey: "DeviceID") as! String
        
        mobileEmailTF.placeholder = "User Name".localize()
        passwordTF.placeholder = "Password".localize()
        forgotBtn.setTitle("forgot Password".localize(), for: .normal)
        registerBtn.setTitle("Register".localize(), for: .normal)
        dontHaveAccountLbl.text = "Don't have an Account?".localize()

        loginBtnOutLet.layer.borderWidth = 1.0
        loginBtnOutLet.layer.cornerRadius = 6.0
        loginBtnOutLet.layer.borderColor = UIColor(red: 122.0/255.0, green: 186.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        
        
        mobileEmailTF.delegate = self
        passwordTF.delegate = self
        mobileEmailTF.maxLengthTextField = 25
        mobileEmailTF.keyboardType = .default
        passwordTF.maxLengthTextField = 25
        passwordTF.keyboardType = .emailAddress

        loginLabel.text = "Login".localize()
        forgotPWDView.isHidden = true
        transparentView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: -  View Will Appear
  
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        print(showNav)
        
        self.navigationController?.navigationBar.isHidden = false
        
           Utilities.setLoginViewControllerNavBarColorInCntrWithColor(backImage: "homeImg", cntr:self, titleView: nil, withText: "Login".localize(), backTitle: " ", rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
    }
    
    //MARK: -  View Will Disappear
 
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false

    }
    
    //MARK: -  textField Did Begin Editing
  
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.autocorrectionType = .no
        
         if textField == passwordTF{
            
            passwordTF.isSecureTextEntry = true
            
        }
        
    }
//MARK: -  textField should Change Characters In range
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        
        return true
    }
    
 //MARK: -  textField Did End Editing
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        if textField == mobileEmailTF{
            email = mobileEmailTF.text!
            
        }
            
        else if textField == passwordTF{
            
            password = passwordTF.text!
            
        }
        
    }
    
    
//MARK: -  validate phone number
    
    func validatePhoneNumber(phoneNumber: String) -> Bool {
        
        
        let EmailTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        
        return EmailTest.evaluate(with: email)
    }
    
    
//MARK: -  validate password
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
// MARK :- login Clicked
   
    @IBAction func loginClicked(_ sender: Any) {
        
    
        email = mobileEmailTF.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        password = passwordTF.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if(appDelegate.checkInternetConnectivity()){

            if email!.isEmpty{
                
                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "Message".localize(), messege: "Please provide UserName".localize(), clickAction: {
                    
                    
                })
                
            }
            else if password!.isEmpty{
                
                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "Message".localize(), messege: "Please Enter Password".localize(), clickAction: {
                    
                    
                })
                
            }
            else{

        self.loginAPIService()
                
            }
            
        }else{
            
            appDelegate.window?.makeToast(kNetworkStatusMessage, duration:kToastDuration, position:CSToastPositionCenter)
            
            return
        }

    }
    
//MARK:- validateAllFields
    
    func validateAllFields() -> Bool
    {
    
        self.view.endEditing(true)
        
        mobileEmailTF.text = mobileEmailTF.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        passwordTF.text = passwordTF.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        
    
         if email!.isEmpty{
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "Message".localize().localize(), messege: "Please provide UserName".localize(), clickAction: {
                
                
            })
            
        }
        if password!.isEmpty{
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "Message".localize(), messege: "Please Enter Password".localize(), clickAction: {
                
                
            })
            
        }

        else {
            
            print("Home Page Navigate")
            
        }
        
     return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
 //MARK:- Login API Service
    
    func loginAPIService(){
        
        let strUrl = LOGINURL
        
        let dictParams = [
            "userName": email!,
            "password": password!,
            "deviceId": self.deviceId,
            "client_id": "ConsoleApp",
            "client_secret": "abc@123"
            ] as [String : Any]
        
        print("dic params \(dictParams)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        print("dictHeader:\(dictHeaders)")
        
        if(appDelegate.checkInternetConnectivity()){
            
            if !(email!.isEmpty && password!.isEmpty) {
                
                serviceController.postRequest(strURL: strUrl as NSString, postParams: dictParams as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
                    DispatchQueue.main.async()
                        {
                            
                            print("\(result)")
                            
                            let respVO:LoginJsonVO = Mapper().map(JSONObject: result)!
                            
                            print("responseString = \(respVO)")
                            
                            
                            let statusCode = respVO.isSuccess
                            print("StatusCode:\(String(describing: statusCode))")
                            
                            if statusCode == true
                            {
                                
                                let successMsg = respVO.endUserMessage
                                print(successMsg!)
                                
                                let loginStatus = successMsg
                                let userid = respVO.result?.userId
                                let loginid =  respVO.result?.userDetails?.id
                                let userName = respVO.result?.userName
                                let accessToken = respVO.result?.access_token
                                let tokenType = respVO.result?.token_type
                                let clientId = respVO.result?.client_id
                                let refreshToken = respVO.result?.refresh_token
                                let expiresIn = respVO.result?.expires_in
                                
                                kUserDefaults.set(accessToken, forKey: kAccess_token)
                                kUserDefaults.set(tokenType, forKey: kTokenType)
                                kUserDefaults.set(clientId, forKey: kClient_id)
                                kUserDefaults.set(refreshToken, forKey: kRefreshToken)
                                kUserDefaults.set(userid, forKey: kuserIdKey)
                                kUserDefaults.set(expiresIn, forKey: kExpires_in)
                                kUserDefaults.set(loginid, forKey: kIdKey)
                                kUserDefaults.set(userName, forKey: kUserName)
                                kUserDefaults.synchronize()
                                
                                kUserDefaults.set(loginStatus, forKey: kLoginSucessStatus)
                                
                                kUserDefaults.set("true", forKey: KFirstTimeLogin)
                                
                                kUserDefaults.synchronize()
                                
                                kUserId = kUserDefaults.value(forKey: kuserIdKey) as! String
                                kId = kUserDefaults.value(forKey: kIdKey) as! Int
                                kUserDefaults.synchronize()
                                
                                
                                if self.navigationString == "navigationString" ||  self.navigationString == "authorInfoString" || self.navigationString == "churchInfoString" {
                                    
                                    
                                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers
                                    for moveToVC in viewControllers {
                                        if moveToVC is YoutubePlayerViewController {
                                            _ = self.navigationController?.popToViewController(moveToVC, animated: true)
                                        }
                                            
                                        else if moveToVC is AuthorDetailsViewController {
                                            _ = self.navigationController?.popToViewController(moveToVC, animated: true)
                                        }
                                            
                                        else if moveToVC is ChurchesInformaationViewControllers {
                                            _ = self.navigationController?.popToViewController(moveToVC, animated: true)
                                        }
                                        
                                    }
                                    
                                }
                                    
                                else {
                                    
                                    self.appDelegate.window?.makeToast(successMsg!, duration:kToastDuration, position:CSToastPositionCenter)
                                    let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                                    self.appDelegate.window?.rootViewController = rootController
                                    
                                }
                            }
                                
                            else {
                                
                                if  let failMsg = respVO.endUserMessage {
                                    print(failMsg)
                                    
                                    self.showAlertViewWithTitle("Alert".localize(), message: failMsg, buttonTitle: "Ok".localize())
                                    
                                    return
                                }
                            }
                            
                            print("success")
                            
                    }
                    
                }, failureHandler:  {(error) in
                    
                    print(error)
                    
                    if(error == "Enter Valid Credentials"){
                        
                        
                        self.showAlertViewWithTitle("Alert".localize(), message: error, buttonTitle: "Ok".localize())
                        
                        
                    }
                    
                    
                })
            }
        }
        else {
            
            return
        }
        
    }
    
  //MARK:- Forgot Password Clicked
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        
    
//        let forgotPassWordViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgotPassWordViewController") as! ForgotPassWordViewController
//        
//        self.navigationController?.pushViewController(forgotPassWordViewController, animated: true)
       
     //   UIView.animate(withDuration: 1, animations: { // 3.0 are the seconds
            
            // Write your code here for e.g. Increasing any Subviews height.
        
            self.forgotPWDView.isHidden = false
            self.transparentView.isHidden = false
            
            
//            self.view.layoutIfNeeded()
//            
//        })
      
    }

 //MARK:- Register Clicked
    
    @IBAction func registerClicked(_ sender: Any) {
        
        let signUpViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        self.navigationController?.pushViewController(signUpViewController, animated: true)
        
    }
    
//MARK:- Eye Btn Action

    @IBAction func eyeBtnAction(_ sender: Any) {
        
        if eyeBtnOutlet.tag == 0
        {
            passwordTF.isSecureTextEntry = false
            eyeBtnOutlet.tag = 1
        }
        else{
            
            passwordTF.isSecureTextEntry = true
            eyeBtnOutlet.tag = 0
            
            
        }
        
    }
    
    
//MARK: -    Back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        print("Back Button Clicked......")
        
    }
    
     func showAlertViewWithTitle(_ title:String,message:String,buttonTitle:String)
    {
        let alertView:UIAlertView = UIAlertView();
        alertView.title=title
        alertView.message=message
        alertView.addButton(withTitle: buttonTitle)
        alertView.show()
    }
    
    
    @IBAction func forgotPWDSubmitAction(_ sender: Any) {
        
        forgotPWDView.isHidden = true
        transparentView.isHidden = true
        
      self.view.endEditing(true)
        
        mobileEmailTF.text = mobileEmailTF.text!.trimmingCharacters(in: CharacterSet.whitespaces)
       
        if (forgotEmailTF.text?.isEmpty)!{
        
        }
        
        else {
        
            self.forgotPWDAPIService()
            
        }
        
    }
    
    
    func forgotPWDAPIService(){
    
        
        let strUrl = FORGOTPASSWORDAPI
        
        
        let dictParams = [
            
            "email": forgotEmailTF.text!
            
            ] as [String : Any]
        
        print("dic params \(dictParams)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        print("dictHeader:\(dictHeaders)")

                
    serviceController.postRequest(strURL: strUrl as NSString, postParams: dictParams as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
        
        DispatchQueue.main.async(){
                            
            
    let respVO:ForgotPswdVO = Mapper().map(JSONObject: result)!
                                                        
    let endUserMessage = respVO.endUserMessage
            
    print("StatusCode:\(String(describing: endUserMessage))")
            
    Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "Warning", messege: endUserMessage!, clickAction: {
    
    
             })
        
            
        }  }) { (failureMessage) in
            
    }
  }
                
}
    
