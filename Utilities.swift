//
//  Utilities.swift
//  Telugu Churches
//
//  Created by Mac OS on 29/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class Utilities: NSObject {

    
    static let sharedInstance : Utilities = Utilities()
    
//MARK: - APP Color
    static let appColor: UIColor = #colorLiteral(red: 0.3843137255, green: 0.6862745098, blue: 0.8156862745, alpha: 1)
    
    static let appFontSize : UIFont = UIFont (name: "Helvetica Neue", size: 30)!
    
    static let bordrColor : CGColor = #colorLiteral(red: 0.3843137255, green: 0.6862745098, blue: 0.8156862745, alpha: 1).cgColor
    

//MARK: - Nil Check
    
    func isObjectNull(_ object: AnyObject?) -> Bool {
        return !isNil(object) && !isNull(object)
    }
    
    private func isNull(_ object: AnyObject?) -> Bool {
        if !isNil(object) {
            if object!.isKind(of: NSNull.self) || object?.classForCoder == NSNull.classForCoder() {
                return true
            } else {
                return isStringNull(object)
            }
        }
        return false
    }
    
    private func isNil(_ object: AnyObject?) -> Bool {
        return object == nil
    }
    
    private func isStringNull(_ object: AnyObject?) -> Bool {
        guard isNil(object) && isNull(object) else {
            let str = object as? String ?? ""
            return str == "<NULL>"
        }
        return false
    }
    
    class func getTokenType() -> String {
        
        let tokenType = UserDefaults.standard.value(forKey: kTokenType) as? String
        
        if tokenType == nil {
            
            return ""
            
        } else {
            
            return tokenType!
        }
}
    

    
//MARK:- UIAlert Controller Actions
    
    func alertWithOkButtonAction(vc :UIViewController, alertTitle:String, messege: String ,clickAction:@escaping () -> Void) {
        
        let capsMsg  = messege.capitalizingFirstLetter()
        let alrtControl = UIAlertController(title: alertTitle, message: capsMsg , preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "Ok".localize(), style: .default) { _ in
            clickAction()
            
        }
        alrtControl.addAction(cancelButton)
        vc.present(alrtControl, animated: true, completion: nil)
        
    }
    
