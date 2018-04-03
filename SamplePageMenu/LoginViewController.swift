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
    
    var appVersion          : String = ""
    
    var navigationString : String = ""
    
    @IBOutlet weak var mobileEmailTF: AkiraTextField!
    
    @IBOutlet weak var passwordTF: AkiraTextField!

    @IBOutlet weak var remembermeBtn: UIButton!
    
    @IBOutlet weak var eyeBtnOutlet: UIButton!
    @IBOutlet weak var loginBtnOutLet: UIButton!
    
    
    @IBOutlet weak var loginLabel: UILabel!
    
    
    @IBOutlet weak var forgotBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var dontHaveAccountLbl: UILabel!
    var email : String? = ""
    var password : String? = ""
    
    var showNav = false

    let utillites =  Utilities()

    var placeHolderName = ["User Name","Password"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mobileEmailTF.placeholder = "User Name".localize()
        passwordTF.placeholder = "Password".localize()
        forgotBtn.setTitle("forgot Password".localize(), for: .normal)
        registerBtn.setTitle("Register".localize(), for: .normal)
        dontHaveAccountLbl.text = "Don't have an Account?".localize()

      /*  let defaults = UserDefaults.standard
        
        if let gst : String = defaults.value(forKey: "1") as? String {
        
        if gst == "1" {}
        
        else {
        
        if let registerSucess = defaults.string(forKey: kRegisterSucessStatus) {
            print(registerSucess)
            self.appDelegate.window?.makeToast(registerSucess, duration:kToastDuration, position:CSToastPositionCenter)
            
            print("defaults savedString: \(registerSucess)")
            
        }
            }
        } */
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
      //  self.navigationController?.navigationBar.isHidden = true

        print(showNav)
        
        self.navigationController?.navigationBar.isHidden = !showNav
           Utilities.setLoginViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Login".localize(), backTitle: "a", rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false

    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.autocorrectionType = .no
        
         if textField == passwordTF{
            
            passwordTF.isSecureTextEntry = true
            
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        
        
        
        
        return true
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        if textField == mobileEmailTF{
            email = mobileEmailTF.text!
            
        }
            
        else if textField == passwordTF{
            
            password = passwordTF.text!
            
        }
        
    }
    
    
    //MARK: -  validate pgone number
    
    func validatePhoneNumber(phoneNumber: String) -> Bool {
        
        
        let EmailTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        
        return EmailTest.evaluate(with: email)
    }
    
    
    //MARK: -  validate password
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
    @IBAction func loginClicked(_ sender: Any) {
        
        
      //  let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
     //   appDelegate.window?.rootViewController = rootController
        
        mobileEmailTF.text = mobileEmailTF.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        passwordTF.text = passwordTF.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        

        
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
    
    
    
    func validateAllFields() -> Bool
    {
    
        self.view.endEditing(true)
        
        mobileEmailTF.text = mobileEmailTF.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        passwordTF.text = passwordTF.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        
      //  var errorMessage:NSString?
        
       /* if email!.isEmpty && password!.isEmpty{
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "Message", messege: "Please Enter Requiredfields", clickAction: {
                
                
            })
            
        } */
         if email!.isEmpty{
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "Message".localize().localize(), messege: "Please provide UserName".localize(), clickAction: {
                
                
            })
            
        }
        if password!.isEmpty{
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "Message".localize(), messege: "Please Enter Password".localize(), clickAction: {
                
                
            })
            
        }

            

        else {
            
//            let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
//                appDelegate.window?.rootViewController = rootController
//            
            print("Home Page Navigate")
            
        }
        
     return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //        self.view.endEditing(true)
        return true
    }
    func loginAPIService(){
        
     //   let  strUrl = CHANGEPASSWORDURL
        
            let strUrl = LOGINURL

        let dictParams = [
            "userName": email!,
            "password": password!,
            ] as [String : Any]
        
        print("dic params \(dictParams)")
        let dictHeaders = ["":"","":""] as NSDictionary
        
        print("dictHeader:\(dictHeaders)")

        
        
        
        
        if(appDelegate.checkInternetConnectivity()){
            
            if !(email!.isEmpty && password!.isEmpty) {
                
               // email! = email!.trimmingCharacters(in: CharacterSet.whitespaces)
               // password!=password!.trimmingCharacters(in: CharacterSet.whitespaces)

                
            //    let strUrl = LOGINURL + "" + email! + "/" + password!
                
                serviceController.postRequest(strURL: strUrl as NSString, postParams: dictParams as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
                    DispatchQueue.main.async()
                        {
               // serviceController.getRequest(strURL:strUrl, success:{(result) in
                  //  DispatchQueue.main.async()
//{
                            
                          //  let respVO:LoginVo = Mapper().map(JSONObject: result)!
                            
                        print("\(result)")
                            
                            
                            let respVO:LoginJsonVO = Mapper().map(JSONObject: result)!
                            
                           print("responseString = \(respVO)")
                            
                        
                            let statusCode = respVO.userDetails?.isSuccess
                            print("StatusCode:\(String(describing: statusCode))")
                            
                            
                            
                           if statusCode == true
                            {
                                
                                
                                let successMsg = respVO.userDetails?.endUserMessage
                                print(successMsg!)
                                let loginStatus = successMsg
                                let userid = respVO.userDetails?.listResult?[0].userId
                                let loginid =  respVO.userDetails?.listResult?[0].id!
                              //  print("\(String(describing: respVO.userDetails?.listResult?[0].id))")
                                
                            
                                
                                kUserDefaults.set(userid, forKey: kuserIdKey)
                                kUserDefaults.set(loginid, forKey: kIdKey)
                                kUserDefaults.synchronize()
                    
                                kUserDefaults.set(loginStatus, forKey: kLoginSucessStatus)

                                kUserDefaults.set("true", forKey: KFirstTimeLogin)
                                
                                kUserDefaults.synchronize()
                              
                                kUserId = kUserDefaults.value(forKey: kuserIdKey) as! String
                                kId = kUserDefaults.value(forKey: kIdKey) as! Int
                                kUserDefaults.synchronize()
                                
                                
                        if self.navigationString == "navigationString" {
                                
        
                            let allOffersVC : AllOffersViewController? =
                              AllOffersViewController(nibName: "AllOffersViewController", bundle: nil)
                                    
                              self.navigationController?.pushViewController(allOffersVC!, animated: true)
                                    
                                
                                }
                                
                                else {
                                    
                                self.appDelegate.window?.makeToast(successMsg!, duration:kToastDuration, position:CSToastPositionCenter)
                                let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                                self.appDelegate.window?.rootViewController = rootController
                               
                                }
                            }
                            
                            else {
                                
                            if  let failMsg = respVO.userDetails?.endUserMessage {
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
            
     //       appDelegate.window?.makeToast(kNetworkStatusMessage, duration:kToastDuration, position:CSToastPositionCenter)
            return
        }
        
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        
        
        
        
        
           let forgotPassWordViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgotPassWordViewController") as! ForgotPassWordViewController
        
        
      //  UserDefaults.standard.set("1", forKey: "1")
      //  UserDefaults.standard.synchronize()
        
        self.navigationController?.pushViewController(forgotPassWordViewController, animated: true)
      //  self.navigationController?.popViewController(animated: true)
        
        
//        let reOrderPopOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePassWordViewController") as! ChangePassWordViewController
//       // reOrderPopOverVC.delegate = self
//        
//            //    reOrderPopOverVC. singleSelection =
//            //   var imagesArray : Array<UIImage> = Array()
//        
//        
//                self.addChildViewController(reOrderPopOverVC)
//                
//                reOrderPopOverVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//                self.view.addSubview(reOrderPopOverVC.view)
//                reOrderPopOverVC.didMove(toParentViewController: self)
//        
        
        
        
    }

    
    
    @IBAction func registerClicked(_ sender: Any) {
        
        let signUpViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        self.navigationController?.pushViewController(signUpViewController, animated: true)
        
    }
    

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
    
    
}

