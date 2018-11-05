//
//  GlobalSupportingClass.swift
//  Mag-nificent
//
//  Created by Soniya on 6/4/15.
//  Copyright (c) 2015 Eaurac. All rights reserved.
//

import UIKit

class GlobalSupportingClass {
    
    static let dateFormatStandard:String = "yyyy-MM-dd HH:mm:ss"
    static let dateFormatInputField:String = "MM/dd/yyyy hh:mm a"
    
    //2017-10-30T04:37:57.006Z
    
    var autTokenn = UserDefaults.standard.string(forKey: "accessToken")
    var authTokenType = UserDefaults.standard.string(forKey: "tokenType")
    
    
    // MARK: - Error Messages
    
    class func blankjobtitleErrorMessage() -> String {
        return "Please Enter jobtitle".localize()
    }
    
    
    class func blankqualificationErrorMessage() -> String {
        return "Please Enter Qualification".localize()
    }
    
    class func blankyearofexperienceErrorMessage() -> String {
        return "Please Enter Years Of Experience".localize()
    }
    
    class func blankmonthofexperienceErrorMessage() -> String {
        return "Please Enter months Of Experience".localize()
    }
    
    
    class func blankresumeErrorMessage() -> String {
        return "Please Upload Resume".localize()
    }
    class func blankcurrentorganizationErrorMessage() -> String {
        return "Please Enter Current Organization".localize()
    }
    class func blankcurrentsalaryErrorMessage() -> String {
        return "Please Enter Current Salary".localize()
    }
    class func blankexpectedsalaryErrorMessage() -> String {
        return "Please Enter Expected Salary".localize()
    }
    
    class func blankFullNameErrorMessage() -> String {
        return "Please Enter Full Name".localize()
    }
    class func blankFlatnoErrorMessage() -> String {
        return "Please Enter Flat No".localize()
    }
    
    class func blankAreaErrorMessage() -> String {
        return "Please Enter Area".localize()
    }
 
    class func blankPinCodeErrorMessage() -> String {
        return "Please Enter PinCode".localize()
    }
    class func blankLandmarkErrorMessage() -> String {
        return "Please Enter Landmark".localize()
    }
    class func blankStateErrorMessage() -> String {
        return "Please Select State".localize()
    }
    class func blankCountryErrorMessage() -> String {
        return "Please Select Country".localize()
    }
    
    
    
    
    class func blankFirstNameErrorMessage() -> String {
        return "Please Enter First Name".localize()
    }
    class func AlphaBetsOnlyErrorMessage() -> String {
        return "Only AlphaBets Allowed".localize()
    }
    class func blankMiddleNameErrorMessage() -> String {
        return "Please Enter MiddleName".localize()
    }
    
    class func blankLastNameErrorMessage() -> String {
        return "Please Enter Lastname".localize()
    }
    class func blankUserNameErrorMessage() -> String {
        return "Please Enter UserName".localize()
    }
    class func blankEmailIDErrorMessage() -> String {
        return "Please Enter e-mail".localize()
    }
    class func blankMobileNumberErrorMessage() -> String {
        return "Please Enter Mobile Number".localize()
    }
    
    class func miniCharMobileNumberErrorMessage() -> String {
        return "Please Enter Mobile Number".localize()
    }
    class func invalidMobileNumberErrorMessage() -> String {
        return "invalid Mobile Number".localize()
    }
    class func miniCharEmailIDErrorMessage() -> String {
        return "Email Should Minimum 5-Character".localize()
    }
    class func invalidEmaildIDFormatErrorMessage() -> String {
        return "Please Enter valid e-mail id Format".localize()
    }
    class func blankDOBErrorMessage() -> String {
        return "Please Enter DOB".localize()
    }
    class func blankgenderErrorMessage() -> String {
        return "Please Enter Gender".localize()
    }

    class func blankPassWordErrorMessage() -> String {
        return "Please Enter Password".localize()
    }
    class func blankConfirmPasswordErrorMessage() -> String {
        return "Please Enter Confirm Password".localize()
        
    }
    