//MARK:::::::::::::::::::::::::::::::  Below Programmatically Set NavigationBar With Title and Back Button for All ViewController :::::::::::::::::::::::::::://
    
    class func setHoneViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
        }
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    class func setLoginViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        if (titlelabel == nil) {
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        titlelabel!.text = title
        if(cntr.navigationController != nil) {
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
        }
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        leftButton.addTarget(cntr, action: #selector(LoginViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
    }
    
    class func setSignUpViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
        }
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        let rightButtonImage: UIImage = UIImage(named: rightImage)!
        let rightButton: UIButton = UIButton(type: .custom)
        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        
        leftButton.addTarget(cntr, action: #selector(SignUpViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        rightButton.addTarget(cntr, action: #selector(SignUpViewController.homeButtonTapped(_:)), for: .touchUpInside)
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let barbuttonitem2: UIBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        rightButton.frame = CGRect(x: 0, y: 0, width: rightButtonImage.size.width, height: rightButtonImage.size.height)
        rightButton.setTitle("", for: .normal)
        
        if backTitle.characters.count > 0 {
            
            rightButton.setImage(rightButtonImage, for: .normal)
        }
        cntr.navigationItem.rightBarButtonItems = [barbuttonitem2]
        
    }
    
    
    
    class func SetChurchInfoViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        leftButton.addTarget(cntr, action: #selector(ChurchesInformaationViewControllers.backLeftButtonTapped(_:)), for: .touchUpInside)
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
    }
    
    
    
    
    class func setEditProfileViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        if(cntr.navigationController != nil) {
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
        }
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        leftButton.addTarget(cntr, action: #selector(ProfileViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        
    }
    
    class func setProfileViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        
        let rightButtonImage: UIImage = UIImage(named: rightImage)!
        let rightButton: UIButton = UIButton(type: .custom)
        
        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        
        leftButton.addTarget(cntr, action: #selector(ProfileViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        
        
        rightButton.addTarget(cntr, action: #selector(ProfileViewController.homeButtonTapped(_:)), for: .touchUpInside)

        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        let barbuttonitem2: UIBarButtonItem = UIBarButtonItem(customView: rightButton)

        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        
        
        rightButton.frame = CGRect(x: 0, y: 0, width: rightButtonImage.size.width, height: rightButtonImage.size.height)
        rightButton.setTitle("", for: .normal)
        
        if backTitle.characters.count > 0 {
            
            rightButton.setImage(rightButtonImage, for: .normal)
        }
        
        cntr.navigationItem.rightBarButtonItems = [barbuttonitem2]
        
        

        
    }
    
    class func forgotPassWordViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        leftButton.addTarget(cntr, action: #selector(ForgotPassWordViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        
    }
    
    
    
    
    class func setVideosViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        
        
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        
        let rightButtonImage: UIImage = UIImage(named: rightImage)!
        let rightButton: UIButton = UIButton(type: .custom)
        

        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
            leftButton.setTitle(backTitle, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        leftButton.addTarget(cntr, action: #selector(YoutubePlayerViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        
        
        rightButton.addTarget(cntr, action: #selector(YoutubePlayerViewController.homeButtonTapped(_:)), for: .touchUpInside)
        
        

        
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let barbuttonitem2: UIBarButtonItem = UIBarButtonItem(customView: rightButton)

        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        rightButton.frame = CGRect(x: 0, y: 0, width: rightButtonImage.size.width, height: rightButtonImage.size.height)
        rightButton.setTitle("", for: .normal)
        
        if backTitle.characters.count > 0 {
            
            rightButton.setImage(rightButtonImage, for: .normal)
        }
        
        cntr.navigationItem.rightBarButtonItems = [barbuttonitem2]
        

        
        
    }

    
    class func setChurchuDetailViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        

        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        leftButton.addTarget(cntr, action: #selector(ChurchDetailsViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        

        
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        

        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
            
        
    }
    
    class func setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        let rightButtonImage: UIImage = UIImage(named: rightImage)!
        let rightButton: UIButton = UIButton(type: .custom)
        

        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        leftButton.addTarget(cntr, action: #selector(ChurchesInformaationViewControllers.backLeftButtonTapped(_:)), for: .touchUpInside)
        
        rightButton.addTarget(cntr, action: #selector(ChurchesInformaationViewControllers.homeButtonTapped(_:)), for: .touchUpInside)
        
        

        
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        let barbuttonitem2: UIBarButtonItem = UIBarButtonItem(customView: rightButton)


        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        rightButton.frame = CGRect(x: 0, y: 0, width: rightButtonImage.size.width, height: rightButtonImage.size.height)
        rightButton.setTitle("", for: .normal)
        
        if backTitle.characters.count > 0 {
            
            rightButton.setImage(rightButtonImage, for: .normal)
        }
        
        cntr.navigationItem.rightBarButtonItems = [barbuttonitem2]
        
        

        
        
    }
    
    class func setChurchuAdminInfoViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        leftButton.addTarget(cntr, action: #selector(ChurchAdminViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        
    }
    
    class func setEventViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        leftButton.addTarget(cntr, action: #selector(EventViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        
    }
    class func setUpComingEentInfoEventViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        let imageString = backImage
        
        if imageString != "" {
            let leftButtonImage: UIImage = UIImage(named: imageString!)!
            let leftButton: UIButton = UIButton(type: .custom)
            
            leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
            leftButton.setTitle(backTitle, for: .normal)
            if backTitle.characters.count > 0 {
                
                leftButton.setImage(leftButtonImage, for: .normal)
            }
            leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
            leftButton.addTarget(cntr, action: #selector(UpConingEventInfoViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
            let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
            
            cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        }
      
        
        
    }

    class func categoriesViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
//            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        leftButton.addTarget(cntr, action: #selector(CategoriesHomeViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        
    }
    
    class func UpComingAndEventViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {

        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        let rightButtonImage: UIImage = UIImage(named: rightImage)!
        let rightButton: UIButton = UIButton(type: .custom)
        

        
        leftButton.frame = CGRect(x: 0, y: 0, width: 100, height: leftButtonImage.size.height)
       
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
            leftButton.setTitle(backTitle, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        leftButton.addTarget(cntr, action: #selector(AllEventsAndUpComingEventsViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        
        
        rightButton.addTarget(cntr, action: #selector(AllEventsAndUpComingEventsViewController.homeButtonTapped(_:)), for: .touchUpInside)
        
        
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let barbuttonitem2: UIBarButtonItem = UIBarButtonItem(customView: rightButton)

        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        rightButton.frame = CGRect(x: 0, y: 0, width: rightButtonImage.size.width, height: rightButtonImage.size.height)
        rightButton.setTitle("", for: .normal)
        
        if backTitle.characters.count > 0 {
            
            rightButton.setImage(rightButtonImage, for: .normal)
        }
        
        cntr.navigationItem.rightBarButtonItems = [barbuttonitem2]
        

        
        
    }
    
    class func authorDetailsViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        
        
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        let rightButtonImage: UIImage = UIImage(named: rightImage)!
        let rightButton: UIButton = UIButton(type: .custom)
        

        
        leftButton.frame = CGRect(x: 0, y: 0, width: 50, height: leftButtonImage.size.height)
        
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
            leftButton.setTitle(backTitle, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        leftButton.addTarget(cntr, action: #selector(AuthorDetailsViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        
        rightButton.addTarget(cntr, action: #selector(AuthorDetailsViewController.homeButtonTapped(_:)), for: .touchUpInside)

        
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let barbuttonitem2: UIBarButtonItem = UIBarButtonItem(customView: rightButton)

        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        rightButton.frame = CGRect(x: 0, y: 0, width: rightButtonImage.size.width, height: rightButtonImage.size.height)
        rightButton.setTitle(backTitle, for: .normal)
        
        if backTitle.characters.count > 0 {
            
            rightButton.setImage(rightButtonImage, for: .normal)
        }
        
        cntr.navigationItem.rightBarButtonItems = [barbuttonitem2]
        

        
        
        
    }
    class func AllInfoViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        
        
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        let rightButtonImage: UIImage = UIImage(named: rightImage)!
        let rightButton: UIButton = UIButton(type: .custom)
        

        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
            leftButton.setTitle(backTitle, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        
        leftButton.addTarget(cntr, action: #selector(VideoSongsViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        
        rightButton.addTarget(cntr, action: #selector(VideoSongsViewController.homeButtonTapped(_:)), for: .touchUpInside)

        
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        let barbuttonitem2: UIBarButtonItem = UIBarButtonItem(customView: rightButton)

        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        rightButton.frame = CGRect(x: 0, y: 0, width: rightButtonImage.size.width, height: rightButtonImage.size.height)
        rightButton.setTitle("", for: .normal)
        
        if backTitle.characters.count > 0 {
            
            rightButton.setImage(rightButtonImage, for: .normal)
        }
        
        cntr.navigationItem.rightBarButtonItems = [barbuttonitem2]
        
        

        
        
        
    }
    
    class func authorDetailsnextViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        
        
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        let rightButtonImage: UIImage = UIImage(named: rightImage)!
        let rightButton: UIButton = UIButton(type: .custom)
 
        leftButton.frame = CGRect(x: 0, y: 0, width: 50, height: leftButtonImage.size.height)
        
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
            leftButton.setTitle(backTitle, for: .normal)
        }
        //  leftButton.backgroundColor = UIColor.red
        leftButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        leftButton.addTarget(cntr, action: #selector(AuthorDetailsViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        
        rightButton.addTarget(cntr, action: #selector(AuthorDetailsViewController.homeButtonTapped(_:)), for: .touchUpInside)

        
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let barbuttonitem2: UIBarButtonItem = UIBarButtonItem(customView: rightButton)

        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        rightButton.frame = CGRect(x: 0, y: 0, width: rightButtonImage.size.width, height: rightButtonImage.size.height)
        rightButton.setTitle("", for: .normal)
        
        if backTitle.characters.count > 0 {
            
            rightButton.setImage(rightButtonImage, for: .normal)
        }
        
        cntr.navigationItem.rightBarButtonItems = [barbuttonitem2]
        
        

        
        
    }
    

    class func setupFailedViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        
        
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.red
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        leftButton.addTarget(cntr, action: #selector(AuthorDetailsViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        
    }

    
    
    class func audioEventViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        
        
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        let rightButtonImage: UIImage = UIImage(named: rightImage)!
        let rightButton: UIButton = UIButton(type: .custom)
        

        
        leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: leftButtonImage.size.height)
        
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
            leftButton.setTitle(backTitle, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        leftButton.addTarget(cntr, action: #selector(AllEventsAndUpComingEventsViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        
        
        rightButton.addTarget(cntr, action: #selector(AllEventsAndUpComingEventsViewController.homeButtonTapped(_:)), for: .touchUpInside)

        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let barbuttonitem2: UIBarButtonItem = UIBarButtonItem(customView: rightButton)

        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
       
        rightButton.frame = CGRect(x: 0, y: 0, width: rightButtonImage.size.width, height: rightButtonImage.size.height)
        rightButton.setTitle("", for: .normal)
        
        if backTitle.characters.count > 0 {
            
            rightButton.setImage(rightButtonImage, for: .normal)
        }
        
        cntr.navigationItem.rightBarButtonItems = [barbuttonitem2]
        

        
        
    }
    class func eventDetailsAndEventPostDetailsViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = Utilities.appColor
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        let rightButtonImage: UIImage = UIImage(named: rightImage)!
        let rightButton: UIButton = UIButton(type: .custom)
        
        
        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        leftButton.addTarget(cntr, action: #selector(EventDetailsAndEventPostDetailsViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        
        rightButton.addTarget(cntr, action: #selector(EventDetailsAndEventPostDetailsViewController.homeButtonTapped(_:)), for: .touchUpInside)
        
        
        
        
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        let barbuttonitem2: UIBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        
        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
        rightButton.frame = CGRect(x: 0, y: 0, width: rightButtonImage.size.width, height: rightButtonImage.size.height)
        rightButton.setTitle("", for: .normal)
        
        if backTitle.characters.count > 0 {
            
            rightButton.setImage(rightButtonImage, for: .normal)
        }
        
        cntr.navigationItem.rightBarButtonItems = [barbuttonitem2]
    }
    
//MARK:- Set AlertController for "EndUserMessages" or "ErrorMessages" and "AlertMessages"
    
    func alertWithOkAndCancelButtonAction(vc :UIViewController, alertTitle:String, messege: String ,clickAction:@escaping () -> Void) {
        
        let capsMsg  =  messege.capitalizingFirstLetter()
        let alrtControl = UIAlertController(title: alertTitle, message: capsMsg , preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok".localize(), style: .default) { _ in
            clickAction()
        }
        let cancelButton = UIAlertAction(title: "Cancel".localize(), style: .default) { _ in
        }
        alrtControl.addAction(cancelButton)
        alrtControl.addAction(okButton)
        vc.present(alrtControl, animated: true, completion: nil)
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

//MARK: - DateFormatter Extensions

extension DateFormatter {
    
    // let dateFormatter = DateFormatter() 2018-12-24T15:22:11
    
    static let dateee : DateFormatter = DateFormatter()
    
    func systemTimeZone() {
        
        let enUSPOSIXLocale:NSLocale=NSLocale(localeIdentifier: "en_US_POSIX")
        self.locale=enUSPOSIXLocale as Locale!
        
        self.timeZone = NSTimeZone(name: "GMT") as TimeZone!
    }
    
    class func dateFormatter_yyyy_MM_dd_hh_mm_ss_Z() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.systemTimeZone()
        return dateFormatter
    }
    
    class func dateFormatter_yyyy_MM_dd_hh_mm_ss_SSSSSSS_Z() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ" //2016-01-01T11:57:55.6738531+05:30
        dateFormatter.systemTimeZone()
        return dateFormatter
    }
    
    class func dateFormatter_yyyy_dd_MM_hh_mm_ss_SSSSSSS_Z() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy-dd-MM'T'HH:mm:ss.SSSSSSSZ" //2016-16-12T11:57:55.6738531+05:30
        dateFormatter.systemTimeZone()
        return dateFormatter
    }
    
    class func dateFormatter_yyyy_MM_dd_hh_mm_ss_SSS() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS" //2016-11-30T02:19:47.633
        dateFormatter.systemTimeZone()
        return dateFormatter
    }
    
    class func dateFormatter_yyyy_MM_dd() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy/MM/dd" //2016-11-30T02:19:47.633
        dateFormatter.systemTimeZone()
        return dateFormatter
    }
    
    class func dateFormatter_yyyy() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy"
        dateFormatter.systemTimeZone()
        return dateFormatter
    }
    
    class func dateFormatter_mm_dd_yyyy() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.systemTimeZone()
        return dateFormatter
    }
    
    class func dateFormatter_Local_mm_dd_yyyy() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }
    
    class func dateFormatter_Local_yyyy_MM_dd_H_M_S() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"     //2016-12-28T00:00:00
        return dateFormatter
    }
    
    
    
    class func dateFormatter_Local_yyyy_MM_dd() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "yyyy-MM-dd"     //2016-12-28T00:00:00
        return dateFormatter
    }
    
    class func dateFormatter_Local_mm_dd_yy() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter
    }
    
    class func dateFormatter_Local_mm_dd() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter
    }
    
    class func dateFormatter_Local_yyyy_MM_dd_hh_mm_ss_SSS() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS" //2016-11-30T02:19:47.633
        dateFormatter.timeZone = NSTimeZone.system
        return dateFormatter
    }
    
    class func dateFormatter_Local_yyyy_MM_dd_hh_mm_ss() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2016-10-27T00:00:00
        dateFormatter.timeZone = NSTimeZone.system
        return dateFormatter
    }
    
    class func dateFormatter_Local_yyyy() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter
    }
    
    
    
}
//MARK: String Extensions

extension String {
    
    func capitalizingFirstLetter() -> String {
        
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    
    
}