    class func invalidDigitsInPasswordErrorMessage() -> String {
        return "Incorrect Confirm Password".localize()
    }
    class func passwordMissMatchErrorMessage() -> String {
        return "Password Mismatch".localize()
    }
    
    
    class func blankPasswordErrorMessage() -> String {
        return "Please Enter New Password".localize()
    }
    class func blankPswdErrorMessage() -> String {
        return "Please Enter Password".localize()
    }
    
    class func blankResetPasswordErrorMessage() -> String {
        return "Please Enter Reset-Password".localize()
    }
    //    class func blankConfirmPassWordErrorMessage() -> String {
    //        return "Please ConfirmPassWord Password"
    //    }
    class func capitalLetterMessage() -> String {
        return "password must have at least one uppercase letter".localize()
    }
    
    
    
    class func blankMobilenumberErrorMessage() -> String {
        return "Please Enter Your Mobile Number".localize()
    }
    class func invalidMobilenumberErrorMessage() -> String {
        return "Please Enter 10-Digits MobileNumber".localize()
    }
    
    class func invalidPassWordErrorMessage() -> String {
        return "Please Enter Minimum 8 Characters Password".localize()
    }
    //    class func invalidPhoneNumberErrorMessage() -> String {
    //        return "app.Pleaseprovide10digitsmobilenumber".localize()
    //    }
    
    
    class func pswdnumberMessage() -> String {
        return "Password Should Contain One Uppercase, One Lowercase, One Special Character, One Numeric And Minimum Of 8 Characters".localize()
    }
    
    
    
    class func numberMessage() -> String {
        return "Password must have at least one number".localize()
    }
    
    class func specialCharacterMessage() -> String {
        return "Password must have at least one special Character".localize()
    }
    
    class func blankOldPasswordErrorMessage() -> String {
        return "Provied Old Password".localize()
    }
    
    class func blankNilOldPasswordErrorMessage() -> String {
        return "Please Enter Old Password".localize()
    }
    
    class func IncooectOldPasswordErrorMessage() -> String {
        return "Please Enter Valid Old Password".localize()
    }
    
    // MARK: - Capital
    
    class func capitalOnly(password: String) -> Bool {
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard texttest.evaluate(with: password) else { return false }
        
        return true
    }
    
    //MARK: -  validate password
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
    
    // MARK: - Phone Number Valdation
    
   class func phoneValidate(value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
//    // MARK: - Capital
//    
//    class func capitalOnly(password: String) -> Bool {
//        let capitalLetterRegEx  = ".*[A-Z]+.*"
//        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
//        guard texttest.evaluate(with: password) else { return false }
//        
//        return true
//    }
    
    // MARK: - Number Only
    
    class func numberOnly(password: String) -> Bool {
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        guard texttest1.evaluate(with: password) else { return false }
        
        return true
    }
    
    // MARK: - Special Char Only
    
    class func specialCharOnly(password: String) -> Bool {
        
        let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        guard texttest2.evaluate(with: password) else { return false }
        
        return true
    }
    
    
    
    // MARK: - Validate
    
    class func isValidEmail(_ emailID:NSString) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    
    //MARK : - Special character checking in string
    
    class func isHavingSpecialCharacter(_ string:NSString) -> Bool {
        
        let set:CharacterSet = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890").inverted
        if string.rangeOfCharacter(from: set).location == NSNotFound    {
            //No special character exists
            return false
        }
        //special character exists
        return true
    }
    
    class func isOnlyNumbers(_ string:NSString) -> Bool {
        
        let set:CharacterSet = CharacterSet(charactersIn:"1234567890").inverted
        if string.rangeOfCharacter(from: set).location == NSNotFound    {
            //No special character exists
            return false
        }
        //special character exists
        return true
    }
    
    //MARK : - Navigation
    class func imageLayerForNavigationGradientBackground(_ frame :CGRect) -> UIImage {
        
        var updatedFrame = frame
        // take into account the status bar
        updatedFrame.size.height += 20
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0.0, y: 0.5);
        layer.endPoint = CGPoint(x: 1.0, y: 0.5);
        layer.frame = updatedFrame
        layer.colors = [UIColor(red: 110/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1.0).cgColor, UIColor(red: 140/255.0, green: 185/255.0, blue: 150/255.0, alpha: 1.0).cgColor]
        UIGraphicsBeginImageContext(layer.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    //MARK: - Date Methods
    
    static  func getDateFromFormat(_ currFormat:String,ToFormat toFormat:String, WithDate strDate:String) ->String
    {
        var resultString:String
        let dateFormatter:DateFormatter  =  DateFormatter()
        dateFormatter.dateFormat = currFormat
        let yourDate = dateFormatter.date(from: strDate)
        if yourDate != nil{
            dateFormatter.dateFormat = toFormat
            resultString = dateFormatter.string(from: yourDate!)
        }
        else{
            resultString = strDate
        }
        
        return resultString
    }
    
    static  func getCurrentDate() -> String
    {
        // Set up an NSDateFormatter for UTC time zone
        let formatterUtc:DateFormatter  =  DateFormatter()
        formatterUtc.dateFormat = GlobalSupportingClass.dateFormatStandard
        formatterUtc.timeZone = TimeZone(secondsFromGMT: 0)
        
        
        // Cast the input string to NSDate
        let utcDate:Date = Date()
       // print("utc: \(utcDate)", terminator: "")
        let strUTC:String = formatterUtc.string(from: utcDate)
      //  print("strutc: \(strUTC)")
        
        return strUTC;
    }
    
    class func dateStandardFormat() -> String {
        return dateFormatStandard
    }
    class func date120Format() -> String {
        return dateFormatInputField
    }
    
    static  func getEpochDateFromFormat(_ currFormat:String, WithDate strDate:String) ->String
    {
        var resultString:String
        let dateFormatter:DateFormatter  =  DateFormatter()
        dateFormatter.dateFormat = currFormat
        let yourDate = dateFormatter.date(from: strDate)
        if yourDate != nil{
            let epochTimeInterval:TimeInterval = floor(yourDate!.timeIntervalSince1970)
            resultString = NSString(format:"%d",epochTimeInterval) as String
        }
        else{
            resultString = strDate
        }
        
        return resultString
    }
    
//    class func saveAccessToken(_ accessToken: String) {
//        
//        if let accessTokenData = accessToken.data(using: String.Encoding.utf8) {
//            
//            let encryptedAccessToken = RNCryptor.encrypt(data: accessTokenData, withPassword: autTokenn)
//            UserDefaults.standard.setValue(encryptedAccessToken, forKey: autTokenn)
//            UserDefaults.standard.synchronize()
//        }
//    }
//    
//    class func getAccessToken() -> String {
//        
//        if let accessTokenData = UserDefaults.standard.value(forKey: autTokenn) as? Data {
//            
//            do {
//                
//                let decryptedAccessToken = try RNCryptor.decrypt(data: accessTokenData, withPassword: autTokenn)
//                
//                if let accessToken = String.init(data: decryptedAccessToken, encoding: String.Encoding.utf8) {
//                    
//                    return accessToken
//                }
//                
//            } catch {
//                
//                fatalError("Error fetching password items - \(error)")
//            }
//        }
//        
//        return ""
//    }
//    
//    class func saveTokenType(_ tokenType: String) {
//        
//        UserDefaults.standard.setValue(tokenType, forKey: autTokenn)
//        UserDefaults.standard.synchronize()
//    }
//    
//    class func getTokenType() -> String {
//        
//        let tokenType = UserDefaults.standard.value(forKey: autTokenn) as? String
//        
//        if tokenType == nil {
//            
//            return ""
//            
//        } else {
//            
//            return tokenType!
//        }
//    }
    
//    //MARK: - Alert
//    
//    static func showAlertViewWithTitle(title:String,message:String,buttonTitle:String)
//    {
//        let alertView:UIAlertView = UIAlertView();
//        alertView.title=title
//        alertView.message=message
//        alertView.addButton(withTitle: buttonTitle)
//        alertView.show()
//    }
//
//    static func showAlertViewWithTitleAndButtons(title:String,message:String,arrButtons:
//        
//        NSArray,delegate:AnyObject)
//    {
//        let alertView:UIAlertView = UIAlertView();
//        alertView.title=title
//        alertView.message=message
//        alertView.delegate=delegate
//        for  buttonTitle in arrButtons
//        {
//            alertView.addButtonWithTitle(buttonTitle as! String)
//        }
//        alertView.show()
//    }
    
}



